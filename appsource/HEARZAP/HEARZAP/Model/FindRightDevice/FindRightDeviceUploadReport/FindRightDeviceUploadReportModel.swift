//
//  FindRightDeviceUploadReportModel.swift
//  HEARZAP
//
//  Created by Purushoth on 19/07/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - FindRightDeviceUploadReportModel
struct FindRightDeviceUploadReportModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: FindRightDeviceUploadReportModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct FindRightDeviceUploadReportModelDataClass: Codable {
    var reportId: String?
    
    enum CodingKeys: String, CodingKey {
        case reportId = "report_id"
    }
}
