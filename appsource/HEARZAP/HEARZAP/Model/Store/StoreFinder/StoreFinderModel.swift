//
//  StoreFinderModel.swift
//  HEARZAP
//
//  Created by Purushoth on 26/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - StoreModel
struct StoreFinderModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: StoreFinderModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct StoreFinderModelDataClass: Codable {
    var metroStoreList: [StoreList]?
    var videoLink: String?
    //    var metroCityList: [String]?
    var stateList: [StoreFinderModelStateList]?
    //    var nearbyStoreList: [StoreList]?
    
    enum CodingKeys: String, CodingKey {
        case metroStoreList = "metro_store_list"
        case videoLink = "video_link"
        //        case metroCityList = "metro_city_list"
        case stateList = "state_list"
        //  case nearbyStoreList = "nearby_store_list"
    }
}
// MARK: - StoreList
struct StoreList: Codable {
    var store: Store?
    var storePhoto: [StorePhoto]?
    //    var storeWorkingHourStatus: StoreWorkingHourStatus?
    var hearzapStoreLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case store
        case storePhoto = "store_photo"
        //        case storeWorkingHourStatus = "store_working_hour_status"
        case hearzapStoreLocation = "hearzap_store_location"
    }
}

// MARK: - StoreList
struct Store: Codable {
    var id: Int?
    var uid, name: String?
    var isExperienceStore: Bool?
    var slug, addressLine1, addressLine2, storeCountry: String?
    var storeState, storeCity, storeCityArea, zipcode: String?
    var storePhotos: [StorePhoto]?
    var storeWorkingHourStatus: StoreWorkingHourStatus?
    
    enum CodingKeys: String, CodingKey {
        case id, uid, name
        case isExperienceStore = "is_experience_store"
        case slug
        case addressLine1 = "address_line_1"
        case addressLine2 = "address_line_2"
        case storeCountry = "store_country"
        case storeState = "store_state"
        case storeCity = "store_city"
        case storeCityArea = "store_city_area"
        case zipcode
        case storePhotos = "store_photos"
        case storeWorkingHourStatus = "store_working_hour_status"
    }
}

// MARK: - StorePhoto
struct StorePhoto: Codable {
    var photo: String?
    var photoType: String?
    
    enum CodingKeys: String, CodingKey {
        case photo
        case photoType = "photo_type"
    }
}
// MARK: - StoreWorkingHourStatus
struct StoreWorkingHourStatus: Codable {
    var status, statusDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case statusDescription = "status_description"
    }
}

// MARK: - StateList
struct StoreFinderModelStateList: Codable {
    var uid, name, storeGeographyType: String?
    var storeList: [StoreList]?
    var storeCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case uid, name
        case storeGeographyType = "store_geography_type"
        case storeList = "store_list"
        case storeCount = "store_count"
    }
}
