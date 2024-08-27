//
//  BlogsDetailModel.swift
//  HEARZAP
//
//  Created by Purushoth on 05/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BlogsDetailModel
struct BlogsDetailModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BlogsDetailModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BlogsDetailModelDataClass: Codable {
    var article: BlogsDetailModelArticle?
    var relatedArticle, recentArticles: [BlogsDetailModelArticle]?

    enum CodingKeys: String, CodingKey {
        case article
        case relatedArticle = "related_article"
        case recentArticles = "recent_articles"
    }
}

// MARK: - Article
struct BlogsDetailModelArticle: Codable {
    var id: Int?
    var tags: [String]?
    var image: String?
    var category: BlogsDetailModelCategory?
    var createdBy, updatedBy, createdOnDate: String?
    var displayDate: String?
    var title, slug, metaTitle, metaDescription: String?
    var metaKeywords, authorName: String?
    var isWebsite, isHome, isBanner: Bool?
    var imageAlt, content: String?
    var shortDescription: String?
    var status: String?
    var displayOrder: Int?
    var sharedLink: String?

    enum CodingKeys: String, CodingKey {
        case id, tags, image, category
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case createdOnDate = "created_on_date"
        case displayDate = "display_date"
        case title, slug
        case metaTitle = "meta_title"
        case metaDescription = "meta_description"
        case metaKeywords = "meta_keywords"
        case authorName = "author_name"
        case isWebsite = "is_website"
        case isHome = "is_home"
        case isBanner = "is_banner"
        case imageAlt = "image_alt"
        case content
        case shortDescription = "short_description"
        case status
        case displayOrder = "display_order"
        case sharedLink = "shared_link"
    }
}

// MARK: - Category
struct BlogsDetailModelCategory: Codable {
    var name, shortDescription, slug, image: String?

    enum CodingKeys: String, CodingKey {
        case name
        case shortDescription = "short_description"
        case slug, image
    }
}
//// MARK: - Errors
//struct Errors: Codable {
//}
