//
//  ReturnReasonViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 13/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct ReturnReasonViewModel {
    func postReturnReason(canShowLoader: Bool, viewCon: ReturnReasonViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ReturnReasonModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.showToastAlert(AppLocalizationString.returnSuccess, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: viewCon)
                    UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
                    UserDefaults.standard.synchronize()
                    viewCon.sceneDelegate?.navigateToCustomTabbar()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
