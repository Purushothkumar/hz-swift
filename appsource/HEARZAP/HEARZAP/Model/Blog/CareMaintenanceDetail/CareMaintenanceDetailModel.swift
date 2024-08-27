//
//  CareMaintenanceDetailModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CareMaintenanceDetailModel
struct CareMaintenanceDetailModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CareMaintenanceDetailModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CareMaintenanceDetailModelDataClass: Codable {
    var careAndMaintenance: CareMaintenanceDetailModelCareAndMaintenance?
    var relatedCareAndMaintenance: [CareMaintenanceDetailModelCareAndMaintenance]?
    
    enum CodingKeys: String, CodingKey {
        case careAndMaintenance = "care_and_maintenance"
        case relatedCareAndMaintenance = "related_care_and_maintenance"
    }
}

// MARK: - CareAndMaintenance
struct CareMaintenanceDetailModelCareAndMaintenance: Codable {
    var id: Int?
    var image: String?
    var categoryName, createdOnDate, title, slug: String?
    var imageAlt: String?
    var videoLink: String?
    var content: String?
    enum CodingKeys: String, CodingKey {
        case id, image
        case categoryName = "category_name"
        case createdOnDate = "created_on_date"
        case title, slug
        case imageAlt = "image_alt"
        case videoLink = "video_link"
        case content
    }
}
