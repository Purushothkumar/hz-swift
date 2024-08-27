//
//  OTPVerificationViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 13/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct OTPVerificationViewModel {
    func postOTPVerification(canShowLoader: Bool, viewCon: OTPVerificationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OTPVerificationModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.token.isNilOrEmpty) {
                        UserDefaults.standard.set(json.data!.token!, forKey: UserDefaultsPreferenceKeys.token)
                        UserDefaults.standard.synchronize()
                    }
                    if !(json.data!.customerName.isNilOrEmpty) {
                        UserDefaults.standard.set(json.data!.customerName!.capitalized, forKey: UserDefaultsPreferenceKeys.customerName)
                        UserDefaults.standard.synchronize()
                    }
                    if !(json.data!.customerMobile.isNilOrEmpty) {
                        UserDefaults.standard.set(json.data!.customerMobile!, forKey: UserDefaultsPreferenceKeys.customerMobile)
                        UserDefaults.standard.synchronize()
                    }
                    if !(json.data!.customerUid.isNilOrEmpty) {
                        UserDefaults.standard.set(json.data!.customerUid!, forKey: UserDefaultsPreferenceKeys.customerUID)
                        UserDefaults.standard.synchronize()
                    }
                    viewCon.appDelegate?.saveDefaultValues()
                    viewCon.checkNavigationControl()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postResendOTP(canShowLoader: Bool, viewCon: OTPVerificationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
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
