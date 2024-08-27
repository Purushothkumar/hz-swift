//
//  HearingAidPriceRangeListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 03/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
// MARK: - HearingAidPriceRangeListModel
struct HearingAidPriceRangeListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: HearingAidPriceRangeListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct HearingAidPriceRangeListModelDataClass: Codable {
    var priceRangeList: [HearingAidPriceRangeList]?
    //    var priceRangeDict: Errors?
    var brandList: [HearingAidBrandList]?
    
    enum CodingKeys: String, CodingKey {
        case priceRangeList = "price_range_list"
        //        case priceRangeDict = "price_range_dict"
        case brandList = "brand_list"
    }
}

// MARK: - BrandList
// struct BrandList: Codable {
//    var id: Int?
//    var name: String?
//    var photo: String?
//    var code: String?
// }

// MARK: - PriceRangeList
struct HearingAidPriceRangeList: Codable {
    var priceRangeName: String?
    var id: Int?
    var name, slug, description, image: String?
    var priceStartRange, priceEndRange: Int?
    var products: [ShopProductList]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, description, image
        case priceStartRange = "price_start_range"
        case priceEndRange = "price_end_range"
        case products
    }
}
