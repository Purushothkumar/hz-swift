//
//  BookAppointmentDemoViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 22/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct BookAppointmentDemoViewModel {
    func getBookAppointmentStepsList(canShowLoader: Bool, viewCon: BookAppointmentDemoViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookAppointmentDemoModel.self, from: result as Data)
                if json.data != nil {
                    let view0 = viewCon.mainStackView.arrangedSubviews[0]// banner Image
                    let view1 = viewCon.mainStackView.arrangedSubviews[1]// content
                    let view2 = viewCon.mainStackView.arrangedSubviews[2]// empty
                    view0.isHidden = false
                    view1.isHidden = true
                    view2.isHidden = true
                    
                    let contentview0 = viewCon.contentStackView.arrangedSubviews[0]// title
                    let contentview1 = viewCon.contentStackView.arrangedSubviews[1]// table
                    contentview0.isHidden = true
                    contentview1.isHidden = true
                    
                    viewCon.bookAppointmentView.isHidden = true
                    viewCon.bookAppointmentArray.removeAll()
                    viewCon.serviceType = ""
                    viewCon.serviceName = ""
                    viewCon.serviceDesc = ""
                    viewCon.servicePosterPhoto = ""
                    viewCon.serviceMarketingVideoLink = ""
                    
                    if json.data!.bookingService != nil {
                        if !(json.data!.bookingService!.servicePosterPhoto.isNilOrEmpty) {
                            viewCon.servicePosterPhoto = json.data!.bookingService!.servicePosterPhoto!
                        }
                        if !(json.data!.bookingService!.serviceDesc.isNilOrEmpty) {
                            viewCon.serviceDesc = json.data!.bookingService!.serviceDesc!
                        }
                        if !(json.data!.bookingService!.serviceName.isNilOrEmpty) {
                            viewCon.serviceName = json.data!.bookingService!.serviceName!
                        }
                        if !(json.data!.bookingService!.serviceMarketingVideoLink.isNilOrEmpty) {
                            viewCon.serviceMarketingVideoLink = json.data!.bookingService!.serviceMarketingVideoLink!
                        }
                        if !(json.data!.bookingService!.serviceType.isNilOrEmpty) {
                            viewCon.serviceType = json.data!.bookingService!.serviceType!
                        }
                        view1.isHidden = false
                        view2.isHidden = false
                        contentview0.isHidden = false
                        viewCon.bookAppointmentView.isHidden = false
                        viewCon.changeLanguageFormat()
                    }
                    if json.data!.bookingSteps != nil {
                        if json.data!.bookingSteps!.count > 0 {
                            viewCon.bookAppointmentArray = json.data!.bookingSteps!
                            view2.isHidden = false
                            view1.isHidden = false
                            contentview1.isHidden = false
                            viewCon.bookAppointmentView.isHidden = false
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
