//
//  HAProductDetailModel.swift
//  HEARZAP
//
//  Created by Purushoth on 02/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct HAProductDetailModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: HAProductDetailModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct HAProductDetailModelDataClass: Codable {
    var product: ShopProductList?
    var productFeatures: [ProductFeature]?
    var productBoxing: [ProductBoxing]?
    var productPartnumber: [ProductPartnumber]?
    var productLifestyle: [ProductLifestyle]?
    var productSpecification: [ProductSpecification]?
    var relatedProducts: [RelatedProduct]?
    //    var boughtTogetherProducts: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case product
        case productFeatures = "product_features"
        case productBoxing = "product_boxing"
        case productPartnumber = "product_partnumber"
        case productLifestyle = "product_lifestyle"
        case productSpecification = "product_specification"
        case relatedProducts = "related_products"
        //        case boughtTogetherProducts = "bought_together_products"
    }
}

// MARK: - ProductBoxing
struct ProductBoxing: Codable {
    var id: Int?
    var itemName: String?
    var itemCount, product: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case itemName = "item_name"
        case itemCount = "item_count"
        case product
    }
}

// MARK: - ProductLifestyle
struct ProductLifestyle: Codable {
    var lifestyleName, lifestyleImage, fitLevel, colorCode: String?
    var fitLevelDescription: String?
    var compatibilityScore: Int?
    var lifestyleDescription: String?
    var situation: [String]?
    
    enum CodingKeys: String, CodingKey {
        case lifestyleName = "lifestyle_name"
        case lifestyleImage = "lifestyle_image"
        case fitLevel = "fit_level"
        case colorCode = "color_code"
        case fitLevelDescription = "fit_level_description"
        case compatibilityScore = "compatibility_score"
        case lifestyleDescription = "lifestyle_description"
        case situation
    }
}
// MARK: - ProductFeatures
struct ProductFeature: Codable {
    var id: Int?
    var name, value: String?
}

// MARK: - ProductSpecification
struct ProductSpecification: Codable {
    var name: String?
    var values: [Value]?
}

// MARK: - Value
struct Value: Codable {
    var id, name: String?
    var selected: Bool?
}

// MARK: - RelatedProduct
struct RelatedProduct: Codable {
    var id: Int?
    var relatedProduct: ShopProductList?
    
    enum CodingKeys: String, CodingKey {
        case id
        case relatedProduct = "related_product"
    }
}

// MARK: - ProductPartnumber
struct ProductPartnumber: Codable {
    var id: Int?
    var isMain: Bool?
    var product, partNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case isMain = "is_main"
        case product
        case partNumber = "part_number"
    }
}
