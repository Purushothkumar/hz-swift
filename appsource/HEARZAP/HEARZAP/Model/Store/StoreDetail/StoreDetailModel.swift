//
//  StoreDetailModel.swift
//  HEARZAP
//
//  Created by Purushoth on 27/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - StoreDetailModel
struct StoreDetailModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: StoreDetailModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct StoreDetailModelDataClass: Codable {
    var storeObj: StoreObj?
    var storePhoto: [StorePhoto]?
    var storeWorkHours: [StoreWorkHour]?
    var storeService: [StoreService]?
    var storeFeature: [StoreFeature]?
    var storeReview: [StoreReview]?
    let storeReviewCount, averageRating: Int?
    var sharedLink: String?
    
    enum CodingKeys: String, CodingKey {
        case storeObj = "store_obj"
        case storePhoto = "store_photo"
        case storeWorkHours = "store_work_hours"
        case storeService = "store_service"
        case storeFeature = "store_feature"
        case storeReview = "store_review"
        case storeReviewCount = "store_review_count"
        case averageRating = "average_rating"
        case sharedLink = "shared_link"
    }
}
// MARK: - StoreService
struct StoreService: Codable {
    var name, description: String?
    enum CodingKeys: String, CodingKey {
        case name, description
    }
}
// MARK: - StoreFeature
struct StoreFeature: Codable {
    var name, description: String?
    
    enum CodingKeys: String, CodingKey {
        case name, description
    }
}
// MARK: - StoreObj
struct StoreObj: Codable {
    var name: String?
    var isExperienceStore: Bool?
    var slug, addressLine1, addressLine2, storeCountry: String?
    var storeState, storeCity, storeCityArea, zipcode: String?
    var lat, lng: Double?
    var phoneNumber, email: String?
    var storeWorkingHourStatus: StoreWorkingHourStatus?
    
    enum CodingKeys: String, CodingKey {
        case name
        case isExperienceStore = "is_experience_store"
        case slug
        case addressLine1 = "address_line_1"
        case addressLine2 = "address_line_2"
        case storeCountry = "store_country"
        case storeState = "store_state"
        case storeCity = "store_city"
        case storeCityArea = "store_city_area"
        case zipcode, lat, lng
        case phoneNumber = "phone_number"
        case email
        case storeWorkingHourStatus = "store_working_hour_status"
    }
}

// MARK: - StoreWorkHour
struct StoreWorkHour: Codable {
    let day, workingHours: String?
    
    enum CodingKeys: String, CodingKey {
        case day
        case workingHours = "working_hours"
    }
}

// MARK: - StoreReview
struct StoreReview: Codable {
    var id: Int?
    var rating, review, createdBy, storeSlug: String?
    
    enum CodingKeys: String, CodingKey {
        case id, rating, review
        case createdBy = "created_by"
        case storeSlug = "store_slug"
    }
}
