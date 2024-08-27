//
//  NotificationCountModel.swift
//  HEARZAP
//
//  Created by Purushoth on 10/05/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - NotificationCountModel
struct NotificationCountModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: NotificationCountModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct NotificationCountModelDataClass: Codable {
    var alert, cart: Bool?
}
