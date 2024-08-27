//
//  OnlineConsultationLocationSendOTPModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
// MARK: - OnlineConsultationLocationSendOTPModel
struct OnlineConsultationLocationSendOTPModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: OnlineConsultationLocationSendOTPModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct OnlineConsultationLocationSendOTPModelDataClass: Codable {
    var phoneToken: String?
    var newUser: Bool?

    enum CodingKeys: String, CodingKey {
        case phoneToken = "phone_token"
        case newUser = "new_user"
    }
}

//// MARK: - Errors
//struct Errors: Codable {
//}
