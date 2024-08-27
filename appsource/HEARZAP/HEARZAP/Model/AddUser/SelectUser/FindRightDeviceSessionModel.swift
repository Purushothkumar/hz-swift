//
//  FindRightDeviceSessionModel.swift
//  HEARZAP
//
//  Created by Purushoth on 15/11/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - FindRightDeviceSessionModel
struct FindRightDeviceSessionModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: FindRightDeviceSessionModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct FindRightDeviceSessionModelDataClass: Codable {
    let sessionID: String?
    
    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
    }
}


