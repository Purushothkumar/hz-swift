//
//  AccessoriesSubCategoryColorModel.swift
//  HEARZAP
//
//  Created by Purushoth on 10/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

// MARK: - AccessoriesSubCategoryModel
struct AccessoriesSubCategoryColorModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: AccessoriesSubCategoryColorModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct AccessoriesSubCategoryColorModelDataClass: Codable {
    var products: [ShopProductList]?
    var paginatedData: PaginatedData?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case products
        case paginatedData = "paginated_data"
        case image
    }
}
