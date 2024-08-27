//
//  GoogleAPIModel.swift
//  HEARZAP
//
//  Created by Purushoth on 24/05/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - GoogleAPIModel
struct GoogleAPIModel: Codable {
    var plusCode: PlusCode?
    var results: [Result]?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case plusCode = "plus_code"
        case results, status
    }
}

// MARK: - PlusCode
struct PlusCode: Codable {
    var compoundCode, globalCode: String?
    
    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}

// MARK: - Result
struct Result: Codable {
    var addressComponents: [AddressComponent]?
    var formattedAddress: String?
    var geometry: Geometry?
    var placeID: String?
    var plusCode: PlusCode?
    var types: [String]?
    
    enum CodingKeys: String, CodingKey {
        case addressComponents = "address_components"
        case formattedAddress = "formatted_address"
        case geometry
        case placeID = "place_id"
        case plusCode = "plus_code"
        case types
    }
}

// MARK: - AddressComponent
struct AddressComponent: Codable {
    var longName, shortName: String?
    var types: [String]?
    
    enum CodingKeys: String, CodingKey {
        case longName = "long_name"
        case shortName = "short_name"
        case types
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    var location: Location?
    var locationType: String?
    var viewport, bounds: Bounds?
    
    enum CodingKeys: String, CodingKey {
        case location
        case locationType = "location_type"
        case viewport, bounds
    }
}

// MARK: - Bounds
struct Bounds: Codable {
    var northeast, southwest: Location?
}

// MARK: - Location
struct Location: Codable {
    var lat, lng: Double?
}
