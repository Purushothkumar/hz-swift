//
//  CancelReasonViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 03/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct CancelReasonViewModel {
    func postCancelReason(canShowLoader: Bool, viewCon: CancelOrderViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CancelReasonModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.showToastAlert(AppLocalizationString.cancelSuccess, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: viewCon)
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
