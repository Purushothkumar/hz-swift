//
//  DeleteAddressModel.swift
//  HEARZAP
//
//  Created by Purushoth on 07/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - DeleteAddressModel
struct DeleteAddressModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: DeleteAddressModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct DeleteAddressModelDataClass: Codable {
}
