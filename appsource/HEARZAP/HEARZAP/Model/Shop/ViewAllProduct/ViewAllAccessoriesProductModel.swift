//
//  ViewAllAccessoriesProductModel.swift
//  HEARZAP
//
//  Created by Purushoth on 11/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ViewAllAccessoriesProductModel
struct ViewAllAccessoriesProductModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ViewAllAccessoriesProductModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ViewAllAccessoriesProductModelDataClass: Codable {
    //    var accessoriesFilterData: Errors?
    var products: [ShopProductList]?
    var paginatedData: PaginatedData?
    var title, description: String?
    
    enum CodingKeys: String, CodingKey {
        //        case accessoriesFilterData = "accessories_filter_data"
        case products
        case paginatedData = "paginated_data"
        case title, description
    }
}
