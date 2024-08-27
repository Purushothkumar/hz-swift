//
//  ViewAllBrandProductModel.swift
//  HEARZAP
//
//  Created by Purushoth on 04/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ViewAllBrandProductModel
struct ViewAllBrandProductModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ViewAllBrandProductModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ViewAllBrandProductModelDataClass: Codable {
    var priceRangeList: [HearingAidPriceRangeList]?
    var brandDict: HearingAidBrandDict?
    var brandList: [HearingAidBrandList]?
    
    enum CodingKeys: String, CodingKey {
        case priceRangeList = "price_range_list"
        case brandDict = "brand_dict"
        case brandList = "brand_list"
    }
}

// MARK: - BrandDict
struct HearingAidBrandDict: Codable {
    var id: Int?
    var name, photo, code: String?
    var paginatedData: PaginatedData?
    var products: [ShopProductList]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, photo, code
        case paginatedData = "paginated_data"
        case products
    }
}
