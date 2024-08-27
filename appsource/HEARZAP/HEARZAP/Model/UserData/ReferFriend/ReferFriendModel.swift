//
//  ReferFriendModel.swift
//  HEARZAP
//
//  Created by Purushoth on 17/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ReferFriendModel
struct ReferFriendModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ReferFriendModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ReferFriendModelDataClass: Codable {
    var referenceLink: String?
    var service: Service?
    var serviceSteps: [ServiceStep]?
    
    enum CodingKeys: String, CodingKey {
        case referenceLink = "reference_link"
        case service
        case serviceSteps = "service_steps"
    }
}

// MARK: - Service
// struct Service: Codable {
//    var id: Int?
//    var serviceType, serviceName, serviceDesc, servicePosterPhoto: String?
//    var serviceMarketingVideoLink: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case serviceType = "service_type"
//        case serviceName = "service_name"
//        case serviceDesc = "service_desc"
//        case servicePosterPhoto = "service_poster_photo"
//        case serviceMarketingVideoLink = "service_marketing_video_link"
//    }
// }
//
// MARK: - ServiceStep
// struct ServiceStep: Codable {
//    var id: Int?
//    var serviceStepName, serviceDesc: String?
//    var serviceStepOrder: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case serviceStepName = "service_step_name"
//        case serviceDesc = "service_desc"
//        case serviceStepOrder = "service_step_order"
//    }
// }
