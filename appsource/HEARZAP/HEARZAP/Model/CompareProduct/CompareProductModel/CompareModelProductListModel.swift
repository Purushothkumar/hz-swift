//
//  CompareModelProductListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct CompareModelProductListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CompareModelProductListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CompareModelProductListModelDataClass: Codable {
    var products: [ShopProductList]?
}
