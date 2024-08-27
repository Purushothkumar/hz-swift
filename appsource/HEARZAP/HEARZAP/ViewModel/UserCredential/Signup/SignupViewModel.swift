//
//  SignupViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 13/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct SignupViewModel {
    func postSignup(canShowLoader: Bool, viewCon: SignupViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(SignupModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.phoneToken.isNilOrEmpty) {
                        viewCon.navigateToOTPVerificationViewController(isFrom: viewCon.isFrom, mobileNumber: viewCon.mobileNumberTextField.text!, isLogin: false, name: viewCon.nameTextField.text!, phoneToken: json.data!.phoneToken!, isWishlist: viewCon.isWishList, productUID: viewCon.productUID)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
