//
//  StoreFilterModelStoreList.swift
//  HEARZAP
//
//  Created by Purushoth on 08/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - StoreList
struct StoreFilterModelStoreList: Codable {
    var id: Int?
    var name: String?
    var isExperienceStore: Bool?
    var slug, addressLine1, addressLine2, storeCountry: String?
    var storeState, storeCity, storeCityArea, zipcode: String?
    var storeWorkingHourStatus: StoreWorkingHourStatus?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case isExperienceStore = "is_experience_store"
        case slug
        case addressLine1 = "address_line_1"
        case addressLine2 = "address_line_2"
        case storeCountry = "store_country"
        case storeState = "store_state"
        case storeCity = "store_city"
        case storeCityArea = "store_city_area"
        case zipcode
        case storeWorkingHourStatus = "store_working_hour_status"
    }
}
