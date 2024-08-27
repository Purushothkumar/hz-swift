//
//  TipsDetailModel.swift
//  HEARZAP
//
//  Created by Purushoth on 31/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - TipsDetailModel
struct TipsDetailModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: TipsDetailModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct TipsDetailModelDataClass: Codable {
    var tips: Tips?
    var nextTip: NextTip?
    var relatedTip: [Tips]?
    
    enum CodingKeys: String, CodingKey {
        case tips
        case nextTip = "next_tip"
        case relatedTip = "related_tip"
    }
}

// MARK: - NextTip
struct NextTip: Codable {
    var slug: String?
    var sharedLink: String?
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case slug
        case sharedLink = "shared_link"
        case imageURL = "image_url"
    }
}

// MARK: - Tips
struct Tips: Codable {
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
    var tipDetailList: [TipDetailList]?
    var content: String?
    var sharedLink: String?
    
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
        case tipDetailList = "tip_detail_list"
        case content
        case sharedLink = "shared_link"
    }
}

// MARK: - TipDetailList
struct TipDetailList: Codable {
    var title, content: String?
    var image: String?
    var imageAlt: String?
    
    enum CodingKeys: String, CodingKey {
        case title, content, image
        case imageAlt = "image_alt"
    }
}
