//
//  DisableAccountModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - DisableAccountModel
struct DisableAccountModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: DisableAccountModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct DisableAccountModelDataClass: Codable {
}
