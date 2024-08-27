//
//  HomeStaticModel.swift
//  HEARZAP
//
//  Created by Purushoth on 16/04/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - HomeStaticModel
struct HomeStaticModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: HomeStaticModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct HomeStaticModelDataClass: Codable {
}
