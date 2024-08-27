//
//  ChangeInformationViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct ChangeInformationViewModel {
    func postChangePhone(canShowLoader: Bool, viewCon: ChangeInformationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ChangeMobileModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.phoneToken.isNilOrEmpty) {
                        let mobilnumber = String(format: "%@%@", "+91", viewCon.changeInformationTextfield.text!)
                        viewCon.navigateToChangeInformationOTPVerificationViewController(toChangeNumber: viewCon.toChangeNumber, changeData: viewCon.changeInformationTextfield.text ?? "", token: json.data!.phoneToken!)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postChangeEmail(canShowLoader: Bool, viewCon: ChangeInformationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ChangeEmailmodel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.emailToken.isNilOrEmpty) {
                        viewCon.navigateToChangeInformationOTPVerificationViewController(toChangeNumber: viewCon.toChangeNumber, changeData: viewCon.changeInformationTextfield.text ?? "", token: json.data!.emailToken!)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
