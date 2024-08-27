//
//  BlogsListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 05/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BlogsListModel
struct BlogsListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BlogsListModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BlogsListModelDataClass: Codable {
    var category: [BlogsListModelCategory]?
    var paginatedData: PaginatedData?
    var articles: [BlogsListModelArticle]?

    enum CodingKeys: String, CodingKey {
        case category
        case paginatedData = "paginated_data"
        case articles
    }
}

// MARK: - Article
struct BlogsListModelArticle: Codable {
    var image, createdOnDate, title, slug: String?
    var tags: [String]?
    var authorName, content: String?
    var displayDate: String?
    var categoryName: String?

    enum CodingKeys: String, CodingKey {
        case image
        case createdOnDate = "created_on_date"
        case title, slug
        case tags
        case authorName = "author_name"
        case content
        case displayDate = "display_date"
        case categoryName = "category_name"
    }
}

// MARK: - Category
struct BlogsListModelCategory: Codable {
    var name, slug: String?
}

//// MARK: - PaginatedData
//struct PaginatedData: Codable {
//    var count, totalPages, perPage, pageNumber: Int?
//    var previous, next: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case totalPages = "total_pages"
//        case perPage = "per_page"
//        case pageNumber = "page_number"
//        case previous, next
//    }
//}
//
//// MARK: - Errors
//struct Errors: Codable {
//}
