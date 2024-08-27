//
//  BlogsDetailModel.swift
//  HEARZAP
//
//  Created by Purushoth on 05/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BlogsDetailModel
struct BlogsQueriesModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BlogsQueriesModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BlogsQueriesModelDataClass: Codable {
    var message: String?
}

// MARK: - Errors
//struct Errors: Codable {
//}
