//
//  CheckOutSummaryViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 08/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct CheckOutSummaryViewModel {
    
    func postCheckoutMakePayment(canShowLoader: Bool, viewCon: CheckOutSummaryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(RazorPayModel.self, from: result as Data)
                if json.data != nil {
                    var razorTotalAmount = ""
                    var currency = ""
                    var strRazorOrderId = ""
                    
                    if json.data!.razorpayResponse != nil {
                        if json.data!.razorpayResponse!.amount != nil {
                            razorTotalAmount = String(format: "%d", json.data!.razorpayResponse!.amount!)
                        }
                        if !(json.data!.razorpayResponse!.id.isNilOrEmpty) {
                            strRazorOrderId = json.data!.razorpayResponse!.id!
                        }
                        if !(json.data!.razorpayResponse!.currency.isNilOrEmpty) {
                            currency = json.data!.razorpayResponse!.currency!
                        }
                        if razorTotalAmount.isEmpty {
                            viewCon.showToastAlert(AppLocalizationString.failedRazorPaySupportTeam, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                        } else {
                            viewCon.toShowPaymentForm(strRazorOrderId: strRazorOrderId, razorTotalAmount: razorTotalAmount, currency: currency)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postCheckoutVerifyPayment(canShowLoader: Bool, viewCon: CheckOutSummaryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OnlineConsultationPaymentSuccessModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.navigateToCheckOutConfirmationViewController()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getCheckoutSummary(canShowLoader: Bool, viewCon: CheckOutSummaryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// Address
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// product
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// coupon detail
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// payment
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// Audiologist
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// geninue
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// privacy
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = false
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        view6.isHidden = true
        
        let addressView0 = viewCon.addressStackView.arrangedSubviews[0]// title
        let addressView1 = viewCon.addressStackView.arrangedSubviews[1]// Home
        let addressView2 = viewCon.addressStackView.arrangedSubviews[2]// store
        
        addressView0.isHidden = true
        addressView1.isHidden = true
        
        let homeAddressView0 = viewCon.homeAddressStackView.arrangedSubviews[0]// title
        let homeAddressView1 = viewCon.homeAddressStackView.arrangedSubviews[1]// name
        let homeAddressView2 = viewCon.homeAddressStackView.arrangedSubviews[2]// address
        let homeAddressView3 = viewCon.homeAddressStackView.arrangedSubviews[3]// numer
        let homeAddressView4 = viewCon.homeAddressStackView.arrangedSubviews[4]// line
        
        homeAddressView0.isHidden = true
        homeAddressView1.isHidden = true
        homeAddressView2.isHidden = true
        homeAddressView3.isHidden = true
        homeAddressView4.isHidden = true
        
        let storeAddressView0 = viewCon.storeAddressStackView.arrangedSubviews[0]// title
        let storeAddressView1 = viewCon.storeAddressStackView.arrangedSubviews[1]// name
        let storeAddressView2 = viewCon.storeAddressStackView.arrangedSubviews[2]// address
        let storeAddressView3 = viewCon.storeAddressStackView.arrangedSubviews[3]// numer
        let storeAddressView4 = viewCon.storeAddressStackView.arrangedSubviews[4]// line
        
        storeAddressView0.isHidden = true
        storeAddressView1.isHidden = true
        storeAddressView2.isHidden = true
        storeAddressView3.isHidden = true
        storeAddressView4.isHidden = true
        
        let couponView0 = viewCon.couponStackView.arrangedSubviews[0]// coupon
        couponView0.isHidden = true
        
        let paymentView0 = viewCon.paymentStackView.arrangedSubviews[0]// title
        let paymentView1 = viewCon.paymentStackView.arrangedSubviews[1]// list
        let paymentView2 = viewCon.paymentStackView.arrangedSubviews[2]// line
        let paymentView3 = viewCon.paymentStackView.arrangedSubviews[3]// total
        
        paymentView0.isHidden = true
        paymentView1.isHidden = true
        paymentView2.isHidden = true
        paymentView3.isHidden = true
        
        let productInfoView1 = viewCon.productInfoStackView.arrangedSubviews[1]// Free Shipping
        productInfoView1.isHidden = true
        
        viewCon.reloadItemsTableView()
        viewCon.reloadPriceTableView()
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CheckOutSummaryModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.couponCode = ""
                    viewCon.couponAmount = ""
                    viewCon.paymentStatus = ""
                    viewCon.razorpayPaymentID = ""
                    viewCon.razorpayOrderID = ""
                    viewCon.razorpaySignature = ""
                    viewCon.addressHeading = ""
                    
                    viewCon.totalPrice = ""
                    viewCon.coupontitle = ""
                    viewCon.coupondescription = ""
                    viewCon.isCouponAdded = false
                    viewCon.buttonView.isHidden = false
                    viewCon.canShowFreeShipping = false
                    
                    if json.data!.canShowFreeShipping != nil {
                        viewCon.canShowFreeShipping = json.data!.canShowFreeShipping!
                    }
                    productInfoView1.isHidden = !(viewCon.canShowFreeShipping)
                    
                    if json.data!.addressHeading != nil {
                        if !(json.data!.addressHeading.isNilOrEmpty) {
                            viewCon.addressHeading = json.data!.addressHeading!
                        }
                    }
                    if json.data!.canShowHomeAddress != nil {
                        viewCon.canShowHomeAddress = json.data!.canShowHomeAddress!
                        if viewCon.canShowHomeAddress == true {
                            var address: BookingHomeAddress?
                            
                            if json.data!.homeAddress != nil {
                                address = json.data!.homeAddress!
                            }
                            if address != nil {
                                view0.isHidden = false
                                view5.isHidden = false
                                view6.isHidden = false
                                
                                addressView0.isHidden = false
                                addressView1.isHidden = false
                                
                                if !(address!.name.isNilOrEmpty) {
                                    homeAddressView0.isHidden = false
                                    homeAddressView1.isHidden = false
                                    homeAddressView4.isHidden = false
                                    viewCon.homeAddressNameLabel.text = address!.name!
                                    viewCon.homeAddressTypeView.isHidden = true
                                    if !(address!.addressType.isNilOrEmpty) {
                                        viewCon.homeAddressTypeView.isHidden = false
                                        viewCon.homeAddressTypeLabel.text = address!.addressType
                                        viewCon.homeAddressTypeView.layer.cornerRadius = AppConstantValue.cornerRadius4
                                        viewCon.homeAddressTypeView.clipsToBounds = true
                                        viewCon.homeAddressTypeView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                                        viewCon.homeAddressTypeView.layer.borderWidth = 1.0
                                    }
                                }
                                if !(address!.serviceLocation.isNilOrEmpty) {
                                    homeAddressView0.isHidden = false
                                    homeAddressView2.isHidden = false
                                    homeAddressView4.isHidden = false
                                    viewCon.homeAddressLabel.text = address!.serviceLocation!
                                }
                                if !(address!.mobile.isNilOrEmpty) {
                                    homeAddressView0.isHidden = false
                                    homeAddressView3.isHidden = false
                                    homeAddressView4.isHidden = false
                                    viewCon.homeAddressContactLabel.text = address!.mobile!
                                }
                            }
                        }
                    }
                    if json.data!.canShowStoreAddress != nil {
                        viewCon.canShowStoreAddress = json.data!.canShowStoreAddress!
                        if viewCon.canShowStoreAddress == true {
                            var address: BookingStoreAddress?
                            if json.data!.storeAddress != nil {
                                address = json.data!.storeAddress!
                            }
                            if address != nil {
                                view0.isHidden = false
                                view5.isHidden = false
                                view6.isHidden = false
                                
                                addressView0.isHidden = false
                                addressView2.isHidden = false
                                
                                if !(address!.name.isNilOrEmpty) {
                                    storeAddressView0.isHidden = false
                                    storeAddressView1.isHidden = false
                                    storeAddressView4.isHidden = false
                                    viewCon.storeAddressNameLabel.text = address!.name!
                                    
                                }
                                if !(address!.serviceLocation.isNilOrEmpty) {
                                    storeAddressView0.isHidden = false
                                    storeAddressView2.isHidden = false
                                    storeAddressView4.isHidden = false
                                    viewCon.storeAddressLabel.text = address!.serviceLocation!
                                }
                                if !(address!.mobile.isNilOrEmpty) {
                                    storeAddressView0.isHidden = false
                                    storeAddressView3.isHidden = false
                                    storeAddressView4.isHidden = false
                                    viewCon.storeAddressContactLabel.text = address!.mobile!
                                }
                            }
                        }
                    }
                    if json.data!.orderItems != nil {
                        viewCon.cartListArray = json.data!.orderItems!
                        viewCon.reloadItemsTableView()
                        if viewCon.cartListArray.count > 0 {
                            view1.isHidden = false
                            view5.isHidden = false
                            view6.isHidden = false
                            viewCon.itemsTableViewHeight.constant = ((8 + CGFloat(124) + 8) * CGFloat(viewCon.cartListArray.count)) + 16
                        }
                    }
                    
                    if json.data!.canShowApplyCoupon != nil {
                        viewCon.canShowApplyCoupon = json.data!.canShowApplyCoupon!
                        if viewCon.canShowApplyCoupon == true {
                            if json.data!.couponDetails != nil {
                                view2.isHidden = false
                                view5.isHidden = false
                                view6.isHidden = false
                                couponView0.isHidden = false
                                if !(json.data!.couponDetails!.title.isNilOrEmpty) {
                                    viewCon.coupontitle = json.data!.couponDetails!.title!
                                }
                                if !(json.data!.couponDetails!.description.isNilOrEmpty) {
                                    viewCon.coupondescription = json.data!.couponDetails!.description!
                                }
                                if !(json.data!.couponDetails!.couponCode.isNilOrEmpty) {
                                    viewCon.couponCode = json.data!.couponDetails!.couponCode!
                                }
                                if json.data!.couponDetails!.isCouponAdded != nil {
                                    viewCon.isCouponAdded = json.data!.couponDetails!.isCouponAdded!
                                }
                            }
                        }
                    }
                    if json.data!.canShowPricingDetails != nil {
                        viewCon.canShowPricingDetails = json.data!.canShowPricingDetails!
                        if viewCon.canShowPricingDetails == true {
                            if json.data!.pricingDetails != nil {
                                viewCon.priceDetailsArray = json.data!.pricingDetails!
                                viewCon.reloadPriceTableView()
                                if viewCon.priceDetailsArray.count > 0 {
                                    view3.isHidden = false
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    paymentView0.isHidden = false
                                    paymentView1.isHidden = false
                                    paymentView2.isHidden = false
                                }
                            }
                        }
                    }
                    
                    if !(json.data!.totalPrice.isNilOrEmpty) {
                        view3.isHidden = false
                        view5.isHidden = false
                        view6.isHidden = false
                        
                        paymentView0.isHidden = false
                        paymentView3.isHidden = false
                        viewCon.totalPrice = json.data!.totalPrice!
                    }
                    
                    if json.data!.canShowAudiologistApproval != nil {
                        viewCon.canShowPricingDetails = json.data!.canShowAudiologistApproval!
                        if viewCon.canShowPricingDetails == false {
                            view4.isHidden = false
                            view5.isHidden = false
                            view6.isHidden = false
                            
                            viewCon.audiologistButton.setImage(viewCon.isAudiologistPrescribed == false ? UIImage(named: Asset.checksquarewhite) : UIImage(named: Asset.checksquareblueFill), for: .normal)
                        }
                    }
                    viewCon.reloadItemsTableView()
                    viewCon.reloadPriceTableView()
                    viewCon.changeLanguageFormat()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func applyCoupon(canShowLoader: Bool, viewCon: CheckOutSummaryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ApplyCouponModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.commonAPICALL(retryAPIID: 1002)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
