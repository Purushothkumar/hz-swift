//
//  CompareListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 04/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CompareListModel
struct CompareListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CompareListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CompareListModelDataClass: Codable {
    var priceRangeList: [HearingAidPriceRangeList]?
    var brandList: [HearingAidBrandList]?
    var modelList: [ShopModelList]?
    var productComparisonHistory: [ProductComparisonHistory]?
    //    var product1, product2: ShopProductList?
    //    var productOverview: [CompareListModelProductOverViewElement]?
    //    var productSpecification: [CompareListModelProductSpecificationElement]?
    //    var productFeatures: [CompareListModelProductFeatureElement]?
    //    var productCompatability: [CompareListModelProductCompatability]?
    //    var product1_Specification, product2_Specification: [CompareListModelProductSpecification]?
    
    enum CodingKeys: String, CodingKey {
        case priceRangeList = "price_range_list"
        case brandList = "brand_list"
        case modelList = "model_list"
        case productComparisonHistory = "product_comparison_history"
        //        case product1 = "product_1"
        //        case product2 = "product_2"
        //        case productOverview = "product_overview"
        //        case productFeatures = "product_features"
        //        case productSpecification = "product_specification"
        //        case productCompatability = "product_compatability"
    }
}

// MARK: - ProductComparisonHistory
struct ProductComparisonHistory: Codable {
    var product1, product2: ShopProductList?
    
    enum CodingKeys: String, CodingKey {
        case product1 = "product_1"
        case product2 = "product_2"
    }
}
struct CompareTagModel: Codable {
    var name: String
    var slug: String
    var type: String
}
