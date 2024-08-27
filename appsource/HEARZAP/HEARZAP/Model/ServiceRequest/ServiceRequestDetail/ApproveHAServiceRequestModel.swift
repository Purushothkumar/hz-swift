//
//  ApproveHAServiceRequestModel.swift
//  HEARZAP
//
//  Created by Purushoth on 07/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ApproveHAServiceRequestModel
struct ApproveHAServiceRequestModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ApproveHAServiceRequestModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ApproveHAServiceRequestModelDataClass: Codable {
    var bookingUid: String?
    
    enum CodingKeys: String, CodingKey {
        case bookingUid = "booking_uid"
    }
}
