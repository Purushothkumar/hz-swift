//
//  EnterAddressViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct EnterAddressViewModel {
    func saveCustomerAddress(canShowLoader: Bool, viewCon: EnterAddressViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(SaveAddressModel.self, from: result as Data)
                if json.data != nil {
                    if viewCon.isFrom == IsNavigateFrom.addresslist.rawValue {
                        viewCon.navigateBackToAddressListViewControllerUpdated()
                    } else if viewCon.isFrom == IsNavigateFrom.addressCheckOut.rawValue {
                        viewCon.navigateBackToCheckOutViewControllerFromAddress()
                    } else if viewCon.isFrom == IsNavigateFrom.addressBookAppointment.rawValue {
                        viewCon.navigateBackToBookAppointmentAddressViewControllerFromAddress()
                    } else {
                        viewCon.navigateBackToAddressListViewControllerUpdated()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
