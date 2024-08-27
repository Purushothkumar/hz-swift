//
//  CouponListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CouponListModel
struct CouponListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CouponListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CouponListModelDataClass: Codable {
    var customerCoupon: [CustomerCoupon]?
    
    enum CodingKeys: String, CodingKey {
        case customerCoupon = "customer_coupon"
    }
}

// MARK: - CustomerCoupon
struct CustomerCoupon: Codable {
    var typeName: String?
    var typeCode: String?
    var couponList: [CouponList]?
    
    enum CodingKeys: String, CodingKey {
        case typeName = "type_name"
        case typeCode = "type_code"
        case couponList = "coupon_list"
    }
}

// MARK: - CouponList
struct CouponList: Codable {
    var couponCode: String?
    var couponAssignedType: String?
    var couponData: CouponData?
    
    enum CodingKeys: String, CodingKey {
        case couponCode = "coupon_code"
        case couponAssignedType = "coupon_assigned_type"
        case couponData = "coupon_data"
    }
}

// MARK: - CouponData
struct CouponData: Codable {
    var id: Int?
    var couponUid: String?
    var couponName: String?
    var couponPhoto: String?
    var couponType: String?
    var couponCategory: String?
    var couponMaxCount: Int?
    var couponUsageStartDate: String?
    var couponUsageEndDate: String?
    var couponDiscountType: String?
    //    var couponDiscountValue : Double?
    var couponSaleCoins: Int?
    var couponDescription: String?
    var isUsed: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case couponUid = "coupon_uid"
        case couponName = "coupon_name"
        case couponPhoto = "coupon_photo"
        case couponType = "coupon_type"
        case couponCategory = "coupon_category"
        case couponMaxCount = "coupon_max_count"
        case couponUsageStartDate = "coupon_usage_start_date"
        case couponUsageEndDate = "coupon_usage_end_date"
        case couponDiscountType = "coupon_discount_type"
        //        case couponDiscountValue = "coupon_discount_value"
        case couponSaleCoins = "coupon_sale_coins"
        case couponDescription = "coupon_description"
        case isUsed = "is_used"
    }
}
