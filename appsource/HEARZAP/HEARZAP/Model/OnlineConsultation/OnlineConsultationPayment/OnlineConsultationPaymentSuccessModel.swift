//
//  OnlineConsultationPaymentSuccessModel.swift
//  HEARZAP
//
//  Created by Purushoth on 25/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - OnlineConsultationPaymentSuccessModel
struct OnlineConsultationPaymentSuccessModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: OnlineConsultationPaymentSuccessModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct OnlineConsultationPaymentSuccessModelDataClass: Codable {
    var booking: Booking?
    var meetingLink: String?
    
    enum CodingKeys: String, CodingKey {
        case booking
        case meetingLink = "meeting_link"
    }
}

// MARK: - Booking
struct Booking: Codable {
    var id: Int?
    var bookingUid, bookingMasterType, serviceDate, serviceStartTime: String?
    var serviceEndTime, serviceAddressLine1: String?
    var serviceAddressLine2, serviceAddressLine3, serviceState, serviceCity: String?
    var zipcode: Int?
    var serviceLocationLat, serviceLocationLng: Double?
    var location: String?
    var serviceStoreUid: String?
    //    var serviceAgent: JSONNull?
    var serviceAudiologist, serviceCustomerUid, servicePatientID: String?
    //    var serviceOtp: JSONNull?
    var bookingMasterStatus: String?
    var weekday: String?
    var canShowJoinButton: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case bookingUid = "booking_uid"
        case bookingMasterType = "booking_master_type"
        case serviceDate = "service_date"
        case serviceStartTime = "service_start_time"
        case serviceEndTime = "service_end_time"
        case serviceAddressLine1 = "service_address_line_1"
        case serviceAddressLine2 = "service_address_line_2"
        case serviceAddressLine3 = "service_address_line_3"
        case serviceState = "service_state"
        case serviceCity = "service_city"
        case zipcode
        case weekday
        case serviceLocationLat = "service_location_lat"
        case serviceLocationLng = "service_location_lng"
        case location
        case serviceStoreUid = "service_store_uid"
        //        case serviceAgent = "service_agent"
        case serviceAudiologist = "service_audiologist"
        case serviceCustomerUid = "service_customer_uid"
        case servicePatientID = "service_patient_id"
        //        case serviceOtp = "service_otp"
        case bookingMasterStatus = "booking_master_status"
        case canShowJoinButton = "can_show_join_button"
    }
}

// MARK: - BookingAmountDetail
// struct BookingAmountDetail: Codable {
//    var id, booking, subTotalAmount, mrpDiscountTotalAmount: Int?
//    var couponDiscountTotalAmount: Int?
//    var couponCode: String?
//    var serviceChargeAmount, taxTotalAmount, finalTotalAmount: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, booking
//        case subTotalAmount = "sub_total_amount"
//        case mrpDiscountTotalAmount = "mrp_discount_total_amount"
//        case couponDiscountTotalAmount = "coupon_discount_total_amount"
//        case couponCode = "coupon_code"
//        case serviceChargeAmount = "service_charge_amount"
//        case taxTotalAmount = "tax_total_amount"
//        case finalTotalAmount = "final_total_amount"
//    }
// }
//
// MARK: - BookingRequestList
// struct BookingRequestList: Codable {
//    var onlineConsultation: OnlineConsultation?
//
//    enum CodingKeys: String, CodingKey {
//        case onlineConsultation = "online_consultation"
//    }
// }
//
// MARK: - OnlineConsultation
// struct OnlineConsultation: Codable {
//    var id: Int?
//    var bookingServiceRequest: String?
//    var meetingLink: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case bookingServiceRequest = "booking_service_request"
//        case meetingLink = "meeting_link"
//    }
// }
//
// MARK: - CustomerAddress
// struct CustomerAddress: Codable {
//    var id: Int?
//    var customerName, addressType: String?
//    var isPrimary: Bool?
//    var address1: String?
//    var address2, address3, landmark, city: String?
//    var state: String?
//    var zipcode: Int?
//    var lat, lng: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case customerName = "customer_name"
//        case addressType = "address_type"
//        case isPrimary = "is_primary"
//        case address1 = "address_1"
//        case address2 = "address_2"
//        case address3 = "address_3"
//        case landmark, city, state, zipcode, lat, lng
//    }
// }
//
// MARK: - CustomerCouponList
// struct CustomerCouponList: Codable {
//    var customerCoupon: [CustomerCoupon]?
//
//    enum CodingKeys: String, CodingKey {
//        case customerCoupon = "customer_coupon"
//    }
// }
//
// MARK: - CustomerCoupon
//// struct CustomerCoupon: Codable {
////    var couponCode, couponName: String?
////    var couponDiscountValue: Int?
////    var couponDiscountType, couponUsageEndDate, couponCategory: String?
////    var isUsed: Bool?
////
////    enum CodingKeys: String, CodingKey {
////        case couponCode = "coupon_code"
////        case couponName = "coupon_name"
////        case couponDiscountValue = "coupon_discount_value"
////        case couponDiscountType = "coupon_discount_type"
////        case couponUsageEndDate = "coupon_usage_end_date"
////        case couponCategory = "coupon_category"
////        case isUsed = "is_used"
////    }
//// }
//
// MARK: - PatientProfile
// struct PatientProfile: Codable {
//    var id: Int?
//    var uid, customerUid, name: String?
//    var age: String?
//    var dob, gender, relationship: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, uid
//        case customerUid = "customer_uid"
//        case name, age, dob, gender, relationship
//    }
// }
//
// MARK: - ServiceQuestionnaire
// struct ServiceQuestionnaire: Codable {
//    var id: Int?
//    var bookingServiceRequest, bookingMasterServiceRequestMasterQuestionaire, selectedValue: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case bookingServiceRequest = "booking_service_request"
//        case bookingMasterServiceRequestMasterQuestionaire = "booking_master_service_request_master_questionaire"
//        case selectedValue = "selected_value"
//    }
// }
