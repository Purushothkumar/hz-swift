//
//  LegalViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 13/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct LegalViewModel {
    func getLegalData(canShowLoader: Bool, viewCon: LegalViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// content
        view1.isHidden = true
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(LegalModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.supportDescription = ""
                    viewCon.updatedOn = ""
                    if json.data!.legal != nil {
                        if json.data!.legal!.supportDescription != nil {
                            if !(json.data!.legal!.supportDescription.isNilOrEmpty) {
                                viewCon.supportDescription = json.data!.legal!.supportDescription!
                                view1.isHidden = false
                            }
                        }
                        if json.data!.legal!.updatedOn != nil {
                            if !(json.data!.legal!.updatedOn.isNilOrEmpty) {
                                viewCon.updatedOn = "\(AppLocalizationString.updatedon) \(json.data!.legal!.updatedOn!)"
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
