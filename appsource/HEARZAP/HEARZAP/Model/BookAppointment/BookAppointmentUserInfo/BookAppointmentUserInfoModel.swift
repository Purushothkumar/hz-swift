//
//  BookAppointmentUserInfoModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BookAppointmentUserInfoModel
struct BookAppointmentUserInfoModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookAppointmentUserInfoModelDataClass?
    var errors: Errors?
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BookAppointmentUserInfoModelDataClass: Codable {
}
