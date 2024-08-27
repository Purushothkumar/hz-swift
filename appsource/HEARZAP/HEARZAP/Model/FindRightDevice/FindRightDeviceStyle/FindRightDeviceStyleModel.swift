//
//  FindRightDeviceStyleModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - FindRightDeviceStyleModel
struct FindRightDeviceStyleModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: FindRightDeviceStyleModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct FindRightDeviceStyleModelDataClass: Codable {
    var lifestyle: [FindRightDeviceStyleModelLifestyle]?
}

// MARK: - Lifestyle
struct FindRightDeviceStyleModelLifestyle: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var lifestyleDescription: String?
    var situation: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, image
        case lifestyleDescription = "description"
        case situation
    }
}
