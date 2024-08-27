//
//  OnlineConsultationDemoModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - OnlineConsultationDemoModel
struct OnlineConsultationDemoModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: OnlineConsultationDemoModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct OnlineConsultationDemoModelDataClass: Codable {
    var ocService: OcService?
    var ocSteps: [OcStep]?
    
    enum CodingKeys: String, CodingKey {
        case ocService = "oc_service"
        case ocSteps = "oc_steps"
    }
}

// MARK: - OcService
struct OcService: Codable {
    var id: Int?
    var serviceType, serviceName, serviceDesc, servicePosterPhoto: String?
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

// MARK: - OcStep
struct OcStep: Codable {
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
