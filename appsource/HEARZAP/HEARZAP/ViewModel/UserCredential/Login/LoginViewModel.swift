//
//  LoginViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct LoginViewModel {
    func postLogin(canShowLoader: Bool, viewCon: LoginViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(LoginModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.phoneToken.isNilOrEmpty) {
                        viewCon.navigateToOTPVerificationViewController(isFrom: viewCon.isFrom, mobileNumber: viewCon.mobileNumberTextField.text!, isLogin: true, name: "", phoneToken: json.data!.phoneToken!, isWishlist: viewCon.isWishList, productUID: viewCon.productUID)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
