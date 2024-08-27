//
//  HomeLPModel.swift
//  HEARZAP
//
//  Created by Purushoth on 16/04/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - HomeLPModel
struct HomeLPModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: HomeLPModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct HomeLPModelDataClass: Codable {
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
