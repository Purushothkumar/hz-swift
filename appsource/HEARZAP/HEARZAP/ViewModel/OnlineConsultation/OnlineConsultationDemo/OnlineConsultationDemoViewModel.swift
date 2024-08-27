//
//  OnlineConsultationDemoViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct OnlineConsultationDemoViewModel {
    func getOnlineConsultationStepsList(canShowLoader: Bool, viewCon: OnlineConsultationDemoViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OnlineConsultationDemoModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.onlineConsultationView.isHidden = false
                    
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
                    
                    viewCon.onlineConsultationView.isHidden = true
                    viewCon.onlineConsultationArray.removeAll()
                    viewCon.serviceType = ""
                    viewCon.serviceName = ""
                    viewCon.serviceDesc = ""
                    viewCon.servicePosterPhoto = ""
                    viewCon.serviceMarketingVideoLink = ""
                    
                    if json.data!.ocService != nil {
                        if !(json.data!.ocService!.servicePosterPhoto.isNilOrEmpty) {
                            viewCon.servicePosterPhoto = json.data!.ocService!.servicePosterPhoto!
                        }
                        if !(json.data!.ocService!.serviceDesc.isNilOrEmpty) {
                            viewCon.serviceDesc = json.data!.ocService!.serviceDesc!
                        }
                        if !(json.data!.ocService!.serviceName.isNilOrEmpty) {
                            viewCon.serviceName = json.data!.ocService!.serviceName!
                        }
                        if !(json.data!.ocService!.serviceMarketingVideoLink.isNilOrEmpty) {
                            viewCon.serviceMarketingVideoLink = json.data!.ocService!.serviceMarketingVideoLink!
                        }
                        if !(json.data!.ocService!.serviceType.isNilOrEmpty) {
                            viewCon.serviceType = json.data!.ocService!.serviceType!
                        }
                        view1.isHidden = false
                        view2.isHidden = false
                        view3.isHidden = false
                        contentview0.isHidden = false
                        viewCon.onlineConsultationView.isHidden = false
                        viewCon.changeLanguageFormat()
                    }
                    if json.data!.ocSteps != nil {
                        if json.data!.ocSteps!.count > 0 {
                            viewCon.onlineConsultationArray = json.data!.ocSteps!
                            view1.isHidden = false
                            view2.isHidden = false
                            view3.isHidden = false
                            contentview1.isHidden = false
                            viewCon.onlineConsultationView.isHidden = false
                            viewCon.reloadTableview()
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
