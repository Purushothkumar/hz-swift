//
//  ApplyCouponModel.swift
//  HEARZAP
//
//  Created by Purushoth on 31/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ApplyCouponModel
struct ApplyCouponModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ApplyCouponModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ApplyCouponModelDataClass: Codable {
    var isValidCoupon: Bool?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case isValidCoupon = "is_valid_coupon"
        case message
    }
}
