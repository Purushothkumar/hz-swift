//
//  FindRightDeviceRecommendPostModel.swift
//  HEARZAP
//
//  Created by Purushoth on 22/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

// MARK: - FindRightDeviceRecommendModel
struct FindRightDeviceRecommendModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: FindRightDeviceRecommendModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct FindRightDeviceRecommendModelDataClass: Codable {
    var input: FindRightDeviceRecommendModelInput?
    var output: [FindRightDeviceRecommendModelOutput]?
}

// MARK: - Input
struct FindRightDeviceRecommendModelInput: Codable {
    var uid, lifestyle: String?
    var model: [String]?
    var technology, earInfo, createdOn: String?
    
    enum CodingKeys: String, CodingKey {
        case uid, lifestyle, model, technology
        case earInfo = "ear_info"
        case createdOn = "created_on"
    }
}

// MARK: - Output
struct FindRightDeviceRecommendModelOutput: Codable {
    var product: FindRightDeviceRecommendModelProduct?
    var productCompatibility: FindRightDeviceRecommendModelProductCompatibility?
    
    enum CodingKeys: String, CodingKey {
        case product
        case productCompatibility = "product_compatibility"
    }
}

// MARK: - Product
struct FindRightDeviceRecommendModelProduct: Codable {
    var id: Int?
    var uid, name, slug, code: String?
    var category, subCategory: Int?
    var description: String?
    var unitPrice, unitSellingPrice: String?
    var technology: Int?
    var generation: String?
    var mainImage: String?
    var returnPeriod: Int?
    var brand: String?
    
    enum CodingKeys: String, CodingKey {
        case id, uid, name, slug, code, category
        case subCategory = "sub_category"
        case description
        case unitPrice = "unit_price"
        case unitSellingPrice = "unit_selling_price"
        case technology, generation
        case mainImage = "main_image"
        case returnPeriod = "return_period"
        case brand
    }
}

// MARK: - ProductCompatibility
struct FindRightDeviceRecommendModelProductCompatibility: Codable {
    var lifestyle, compatibilityScore: Int?
    var fitLevel: String?
    var description: String?
    var colorCode: String?
    
    enum CodingKeys: String, CodingKey {
        case lifestyle
        case compatibilityScore = "compatibility_score"
        case fitLevel = "fit_level"
        case description
        case colorCode = "color_code"
    }
}
