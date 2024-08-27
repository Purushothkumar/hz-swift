//
//  SelectUserViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 18/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct SelectUserViewModel {
    func getCustomerRelationPersonList(canShowLoader: Bool, viewCon: SelectUserViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(UserListModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.patientList != nil {
                        viewCon.patientList = json.data!.patientList!
                    }
                    viewCon.reloadTableview()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postFindTheRightDevicePersonList(canShowLoader: Bool, viewCon: SelectUserViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(FindRightDeviceSessionModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.sessionID.isNilOrEmpty) {
                        viewCon.sessionID = json.data!.sessionID!
                    } else {
                        viewCon.sessionID = ""
                    }
                    if viewCon.sessionID.isEmpty {
                        viewCon.showToastAlert(AppLocalizationString.failedtoCreateSessionID, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                    } else {
                        viewCon.navigateToFindRightDeviceUploadReportViewController(isFrom: viewCon.isFrom, patientUid: viewCon.selectedPerson, sessionID: viewCon.sessionID)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
