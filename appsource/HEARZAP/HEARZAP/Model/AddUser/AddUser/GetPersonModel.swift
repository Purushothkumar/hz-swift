//
//  GetPersonModel.swift
//  HEARZAP
//
//  Created by Purushoth on 15/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - GetPersonModel
struct GetPersonModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: GetPersonModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct GetPersonModelDataClass: Codable {
    var patientData: PatientList?
    
    enum CodingKeys: String, CodingKey {
        case patientData = "patient_data"
    }
}
