//
//  FindRightDeviceIntroductionModel.swift
//  HEARZAP
//
//  Created by Purushoth on 08/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - FindRightDeviceIntroductionModel
struct FindRightDeviceIntroductionModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: FindRightDeviceIntroductionModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct FindRightDeviceIntroductionModelDataClass: Codable {
    var steps: [Step]?
    var previousResults: [PreviousResult]?
    var id: Int?
    var servicePosterImage: String?
    var serviceName, serviceDescription: String?
    var servicePosterVideoLink: String?
    
    enum CodingKeys: String, CodingKey {
        case steps
        case previousResults = "previous_results"
        case id
        case servicePosterImage = "service_poster_image"
        case serviceName = "service_name"
        case serviceDescription = "service_description"
        case servicePosterVideoLink = "service_poster_video_link"
    }
}

// MARK: - PreviousResult
struct PreviousResult: Codable {
    var uid, createdOn, updatedOn: String?
    var input: Input?
    
    enum CodingKeys: String, CodingKey {
        case uid
        case createdOn = "created_on"
        case updatedOn = "updated_on"
        case input
    }
}
// MARK: - Input
struct Input: Codable {
    var lifestyle: String?
    var lifestyleID: Int?
    var model: [String]?
    var modelIDList: [Int]?
    var technology: String?
    var technologyID: Int?
    var earInfo: String?
    var earInfoID: Int?
    
    enum CodingKeys: String, CodingKey {
        case lifestyle
        case lifestyleID = "lifestyle_id"
        case model
        case modelIDList = "model_id_list"
        case technology
        case technologyID = "technology_id"
        case earInfo = "ear_info"
        case earInfoID = "ear_info_id"
    }
}

// MARK: - Step
struct Step: Codable {
    var serviceStepName, serviceStepDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case serviceStepName = "service_step_name"
        case serviceStepDescription = "service_step_description"
    }
}
