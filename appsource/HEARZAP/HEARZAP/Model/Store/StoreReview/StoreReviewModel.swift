//
//  StoreReviewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 02/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - StoreReviewModel
struct StoreReviewModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: StoreReviewModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct StoreReviewModelDataClass: Codable {
    var storeObj: StoreObj?
    var storePhoto: [StorePhoto]?
    var storeWorkHours: [StoreWorkHour]?
    var storeService: [StoreService]?
    var storeFeature: [StoreFeature]?
    var storeReview: [StoreReview]?
    var storeReviewCount: Int?
    var sharedLink: String?
    
    enum CodingKeys: String, CodingKey {
        case storeObj = "store_obj"
        case storePhoto = "store_photo"
        case storeWorkHours = "store_work_hours"
        case storeService = "store_service"
        case storeFeature = "store_feature"
        case storeReview = "store_review"
        case storeReviewCount = "store_review_count"
        case sharedLink = "shared_link"
    }
}
