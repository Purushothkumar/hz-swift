//
//  OTPVerificationModel.swift
//  HEARZAP
//
//  Created by Purushoth on 13/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - OTPVerificationModel
struct OTPVerificationModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: OTPVerificationModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct OTPVerificationModelDataClass: Codable {
    var token, customerName, customerUid, customerMobile: String?
    
    enum CodingKeys: String, CodingKey {
        case token
        case customerName = "customer_name"
        case customerUid = "customer_uid"
        case customerMobile = "customer_mobile"
    }
}
