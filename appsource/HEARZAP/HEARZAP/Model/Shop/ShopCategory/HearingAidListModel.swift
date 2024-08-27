//
//  HearingAidListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 08/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - HearingAidListModel
struct HearingAidListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: HearingAidListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct HearingAidListModelDataClass: Codable {
    var latestProducts, hotDealProducts: [ShopProductList]?
    var priceRangeList: [HearingAidPriceRangeList]?
    var brandList: [HearingAidBrandList]?
    var modelList: [ShopModelList]?
    var viewallLatest, latestTitle, latestDescription, viewallHotdeal: String?
    var hotDealTitle, hotDealDescription, priceTitle, priceDescription: String?
    var brandTitle, brandDescription, modelTitle, modelDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case latestProducts = "latest_products"
        case hotDealProducts = "hot_deal_products"
        case priceRangeList = "price_range_list"
        case brandList = "brand_list"
        case modelList = "model_list"
        case viewallLatest = "viewall_latest"
        case latestTitle = "latest_title"
        case latestDescription = "latest_description"
        case viewallHotdeal = "viewall_hotdeal"
        case hotDealTitle = "hot_deal_title"
        case hotDealDescription = "hot_deal_description"
        case priceTitle = "price_title"
        case priceDescription = "price_description"
        case brandTitle = "brand_title"
        case brandDescription = "brand_description"
        case modelTitle = "model_title"
        case modelDescription = "model_description"
    }
}

// MARK: - ModelList
struct ShopModelList: Codable {
    var id: Int?
    var slug, name, code: String?
    var photo: String?
    var productsCount: Int?
    let info: ShopModelListInfo?
    
    enum CodingKeys: String, CodingKey {
        case id, slug, name, code, photo
        case productsCount = "products_count"
        case info
        
    }
}
// MARK: - Info
struct ShopModelListInfo: Codable {
    var id: Int?
    var name, image, description, suitableFor: String?
    var pros, cons: [String]?
    var deviceView, humanEarView: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, description
        case suitableFor = "suitable_for"
        case pros, cons
        case deviceView = "device_view"
        case humanEarView = "human_ear_view"
    }
}
