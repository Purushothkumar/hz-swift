//
//  BookAppointmentScheduleUpdateSlotModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
// MARK: - BookAppointmentScheduleUpdateSlotModel
struct BookAppointmentScheduleUpdateSlotModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookAppointmentScheduleSlotModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

//// MARK: - DataClass
//struct BookAppointmentScheduleSlotModelDataClass: Codable {
//    var dateList: [DateList]?
//    var currentDateSlots, otherDateSlots: [DateSlot]?
//    var serviceType: String?
//
//    enum CodingKeys: String, CodingKey {
//        case dateList = "date_list"
//        case currentDateSlots = "current_date_slots"
//        case otherDateSlots = "other_date_slots"
//        case serviceType = "service_type"
//    }
//}
