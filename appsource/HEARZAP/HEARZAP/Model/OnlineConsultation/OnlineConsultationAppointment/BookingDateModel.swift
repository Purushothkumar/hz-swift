//
//  BookingDateModel.swift
//  HEARZAP
//
//  Created by Purushoth on 24/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BookingDateModel
struct BookingDateModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookingDateModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BookingDateModelDataClass: Codable {
    var dateSlot: [DateSlot]?
    
    enum CodingKeys: String, CodingKey {
        case dateSlot = "date_slot"
    }
}

// MARK: - DateSlot
struct DateSlot: Codable {
    var label, weekday, value: String?
}
