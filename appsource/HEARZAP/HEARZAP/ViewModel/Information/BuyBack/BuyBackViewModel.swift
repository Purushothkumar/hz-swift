//
//  BuyBackViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 21/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct BuyBackViewModel {
    func getBuybackData(canShowLoader: Bool, viewCon: BuyBackViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BuyBackModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.buyBackDescriptionView.isHidden = true
                    viewCon.buybackArray.removeAll()
                    viewCon.reloadTableview()
                    viewCon.serviceType = ""
                    viewCon.serviceName = ""
                    viewCon.serviceDesc = ""
                    viewCon.servicePosterPhoto = ""
                    viewCon.serviceMarketingVideoLink = ""
                    viewCon.talkToExpertView.isHidden = true
                    
                    let view0 = viewCon.mainStackView.arrangedSubviews[0]// banner Image
                    let view1 = viewCon.mainStackView.arrangedSubviews[1]// content
                    let view2 = viewCon.mainStackView.arrangedSubviews[2]// policy
                    let view3 = viewCon.mainStackView.arrangedSubviews[3]// empty
                    view0.isHidden = false
                    view1.isHidden = true
                    view2.isHidden = true
                    view3.isHidden = true
                    
                    let contentview0 = viewCon.contentStackView.arrangedSubviews[0]// title
                    let contentview1 = viewCon.contentStackView.arrangedSubviews[1]// table
                    contentview0.isHidden = true
                    contentview1.isHidden = true
                    
                    if json.data!.buybackData != nil {
                        if json.data!.buybackData?.buybackService != nil {
                            if !(json.data!.buybackData!.buybackService!.servicePosterPhoto.isNilOrEmpty) {
                                viewCon.servicePosterPhoto = json.data!.buybackData!.buybackService!.servicePosterPhoto!
                            }
                            if !(json.data!.buybackData!.buybackService!.serviceDesc.isNilOrEmpty) {
                                viewCon.serviceDesc = json.data!.buybackData!.buybackService!.serviceDesc!
                            }
                            if !(json.data!.buybackData!.buybackService!.serviceName.isNilOrEmpty) {
                                viewCon.serviceName = json.data!.buybackData!.buybackService!.serviceName!
                            }
                            if !(json.data!.buybackData!.buybackService!.serviceMarketingVideoLink.isNilOrEmpty) {
                                viewCon.serviceMarketingVideoLink = json.data!.buybackData!.buybackService!.serviceMarketingVideoLink!
                            }
                            if !(json.data!.buybackData!.buybackService!.serviceType.isNilOrEmpty) {
                                viewCon.serviceType = json.data!.buybackData!.buybackService!.serviceType!
                            }
                            view1.isHidden = false
                            view2.isHidden = false
                            view3.isHidden = false
                            contentview0.isHidden = false
                            viewCon.talkToExpertView.isHidden = false
                            viewCon.changeLanguageFormat()
                        }
                    }
                    if json.data!.buybackData!.buybackSteps != nil {
                        if json.data!.buybackData!.buybackSteps!.count > 0 {
                            viewCon.buybackArray = json.data!.buybackData!.buybackSteps!
                            view1.isHidden = false
                            view2.isHidden = false
                            view3.isHidden = false
                            contentview1.isHidden = false
                            viewCon.talkToExpertView.isHidden = false
                            viewCon.reloadTableview()
                        }
                    }
                    viewCon.viewWillLayoutSubviews()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
