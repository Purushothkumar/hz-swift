//
//  SupportModel.swift
//  HEARZAP
//
//  Created by Purushoth on 25/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct SupportModel: Codable {
    
    let title: String
    let description: String
    let buttonTitle: String
    let image: String
    let supportdata: String
    let supportDeskType: String
}
// MARK: - SupportAPIModel
struct SupportAPIModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: SupportAPIModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct SupportAPIModelDataClass: Codable {
    var whatsappNumber, contactNumber, emailAddress: String?
    
    enum CodingKeys: String, CodingKey {
        case whatsappNumber = "whatsapp_number"
        case contactNumber = "contact_number"
        case emailAddress = "email_address"
    }
}
