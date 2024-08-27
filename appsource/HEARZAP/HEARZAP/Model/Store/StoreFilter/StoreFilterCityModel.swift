//
//  StoreFilterCityModel.swift
//  HEARZAP
//
//  Created by Purushoth on 22/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - StoreFilterCityModel
struct StoreFilterCityModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: StoreFilterCityModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct StoreFilterCityModelDataClass: Codable {
    var cityObj: StoreFilterCityModelCityObj?
    var storeList: [StoreFilterModelStoreList]?
    var paginatedData: PaginatedData?
    
    enum CodingKeys: String, CodingKey {
        case cityObj = "city_obj"
        case storeList = "store_list"
        case paginatedData = "paginated_data"
    }
}

// MARK: - CityObj
struct StoreFilterCityModelCityObj: Codable {
    var uid, name, storeGeographyType: String?
    var storesCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case uid, name
        case storeGeographyType = "store_geography_type"
        case storesCount = "stores_count"
    }
}

// MARK: - StoreList
// struct StoreList: Codable {
//    var id: Int?
//    var name: String?
//    var isExperienceStore: Bool?
//    var slug, addressLine1, addressLine2: String?
//    var storeCountry: String?
//    var storeState: String?
//    var storeCity: String?
//    var storeCityArea: String?
//    var zipcode: String?
//    var storeWorkingHourStatus: StoreWorkingHourStatus?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case isExperienceStore = "is_experience_store"
//        case slug
//        case addressLine1 = "address_line_1"
//        case addressLine2 = "address_line_2"
//        case storeCountry = "store_country"
//        case storeState = "store_state"
//        case storeCity = "store_city"
//        case storeCityArea = "store_city_area"
//        case zipcode
//        case storeWorkingHourStatus = "store_working_hour_status"
//    }
// }
