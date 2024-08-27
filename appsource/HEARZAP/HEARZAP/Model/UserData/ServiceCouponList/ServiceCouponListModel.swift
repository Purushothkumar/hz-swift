//
//  ServiceCouponListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 30/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ServiceCouponListModel
struct ServiceCouponListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ServiceCouponListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ServiceCouponListModelDataClass: Codable {
    var service: Service?
    var serviceSteps: [ServiceStep]?
    var customerCoupon: [ServiceCouponListModelCustomerCoupon]?
    
    enum CodingKeys: String, CodingKey {
        case service
        case serviceSteps = "service_steps"
        case customerCoupon = "customer_coupon"
    }
}

// MARK: - CustomerCoupon
struct ServiceCouponListModelCustomerCoupon: Codable {
    var couponCode, couponName: String?
    //    var couponDiscountValue: Double?
    var couponDiscountType, couponUsageEndDate, couponCategory: String?
    var isUsed: Bool?
    
    enum CodingKeys: String, CodingKey {
        case couponCode = "coupon_code"
        case couponName = "coupon_name"
        //        case couponDiscountValue = "coupon_discount_value"
        case couponDiscountType = "coupon_discount_type"
        case couponUsageEndDate = "coupon_usage_end_date"
        case couponCategory = "coupon_category"
        case isUsed = "is_used"
    }
}

// MARK: - Service
struct Service: Codable {
    var id: Int?
    var serviceType, serviceName, serviceDesc: String?
    var servicePosterPhoto: String?
    var serviceMarketingVideoLink: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case serviceType = "service_type"
        case serviceName = "service_name"
        case serviceDesc = "service_desc"
        case servicePosterPhoto = "service_poster_photo"
        case serviceMarketingVideoLink = "service_marketing_video_link"
    }
}

// MARK: - ServiceStep
struct ServiceStep: Codable {
    var id: Int?
    var serviceStepName, serviceDesc: String?
    var serviceStepOrder: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case serviceStepName = "service_step_name"
        case serviceDesc = "service_desc"
        case serviceStepOrder = "service_step_order"
    }
}
