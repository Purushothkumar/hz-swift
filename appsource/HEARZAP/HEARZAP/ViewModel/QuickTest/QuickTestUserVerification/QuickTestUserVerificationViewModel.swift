//
//  QuickTestUserVerificationViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 17/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct QuickTestUserVerificationViewModel{
    func postQuickCheckVerifyOTP(canShowLoader: Bool, viewCon: QuickTestUserVerificationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(QuickTestUserVerificationModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.quickcheckupSession != nil{
                        if !(json.data!.quickcheckupSession!.uid.isNilOrEmpty) {
                            viewCon.sessionID = json.data!.quickcheckupSession!.uid!
                        } else {
                            viewCon.sessionID = ""
                        }
                    }
                    if !(json.data!.token.isNilOrEmpty) {
                        UserDefaults.standard.set(json.data!.token!, forKey: UserDefaultsPreferenceKeys.token)
                        UserDefaults.standard.synchronize()
                    }
                    if viewCon.sessionID.isEmpty {
                        viewCon.showToastAlert(AppLocalizationString.failedtoCreateSessionID, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                    } else {
                        viewCon.navigateToQuickTestResultViewController(isFrom: viewCon.isFrom, sessionID: viewCon.sessionID)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postResendOTP(canShowLoader: Bool, viewCon: QuickTestUserVerificationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ResendOTPModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.showToastAlert(AppLocalizationString.otpresendsuccessfully, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: viewCon)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
