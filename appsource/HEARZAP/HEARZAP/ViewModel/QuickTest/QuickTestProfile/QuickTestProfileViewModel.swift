//
//  QuickTestProfileViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 06/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct QuickTestProfileViewModel {

    func getQuickCheckupGuestUserList(canShowLoader: Bool, viewCon:  QuickTestProfileViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(UserListModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.patientList.removeAll()
                    if json.data!.patientList != nil {
                        viewCon.patientList = json.data!.patientList!
                    }
                    viewCon.updateDefaultPatientList()
                    viewCon.canHideShimmering = true
                    viewCon.reloadProfileCollectionView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getCustomerRelationPersonList(canShowLoader: Bool, viewCon:  QuickTestProfileViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(UserListModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.patientList.removeAll()
                    if json.data!.patientList != nil {
                        viewCon.patientList = json.data!.patientList!
                    }
                    viewCon.updateDefaultPatientList()
                    viewCon.canHideShimmering = true
                    viewCon.reloadProfileCollectionView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postQuickCheckupPersonList(canShowLoader: Bool, viewCon: QuickTestProfileViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(QuickCheckSessionModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.sessionID.isNilOrEmpty) {
                        viewCon.sessionID = json.data!.sessionID!
                    } else {
                        viewCon.sessionID = ""
                    }
                    if json.data!.patientData != nil {
                        viewCon.patientData = json.data!.patientData!
                    } else {
                        viewCon.patientData = PatientList(id: nil, uid: "", customerUid: "", name: "", age: "", dob: "", gender: "", relationship: "", relationshipType: "")
                    }
                    if viewCon.sessionID.isEmpty {
                        viewCon.showToastAlert(AppLocalizationString.failedtoCreateSessionID, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                    } else {
                        viewCon.navigateToQuickTestHeadsetConnectivityViewController(isFrom: viewCon.isFrom, patientData: viewCon.patientData!, sessionID: viewCon.sessionID)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
