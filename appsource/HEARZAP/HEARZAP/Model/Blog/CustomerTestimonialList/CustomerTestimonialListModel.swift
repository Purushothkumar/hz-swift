//
//  CustomerTestimonialListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 03/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CustomerTestimonialListModel
struct CustomerTestimonialListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CustomerTestimonialListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CustomerTestimonialListModelDataClass: Codable {
    var testimonial: [Testimonial]?
}

// MARK: - Testimonial
struct Testimonial: Codable {
    var id: Int?
    var uid, reviewRating, review, reviewByName: String?
    var reviewBySubline: String?
    var showMore: Bool?
    var reviewBySublineContent: String?
    var videoLink: String?
    var createdOn: String?
    var image: String?
    var canShowToCustomer: Bool?
    enum CodingKeys: String, CodingKey {
        case id, uid
        case reviewRating = "review_rating"
        case review
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
