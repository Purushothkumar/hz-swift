//
//  CheckOutItemModel.swift
//  HEARZAP
//
//  Created by Purushoth on 21/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CheckOutItemModel
struct CheckOutItemModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CheckOutItemModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CheckOutItemModelDataClass: Codable {
    //    var orderNumber, customerUid, addressHeading: String?
    //    var canShowHomeAddress: Bool?
    //    var homeAddress: BookingHomeAddress?
    //    var canShowStoreAddress: Bool?
    //    var storeAddress: BookingStoreAddress?
    //    var canShowAudiologistApproval: Bool?
    var orderItems: [OrderItem]?
    //    var canShowApplyCoupon: Bool?
    //    var couponDetails: CouponDetails?
    //    var canShowPricingDetails: Bool?
    //    var pricingDetails: [PricingDetail]?
    //    var totalPrice: String?
    
    enum CodingKeys: String, CodingKey {
        //        case orderNumber = "order_number"
        //        case customerUid = "customer_uid"
        //        case addressHeading = "address_heading"
        //        case canShowHomeAddress = "can_show_home_address"
        //        case homeAddress = "home_address"
        //        case canShowStoreAddress = "can_show_store_address"
        //        case storeAddress = "store_address"
        //        case canShowAudiologistApproval = "can_show_audiologist_approval"
        case orderItems = "order_items"
        //        case canShowApplyCoupon = "can_show_apply_coupon"
        //        case couponDetails = "coupon_details"
        //        case canShowPricingDetails = "can_show_pricing_details"
        //        case pricingDetails = "pricing_details"
        //        case totalPrice = "total_price"
    }
}

// MARK: - OrderItem
struct OrderItem: Codable {
    var productImage: String?
    var brandName, productName, sellingPrice: String?
    var canShowMrpPrice: Bool?
    var mrpPrice: String?
    var productDiscount, qty: Int?
    var estimatedDeliveryDate: String?
    
    enum CodingKeys: String, CodingKey {
        case productImage = "product_image"
        case brandName = "brand_name"
        case productName = "product_name"
        case sellingPrice = "selling_price"
        case canShowMrpPrice = "can_show_mrp_price"
        case mrpPrice = "mrp_price"
        case productDiscount = "product_discount"
        case qty
        case estimatedDeliveryDate = "estimated_delivery_date"
    }
}
