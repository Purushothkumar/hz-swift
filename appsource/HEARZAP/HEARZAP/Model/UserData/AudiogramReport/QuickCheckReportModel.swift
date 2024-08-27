//
//  QuickCheckReportModel.swift
//  HEARZAP
//
//  Created by Purushoth on 08/05/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - QuickCheckReportModel
struct QuickCheckReportModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: QuickCheckReportModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct QuickCheckReportModelDataClass: Codable {
    var quickTestReports: [QuickTestReport]?
    
    enum CodingKeys: String, CodingKey {
        case quickTestReports = "quick_test_reports"
    }
}

// MARK: - QuickTestReport
struct QuickTestReport: Codable {
    var patientName, reportName: String?
    var reportLink: String?
    var sessionUid, reportDate: String?
    
    enum CodingKeys: String, CodingKey {
        case patientName = "patient_name"
        case reportName = "report_name"
        case reportLink = "report_link"
        case sessionUid = "session_uid"
        case reportDate = "report_date"
    }
}
