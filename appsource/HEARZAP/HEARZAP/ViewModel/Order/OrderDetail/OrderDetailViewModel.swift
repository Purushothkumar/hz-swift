//
//  OrderDetailViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 10/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct OrderDetailViewModel {
    func getOrderDetail(canShowLoader: Bool, viewCon: OrderDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OrderDetailModel.self, from: result as Data)
                if json.data != nil {
                    if (retryAPIID == 2000) || (retryAPIID == 2001) {
                        viewCon.refreshControl.endRefreshing()
                    }
                    viewCon.paymentDateLabel.text = ""
                    viewCon.paymentModeLabel.text = ""
                    viewCon.paymentAmountLabel.text = ""
                    viewCon.paymentIDLabel.text = ""
                    viewCon.trackingIdLabel.text = ""
                    viewCon.refundAmountLabel.text = ""
                    viewCon.refundStatusLabel.text = ""
                    viewCon.orderReasonLabel.text = ""
                    viewCon.orderStatusLabel.text = ""
                    viewCon.orderIDLabel.text = ""
                    viewCon.orderAmountLabel.text = ""
                    viewCon.orderDateLabel.text = ""
                    viewCon.deliveryLocationLabel.text = ""
                    viewCon.orderDateStatusLabel.text = ""
                    viewCon.invoiceDocument = ""
                    viewCon.paymentReceipt = ""
                    viewCon.trackingCode = ""
                    viewCon.trackingURL = ""
                    
                    viewCon.productListArray.removeAll()
                    viewCon.trackingStatusArray.removeAll()
                    viewCon.returnReasonList.removeAll()
                    viewCon.cancelReasonList.removeAll()
                    
                    viewCon.canShowOrderItem = false
                    viewCon.canShowTrackingDetails = false
                    viewCon.canShowDeliveryAddress = false
                    viewCon.canShowOrderDetail = false
                    viewCon.canShowCancelOrder = false
                    viewCon.canShowReturnOrderItem = false
                    viewCon.canShowPaymentDetails = false
                    viewCon.canShowTrackingInfo = false
                    
                    let view0 = viewCon.mainStackView.arrangedSubviews[0] // title
                    let view1 = viewCon.mainStackView.arrangedSubviews[1] // Address
                    let view2 = viewCon.mainStackView.arrangedSubviews[2] // information
                    let view3 = viewCon.mainStackView.arrangedSubviews[3] // tracking
                    let view4 = viewCon.mainStackView.arrangedSubviews[4] // payment
                    
                    view0.isHidden = true
                    view1.isHidden = true
                    view2.isHidden = true
                    view3.isHidden = true
                    view4.isHidden = true
                    
                    let addressview0 = viewCon.addressInfoStackView.arrangedSubviews[0] // ordertype
                    let addressview1 = viewCon.addressInfoStackView.arrangedSubviews[1] // Address title
                    let addressview2 = viewCon.addressInfoStackView.arrangedSubviews[2] // Address
                    
                    addressview0.isHidden = true
                    addressview1.isHidden = true
                    addressview2.isHidden = true
                    
                    let infoview0 = viewCon.infoStackView.arrangedSubviews[0] // booking
                    let infoview1 = viewCon.infoStackView.arrangedSubviews[1] // line
                    let infoview2 = viewCon.infoStackView.arrangedSubviews[2] // list
                    let infoview3 = viewCon.infoStackView.arrangedSubviews[3] // line
                    let infoview4 = viewCon.infoStackView.arrangedSubviews[4] // help/cancel button
                    let infoview5 = viewCon.infoStackView.arrangedSubviews[5] // return
                    
                    infoview0.isHidden = true
                    infoview1.isHidden = true
                    infoview2.isHidden = true
                    infoview3.isHidden = true
                    infoview4.isHidden = true
                    infoview5.isHidden = true
                    
                    let bookingview0 = viewCon.bookingStackView.arrangedSubviews[0] // title
                    let bookingview1 = viewCon.bookingStackView.arrangedSubviews[1] // id
                    let bookingview2 = viewCon.bookingStackView.arrangedSubviews[2] // date
                    let bookingview3 = viewCon.bookingStackView.arrangedSubviews[3] // amount
                    let bookingview4 = viewCon.bookingStackView.arrangedSubviews[4] // status
                    let bookingview5 = viewCon.bookingStackView.arrangedSubviews[5] // reason
                    let bookingview6 = viewCon.bookingStackView.arrangedSubviews[6] // refund status
                    let bookingview7 = viewCon.bookingStackView.arrangedSubviews[7] // refund amount
                    
                    bookingview0.isHidden = true
                    bookingview1.isHidden = true
                    bookingview2.isHidden = true
                    bookingview3.isHidden = true
                    bookingview4.isHidden = true
                    bookingview5.isHidden = true
                    bookingview6.isHidden = true
                    bookingview7.isHidden = true
                    
                    let buttonview0 = viewCon.buttonStackView.arrangedSubviews[0] // left
                    let buttonview1 = viewCon.buttonStackView.arrangedSubviews[1] // line
                    let buttonview2 = viewCon.buttonStackView.arrangedSubviews[2] // right
                    
                    buttonview0.isHidden = true
                    buttonview1.isHidden = true
                    buttonview2.isHidden = true
                    
                    let trackingview0 = viewCon.trackingStackView.arrangedSubviews[0] // empty
                    let trackingview1 = viewCon.trackingStackView.arrangedSubviews[1] // title
                    let trackingview2 = viewCon.trackingStackView.arrangedSubviews[2] // line
                    let trackingview3 = viewCon.trackingStackView.arrangedSubviews[3] // list
                    let trackingview4 = viewCon.trackingStackView.arrangedSubviews[4] // empty
                    
                    trackingview0.isHidden = true
                    trackingview1.isHidden = true
                    trackingview2.isHidden = true
                    trackingview3.isHidden = true
                    trackingview4.isHidden = true
                    
                    let paymentview0 = viewCon.paymentStackView.arrangedSubviews[0] // amount
                    let paymentview1 = viewCon.paymentStackView.arrangedSubviews[1] // mode
                    let paymentview2 = viewCon.paymentStackView.arrangedSubviews[2] // id
                    let paymentview3 = viewCon.paymentStackView.arrangedSubviews[3] // date
                    let paymentview4 = viewCon.paymentStackView.arrangedSubviews[4] // line
                    let paymentview5 = viewCon.paymentStackView.arrangedSubviews[5] // receipt/invoice button
                    
                    paymentview0.isHidden = true
                    paymentview1.isHidden = true
                    paymentview2.isHidden = true
                    paymentview3.isHidden = true
                    paymentview4.isHidden = true
                    paymentview5.isHidden = true
                    
                    let downloadbuttonview0 = viewCon.downloadButtonStackView.arrangedSubviews[0] // left
                    let downloadbuttonview1 = viewCon.downloadButtonStackView.arrangedSubviews[1] // line
                    let downloadbuttonview2 = viewCon.downloadButtonStackView.arrangedSubviews[2] // right
                    
                    downloadbuttonview0.isHidden = true
                    downloadbuttonview1.isHidden = true
                    downloadbuttonview2.isHidden = true
                    
                    if json.data!.canShowOrderItem != nil {
                        viewCon.canShowOrderItem = json.data!.canShowOrderItem!
                    }
                    if json.data!.canShowTrackingDetails != nil {
                        viewCon.canShowTrackingDetails = json.data!.canShowTrackingDetails!
                    }
                    if json.data!.canShowDeliveryAddress != nil {
                        viewCon.canShowDeliveryAddress = json.data!.canShowDeliveryAddress!
                    }
                    if json.data!.canShowOrderDetail != nil {
                        viewCon.canShowOrderDetail = json.data!.canShowOrderDetail!
                    }
                    if json.data!.canShowCancelOrder != nil {
                        viewCon.canShowCancelOrder = json.data!.canShowCancelOrder!
                    }
                    if json.data!.canShowReturnOrderItem != nil {
                        viewCon.canShowReturnOrderItem = json.data!.canShowReturnOrderItem!
                    }
                    if json.data!.canShowPaymentDetails != nil {
                        viewCon.canShowPaymentDetails = json.data!.canShowPaymentDetails!
                    }
                    if json.data!.returnReasonList != nil {
                        viewCon.returnReasonList = json.data!.returnReasonList!
                    }
                    if json.data!.cancelReasonList != nil {
                        viewCon.cancelReasonList = json.data!.cancelReasonList!
                    }
                    if json.data!.orderInfo != nil {
                        var orderDate = ""
                        var statusName = ""
                        var statusTextColor = UIColor.colorLiteral.theme_blue_2AACEF
                        viewCon.orderTitleLabel.text = ""
                        viewCon.orderDateStatusLabel.text = ""
                        
                        if !(json.data!.orderInfo!.orderNumber.isNilOrEmpty) {
                            viewCon.orderID = json.data!.orderInfo!.orderNumber!
                        }
                        if !(viewCon.orderID.isEmpty) {
                            view0.isHidden = false
                            view1.isHidden = false
                            addressview0.isHidden = false
                            viewCon.orderTitleLabel.text = String(format: "%@ (%@)", viewCon.isReturn == false ? AppLocalizationString.order : AppLocalizationString.returnOrder, viewCon.orderID)
                            viewCon.orderTitleLabel.text = viewCon.orderID
                        }
                        
                        if !(json.data!.orderInfo!.orderDate.isNilOrEmpty) {
                            orderDate = json.data!.orderInfo!.orderDate!
                        }
                        if !(json.data!.orderInfo!.statusName.isNilOrEmpty) {
                            statusName = json.data!.orderInfo!.statusName!.capitalized
                        }
                        if !(json.data!.orderInfo!.statusTextColor.isNilOrEmpty) {
                            statusTextColor = UIColor(hexString: json.data!.orderInfo!.statusTextColor!, alpha: 1.0)
                        }
                        //                        if viewCon.isReturn == true && viewCon.canShowDeliveryAddress == true{
                        //                            if json.data!.orderInfo!.serviceLocation != nil {
                        //                                if !(json.data!.orderInfo!.serviceLocation.isNilOrEmpty) {
                        //                                    view0.isHidden = false
                        //                                    view1.isHidden = false
                        //                                    addressview1.isHidden = false
                        //                                    addressview2.isHidden = false
                        //                                    viewCon.deliveryLocationLabel.text = json.data!.orderInfo!.serviceLocation!.capitalized
                        //                                }
                        //                            }
                        //                        }
                        
                        if !(orderDate.isEmpty) && !(statusName.isEmpty) {
                            view0.isHidden = false
                            view1.isHidden = false
                            addressview0.isHidden = false
                            let combination = NSMutableAttributedString()
                            let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
                            let statusFontAttributes = [NSAttributedString.Key.foregroundColor: statusTextColor, NSAttributedString.Key.font: AppFont.regular.size(13)]
                            let date = NSMutableAttributedString(string: String(format: "%@ | ", orderDate), attributes: dateFontAttributes as [NSAttributedString.Key: Any])
                            let status = NSMutableAttributedString(string: String(format: "%@", statusName), attributes: statusFontAttributes as [NSAttributedString.Key: Any])
                            combination.append(date)
                            combination.append(status)
                            viewCon.orderDateStatusLabel.attributedText = combination
                        } else if !(orderDate.isEmpty) {
                            view0.isHidden = false
                            view1.isHidden = false
                            addressview0.isHidden = false
                            let combination = NSMutableAttributedString()
                            let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
                            let date = NSMutableAttributedString(string: String(format: "%@", orderDate), attributes: dateFontAttributes as [NSAttributedString.Key: Any])
                            combination.append(date)
                            viewCon.orderDateStatusLabel.attributedText = combination
                        } else if !(statusName.isEmpty) {
                            view0.isHidden = false
                            view1.isHidden = false
                            addressview0.isHidden = false
                            let combination = NSMutableAttributedString()
                            let statusFontAttributes = [NSAttributedString.Key.foregroundColor: statusTextColor, NSAttributedString.Key.font: AppFont.regular.size(13)]
                            let status = NSMutableAttributedString(string: String(format: "%@", statusName), attributes: statusFontAttributes as [NSAttributedString.Key: Any])
                            combination.append(status)
                            viewCon.orderDateStatusLabel.attributedText = combination
                        }
                    }
                    if viewCon.canShowDeliveryAddress == true {
                        if json.data!.deliveryAddress != nil {
                            if !(json.data!.deliveryAddress!.deliveryLocation.isNilOrEmpty) {
                                view0.isHidden = false
                                view1.isHidden = false
                                addressview1.isHidden = false
                                addressview2.isHidden = false
                                viewCon.deliveryLocationLabel.text = json.data!.deliveryAddress!.deliveryLocation!.capitalized
                            }
                        }
                    }
                    if viewCon.canShowOrderDetail == true {
                        var orderID = ""
                        var orderDate = ""
                        var orderAmount = ""
                        var orderStatus = ""
                        var cancelledDate = ""
                        var cancellationReason = ""
                        var cancellationComments = ""
                        var refundStatus = ""
                        var refundReqAmount = ""
                        var canShowCancellationDetails = false
                        var canShowRefundDetails = false
                        var statusTextColor = UIColor.colorLiteral.theme_blue_2AACEF
                        
                        if !(json.data!.orderDetails!.orderID.isNilOrEmpty) {
                            orderID = json.data!.orderDetails!.orderID!
                        }
                        if !(json.data!.orderDetails!.orderDate.isNilOrEmpty) {
                            orderDate = json.data!.orderDetails!.orderDate!
                        }
                        if !(json.data!.orderDetails!.orderAmount.isNilOrEmpty) {
                            orderAmount = json.data!.orderDetails!.orderAmount!
                        }
                        if !(json.data!.orderDetails!.orderStatus.isNilOrEmpty) {
                            orderStatus = json.data!.orderDetails!.orderStatus!
                        }
                        if !(json.data!.orderDetails!.statusTextColor.isNilOrEmpty) {
                            statusTextColor = UIColor(hexString: json.data!.orderDetails!.statusTextColor!, alpha: 1.0)
                        }
                        if !(json.data!.orderDetails!.cancelledDate.isNilOrEmpty) {
                            cancelledDate = json.data!.orderDetails!.cancelledDate!
                        }
                        if !(json.data!.orderDetails!.cancellationReason.isNilOrEmpty) {
                            cancellationReason = json.data!.orderDetails!.cancellationReason!
                        }
                        if !(json.data!.orderDetails!.cancellationComments.isNilOrEmpty) {
                            cancellationComments = json.data!.orderDetails!.cancellationComments!
                        }
                        if !(json.data!.orderDetails!.refundStatus.isNilOrEmpty) {
                            refundStatus = json.data!.orderDetails!.refundStatus!
                        }
                        if !(json.data!.orderDetails!.refundReqAmount.isNilOrEmpty) {
                            refundReqAmount = json.data!.orderDetails!.refundReqAmount!
                        }
                        if json.data!.orderDetails!.canShowCancellationDetails != nil {
                            canShowCancellationDetails = json.data!.orderDetails!.canShowCancellationDetails!
                        }
                        if json.data!.orderDetails!.canShowRefundDetails != nil {
                            canShowRefundDetails = json.data!.orderDetails!.canShowRefundDetails!
                        }
                        if !(orderID.isEmpty) {
                            view2.isHidden = false
                            infoview0.isHidden = false
                            infoview3.isHidden = false
                            infoview4.isHidden = false
                            bookingview0.isHidden = false
                            bookingview1.isHidden = false
                            buttonview2.isHidden = false
                            viewCon.orderIDLabel.text = orderID
                        }
                        if !(orderDate.isEmpty) {
                            view2.isHidden = false
                            infoview0.isHidden = false
                            infoview3.isHidden = false
                            infoview4.isHidden = false
                            bookingview0.isHidden = false
                            bookingview2.isHidden = false
                            buttonview2.isHidden = false
                            viewCon.orderDateLabel.text = orderDate
                        }
                        if !(orderAmount.isEmpty) {
                            view2.isHidden = false
                            infoview0.isHidden = false
                            infoview3.isHidden = false
                            infoview4.isHidden = false
                            bookingview0.isHidden = false
                            bookingview3.isHidden = false
                            buttonview2.isHidden = false
                            if orderAmount.contains("Rs.") {
                                viewCon.orderAmountLabel.text = orderAmount
                            } else {
                                viewCon.orderAmountLabel.text = String(format: "%@ %@", AppConstantValue.rupeesymbol, orderAmount)
                            }
                        }
                        if !(orderStatus.isEmpty) {
                            view2.isHidden = false
                            infoview0.isHidden = false
                            infoview3.isHidden = false
                            infoview4.isHidden = false
                            bookingview0.isHidden = false
                            bookingview4.isHidden = false
                            buttonview2.isHidden = false
                            let combination = NSMutableAttributedString()
                            let statusFontAttributes = [NSAttributedString.Key.foregroundColor: statusTextColor, NSAttributedString.Key.font: AppFont.regular.size(13)]
                            let status = NSMutableAttributedString(string: orderStatus, attributes: statusFontAttributes as [NSAttributedString.Key: Any])
                            combination.append(status)
                            viewCon.orderStatusLabel.attributedText = status
                        }
                        if !(cancellationReason.isEmpty) && (canShowCancellationDetails == true) {
                            view2.isHidden = false
                            infoview0.isHidden = false
                            infoview3.isHidden = false
                            infoview4.isHidden = false
                            bookingview0.isHidden = false
                            bookingview5.isHidden = false
                            buttonview2.isHidden = false
                            viewCon.orderReasonLabel.text = cancellationReason
                        } else if !(cancellationReason.isEmpty) && (canShowRefundDetails == true) {
                            view2.isHidden = false
                            infoview0.isHidden = false
                            infoview3.isHidden = false
                            infoview4.isHidden = false
                            bookingview0.isHidden = false
                            bookingview5.isHidden = false
                            buttonview2.isHidden = false
                            viewCon.orderReasonLabel.text = cancellationReason
                        }
                        if !(refundStatus.isEmpty) && (canShowRefundDetails == true) {
                            view2.isHidden = false
                            infoview0.isHidden = false
                            infoview3.isHidden = false
                            infoview4.isHidden = false
                            bookingview0.isHidden = false
                            bookingview6.isHidden = false
                            buttonview2.isHidden = false
                            viewCon.refundStatusLabel.text = refundStatus
                        }
                        if !(refundReqAmount.isEmpty) && (canShowRefundDetails == true) {
                            if (refundReqAmount != "0.00") && (refundReqAmount != "0") && (refundReqAmount != "Rs. 0.00") && (refundReqAmount != "Rs.0.00"){
                                view2.isHidden = false
                                infoview0.isHidden = false
                                infoview3.isHidden = false
                                infoview4.isHidden = false
                                bookingview0.isHidden = false
                                bookingview7.isHidden = false
                                buttonview2.isHidden = false
                                if refundReqAmount.contains("Rs.") {
                                    viewCon.refundAmountLabel.text = refundReqAmount
                                } else {
                                    viewCon.refundAmountLabel.text = String(format: "%@ %@", AppConstantValue.rupeesymbol, refundReqAmount)
                                }
                            }
                        }
                    }
                    if (viewCon.canShowReturnOrderItem == true) && (viewCon.isReturn == true) {
                        if json.data!.orderItemList != nil {
                            viewCon.productListArray = json.data!.orderItemList!
                            viewCon.reloadItemTableview()
                            if viewCon.productListArray.count > 0 {
                                view2.isHidden = false
                                infoview1.isHidden = false
                                infoview2.isHidden = false
                                buttonview2.isHidden = false
                                view2.isHidden = false
                                infoview3.isHidden = false
                                infoview4.isHidden = false
                                buttonview2.isHidden = false
                            }
                        }
                    }
                    if (viewCon.canShowOrderItem == true) && (viewCon.isReturn == false) {
                        if json.data!.orderItemList != nil {
                            viewCon.productListArray = json.data!.orderItemList!
                            viewCon.reloadItemTableview()
                            if viewCon.productListArray.count > 0 {
                                view2.isHidden = false
                                infoview1.isHidden = false
                                infoview2.isHidden = false
                                view2.isHidden = false
                                infoview3.isHidden = false
                                infoview4.isHidden = false
                                buttonview2.isHidden = false
                            }
                        }
                    }
                    if (viewCon.canShowCancelOrder == true) && (viewCon.cancelReasonList.count > 0) && (viewCon.productListArray.count > 0) {
                        view2.isHidden = false
                        infoview3.isHidden = false
                        infoview4.isHidden = false
                        buttonview0.isHidden = false
                        buttonview1.isHidden = false
                        buttonview2.isHidden = false
                    }
                    if (viewCon.canShowReturnOrderItem == true) && (viewCon.returnReasonList.count > 0) && (viewCon.productListArray.count > 0) {
                        var canShowReturnOrderItem = false
                        for item in viewCon.productListArray {
                            if item.canShowInReturn != nil {
                                if item.canShowInReturn == true {
                                    canShowReturnOrderItem = true
                                }
                            }
                        }
                        if canShowReturnOrderItem == true {
                            view2.isHidden = false
                            infoview3.isHidden = false
                            infoview5.isHidden = false
                            view2.isHidden = false
                            infoview3.isHidden = false
                            infoview4.isHidden = false
                            buttonview2.isHidden = false
                        }
                    }
                    if viewCon.canShowTrackingDetails == true {
                        if json.data!.trackingDetails != nil {
                            if json.data!.trackingDetails!.statusList != nil {
                                viewCon.trackingStatusArray = json.data!.trackingDetails!.statusList!
                                viewCon.reloadTrackingTableView()
                                if viewCon.trackingStatusArray.count > 0 {
                                    view3.isHidden = false
                                    trackingview0.isHidden = false
                                    trackingview3.isHidden = false
                                    trackingview4.isHidden = false
                                }
                            }
                            if json.data!.trackingDetails!.canShowTrackingInfo != nil {
                                viewCon.canShowTrackingInfo = json.data!.trackingDetails!.canShowTrackingInfo!
                                if viewCon.canShowTrackingInfo == true {
                                    if json.data!.trackingDetails!.trackingInfo != nil {
                                        if !(json.data!.trackingDetails!.trackingInfo!.trackingURL.isNilOrEmpty) {
                                            viewCon.trackingURL = json.data!.trackingDetails!.trackingInfo!.trackingURL!
                                        }
                                        if !(json.data!.trackingDetails!.trackingInfo!.trackingCode.isNilOrEmpty) {
                                            viewCon.trackingCode = json.data!.trackingDetails!.trackingInfo!.trackingCode!
                                        }
                                        if !(viewCon.trackingCode.isEmpty) {
                                            view3.isHidden = false
                                            trackingview0.isHidden = false
                                            trackingview1.isHidden = false
                                            trackingview4.isHidden = false
                                            if viewCon.trackingStatusArray.count > 0 {
                                                trackingview2.isHidden = false
                                            }
                                            viewCon.trackingIdLabel.text = viewCon.trackingCode
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    if viewCon.canShowPaymentDetails == true {
                        if json.data!.paymentDetails != nil {
                            var paymentAmount = ""
                            var paymentMode = ""
                            var paymentTxnID = ""
                            var paymentDate = ""
                            
                            var canShowInvoice = false
                            var canShowReceipt = false
                            
                            if !(json.data!.paymentDetails!.paymentAmount.isNilOrEmpty) {
                                paymentAmount = json.data!.paymentDetails!.paymentAmount!
                            }
                            if !(json.data!.paymentDetails!.paymentMode.isNilOrEmpty) {
                                paymentMode = json.data!.paymentDetails!.paymentMode!
                            }
                            if !(json.data!.paymentDetails!.paymentTxnID.isNilOrEmpty) {
                                paymentTxnID = json.data!.paymentDetails!.paymentTxnID!
                            }
                            if !(json.data!.paymentDetails!.paymentDate.isNilOrEmpty) {
                                paymentDate = json.data!.paymentDetails!.paymentDate!
                            }
                            if !(json.data!.paymentDetails!.invoiceDocument.isNilOrEmpty) {
                                viewCon.invoiceDocument = json.data!.paymentDetails!.invoiceDocument!
                            }
                            if !(json.data!.paymentDetails!.paymentReceipt.isNilOrEmpty) {
                                viewCon.paymentReceipt = json.data!.paymentDetails!.paymentReceipt!
                            }
                            if json.data!.paymentDetails!.canShowInvoice != nil {
                                canShowInvoice = json.data!.paymentDetails!.canShowInvoice!
                            }
                            if json.data!.paymentDetails!.canShowReceipt != nil {
                                canShowReceipt = json.data!.paymentDetails!.canShowReceipt!
                            }
                            
                            if !(paymentAmount.isEmpty) {
                                view4.isHidden = false
                                paymentview0.isHidden = false
                                if paymentAmount.contains("Rs.") {
                                    viewCon.paymentAmountLabel.text = paymentAmount
                                } else {
                                    viewCon.paymentAmountLabel.text = String(format: "%@ %@", AppConstantValue.rupeesymbol, paymentAmount)
                                }
                            }
                            if !(paymentMode.isEmpty) {
                                view4.isHidden = false
                                paymentview1.isHidden = false
                                viewCon.paymentModeLabel.text = paymentMode
                            }
                            if !(paymentTxnID.isEmpty) {
                                view4.isHidden = false
                                paymentview2.isHidden = false
                                viewCon.paymentIDLabel.text = paymentTxnID
                            }
                            if !(paymentDate.isEmpty) {
                                view4.isHidden = false
                                paymentview3.isHidden = false
                                viewCon.paymentDateLabel.text = paymentDate
                            }
                            if (canShowInvoice == true) && !(viewCon.paymentReceipt.isEmpty) && (canShowReceipt == true) && !(viewCon.invoiceDocument.isEmpty) {
                                view4.isHidden = false
                                paymentview4.isHidden = false
                                paymentview5.isHidden = false
                                downloadbuttonview0.isHidden = false
                                downloadbuttonview1.isHidden = false
                                downloadbuttonview2.isHidden = false
                            } else if (canShowInvoice == true) && !(viewCon.invoiceDocument.isEmpty) {
                                view4.isHidden = false
                                paymentview4.isHidden = false
                                paymentview5.isHidden = false
                                downloadbuttonview2.isHidden = false
                            } else if (canShowReceipt == true) && !(viewCon.paymentReceipt.isEmpty) {
                                view4.isHidden = false
                                paymentview4.isHidden = false
                                paymentview5.isHidden = false
                                downloadbuttonview0.isHidden = false
                            }
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
