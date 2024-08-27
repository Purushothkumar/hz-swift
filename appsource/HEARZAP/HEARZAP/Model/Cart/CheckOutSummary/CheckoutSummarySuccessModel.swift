//
//  CheckoutSummarySuccessModel.swift
//  HEARZAP
//
//  Created by Purushoth on 31/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CheckoutSummarySuccessModel
struct CheckoutSummarySuccessModel: Codable {
    let statusCode: Int
    let message: String
    let data: DataClass
    let errors: Errors
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    //    let redirect: JSONNull?
}
