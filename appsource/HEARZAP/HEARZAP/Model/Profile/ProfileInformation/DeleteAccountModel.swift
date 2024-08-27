//
//  DeleteAccountModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - DeleteAccountModel
struct DeleteAccountModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: DeleteAccountModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct DeleteAccountModelDataClass: Codable {
}
