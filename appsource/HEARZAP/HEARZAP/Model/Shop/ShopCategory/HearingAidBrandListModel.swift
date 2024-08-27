//
//  HearingAidBrandListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 03/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - HearingAidBrandListModel
struct HearingAidBrandListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: HearingAidBrandListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct HearingAidBrandListModelDataClass: Codable {
    var priceRangeList: [HearingAidPriceRangeList]?
    //    var brandDict: Errors?
    var brandList: [HearingAidBrandList]?
    
    enum CodingKeys: String, CodingKey {
        case priceRangeList = "price_range_list"
        //        case brandDict = "brand_dict"
        case brandList = "brand_list"
    }
}

// MARK: - BrandList
struct HearingAidBrandList: Codable {
    var id: Int?
    var name: String?
    var photo: String?
    var code: String?
    var products: [ShopProductList]?
}
