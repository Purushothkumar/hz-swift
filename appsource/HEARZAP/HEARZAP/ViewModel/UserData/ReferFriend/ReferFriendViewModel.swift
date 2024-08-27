//
//  ReferFriendViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 17/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct ReferFriendViewModel {
    
    func getReferAFriend(canShowLoader: Bool, viewCon: ReferFriendViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ReferFriendModel.self, from: result as Data)
                let view0 = viewCon.mainStackView.arrangedSubviews[0]// banner Image
                let view1 = viewCon.mainStackView.arrangedSubviews[1]// title
                let view2 = viewCon.mainStackView.arrangedSubviews[2]// list
                let view3 = viewCon.mainStackView.arrangedSubviews[3]// link
                let view4 = viewCon.mainStackView.arrangedSubviews[4]// button
                
                view0.isHidden = false
                view1.isHidden = false
                view2.isHidden = false
                view3.isHidden = true
                view4.isHidden = true
                
                viewCon.serviceType = ""
                viewCon.serviceName = ""
                viewCon.serviceDesc = ""
                viewCon.servicePosterPhoto = ""
                viewCon.serviceMarketingVideoLink = ""
                
                if json.data != nil {
                    if json.data!.service != nil {
                        if !(json.data!.service!.servicePosterPhoto.isNilOrEmpty) {
                            viewCon.servicePosterPhoto = json.data!.service!.servicePosterPhoto!
                        }
                        if !(json.data!.service!.serviceDesc.isNilOrEmpty) {
                            viewCon.serviceDesc = json.data!.service!.serviceDesc!
                        }
                        if !(json.data!.service!.serviceName.isNilOrEmpty) {
                            viewCon.serviceName = json.data!.service!.serviceName!
                        }
                        if !(json.data!.service!.serviceMarketingVideoLink.isNilOrEmpty) {
                            viewCon.serviceMarketingVideoLink = json.data!.service!.serviceMarketingVideoLink!
                        }
                        if !(json.data!.service!.serviceType.isNilOrEmpty) {
                            viewCon.serviceType = json.data!.service!.serviceType!
                        }
                        viewCon.changeLanguageFormat()
                    }
                    
                    if json.data!.serviceSteps != nil {
                        viewCon.stepArray = json.data!.serviceSteps!
                        viewCon.reloadTableview()
                    }
                    if json.data!.referenceLink != nil {
                        view3.isHidden = false
                        view4.isHidden = false
                        viewCon.referenceLink = json.data!.referenceLink!
                        viewCon.changeLanguageFormat()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
