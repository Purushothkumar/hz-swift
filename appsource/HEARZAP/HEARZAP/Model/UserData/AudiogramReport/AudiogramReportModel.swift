//
//  AudiogramReportModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - AudiogramReportModel
struct AudiogramReportModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: AudiogramReportModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct AudiogramReportModelDataClass: Codable {
    var audiogramTestReports: [AudiogramTestReport]?
    
    enum CodingKeys: String, CodingKey {
        case audiogramTestReports = "audiogram_test_reports"
    }
}

// MARK: - AudiogramTestReport
struct AudiogramTestReport: Codable {
    var patientName, reportName: String?
    var reportLink: String?
    var reportDate: String?
    
    enum CodingKeys: String, CodingKey {
        case patientName = "patient_name"
        case reportName = "report_name"
        case reportLink = "report_link"
        case reportDate = "report_date"
    }
}
