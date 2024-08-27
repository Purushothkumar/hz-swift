//
//  AddUserModel.swift
//  HEARZAP
//
//  Created by Purushoth on 22/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - AddUserModel
struct AddUserModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: AddUserModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct AddUserModelDataClass: Codable {
}

// MARK: - GenderRelationModel
struct GenderRelationModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: GenderRelationModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct GenderRelationModelDataClass: Codable {
    var gender: [GenderRelationModelGender]?
    var relationType: [GenderRelationModelRelationType]?
    
    enum CodingKeys: String, CodingKey {
        case gender
        case relationType = "relation_type"
    }
}

// MARK: - Gender
struct GenderRelationModelGender: Codable {
    var key, value: String?
}
struct GenderRelationModelRelationType: Codable {
    var key, value: String?
}
