//
//  StoreFAQModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct StoreFAQModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: StoreFAQModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct StoreFAQModelDataClass: Codable {
    var paginatedData: PaginatedData?
    var results: [StoreFAQModelResult]?
    
    enum CodingKeys: String, CodingKey {
        case paginatedData = "paginated_data"
        case results
    }
}

// MARK: - Result
struct StoreFAQModelResult: Codable {
    var question, answer: String?
}

struct FAQModelExpanded: Codable {
    var question: String
    var answer: String
    var expanded: Bool
}
