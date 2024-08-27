//
//  OnlineConsultationPaymentViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 24/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct OnlineConsultationPaymentViewModel {
    func postOnlineConsultationMakePayment(canShowLoader: Bool, viewCon: OnlineConsultationPaymentViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
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
    func postOnlineConsultationVerifyPayment(canShowLoader: Bool, viewCon: OnlineConsultationPaymentViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OnlineConsultationPaymentSuccessModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.navigateToOnlineConsultationConfirmationViewController(isFrom: viewCon.isFrom, bookingUid: viewCon.bookingUid)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getBookingSummary(canShowLoader: Bool, viewCon: OnlineConsultationPaymentViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// info
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// service
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// coupon detail
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// payment
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// privacy
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = false
        view3.isHidden = true
        view4.isHidden = true
        
        let bookingDetailsView0 = viewCon.bookingDetailsStackView.arrangedSubviews[0]// title
        let bookingDetailsView1 = viewCon.bookingDetailsStackView.arrangedSubviews[1]// audiologist
        let bookingDetailsView2 = viewCon.bookingDetailsStackView.arrangedSubviews[2]// date
        let bookingDetailsView3 = viewCon.bookingDetailsStackView.arrangedSubviews[3]// time
        let bookingDetailsView4 = viewCon.bookingDetailsStackView.arrangedSubviews[4]// time
        
        bookingDetailsView0.isHidden = true
        bookingDetailsView1.isHidden = true
        bookingDetailsView2.isHidden = true
        bookingDetailsView3.isHidden = true
        bookingDetailsView4.isHidden = true
        
        let serviceDetailsView0 = viewCon.serviceDetailsStackView.arrangedSubviews[0]// title
        let serviceDetailsView1 = viewCon.serviceDetailsStackView.arrangedSubviews[1]// list qty
        
        serviceDetailsView0.isHidden = true
        serviceDetailsView1.isHidden = true
        
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
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookingSummaryModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.couponCode = ""
                    viewCon.couponAmount = ""
                    viewCon.paymentStatus = ""
                    viewCon.razorpayPaymentID = ""
                    viewCon.razorpayOrderID = ""
                    viewCon.razorpaySignature = ""
                    viewCon.name = ""
                    viewCon.specialization = ""
                    viewCon.experience = ""
                    viewCon.audiologistuid = ""
                    viewCon.canShowAudiologistStaff = false
                    viewCon.canShowHomeAddress = false
                    viewCon.canShowStoreAddress = false
                    viewCon.scheduleDate = ""
                    viewCon.timeSlot = ""
                    viewCon.canShowApplyCoupon = false
                    viewCon.canShowPricingDetails = false
                    viewCon.totalPrice = ""
                    viewCon.coupontitle = ""
                    viewCon.coupondescription = ""
                    viewCon.isCouponAdded = false
                    view4.isHidden = false
                    viewCon.buttonView.isHidden = false
                    
                    if json.data!.visitType != nil {
                        if !(json.data!.visitType.isNilOrEmpty) {
                            viewCon.visitType = json.data!.visitType!
                        }
                    }
                    if json.data!.canShowAudiologistStaff != nil {
                        viewCon.canShowAudiologistStaff = json.data!.canShowAudiologistStaff!
                        if viewCon.canShowAudiologistStaff == true {
                            if json.data!.serviceStaff != nil {
                                if json.data!.serviceStaff!.audiologistDetails != nil {
                                    viewCon.audiologistDetails = json.data!.serviceStaff!.audiologistDetails!
                                }
                            }
                            if viewCon.audiologistDetails != nil {
                                view0.isHidden = false
                                bookingDetailsView0.isHidden = false
                                bookingDetailsView1.isHidden = false
                                if !(viewCon.audiologistDetails!.name.isNilOrEmpty) {
                                    viewCon.name = viewCon.audiologistDetails!.name!
                                }
                                if !(viewCon.audiologistDetails!.designationName.isNilOrEmpty) {
                                    viewCon.designationName = viewCon.audiologistDetails!.designationName!
                                }
                                if !(viewCon.audiologistDetails!.specializationDegree.isNilOrEmpty) {
                                    viewCon.specializationDegree = viewCon.audiologistDetails!.specializationDegree!
                                }
                                if !(viewCon.audiologistDetails!.experience.isNilOrEmpty) {
                                    viewCon.experience = viewCon.audiologistDetails!.experience!
                                }
                                if  !(viewCon.audiologistDetails!.specialization.isNilOrEmpty) {
                                    viewCon.specialization = viewCon.audiologistDetails!.specialization!
                                }
                                if !(viewCon.audiologistDetails!.photo.isNilOrEmpty) {
                                    viewCon.photo = viewCon.audiologistDetails!.photo!
                                }
                            }
                            
                            viewCon.audiologistExperienceLabel.text = ""
                            viewCon.audiologistImageView.setImage(imageUrl: viewCon.photo, placeHolderImage: profileBlue)
                            viewCon.audiologistNameLabel.text = viewCon.name
                            if !(viewCon.specializationDegree.isEmpty) && !(viewCon.experience.isEmpty) {
                                viewCon.audiologistExperienceLabel.text = String(format: "%@ (%@)", viewCon.specializationDegree, viewCon.experience)
                            } else if !(viewCon.specializationDegree.isEmpty) || !(viewCon.experience.isEmpty) {
                                if !(viewCon.specializationDegree.isEmpty) {
                                    viewCon.audiologistExperienceLabel.text = viewCon.specializationDegree
                                } else if !(viewCon.experience.isEmpty) {
                                    viewCon.audiologistExperienceLabel.text = viewCon.experience
                                }
                            }
                            viewCon.audiologistSpecialisationLabel.text = viewCon.specialization
                        }
                    }
                    if json.data!.timeSlot != nil {
                        if !(json.data!.timeSlot.isNilOrEmpty) {
                            viewCon.timeSlot = json.data!.timeSlot!.lowercased()
                            view0.isHidden = false
                            bookingDetailsView0.isHidden = false
                            bookingDetailsView3.isHidden = false
                            bookingDetailsView4.isHidden = false
                        }
                    }
                    
                    if json.data!.scheduleDate != nil {
                        if !(json.data!.scheduleDate.isNilOrEmpty) {
                            viewCon.scheduleDate = json.data!.scheduleDate!
                            view0.isHidden = false
                            bookingDetailsView0.isHidden = false
                            bookingDetailsView2.isHidden = false
                            bookingDetailsView4.isHidden = false
                        }
                    }
                    viewCon.dateDescLabel.text = viewCon.scheduleDate
                    viewCon.timeDescLabel.text = viewCon.timeSlot
                    
                    if json.data!.serviceRequestsList != nil {
                        viewCon.serviceRequestsListArray = json.data!.serviceRequestsList!
                        viewCon.reloadServiceDetailsQtyTableView()
                        if viewCon.serviceRequestsListArray.count > 0 {
                            view1.isHidden = false
                            serviceDetailsView0.isHidden = false
                            serviceDetailsView1.isHidden = false
                        }
                    }
                    if json.data!.canShowApplyCoupon != nil {
                        viewCon.canShowApplyCoupon = json.data!.canShowApplyCoupon!
                        if viewCon.canShowApplyCoupon == true {
                            if json.data!.couponDetails != nil {
                                view2.isHidden = false
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
                        viewCon.canShowPricingDetails = json.data!.canShowApplyCoupon!
                        if viewCon.canShowPricingDetails == true {
                            if json.data!.pricingDetails != nil {
                                viewCon.priceDetailsArray = json.data!.pricingDetails!
                                if viewCon.priceDetailsArray.count > 0 {
                                    view3.isHidden = false
                                    paymentView0.isHidden = false
                                    paymentView1.isHidden = false
                                    paymentView2.isHidden = false
                                    viewCon.reloadPriceTableView()
                                }
                            }
                        }
                    }
                    
                    if !(json.data!.totalPrice.isNilOrEmpty) {
                        view3.isHidden = false
                        paymentView0.isHidden = false
                        paymentView3.isHidden = false
                        viewCon.totalPrice = json.data!.totalPrice!
                    }
                    viewCon.changeLanguageFormat()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func applyCoupon(canShowLoader: Bool, viewCon: OnlineConsultationPaymentViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
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
