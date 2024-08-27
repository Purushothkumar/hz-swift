//
//  PrivacyPolicyModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - PrivacyPolicyModel
struct PrivacyPolicyModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: PrivacyPolicyModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct PrivacyPolicyModelDataClass: Codable {
    var privacyPolicy: PrivacyPolicy?
    
    enum CodingKeys: String, CodingKey {
        case privacyPolicy = "privacy_policy"
    }
}

// MARK: - PrivacyPolicy
struct PrivacyPolicy: Codable {
    var supportKey, supportValue, supportDescription, updatedOn: String?
    
    enum CodingKeys: String, CodingKey {
        case supportKey = "support_key"
        case supportValue = "support_value"
        case supportDescription = "support_description"
        case updatedOn = "updated_on"
    }
}
