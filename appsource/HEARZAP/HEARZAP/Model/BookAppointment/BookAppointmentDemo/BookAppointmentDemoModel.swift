//
//  BookAppointmentDemoModel.swift
//  HEARZAP
//
//  Created by Purushoth on 22/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct BookAppointmentDemoModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookAppointmentDemoModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BookAppointmentDemoModelDataClass: Codable {
    var bookingService: BookingService?
    var bookingSteps: [BookingStep]?
    
    enum CodingKeys: String, CodingKey {
        case bookingService = "booking_service"
        case bookingSteps = "booking_steps"
    }
}

// MARK: - BookingService
struct BookingService: Codable {
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

// MARK: - BookingStep
struct BookingStep: Codable {
    var id: Int?
    //    var serviceName: String?
    var serviceStepName, serviceDesc: String?
    var serviceStepOrder: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        //        case serviceName = "service_name"
        case serviceStepName = "service_step_name"
        case serviceDesc = "service_desc"
        case serviceStepOrder = "service_step_order"
    }
}
