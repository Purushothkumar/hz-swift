//
//  OnlineConsultationLocationCityModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - OnlineConsultationLocationCityModel
struct OnlineConsultationLocationCityModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: OnlineConsultationLocationCityModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct OnlineConsultationLocationCityModelDataClass: Codable {
    var city: [City]?
    var languageList: [LanguageList]?

    enum CodingKeys: String, CodingKey {
        case city
        case languageList = "language_list"
    }
}

// MARK: - City
struct City: Codable {
    var id: Int?
    var name: String?
}

/// MARK: - LanguageList
struct LanguageList: Codable {
    var code, name: String?
}

//// MARK: - Errors
//struct Errors: Codable {
//}
