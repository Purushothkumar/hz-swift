//
//  DeletePatientModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - DeletePatientModel
struct DeletePatientModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: DeletePatientModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct DeletePatientModelDataClass: Codable {
}
