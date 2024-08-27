//
//  StoreDeliveryAddressModel.swift
//  HEARZAP
//
//  Created by Purushoth on 20/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - StoreDeliveryAddressModel
struct StoreDeliveryAddressModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: StoreDeliveryAddressModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct StoreDeliveryAddressModelDataClass: Codable {
    var storeList: [StoreDeliveryAddressModelStoreList]?
    
    enum CodingKeys: String, CodingKey {
        case storeList = "store_list"
    }
}
// MARK: - StoreList
struct StoreDeliveryAddressModelStoreList: Codable {
    let store: Store?
    //    let storeDistance: Double?
    //    let hearzapStoreLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case store
        //        case storeDistance = "store_distance"
        //        case hearzapStoreLocation = "hearzap_store_location"
    }
}

// // MARK: - Store
// struct Store: Codable {
//    var id: Int?
//    var uid, name: String?
//    var isExperienceStore: Bool?
//    var slug, addressLine1, addressLine2, storeCountry: String?
//    var storeState, storeCity, storeCityArea, zipcode: String?
//    var storePhotos: [StorePhoto]?
//    var storeWorkingHourStatus: StoreWorkingHourStatus?
//
//    enum CodingKeys: String, CodingKey {
//        case id, uid, name
//        case isExperienceStore = "is_experience_store"
//        case slug
//        case addressLine1 = "address_line_1"
//        case addressLine2 = "address_line_2"
//        case storeCountry = "store_country"
//        case storeState = "store_state"
//        case storeCity = "store_city"
//        case storeCityArea = "store_city_area"
//        case zipcode
//        case storePhotos = "store_photos"
//        case storeWorkingHourStatus = "store_working_hour_status"
//    }
// }

// MARK: - StorePhoto
// struct StorePhoto: Codable {
//    var photo: String?
//    var photoType: String?
//
//    enum CodingKeys: String, CodingKey {
//        case photo
//        case photoType = "photo_type"
//    }
// }
//
// MARK: - StoreWorkingHourStatus
// struct StoreWorkingHourStatus: Codable {
//    var status, statusDescription: String?
//
//    enum CodingKeys: String, CodingKey {
//        case status
//        case statusDescription = "status_description"
//    }
// }
