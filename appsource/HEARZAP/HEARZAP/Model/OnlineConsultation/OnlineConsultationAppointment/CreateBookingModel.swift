//
//  CreateBookingModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CreateBookingModel
struct CreateBookingModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CreateBookingModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CreateBookingModelDataClass: Codable {
    var bookingUid, visitType: String?
    var canShowAudiologistStaff: Bool?
    var serviceStaff: ServiceStaff?
    var canShowHomeAddress: Bool?
    //    var homeAddress: Errors?
    var canShowStoreAddress: Bool?
    //    var storeAddress: Errors?
    var scheduleDate, timeSlot: String?
    var serviceRequestsList: [ServiceRequestsList]?
    var canShowApplyCoupon: Bool?
    var couponDetails: CouponDetails?
    var canShowPricingDetails: Bool?
    var pricingDetails: [PricingDetail]?
    var totalPrice: String?
    
    enum CodingKeys: String, CodingKey {
        case bookingUid = "booking_uid"
        case visitType = "visit_type"
        case canShowAudiologistStaff = "can_show_audiologist_staff"
        case serviceStaff = "service_staff"
        case canShowHomeAddress = "can_show_home_address"
        //        case homeAddress = "home_address"
        case canShowStoreAddress = "can_show_store_address"
        //        case storeAddress = "store_address"
        case scheduleDate = "schedule_date"
        case timeSlot = "time_slot"
        case serviceRequestsList = "service_requests_list"
        case canShowApplyCoupon = "can_show_apply_coupon"
        case couponDetails = "coupon_details"
        case canShowPricingDetails = "can_show_pricing_details"
        case pricingDetails = "pricing_details"
        case totalPrice = "total_price"
    }
}
