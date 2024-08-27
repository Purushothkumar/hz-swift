//
//  ViewAllProductModel.swift
//  HEARZAP
//
//  Created by Purushoth on 03/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ViewAllProductModel
struct ViewAllProductModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ViewAllProductModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ViewAllProductModelDataClass: Codable {
    //    var accessoriesFilterData: Errors?
    var products: [ShopProductList]?
    var paginatedData: PaginatedData?
    var title, dataDescription: String?
    
    enum CodingKeys: String, CodingKey {
        //        case accessoriesFilterData = "accessories_filter_data"
        case products
        case paginatedData = "paginated_data"
        case title
        case dataDescription = "description"
    }
}
