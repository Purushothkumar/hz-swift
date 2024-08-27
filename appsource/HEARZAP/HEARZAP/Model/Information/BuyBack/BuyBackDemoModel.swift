//
//  BuyBackDemoModel.swift
//  HEARZAP
//
//  Created by Purushoth on 21/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BuyBackModel
struct BuyBackModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BuyBackModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BuyBackModelDataClass: Codable {
    var buybackData: BuybackData?
    
    enum CodingKeys: String, CodingKey {
        case buybackData = "buyback_data"
    }
}

// MARK: - BuybackData
struct BuybackData: Codable {
    var buybackService: BuybackService?
    var buybackSteps: [BuybackStep]?
    
    enum CodingKeys: String, CodingKey {
        case buybackService = "buyback_service"
        case buybackSteps = "buyback_steps"
    }
}

// MARK: - BuybackService
struct BuybackService: Codable {
    var id: Int?
    var serviceType, serviceName, serviceDesc: String?
    var servicePosterPhoto: String?
    var serviceMarketingVideoLink: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case serviceType = "service_type"
        case serviceName = "service_name"
        case serviceDesc = "service_desc"
        case servicePosterPhoto = "service_poster_photo"
        case serviceMarketingVideoLink = "service_marketing_video_link"
    }
}

// MARK: - BuybackStep
struct BuybackStep: Codable {
    var id: Int?
    var serviceName, serviceStepName, serviceDesc: String?
    var serviceStepOrder: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case serviceName = "service_name"
        case serviceStepName = "service_step_name"
        case serviceDesc = "service_desc"
        case serviceStepOrder = "service_step_order"
    }
}
