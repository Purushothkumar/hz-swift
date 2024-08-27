//
//  SurveyModel.swift
//  HEARZAP
//
//  Created by Purushoth on 17/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - SurveyModel
struct SurveyModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: SurveyModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct SurveyModelDataClass: Codable {
    var id: Int?
    var questions: [SurveyModelQuestion]?
}

// MARK: - Question
struct SurveyModelQuestion: Codable {
    var id: Int?
    var image, question: String?
    var answers: [SurveyModelAnswer]?
}

// MARK: - Answer
struct SurveyModelAnswer: Codable {
    var id: Int?
    var answer: String?
}
