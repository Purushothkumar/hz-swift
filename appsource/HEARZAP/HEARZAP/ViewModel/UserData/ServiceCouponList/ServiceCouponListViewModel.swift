//
//  ServiceCouponListViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 30/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct ServiceCouponListViewModel {
    func getCouponList(canShowLoader: Bool, viewCon: ServiceCouponListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ServiceCouponListModel.self, from: result as Data)
                let view0 = viewCon.mainStackView.arrangedSubviews[0]// banner Image
                let view1 = viewCon.mainStackView.arrangedSubviews[1]// content
                
                view0.isHidden = false
                view1.isHidden = true
                
                let couponview0 = viewCon.couponStackView.arrangedSubviews[0]// text
                let couponview1 = viewCon.couponStackView.arrangedSubviews[1]// or
                let couponview2 = viewCon.couponStackView.arrangedSubviews[2]// select label
                let couponview3 = viewCon.couponStackView.arrangedSubviews[3]// coupon list
                let couponview4 = viewCon.couponStackView.arrangedSubviews[4]// steps list
                
                couponview0.isHidden = true
                couponview1.isHidden = true
                couponview2.isHidden = true
                couponview3.isHidden = true
                couponview4.isHidden = true
                
                if json.data != nil {
                    viewCon.couponStepArray.removeAll()
                    viewCon.listArray.removeAll()
                    viewCon.serviceType = ""
                    viewCon.serviceName = ""
                    viewCon.serviceDesc = ""
                    viewCon.servicePosterPhoto = ""
                    viewCon.serviceMarketingVideoLink = ""
                    
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
                    
                    if json.data!.customerCoupon != nil {
                        viewCon.listArray = json.data!.customerCoupon!
                    }
                    viewCon.reloadCouponTableview()
                    
                    if json.data!.serviceSteps != nil {
                        viewCon.couponStepArray = json.data!.serviceSteps!
                    }
                    viewCon.reloadTableview()
                    view1.isHidden = false
                    couponview0.isHidden = false
                    
                    if viewCon.listArray.count > 0 {
                        couponview1.isHidden = false
                        couponview2.isHidden = false
                        couponview3.isHidden = false
                    }
                    if viewCon.couponStepArray.count > 0 {
                        couponview4.isHidden = false
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func applyCoupon(canShowLoader: Bool, viewCon: ServiceCouponListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ApplyCouponModel.self, from: result as Data)
                if json.data != nil {
                    if (viewCon.isFrom == IsNavigateFrom.ocHomeStatic.rawValue) || (viewCon.isFrom == IsNavigateFrom.ocQuickCheck.rawValue) || (viewCon.isFrom == IsNavigateFrom.ocHearingCare.rawValue) || (viewCon.isFrom == IsNavigateFrom.ocSurveySuccess.rawValue) {
                        viewCon.navigateBackToOnlineConsultationPaymentViewController()
                    } else if (viewCon.isFrom == IsNavigateFrom.baHomeStatic.rawValue) || (viewCon.isFrom == IsNavigateFrom.baHearingCare.rawValue) || (viewCon.isFrom == IsNavigateFrom.baStore.rawValue) || (viewCon.isFrom == IsNavigateFrom.baShop.rawValue) || (viewCon.isFrom == IsNavigateFrom.baMenu.rawValue) || (viewCon.isFrom == IsNavigateFrom.baStoreDetail.rawValue) || (viewCon.isFrom == IsNavigateFrom.baHAProductDetail.rawValue) || (viewCon.isFrom == IsNavigateFrom.baFHA.rawValue) || (viewCon.isFrom == IsNavigateFrom.baQuickCheck.rawValue) || (viewCon.isFrom == IsNavigateFrom.baSurveySuccess.rawValue) || (viewCon.isFrom == IsNavigateFrom.baSurveyRegisterDevice.rawValue) {
                        viewCon.navigateBackToBookAppointmentSummaryViewController()
                    } else if viewCon.isFrom == IsNavigateFrom.cartCoupon.rawValue {
                        viewCon.navigateBackToCheckOutSummaryViewController()
                    } else {
                        viewCon.navigateBackToViewController()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
