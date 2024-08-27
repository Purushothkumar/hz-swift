//
//  QuickTestUserInfoViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 17/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct QuickTestUserInfoViewModel {
    func postQuickCheckSignIn(canShowLoader: Bool, viewCon: QuickTestUserInfoViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(QuickTestUserInfoSignInModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.phoneToken.isNilOrEmpty) {
                        viewCon.navigateToQuickTestUserVerificationViewController(isFrom: viewCon.isFrom, patientData: viewCon.patientData!, sessionID: viewCon.sessionID, dictLeft: viewCon.dictLeft, dictRight: viewCon.dictRight, arrayLeft: viewCon.arrayLeft, arrayRight: viewCon.arrayRight, phoneToken: json.data!.phoneToken!, name: viewCon.nameTextField.text!.allowSpecialCharacters , mobileNumber: viewCon.mobileNumberTextField.text! , email: viewCon.emailTextField.text!.allowSpecialCharacters )
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
