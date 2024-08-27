//
//  AccessoriesSubCategoryModel.swift
//  HEARZAP
//
//  Created by Purushoth on 01/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

// MARK: - AccessoriesSubCategoryModel
struct AccessoriesSubCategoryModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: AccessoriesSubCategoryModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct AccessoriesSubCategoryModelDataClass: Codable {
    var products: [ShopProductList]?
    var subCategory: String?
    var subCategorySpec: [SubCategorySpec]?
    var paginatedData: PaginatedData?
    var batteries: [ShopProductList]?
    var title, description: String?
    
    enum CodingKeys: String, CodingKey {
        case products
        case subCategory = "sub_category"
        case subCategorySpec = "sub_category_spec"
        case paginatedData = "paginated_data"
        case batteries, title, description
    }
}

// MARK: - SubCategorySpec
struct SubCategorySpec: Codable {
    var key: String?
    var value: String?
}
