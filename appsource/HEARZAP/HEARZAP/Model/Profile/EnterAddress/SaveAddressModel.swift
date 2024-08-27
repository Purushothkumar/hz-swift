//
//  SaveAddressModel.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct SaveAddressModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: SaveAddressModelDataClass?
    let errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct SaveAddressModelDataClass: Codable {
    var customerName, mobile, addressType, isPrimary: String?
    var address1, address2, address3, landmark: String?
    var city, state, zipcode, lat: String?
    var lng, id: String?
    //    let isPrimary: Bool?
    
    enum CodingKeys: String, CodingKey {
        case customerName = "customer_name"
        case mobile
        case addressType = "address_type"
        //          case isPrimary = "is_primary"
        case address1 = "address_1"
        case address2 = "address_2"
        case address3 = "address_3"
        case landmark, city, state, zipcode, lat, lng, id
    }
}
