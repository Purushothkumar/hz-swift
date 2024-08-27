//
//  AccessoriesBrandListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - AccessoriesBrandListModel
struct AccessoriesBrandListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: AccessoriesBrandListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct AccessoriesBrandListModelDataClass: Codable {
    var brandList: [AccessoriesBrandList]?
    
    enum CodingKeys: String, CodingKey {
        case brandList = "brand_list"
    }
}

// MARK: - BrandList
struct AccessoriesBrandList: Codable {
    var brandID: Int?
    var brandCode, brandName: String?
    var products: [ShopProductList]?
    
    enum CodingKeys: String, CodingKey {
        case brandID = "brand_id"
        case brandCode = "brand_code"
        case brandName = "brand_name"
        case products
    }
}

// MARK: - Product
// struct Product: Codable {
//    var id: Int?
//    var uid, slug, name: String?
//    var unitSellingPrice, unitPrice: Int?
//    var brand: String?
//    var mainImage: String?
//    var productDiscount: Int?
//    var isWishlist: Bool?
//    var category, description, subCategory: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, uid, slug, name
//        case unitSellingPrice = "unit_selling_price"
//        case unitPrice = "unit_price"
//        case brand
//        case mainImage = "main_image"
//        case productDiscount = "product_discount"
//        case isWishlist = "is_wishlist"
//        case category, description
//        case subCategory = "sub_category"
//    }
// }
