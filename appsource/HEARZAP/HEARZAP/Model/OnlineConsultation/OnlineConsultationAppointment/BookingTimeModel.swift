//
//  BookingTimeModel.swift
//  HEARZAP
//
//  Created by Purushoth on 24/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BookingTimeModel
struct BookingTimeModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookingTimeModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BookingTimeModelDataClass: Codable {
    var availableTimeSlots: [AvailableTimeSlot]?
    
    enum CodingKeys: String, CodingKey {
        case availableTimeSlots = "available_time_slots"
    }
}


