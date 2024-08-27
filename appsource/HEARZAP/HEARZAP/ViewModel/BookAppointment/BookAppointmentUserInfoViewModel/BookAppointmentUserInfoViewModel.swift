//
//  BookAppointmentUserInfoViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct BookAppointmentUserInfoViewModel {
    func postBookAppointmentCustomerDetail(canShowLoader: Bool, viewCon: BookAppointmentUserInfoViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookAppointmentUserInfoModel.self, from: result as Data)
                    viewCon.navigateToBookAppointmentSuccessViewController(isFrom: viewCon.isFrom)

            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
