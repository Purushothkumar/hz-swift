//
//  SignupModel.swift
//  HEARZAP
//
//  Created by Purushoth on 10/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - SignupModel
struct SignupModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: SignupModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct SignupModelDataClass: Codable {
    var phoneToken, authVerify: String?
    
    enum CodingKeys: String, CodingKey {
        case phoneToken = "phone_token"
        case authVerify = "auth_verify"
    }
}
