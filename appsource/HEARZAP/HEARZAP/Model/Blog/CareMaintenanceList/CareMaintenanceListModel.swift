//
//  CareMaintenanceListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CareMaintenanceListModel
struct CareMaintenanceListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CareMaintenanceListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CareMaintenanceListModelDataClass: Codable {
    var careAndMaintenance: [CareAndMaintenance]?
    
    enum CodingKeys: String, CodingKey {
        case careAndMaintenance = "care_and_maintenance"
    }
}

// MARK: - CareAndMaintenance
struct CareAndMaintenance: Codable {
    var id: Int?
    var image: String?
    var categoryName, createdOnDate, title, slug: String?
    var imageAlt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, image
        case categoryName = "category_name"
        case createdOnDate = "created_on_date"
        case title, slug
        case imageAlt = "image_alt"
    }
}
