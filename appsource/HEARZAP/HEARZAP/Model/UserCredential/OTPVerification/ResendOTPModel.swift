//
//  ResendOTPModel.swift
//  HEARZAP
//
//  Created by Purushoth on 13/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ResendOTPModel
struct ResendOTPModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ResendOTPModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ResendOTPModelDataClass: Codable {
    var otpSend: Bool?
    
    enum CodingKeys: String, CodingKey {
        case otpSend = "otp_send"
    }
}
