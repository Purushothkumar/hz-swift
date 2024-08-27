//
//  BottomSheetCartQuantityModel.swift
//  HEARZAP
//
//  Created by Purushoth on 05/07/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BottomSheetCartQuantityModel
struct BottomSheetCartQuantityModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BottomSheetCartQuantityModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BottomSheetCartQuantityModelDataClass: Codable {
    var specificationMsg: String?
    var totalQuantity: [String]?
    
    enum CodingKeys: String, CodingKey {
        case specificationMsg = "specification_msg"
        case totalQuantity = "total_quantity"
    }
}
