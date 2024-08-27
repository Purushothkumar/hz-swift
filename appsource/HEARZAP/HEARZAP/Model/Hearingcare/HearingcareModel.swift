//
//  HearingcareModel.swift
//  HEARZAP
//
//  Created by Purushoth on 22/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - HearingcareModel
struct HearingcareModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: HearingcareModelData?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - HearingcareModelData
struct HearingcareModelData: Codable {
    var services: [HearingcareModelService]?
    var customerTestimonial: [CustomerTestimonial]?
    
    enum CodingKeys: String, CodingKey {
        case services
        case customerTestimonial = "customer_testimonial"
    }
}

// MARK: - CustomerTestimonial
struct CustomerTestimonial: Codable {
    var id: Int?
    var uid, reviewRating, reviewByName, reviewBySubline: String?
    var showMore: Bool?
    var reviewBySublineContent: String?
    var videoLink: String?
    var createdOn: String?
    var image: String?
    var canShowToCustomer: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, uid
        case reviewRating = "review_rating"
        case reviewByName = "review_by_name"
        case reviewBySubline = "review_by_subline"
        case showMore = "show_more"
        case reviewBySublineContent = "review_by_subline_content"
        case videoLink = "video_link"
        case createdOn = "created_on"
        case image
        case canShowToCustomer = "can_show_to_customer"
    }
}

// MARK: - Service
struct HearingcareModelService: Codable {
    var data: ServiceData?
    var buttonData: String?
    
    enum CodingKeys: String, CodingKey {
        case data
        case buttonData = "button_data"
    }
}

// MARK: - ServiceData
struct ServiceData: Codable {
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
