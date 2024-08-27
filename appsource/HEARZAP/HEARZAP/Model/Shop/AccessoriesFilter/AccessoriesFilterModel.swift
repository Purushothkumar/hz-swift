//
//  AccessoriesFilterModel.swift
//  HEARZAP
//
//  Created by Purushoth on 06/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
// MARK: - AccessoriesFilterModel
struct AccessoriesFilterModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: AccessoriesFilterModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct AccessoriesFilterModelDataClass: Codable {
    var style: [FilterModelStyle]?
    var brand: [FilterModelBrand]?
    var feature: [FilterModelFeature]?
    var specification: [FilterModelSpecification]?
}
