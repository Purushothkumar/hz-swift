//
//  StoreFinderCustomerTestimonial.swift
//  HEARZAP
//
//  Created by Purushoth on 20/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - StoreFinderCustomerTestimonial
struct StoreFinderCustomerTestimonial: Codable {
    var statusCode: Int?
    var message: String?
    var data: StoreFinderCustomerTestimonialDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct StoreFinderCustomerTestimonialDataClass: Codable {
    var paginatedData: PaginatedData?
    var results: [StoreFinderCustomerTestimonialResult]?
    
    enum CodingKeys: String, CodingKey {
        case paginatedData = "paginated_data"
        case results
    }
}
// MARK: - Result
struct StoreFinderCustomerTestimonialResult: Codable {
    var uid, customerUid: String?
    var review: String?
    var reviewRating, reviewByName, reviewBySubline: String?
    
    enum CodingKeys: String, CodingKey {
        case uid
        case customerUid = "customer_uid"
        case review
        case reviewRating = "review_rating"
        case reviewByName = "review_by_name"
        case reviewBySubline = "review_by_subline"    }
}
