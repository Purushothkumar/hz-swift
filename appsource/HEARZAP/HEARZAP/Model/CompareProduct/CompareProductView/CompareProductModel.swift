//
//  CompareProductModel.swift
//  HEARZAP
//
//  Created by Purushoth on 10/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CompareProductModel
struct CompareProductModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CompareProductModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CompareProductModelDataClass: Codable {
    var priceRangeList: [HearingAidPriceRangeList]?
    var brandList: [HearingAidBrandList]?
    var modelList: [ShopModelList]?
    var productComparisonHistory: [ProductComparisonHistory]?
    var product1, product2: [ShopProductList]?
    var productOverview: [CompareProductModelProductOverViewElement]?
    var productSpecification: [CompareProductModelProductSpecificationElement]?
    var productFeatures: [CompareProductModelProductFeatureElement]?
    var productCompatability: [CompareProductModelProductCompatability]?
    var product1Specification, product2Specification: [ProductSpecification]?
    
    enum CodingKeys: String, CodingKey {
        case priceRangeList = "price_range_list"
        case brandList = "brand_list"
        case modelList = "model_list"
        case productComparisonHistory = "product_comparison_history"
        case product1 = "product_1"
        case product2 = "product_2"
        case productOverview = "product_overview"
        case productFeatures = "product_features"
        case productSpecification = "product_specification"
        case productCompatability = "product_compatability"
        case product1Specification = "product_1_specification"
        case product2Specification = "product_2_specification"
    }
}
// MARK: - ProductCompatability
struct CompareProductModelProductCompatability: Codable {
    var key: ProductCompatabilityKey?
    var product1, product2: ProductCompatabilityProduct?
}

// MARK: - Key
struct ProductCompatabilityKey: Codable {
    var id: Int?
    var name, description: String?
    var image: String?
    var situation: [String]?
}

// MARK: - Product
struct ProductCompatabilityProduct: Codable {
    var lifestyleName, lifestyleImage, fitLevel, colorCode: String?
    var fitLevelDescription: String?
    var compatibilityScore: Int?
    var situation: [String]?
    var lifestyleDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case lifestyleName = "lifestyle_name"
        case lifestyleImage = "lifestyle_image"
        case fitLevel = "fit_level"
        case colorCode = "color_code"
        case fitLevelDescription = "fit_level_description"
        case compatibilityScore = "compatibility_score"
        case situation
        case lifestyleDescription = "lifestyle_description"
    }
}

// MARK: - ProductFeature
struct CompareProductModelProductFeatureElement: Codable {
    var key: String?
    var product1: Bool?
    var product1Value: String?
    var product2: Bool?
    var product2Value: String?
    
    enum CodingKeys: String, CodingKey {
        case key, product1
        case product1Value = "product1_value"
        case product2
        case product2Value = "product2_value"
    }
}
// MARK: - ProductOverView
struct CompareProductModelProductOverViewElement: Codable {
    var key, product1, product2: String?
}
// MARK: - ProductSpecification
struct CompareProductModelProductSpecificationElement: Codable {
    var key, product1, product2: String?
}
// MARK: - Product1 and Product2 Specification
// struct ProductSpecification: Codable {
//    var name: String?
//    var values: [Value]?
// }
// MARK: - Value
// struct Value: Codable {
//    var id, name: String?
// }
