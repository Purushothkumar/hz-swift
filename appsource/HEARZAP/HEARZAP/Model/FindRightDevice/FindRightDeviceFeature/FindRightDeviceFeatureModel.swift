//
//  FindRightDeviceFeatureModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - FindRightDeviceFeatureModel
struct FindRightDeviceFeatureModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: FindRightDeviceFeatureModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct FindRightDeviceFeatureModelDataClass: Codable {
    var model: [FindRightDeviceFeatureModelModel]?
    var technology: [FindRightDeviceFeatureModelTechnology]?
    var features: [FindRightDeviceFeatureModelFeature]?
}

// MARK: - Feature
struct FindRightDeviceFeatureModelFeature: Codable {
    var name: String?
    var featureDescription: String?
    var isAvailable: Bool?
    var technologyID: Int?
    var tagsList: [TagsList]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case featureDescription = "description"
        case isAvailable = "is_available"
        case technologyID = "technology_id"
        case tagsList = "tags_list"
    }
}
// MARK: - TagsList
struct TagsList: Codable {
    var name: String?
    var isSelected: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name
        case isSelected = "is_selected"
    }
}
// MARK: - Model
struct FindRightDeviceFeatureModelModel: Codable {
    var id: Int?
    var name, image, modelDescription, suitableFor: String?
    var pros: [String]?
    var cons: [String]?
    var deviceView, humanEarView: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, image
        case modelDescription = "description"
        case suitableFor = "suitable_for"
        case pros, cons
        case deviceView = "device_view"
        case humanEarView = "human_ear_view"
    }
}

// MARK: - Technology
struct FindRightDeviceFeatureModelTechnology: Codable {
    var id: Int?
    var name, technologyDescription: String?
    var priceStartRange, priceEndRange: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case technologyDescription = "description"
        case priceStartRange = "price_start_range"
        case priceEndRange = "price_end_range"
    }
}
