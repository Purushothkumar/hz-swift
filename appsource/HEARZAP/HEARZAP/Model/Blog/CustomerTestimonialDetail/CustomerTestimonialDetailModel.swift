//
//  CustomerTestimonialDetailModel.swift
//  HEARZAP
//
//  Created by Purushoth on 03/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CustomerTestimonialDetailModel
struct CustomerTestimonialDetailModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CustomerTestimonialDetailModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CustomerTestimonialDetailModelDataClass: Codable {
    var customerTestimonial: Testimonial?
    var relatedTestimonial: [Testimonial]?
    
    enum CodingKeys: String, CodingKey {
        case customerTestimonial = "customer_testimonial"
        case relatedTestimonial = "related_testimonial"
    }
}

// MARK: - Testimonial
// struct Testimonial: Codable {
//    var id: Int?
//    var uid, reviewRating, reviewByName, reviewBySubline: String?
//    var videoLink: String?
//    var createdOn: String?
//    var image: String?
//    var reviewShowInWebsite, reviewShowInMobile: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case id, uid
//        case reviewRating = "review_rating"
//        case reviewByName = "review_by_name"
//        case reviewBySubline = "review_by_subline"
//        case videoLink = "video_link"
//        case createdOn = "created_on"
//        case image
//        case reviewShowInWebsite = "review_show_in_website"
//        case reviewShowInMobile = "review_show_in_mobile"
//    }
// }
