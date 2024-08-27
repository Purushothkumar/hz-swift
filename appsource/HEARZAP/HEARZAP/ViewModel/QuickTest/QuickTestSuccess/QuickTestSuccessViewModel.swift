//
//  QuickTestSuccessViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 20/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit
struct QuickTestSuccessViewModel {
    func postQuickCheckupdata(canShowLoader: Bool, viewCon: QuickTestSuccessViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(QuickTestSuccessModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.navigateToQuickTestResultViewController(isFrom: viewCon.isFrom, sessionID: viewCon.sessionID)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
