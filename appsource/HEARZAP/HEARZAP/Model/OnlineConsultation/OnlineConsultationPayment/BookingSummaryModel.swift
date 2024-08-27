//
//  BookingSummaryModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BookingSummaryModel
struct BookingSummaryModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookingSummaryModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BookingSummaryModelDataClass: Codable {
    var bookingUid, visitType: String?
    var canShowAudiologistStaff: Bool?
    var serviceStaff: ServiceStaff?
    var canShowHomeAddress: Bool?
    var homeAddress: BookingHomeAddress?
    var canShowStoreAddress: Bool?
    var storeAddress: BookingStoreAddress?
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
        case homeAddress = "home_address"
        case canShowStoreAddress = "can_show_store_address"
        case storeAddress = "store_address"
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

// MARK: - CouponDetails
struct CouponDetails: Codable {
    var isCouponAdded: Bool?
    var title, description, couponCode: String?
    
    enum CodingKeys: String, CodingKey {
        case isCouponAdded = "is_coupon_added"
        case title, description
        case couponCode = "coupon_code"
    }
}

// MARK: - PricingDetail
struct PricingDetail: Codable {
    var name, info, price: String?
}

// MARK: - ServiceRequestsList
struct ServiceRequestsList: Codable {
    var name, code: String?
    var qty: Int?
}

// MARK: - ServiceStaff
struct ServiceStaff: Codable {
    var audiologistDetails: AudiologistDetails?
    
    enum CodingKeys: String, CodingKey {
        case audiologistDetails = "audiologist_details"
    }
}

// MARK: - AudiologistDetails
struct AudiologistDetails: Codable {
    var photo: String?
    var name, experience, designationName, specialization: String?
    var specializationDegree, specializationDesc, averageRating: String?
    var isVaccinated: Bool?
    //    var langPreference: [String]?
    
    enum CodingKeys: String, CodingKey {
        case photo, name, experience
        case designationName = "designation_name"
        case specialization
        case specializationDegree = "specialization_degree"
        case specializationDesc = "specialization_desc"
        case averageRating = "average_rating"
        case isVaccinated = "is_vaccinated"
        //        case langPreference = "lang_preference"
    }
}
// MARK: - Home Address
struct BookingHomeAddress: Codable {
    var name, mobile, addressType, serviceLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case name, mobile
        case addressType = "address_type"
        case serviceLocation = "service_location"
    }
}

// MARK: - Store Address
struct BookingStoreAddress: Codable {
    var name, mobile, addressType, serviceLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case name, mobile
        case addressType = "address_type"
        case serviceLocation = "service_location"
    }
}
