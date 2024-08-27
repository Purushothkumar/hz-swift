//
//  AddRegisterDeviceModel.swift
//  HEARZAP
//
//  Created by Purushoth on 08/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct AddRegisterDeviceModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: AddRegisterDeviceModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct AddRegisterDeviceModelDataClass: Codable {
    var id, deviceUser, orderRef, deviceName: String?
    var deviceBrand, deviceModel, deviceSerialNumber, deviceEarPreference: String?
    var devicePurchasedOn, devicePurchasedFrom, deviceWarrantyExpiresOn, deviceExtendedWarrantyEndOn: String?
    var deviceWarrantyDetails, deviceNextServiceDate, deviceLastServiceDate, remarks: String?
    var productSpecification: [RegisterDeviceModelProductSpecification]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case deviceUser = "device_user"
        case orderRef = "order_ref"
        case deviceName = "device_name"
        case deviceBrand = "device_brand"
        case deviceModel = "device_model"
        case deviceSerialNumber = "device_serial_number"
        case deviceEarPreference = "device_ear_preference"
        case devicePurchasedOn = "device_purchased_on"
        case devicePurchasedFrom = "device_purchased_from"
        case deviceWarrantyExpiresOn = "device_warranty_expires_on"
        case deviceExtendedWarrantyEndOn = "device_extended_warranty_end_on"
        case deviceWarrantyDetails = "device_warranty_details"
        case deviceNextServiceDate = "device_next_service_date"
        case deviceLastServiceDate = "device_last_service_date"
        case remarks
    }
}
