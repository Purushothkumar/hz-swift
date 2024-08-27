//
//  ServiceRequestStaffRatingModel.swift
//  HEARZAP
//
//  Created by Purushoth on 07/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ServiceRequestStaffRatingModel
struct ServiceRequestStaffRatingModel: Codable {
    var statusCode: Int?
    var message: String?
    var data, errors: ServiceRequestStaffRatingModelDataClass?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ServiceRequestStaffRatingModelDataClass: Codable {
}
