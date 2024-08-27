//
//  ReturnReasonModel.swift
//  HEARZAP
//
//  Created by Purushoth on 13/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ReturnReasonModel
struct ReturnReasonModel: Codable {
    var statusCode: Int?
    var message: String?
    var data, errors: ReturnReasonModelDataClass?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ReturnReasonModelDataClass: Codable {
}
