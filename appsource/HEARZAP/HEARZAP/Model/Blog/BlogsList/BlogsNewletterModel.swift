//
//  BlogsNewletterModel.swift
//  HEARZAP
//
//  Created by Purushoth on 05/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BlogsNewletterModel
struct BlogsNewletterModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BlogsNewletterModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BlogsNewletterModelDataClass: Codable {
    var message: String?
}

// MARK: - Errors
//struct Errors: Codable {
//}
