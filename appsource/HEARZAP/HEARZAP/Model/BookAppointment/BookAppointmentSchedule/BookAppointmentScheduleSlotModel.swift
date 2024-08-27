//
//  BookAppointmentScheduleSlotModel.swift
//  HEARZAP
//
//  Created by Purushoth on 17/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BookAppointmentScheduleSlotModel
struct BookAppointmentScheduleSlotModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookAppointmentScheduleSlotModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BookAppointmentScheduleSlotModelDataClass: Codable {
    var dateList: [DateList]?
    var currentDateSlots, otherDateSlots: [AvailableTimeSlot]?
    var serviceType: String?
    var store: [BookAppointmentScheduleSlotModelStore]?

    enum CodingKeys: String, CodingKey {
        case dateList = "date_list"
        case currentDateSlots = "current_date_slots"
        case otherDateSlots = "other_date_slots"
        case serviceType = "service_type"
        case store
    }
}
// MARK: - Store
struct BookAppointmentScheduleSlotModelStore: Codable {
    var id: Int?
    var name: String?
}
//// MARK: - DateSlot
//struct DateSlot: Codable {
//    var id: Int?
//    var time: String?
//    var isAvailable: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case id, time
//        case isAvailable = "is_available"
//    }
//}

// MARK: - DateList
struct DateList: Codable {
    var day, date: String?
}

//// MARK: - Errors
//struct Errors: Codable {
//}
// MARK: - AvailableTimeSlot
struct AvailableTimeSlot: Codable {
    var id: Int?
    var time: String?
    var isAvailable: Bool?

    enum CodingKeys: String, CodingKey {
        case id, time
        case isAvailable = "is_available"
    }
}

