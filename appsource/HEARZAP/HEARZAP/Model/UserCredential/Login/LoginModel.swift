//
//  LoginModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: LoginModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct LoginModelDataClass: Codable {
    var phoneToken: String?
    
    enum CodingKeys: String, CodingKey {
        case phoneToken = "phone_token"
    }
}
