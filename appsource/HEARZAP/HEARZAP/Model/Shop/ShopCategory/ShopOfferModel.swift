//
//  OfferModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/12/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - OfferModel
struct ShopOfferModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ShopOfferModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ShopOfferModelDataClass: Codable {
    var offerList: [OfferList]?
    var title, dataDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case offerList = "offer_list"
        case title
        case dataDescription = "description"
    }
}

// MARK: - OfferList
struct OfferList: Codable {
    var couponUid, couponDescription, couponTitle, productUid: String?
    var productSlug, categorySlug, redirectURL: String?
    var couponPhoto: String?
    
    enum CodingKeys: String, CodingKey {
        case couponUid = "coupon_uid"
        case couponDescription = "coupon_description"
        case couponTitle = "coupon_title"
        case productUid = "product_uid"
        case productSlug = "product_slug"
        case categorySlug = "category_slug"
        case redirectURL = "redirect_url"
        case couponPhoto = "coupon_photo"
    }
}
