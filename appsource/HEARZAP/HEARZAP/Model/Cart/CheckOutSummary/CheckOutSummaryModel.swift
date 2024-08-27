//
//  CheckOutSummaryModel.swift
//  HEARZAP
//
//  Created by Purushoth on 08/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CheckOutSummaryModel
struct CheckOutSummaryModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CheckOutSummaryModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CheckOutSummaryModelDataClass: Codable {
    var orderNumber, customerUid, addressHeading: String?
    var canShowHomeAddress: Bool?
    var homeAddress: BookingHomeAddress?
    var canShowStoreAddress: Bool?
    var storeAddress: BookingStoreAddress?
    var canShowAudiologistApproval: Bool?
    var orderItems: [OrderItem]?
    var canShowApplyCoupon: Bool?
    var couponDetails: CouponDetails?
    var canShowPricingDetails: Bool?
    var pricingDetails: [PricingDetail]?
    var totalPrice: String?
    var canShowFreeShipping: Bool?
    
    enum CodingKeys: String, CodingKey {
        case orderNumber = "order_number"
        case customerUid = "customer_uid"
        case addressHeading = "address_heading"
        case canShowHomeAddress = "can_show_home_address"
        case homeAddress = "home_address"
        case canShowStoreAddress = "can_show_store_address"
        case storeAddress = "store_address"
        case canShowAudiologistApproval = "can_show_audiologist_approval"
        case orderItems = "order_items"
        case canShowApplyCoupon = "can_show_apply_coupon"
        case couponDetails = "coupon_details"
        case canShowPricingDetails = "can_show_pricing_details"
        case pricingDetails = "pricing_details"
        case totalPrice = "total_price"
        case canShowFreeShipping = "can_show_free_shipping"
    }
}

// MARK: - CouponDetails
// struct CouponDetails: Codable {
//    var isCouponAdded: Bool?
//    var title, description, couponCode: String?
//
//    enum CodingKeys: String, CodingKey {
//        case isCouponAdded = "is_coupon_added"
//        case title, description
//        case couponCode = "coupon_code"
//    }
// }

// MARK: - Home Address
// struct BookingHomeAddress: Codable {
//    var name, mobile, addressType, serviceLocation: String?
//
//    enum CodingKeys: String, CodingKey {
//        case name, mobile
//        case addressType = "address_type"
//        case serviceLocation = "service_location"
//    }
// }
//
// MARK: - Store Address
// struct BookingStoreAddress: Codable {
//    var name, mobile, addressType, serviceLocation: String?
//
//    enum CodingKeys: String, CodingKey {
//        case name, mobile
//        case addressType = "address_type"
//        case serviceLocation = "service_location"
//    }
// }

// MARK: - OrderItem
// struct OrderItem: Codable {
//    var productImage: String?
//    var brandName, productName, sellingPrice: String?
//    var canShowMrpPrice: Bool?
//    var mrpPrice: String?
//    var productDiscount, qty: Int?
//    var estimatedDeliveryDate: String?
//
//    enum CodingKeys: String, CodingKey {
//        case productImage = "product_image"
//        case brandName = "brand_name"
//        case productName = "product_name"
//        case sellingPrice = "selling_price"
//        case canShowMrpPrice = "can_show_mrp_price"
//        case mrpPrice = "mrp_price"
//        case productDiscount = "product_discount"
//        case qty
//        case estimatedDeliveryDate = "estimated_delivery_date"
//    }
// }

// MARK: - PricingDetail
// struct PricingDetail: Codable {
//    var name, info, price: String?
// }
