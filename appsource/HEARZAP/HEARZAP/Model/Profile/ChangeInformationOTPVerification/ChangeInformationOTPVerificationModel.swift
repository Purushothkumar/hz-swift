//
//  ChangeInformationOTPVerificationModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - EmailOTPVerificationModel
struct EmailOTPVerificationModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: EmailOTPVerificationModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct EmailOTPVerificationModelDataClass: Codable {
    var token: String?
}

// MARK: - MobileOTPVerificationModel
struct MobileOTPVerificationModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: MobileOTPVerificationModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct MobileOTPVerificationModelDataClass: Codable {
    var token, customerName, customerUid, customerMobile: String?
    
    enum CodingKeys: String, CodingKey {
        case token
        case customerName = "customer_name"
        case customerUid = "customer_uid"
        case customerMobile = "customer_mobile"
    }
}
