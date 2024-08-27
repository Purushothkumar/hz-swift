//
//  TermsConditionModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - TermsConditionModel
struct TermsConditionModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: TermsConditionModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct TermsConditionModelDataClass: Codable {
    var termsOfUse: TermsOfUse?
    
    enum CodingKeys: String, CodingKey {
        case termsOfUse = "terms_of_use"
    }
}

// MARK: - TermsOfUse
struct TermsOfUse: Codable {
    var supportKey, supportValue, supportDescription, updatedOn: String?
    
    enum CodingKeys: String, CodingKey {
        case supportKey = "support_key"
        case supportValue = "support_value"
        case supportDescription = "support_description"
        case updatedOn = "updated_on"
    }
}
