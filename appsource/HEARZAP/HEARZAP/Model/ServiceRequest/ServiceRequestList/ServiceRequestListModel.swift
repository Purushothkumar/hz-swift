//
//  ServiceRequestListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 31/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct ServiceRequestListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ServiceRequestListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ServiceRequestListModelDataClass: Codable {
    var bookingList: DataBookingList?
    
    enum CodingKeys: String, CodingKey {
        case bookingList = "booking_list"
    }
}

// MARK: - DataBookingList
struct DataBookingList: Codable {
    var bookingList: [BookingListElement]?
    
    enum CodingKeys: String, CodingKey {
        case bookingList = "booking_list"
    }
}

// MARK: - BookingListElement
struct BookingListElement: Codable {
    var bookingUid: String?
    var bookingTypeName: String?
    var bookingTypeCode: String?
    var serviceDate: String?
    var serviceStartTime, serviceEndTime: String?
    var bookingStatusCode, bookingStatusName: String?
    var bookingStatusColorCode: String?
    
    enum CodingKeys: String, CodingKey {
        case bookingUid = "booking_uid"
        case bookingTypeName = "booking_type_name"
        case bookingTypeCode = "booking_type_code"
        case serviceDate = "service_date"
        case serviceStartTime = "service_start_time"
        case serviceEndTime = "service_end_time"
        case bookingStatusCode = "booking_status_code"
        case bookingStatusName = "booking_status_name"
        case bookingStatusColorCode = "booking_status_color_code"
    }
}
