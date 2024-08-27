//
//  PaginationDataModel.swift
//  HEARZAP
//
//  Created by Purushoth on 18/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - PaginatedData
struct PaginatedData: Codable {
    var count, totalPages, pageNumber: Int?
    var previous, next: Bool?

//    var perPage: String? //blogs
//    var perPage: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case totalPages = "total_pages"
//        case perPage = "per_page"
        case pageNumber = "page_number"
        case previous, next
    }
}
