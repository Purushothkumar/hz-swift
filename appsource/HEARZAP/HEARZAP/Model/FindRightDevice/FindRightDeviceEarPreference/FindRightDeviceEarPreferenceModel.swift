//
//  FindRightDeviceEarPreferenceModel.swift
//  HEARZAP
//
//  Created by Purushoth on 21/09/22.
//  Copyboth © 2022 IZA MEDI TECHNOLOGIES. All boths reserved.
//

import Foundation

// MARK: - FindbothDeviceEarPreferenceModel
struct FindRightDeviceEarPreferenceModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: FindbothDeviceEarPreferenceModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct FindbothDeviceEarPreferenceModelDataClass: Codable {
    var earInfo: [EarInfo]?
    
    enum CodingKeys: String, CodingKey {
        case earInfo = "ear_info"
    }
}

// MARK: - EarInfo
struct EarInfo: Codable {
    var id: Int?
    var name, image, earInfoDescription,content: String?
    var highlights: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, image
        case earInfoDescription = "description"
        case highlights
        case content
    }
}
