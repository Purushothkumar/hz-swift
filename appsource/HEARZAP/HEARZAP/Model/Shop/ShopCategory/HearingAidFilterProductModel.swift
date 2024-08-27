//
//  HearingAidFilterProductModel.swift
//  HEARZAP
//
//  Created by Purushoth on 05/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - HearingAidFilterProductModel
struct HearingAidFilterProductModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: HearingAidFilterProductModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct HearingAidFilterProductModelDataClass: Codable {
    var products: [ShopProductList]?
    var paginatedData: PaginatedData?
    
    enum CodingKeys: String, CodingKey {
        case products
        case paginatedData = "paginated_data"
    }
}
