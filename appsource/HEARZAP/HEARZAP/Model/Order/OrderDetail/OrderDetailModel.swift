//
//  OrderDetailModel.swift
//  HEARZAP
//
//  Created by Purushoth on 10/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - OrderDetailModel
struct OrderDetailModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: OrderDetailModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct OrderDetailModelDataClass: Codable {
    var returnReasonList: [ReturnReasonList]?
    var cancelReasonList: [CancelReasonList]?
    var canShowOrderItem, canShowTrackingDetails, canShowDeliveryAddress, canShowOrderDetail: Bool?
    var canShowCancelOrder, canShowReturnOrderItem, canShowPaymentDetails: Bool?
    var orderInfo: OrderInfo?
    var orderItemList: [OrderItemList]?
    var paymentDetails: PaymentDetails?
    var orderDetails: OrderDetails?
    var trackingDetails: TrackingDetails?
    var deliveryAddress: DeliveryAddress?
    
    enum CodingKeys: String, CodingKey {
        case cancelReasonList = "cancel_reason_list"
        case returnReasonList = "return_reason_list"
        case canShowOrderItem = "can_show_order_item"
        case canShowTrackingDetails = "can_show_tracking_details"
        case canShowDeliveryAddress = "can_show_delivery_address"
        case canShowOrderDetail = "can_show_order_detail"
        case canShowCancelOrder = "can_show_cancel_order"
        case canShowReturnOrderItem = "can_show_return_order_item"
        case canShowPaymentDetails = "can_show_payment_details"
        case orderInfo = "order_info"
        case orderItemList = "order_item_list"
        case paymentDetails = "payment_details"
        case orderDetails = "order_details"
        case trackingDetails = "tracking_details"
        case deliveryAddress = "delivery_address"
    }
}

// MARK: - ReasonList
struct ReturnReasonList: Codable {
    var id: Int?
    var value: String?
}

struct CancelReasonList: Codable {
    var id: Int?
    var value: String?
}
// MARK: - DeliveryAddress
struct DeliveryAddress: Codable {
    var deliveryName, deliveryMobile, deliveryType, deliveryLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case deliveryName = "delivery_name"
        case deliveryMobile = "delivery_mobile"
        case deliveryType = "delivery_type"
        case deliveryLocation = "delivery_location"
    }
}

// MARK: - OrderDetails
struct OrderDetails: Codable {
    var orderID, orderDate, orderAmount, orderStatus: String?
    var statusCode, statusTextColor, statusBgColor: String?
    var canShowCancellationDetails, canShowRefundDetails: Bool?
    var cancelledDate, cancellationReason, cancellationComments, refundStatus: String?
    var refundReqAmount: String?
    var orderItem: [OrderDetailModelOrderItem]?
    
    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case orderDate = "order_date"
        case orderAmount = "order_amount"
        case orderStatus = "order_status"
        case statusCode = "status_code"
        case statusTextColor = "status_text_color"
        case statusBgColor = "status_bg_color"
        case canShowCancellationDetails = "can_show_cancellation_details"
        case canShowRefundDetails = "can_show_refund_details"
        case cancelledDate = "cancelled_date"
        case cancellationReason = "cancellation_reason"
        case cancellationComments = "cancellation_comments"
        case refundStatus = "refund_status"
        case refundReqAmount = "refund_req_amount"
        case orderItem = "order_item"
    }
}

// MARK: - OrderItem
struct OrderDetailModelOrderItem: Codable {
    var name, code: String?
    var qty: Int?
}

// MARK: - OrderInfo
struct OrderInfo: Codable {
    var orderNumber, orderDate, statusName, statusCode: String?
    var statusTextColor, statusBgColor, serviceLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case orderNumber = "order_number"
        case orderDate = "order_date"
        case statusName = "status_name"
        case statusCode = "status_code"
        case statusTextColor = "status_text_color"
        case statusBgColor = "status_bg_color"
        case serviceLocation = "service_location"
    }
}

// MARK: - OrderItemList
struct OrderItemList: Codable {
    var itemID: Int?
    var itemImage: String?
    var brandName, productName, productCode: String?
    var canShowInReturn: Bool?
    var specifications: String?
    var qty: Int?
    
    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case itemImage = "item_image"
        case brandName = "brand_name"
        case productName = "product_name"
        case productCode = "product_code"
        case canShowInReturn = "can_show_in_return"
        case specifications, qty
    }
}

// MARK: - PaymentDetails
struct PaymentDetails: Codable {
    var paymentAmount, paymentMode, paymentTxnID, paymentDate: String?
    var canShowReceipt: Bool?
    var paymentReceipt: String?
    var canShowInvoice: Bool?
    var invoiceDocument: String?
    var canShowPaymentDetails: Bool?
    
    enum CodingKeys: String, CodingKey {
        case paymentAmount = "payment_amount"
        case paymentMode = "payment_mode"
        case paymentTxnID = "payment_txn_id"
        case paymentDate = "payment_date"
        case canShowReceipt = "can_show_receipt"
        case paymentReceipt = "payment_receipt"
        case canShowInvoice = "can_show_invoice"
        case invoiceDocument = "invoice_document"
        case canShowPaymentDetails = "can_show_payment_details"
    }
}

// MARK: - TrackingDetails
struct TrackingDetails: Codable {
    var statusList: [StatusList]?
    var canShowTrackingInfo: Bool?
    var trackingInfo: TrackingInfo?
    
    enum CodingKeys: String, CodingKey {
        case statusList = "status_list"
        case canShowTrackingInfo = "can_show_tracking_info"
        case trackingInfo = "tracking_info"
    }
}

// MARK: - StatusList
struct StatusList: Codable {
    var createdOn, statusName: String?
    
    enum CodingKeys: String, CodingKey {
        case createdOn = "created_on"
        case statusName = "status_name"
    }
}

// MARK: - TrackingInfo
struct TrackingInfo: Codable {
    var trackingCode, trackingURL: String?
    
    enum CodingKeys: String, CodingKey {
        case trackingCode = "tracking_code"
        case trackingURL = "tracking_url"
    }
}
