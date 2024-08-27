//
//  TipsListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - TipsListModel
struct TipsListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: TipsListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct TipsListModelDataClass: Codable {
    var tips: [TipsListModelTip]?
}

// MARK: - Tip
struct TipsListModelTip: Codable {
    var id: Int?
    var image: String?
    var createdOnDate: String?
    var tipDetailCount: Int?
    var title, slug, metaTitle, metaDescription: String?
    var metaKeywords: String?
    var tags: [String]?
    var authorName: String?
    var isWebsite, isHome, isBanner: Bool?
    var imageAlt: String?
    var displayOrder: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, image
        case createdOnDate = "created_on_date"
        case tipDetailCount = "tip_detail_count"
        case title, slug
        case metaTitle = "meta_title"
        case metaDescription = "meta_description"
        case metaKeywords = "meta_keywords"
        case tags
        case authorName = "author_name"
        case isWebsite = "is_website"
        case isHome = "is_home"
        case isBanner = "is_banner"
        case imageAlt = "image_alt"
        case displayOrder = "display_order"
    }
}
