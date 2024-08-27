//
//  ChangeInfomationModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
// MARK: - ChangeEmailmodel
struct ChangeEmailmodel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ChangeEmailmodelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ChangeEmailmodelDataClass: Codable {
    var emailToken: String?
    
    enum CodingKeys: String, CodingKey {
        case emailToken = "email_token"
    }
}

// MARK: - ChangeMobileModel
struct ChangeMobileModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ChangeMobileModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ChangeMobileModelDataClass: Codable {
    var phoneToken: String?
    
    enum CodingKeys: String, CodingKey {
        case phoneToken = "phone_token"
    }
}
