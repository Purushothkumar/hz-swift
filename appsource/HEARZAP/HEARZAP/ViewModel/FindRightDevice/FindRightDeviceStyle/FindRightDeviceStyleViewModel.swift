//
//  FindRightDeviceStyleViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct FindRightDeviceStyleViewModel {
    func getFindRightDeviceLifestyleList(canShowLoader: Bool, viewCon: FindRightDeviceStyleViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(FindRightDeviceStyleModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.lifestyle != nil {
                        viewCon.lifestyleArray = json.data!.lifestyle!
                        viewCon.reloadTableView()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
