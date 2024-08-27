//
//  ChangeInformationOTPVerificationViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct ChangeInformationOTPVerificationViewModel {
    func postResendOTP(canShowLoader: Bool, viewCon: ChangeInformationOTPVerificationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
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
    func postEmailVerification(canShowLoader: Bool, viewCon: ChangeInformationOTPVerificationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(EmailOTPVerificationModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.navigateBackToProfileInformationViewController()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postMobileVerification(canShowLoader: Bool, viewCon: ChangeInformationOTPVerificationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(MobileOTPVerificationModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.navigateBackToProfileInformationViewController()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
