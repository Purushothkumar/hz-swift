//
//  BookAppointmentLocationCityModel.swift
//  HEARZAP
//
//  Created by Purushoth on 27/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BookAppointmentLocationCityModel
struct BookAppointmentLocationCityModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookAppointmentLocationCityModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BookAppointmentLocationCityModelDataClass: Codable {
    var cityData: [CityDatum]?
//    var h1Title: JSONNull?

    enum CodingKeys: String, CodingKey {
        case cityData = "city_data"
//        case h1Title = "h1_title"
    }
}

// MARK: - CityDatum
struct CityDatum: Codable {
    var id: Int?
    var name: String?
}

//// MARK: - Errors
//struct Errors: Codable {
//}
