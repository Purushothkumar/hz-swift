//
//  StoreFinderHearzapDifferenceModel.swift
//  HEARZAP
//
//  Created by Purushoth on 19/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - StoreFinderDifferenceModel
struct StoreFinderDifferenceModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: StoreFinderDifferenceModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct StoreFinderDifferenceModelDataClass: Codable {
    var results: [StoreFinderDifferenceModelResult]?
}

// MARK: - Result
struct StoreFinderDifferenceModelResult: Codable {
    var title, resultDescription: String?
    var icon: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case resultDescription = "description"
        case icon
    }
}
