//
//  BookingConfirmationModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - OnlineConsultationConfirmationModel
struct BookingConfirmationModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookingConfirmationModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BookingConfirmationModelDataClass: Codable {
    var bookingUid: String?
    var bookingDetails: BookingDetails?
    var canShowHomeAddress: Bool?
    var homeAddress: BookingHomeAddress?
    var canShowStoreAddress: Bool?
    var storeAddress: BookingStoreAddress?
    var scheduleDate, timeSlot, startTime, endTime: String?
    var bookedDate: String?
    var serviceRequestsList: [ServiceRequestsList]?
    
    enum CodingKeys: String, CodingKey {
        case bookingUid = "booking_uid"
        case bookingDetails = "booking_details"
        case canShowHomeAddress = "can_show_home_address"
        case homeAddress = "home_address"
        case canShowStoreAddress = "can_show_store_address"
        case storeAddress = "store_address"
        case scheduleDate = "schedule_date"
        case timeSlot = "time_slot"
        case startTime = "start_time"
        case endTime = "end_time"
        case bookedDate = "booked_date"
        case serviceRequestsList = "service_requests_list"
    }
}

// MARK: - BookingDetails
struct BookingDetails: Codable {
    var serviceLocation: String?
    var meetingLink: String?
    var enableJoinBtn, canShowJoinBtn: Bool?
    
    enum CodingKeys: String, CodingKey {
        case serviceLocation = "service_location"
        case meetingLink = "meeting_link"
        case enableJoinBtn = "enable_join_btn"
        case canShowJoinBtn = "can_show_join_btn"
    }
}
