//
//  StoreFilterStateModel.swift
//  HEARZAP
//
//  Created by Purushoth on 22/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct StoreFilterStateModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: StoreFilterStateModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct StoreFilterStateModelDataClass: Codable {
    var stateObj: StateObj?
    var storeList: [StoreFilterModelStoreList]?
    var paginatedData: PaginatedData?
    
    enum CodingKeys: String, CodingKey {
        case stateObj = "state_obj"
        case storeList = "store_list"
        case paginatedData = "paginated_data"
    }
    
}

// MARK: - StateObj
struct StateObj: Codable {
    var uid, name, storeGeographyType: String?
    var storesCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case uid, name
        case storeGeographyType = "store_geography_type"
        case storesCount = "stores_count"
    }
    
}
