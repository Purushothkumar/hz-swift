//
//  OnlineConsultationConcernModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - OnlineConsultationConcernModel
struct OnlineConsultationConcernModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: OnlineConsultationConcernModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct OnlineConsultationConcernModelDataClass: Codable {
    var customerConcernQuestions: [CustomerConcernQuestion]?
    
    enum CodingKeys: String, CodingKey {
        case customerConcernQuestions = "customer_concern_questions"
    }
}

// MARK: - CustomerConcernQuestion
struct CustomerConcernQuestion: Codable {
    var id: Int?
    var question: String?
    var possibleAnswers: [String]?
    var isSingleSelect: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, question
        case possibleAnswers = "possible_answers"
        case isSingleSelect = "is_single_select"
    }
}
