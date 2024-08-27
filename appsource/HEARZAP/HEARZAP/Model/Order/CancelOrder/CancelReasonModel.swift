//
//  CancelReasonModel.swift
//  HEARZAP
//
//  Created by Purushoth on 03/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
// MARK: - CancelReasonModel
struct CancelReasonModel: Codable {
    var statusCode: Int?
    var message: String?
    var data, errors: CancelReasonModelDataClass?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CancelReasonModelDataClass: Codable {
}
