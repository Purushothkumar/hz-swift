//
//  FAQModel.swift
//  HEARZAP
//
//  Created by Purushoth on 18/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

// MARK: - FAQModel
// struct FAQModel: Codable {
//    var statusCode: Int?
//    var message: String?
//    var data: FAQModelDataClass?
//    var errors: Errors?
//
//    enum CodingKeys: String, CodingKey {
//        case statusCode = "status_code"
//        case message, data, errors
//    }
// }
//
// MARK: - DataClass
// struct FAQModelDataClass: Codable {
//    var faq: [FAQModelFAQ]?
// }
//
// MARK: - FAQ
// struct FAQModelFAQ: Codable {
//    var question, answer: String?
// }

// MARK: - FAQModel
struct FAQCategoryModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: FAQCategoryModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct FAQCategoryModelDataClass: Codable {
    var faq: [DataFAQ]?
}

// MARK: - DataFAQ
struct DataFAQ: Codable {
    var heading: String?
    var faq: [FAQCategoryModelFAQ]?
}

// MARK: - FAQFAQ
struct FAQCategoryModelFAQ: Codable {
    var question, answer: String?
}
