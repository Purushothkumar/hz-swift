//
//  BookAppointmentLocationVerifyOTPModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BookAppointmentLocationVerifyOTPModel
struct BookAppointmentLocationVerifyOTPModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookAppointmentLocationVerifyOTPModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BookAppointmentLocationVerifyOTPModelDataClass: Codable {
    var token: String?
    var concernID: Int?

    enum CodingKeys: String, CodingKey {
        case token
        case concernID = "concern_id"
    }
}

//// MARK: - Errors
//struct Errors: Codable {
//}
