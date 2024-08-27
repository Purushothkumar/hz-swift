//
//  UserListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 18/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - UserListModel
struct UserListModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: UserListModelDataClass?
    let errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct UserListModelDataClass: Codable {
    let patientList: [PatientList]?
    
    enum CodingKeys: String, CodingKey {
        case patientList = "patient_list"
    }
}

