//
//  EditWishlistModel.swift
//  HEARZAP
//
//  Created by Purushoth on 23/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - EditWishlistModel
struct EditWishlistModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: EditWishlistModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct EditWishlistModelDataClass: Codable {
    var products: [Product]?
}

// MARK: - Product
struct Product: Codable {
    var id: Int?
    var uid, slug, name: String?
    var unitSellingPrice, unitPrice: String?
    var brand: String?
    var mainImage: String?
    var productDiscount: Int?
    var isWishlist: Bool?
    var warrantyInYears, category, image1, image2: String?
    var image3, image4, image5: String?
    var isEmiAvailable, isWarrantyAvailable, isReturnAvailable: Bool?
    var description: String?
    var returnPeriod: Int?
    var subCategory: String?
    
    enum CodingKeys: String, CodingKey {
        case id, uid, slug, name
        case unitSellingPrice = "unit_selling_price"
        case unitPrice = "unit_price"
        case brand
        case mainImage = "main_image"
        case productDiscount = "product_discount"
        case isWishlist = "is_wishlist"
        case warrantyInYears = "warranty_in_years"
        case category
        case image1 = "image_1"
        case image2 = "image_2"
        case image3 = "image_3"
        case image4 = "image_4"
        case image5 = "image_5"
        case isEmiAvailable = "is_emi_available"
        case isWarrantyAvailable = "is_warranty_available"
        case isReturnAvailable = "is_return_available"
        case description
        case returnPeriod = "return_period"
        case subCategory = "sub_category"
    }
}
