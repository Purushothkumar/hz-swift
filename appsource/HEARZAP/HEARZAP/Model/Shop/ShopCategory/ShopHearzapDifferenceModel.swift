//
//  ShopHearzapDifferenceModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/12/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ShopHearzapDifferenceModel
struct ShopHearzapDifferenceModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ShopHearzapDifferenceModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ShopHearzapDifferenceModelDataClass: Codable {
    var results: [ShopHearzapDifferenceModelResult]?
    var title, dataDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case results, title
        case dataDescription = "description"
    }
}

// MARK: - Result
struct ShopHearzapDifferenceModelResult: Codable {
    var id: Int?
    var icon: String?
    var title: String?
    var resultDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id, icon, title
        case resultDescription = "description"
    }
}

// MARK: - Dummy
struct HearingAidsShopBrandModel: Codable {
    let image: String
}
