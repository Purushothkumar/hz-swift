//
//  StoreFilterZipcodeModel.swift
//  HEARZAP
//
//  Created by Purushoth on 22/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - StoreFilterZipcodeModel
struct StoreFilterZipcodeModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: StoreFilterZipcodeModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct StoreFilterZipcodeModelDataClass: Codable {
    var zipcode: String?
    var storeList: [StoreFilterModelStoreList]?
    var paginatedData: PaginatedData?
    
    enum CodingKeys: String, CodingKey {
        case zipcode
        case storeList = "store_list"
        case paginatedData = "paginated_data"
    }
}
