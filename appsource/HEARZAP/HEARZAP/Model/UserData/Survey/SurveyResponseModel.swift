//
//  SurveyResponseModel.swift
//  HEARZAP
//
//  Created by Purushoth on 06/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - SurveyResponseModel
struct SurveyResponseModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: SurveyResponseModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct SurveyResponseModelDataClass: Codable {
    var responseText: String?
    
    enum CodingKeys: String, CodingKey {
        case responseText = "response_text"
    }
}
