//
//  BookAppointmentLocationSaveDataModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BookAppointmentLocationSaveDataModel
struct BookAppointmentLocationSaveDataModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookAppointmentLocationSaveDataModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BookAppointmentLocationSaveDataModelDataClass: Codable {
    var concernID: Int?

    enum CodingKeys: String, CodingKey {
        case concernID = "concern_id"
    }
}
//
//// MARK: - Errors
//struct Errors: Codable {
//}
