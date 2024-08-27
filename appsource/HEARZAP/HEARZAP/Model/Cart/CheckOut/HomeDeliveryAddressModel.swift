//
//  HomeDeliveryAddressModel.swift
//  HEARZAP
//
//  Created by Purushoth on 20/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
// MARK: - HomeDeliveryAddressModel
struct HomeDeliveryAddressModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: HomeDeliveryAddressModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct HomeDeliveryAddressModelDataClass: Codable {
    var addressData: [AddressDatum]?
    
    enum CodingKeys: String, CodingKey {
        case addressData = "address_data"
    }
}

// MARK: - AddressDatum
// struct AddressDatum: Codable {
//    var id: Int?
//    var customerName, mobile, addressType: String?
//    var isPrimary: Bool?
//    var address1, address2, address3, landmark: String?
//    var city, state: String?
//    var zipcode: Int?
//    var lat, lng: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case customerName = "customer_name"
//        case mobile
//        case addressType = "address_type"
//        case isPrimary = "is_primary"
//        case address1 = "address_1"
//        case address2 = "address_2"
//        case address3 = "address_3"
//        case landmark, city, state, zipcode, lat, lng
//    }
// }
