//
//  AppInformationViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct AboutUsViewModel {
    func getAboutUsData(canShowLoader: Bool, viewCon: AboutUsViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// content
        view1.isHidden = true
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(AboutUsModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.supportDescription = ""
                    viewCon.updatedOn = ""
                    if json.data!.aboutUs != nil {
                        if json.data!.aboutUs!.supportDescription != nil {
                            if !(json.data!.aboutUs!.supportDescription.isNilOrEmpty) {
                                viewCon.supportDescription = (json.data?.aboutUs?.supportDescription)!
                                view1.isHidden = false
                            }
                        }
                        if json.data!.aboutUs?.updatedOn != nil {
                            if !(json.data!.aboutUs!.updatedOn.isNilOrEmpty) {
                                viewCon.updatedOn = "\(AppLocalizationString.updatedon) \(json.data!.aboutUs!.updatedOn!)"
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
