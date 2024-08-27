//
//  RegisterDeviceDropDownModel.swift
//  HEARZAP
//
//  Created by Purushoth on 30/06/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - RegisterDeviceDropDownModel
struct RegisterDeviceDropDownModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: RegisterDeviceDropDownModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct RegisterDeviceDropDownModelDataClass: Codable {
    var brandData: [BrandDatum]?
    var patientData: [patientDatum]?
    var earPreference: [earPreference]?
    var purchasedFrom: [purchasedFrom]?
    var warranty: [warranty]?
    
    enum CodingKeys: String, CodingKey {
        case brandData = "brand_data"
        case patientData = "patient_data"
        case earPreference = "ear_preference"
        case purchasedFrom = "purchased_from"
        case warranty
    }
}

// MARK: - BrandDatum
struct BrandDatum: Codable {
    var id, name: String?
}

// MARK: - patientDatum
struct patientDatum: Codable {
    var id, name: String?
}
// MARK: - earPreference
struct earPreference: Codable {
    var id, name: String?
}
// MARK: - purchasedFrom
struct purchasedFrom: Codable {
    var id, name: String?
}
// MARK: - warranty
struct warranty: Codable {
    var id, name: String?
}
