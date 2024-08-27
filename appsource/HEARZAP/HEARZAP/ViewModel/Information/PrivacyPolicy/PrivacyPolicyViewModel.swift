//
//  PrivacyPolicyViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct PrivacyPolicyViewModel {
    func getPrivacyPolicyData(canShowLoader: Bool, viewCon: PrivacyPolicyViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// content
        view1.isHidden = true
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(PrivacyPolicyModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.supportDescription = ""
                    viewCon.updatedOn = ""
                    if json.data!.privacyPolicy != nil {
                        if json.data!.privacyPolicy!.supportDescription != nil {
                            if !(json.data!.privacyPolicy!.supportDescription.isNilOrEmpty) {
                                viewCon.supportDescription = json.data!.privacyPolicy!.supportDescription!
                                view1.isHidden = false
                            }
                        }
                        if json.data!.privacyPolicy!.updatedOn != nil {
                            if !(json.data!.privacyPolicy!.updatedOn.isNilOrEmpty) {
                                viewCon.updatedOn = "\(AppLocalizationString.updatedon) \(json.data!.privacyPolicy!.updatedOn!)"
                            }
                        }
                    }
                    viewCon.reloadWebView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
