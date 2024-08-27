//
//  RemoveCartItemModel.swift
//  HEARZAP
//
//  Created by Purushoth on 19/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
// MARK: - RemoveCartItemModel
struct RemoveCartItemModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: RemoveCartItemModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct RemoveCartItemModelDataClass: Codable {
}
