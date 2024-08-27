//
//  RegisterDeviceModel.swift
//  HEARZAP
//
//  Created by Purushoth on 23/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - RegisterDeviceModel
struct RegisterDeviceModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: RegisterDeviceModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct RegisterDeviceModelDataClass: Codable {
    var deviceData: [RegisterDeviceModelDeviceData]?
    var accessories: [RegisterDeviceModelAccessories]?
    
    enum CodingKeys: String, CodingKey {
        case deviceData = "device_data"
        case accessories
    }
}

// MARK: - Accessory
struct RegisterDeviceModelAccessories: Codable {
    var id: Int?
    var slug, name: String?
    var unitSellingPrice: String?
    var brand: String?
    var mainImage: String?
    var isEmiAvailable, isWarrantyAvailable, isReturnAvailable, isWishlist: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case unitSellingPrice = "unit_selling_price"
        case brand
        case mainImage = "main_image"
        case isEmiAvailable = "is_emi_available"
        case isWarrantyAvailable = "is_warranty_available"
        case isReturnAvailable = "is_return_available"
        case isWishlist = "is_wishlist"
    }
}

// MARK: - DeviceDatum
struct RegisterDeviceModelDeviceData: Codable {
    
    var id: Int?
    var deviceUserUid, deviceUserName: String?
    var orderRef: String?
    var deviceName, deviceBrand, deviceBrandUid, deviceModel: String?
    var deviceSerialNumber, deviceEarPreference, devicePurchasedOn, devicePurchasedFrom: String?
    var deviceWarrantyExpiresOn, deviceExtendedWarrantyEndOn, warrantyEndsOnDaysColor, extendedWarrantyEndsOnDaysColor: String?
    var deviceWarrantyDetails, deviceNextServiceDate, deviceLastServiceDate: String?
    var deviceImage: String?
    var deviceCMVideo: String?
    var warrantyEndsOnDays, deviceEarPreferenceValue, devicePurchasedFromValue, deviceWarrantyDetailsValue: String?
    var productSpecification: [RegisterDeviceModelProductSpecification]?
    var canTakeSurvey: Bool?
    var extendedWarrantyEndsOnDays: String?
    var remarks: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case deviceUserUid = "device_user_uid"
        case deviceUserName = "device_user_name"
        case orderRef = "order_ref"
        case deviceName = "device_name"
        case deviceBrand = "device_brand"
        case deviceBrandUid = "device_brand_uid"
        case deviceModel = "device_model"
        case deviceSerialNumber = "device_serial_number"
        case deviceEarPreference = "device_ear_preference"
        case devicePurchasedOn = "device_purchased_on"
        case devicePurchasedFrom = "device_purchased_from"
        case deviceWarrantyExpiresOn = "device_warranty_expires_on"
        case deviceExtendedWarrantyEndOn = "device_extended_warranty_end_on"
        case warrantyEndsOnDaysColor = "warranty_ends_on_days_color"
        case extendedWarrantyEndsOnDaysColor = "extended_warranty_ends_on_days_color"
        case deviceWarrantyDetails = "device_warranty_details"
        case deviceNextServiceDate = "device_next_service_date"
        case deviceLastServiceDate = "device_last_service_date"
        case deviceImage = "device_image"
        case deviceCMVideo = "device_cm_video"
        case warrantyEndsOnDays = "warranty_ends_on_days"
        case deviceEarPreferenceValue = "device_ear_preference_value"
        case devicePurchasedFromValue = "device_purchased_from_value"
        case deviceWarrantyDetailsValue = "device_warranty_details_value"
        case productSpecification = "product_specification"
        case canTakeSurvey = "can_take_survey"
        case extendedWarrantyEndsOnDays = "extended_warranty_ends_on_days"
        case remarks
    }
}

// MARK: - ProductSpecification
struct RegisterDeviceModelProductSpecification: Codable {
    var key, value: String?
}
