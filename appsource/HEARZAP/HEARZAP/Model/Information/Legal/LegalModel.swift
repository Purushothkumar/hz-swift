//
//  LegalModel.swift
//  HEARZAP
//
//  Created by Purushoth on 13/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - LegalModel
struct LegalModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: LegalModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct LegalModelDataClass: Codable {
    var legal: Legal?
}

// MARK: - Legal
struct Legal: Codable {
    var supportKey, supportValue, supportDescription, updatedOn: String?
    
    enum CodingKeys: String, CodingKey {
        case supportKey = "support_key"
        case supportValue = "support_value"
        case supportDescription = "support_description"
        case updatedOn = "updated_on"
    }
}
