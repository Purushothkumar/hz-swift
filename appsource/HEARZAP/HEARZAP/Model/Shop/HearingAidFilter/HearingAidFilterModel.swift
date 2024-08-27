//
//  HearingAidFilterModel.swift
//  HEARZAP
//
//  Created by Purushoth on 05/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - HearingAidFilterModel
struct HearingAidFilterModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: HearingAidFilterModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct HearingAidFilterModelDataClass: Codable {
    //    var products: [JSONAny]?
    var style: [FilterModelStyle]?
    var brand: [FilterModelBrand]?
    var feature: [FilterModelFeature]?
    var specification: [FilterModelSpecification]?
    
}

// MARK: - Brand
struct FilterModelBrand: Codable {
    var id, name: String?
}
// MARK: - Brand
struct FilterModelStyle: Codable {
    var id, name: String?
}
// MARK: - Feature
struct FilterModelFeature: Codable {
    var id: String?
    var value: [String]?
}
// MARK: - Specification
struct FilterModelSpecification: Codable {
    var id: String?
    var value: [String]?
}
