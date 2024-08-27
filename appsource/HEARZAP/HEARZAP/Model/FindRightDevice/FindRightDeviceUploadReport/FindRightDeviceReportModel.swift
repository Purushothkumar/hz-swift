//
//  FindRightDeviceReportModel.swift
//  HEARZAP
//
//  Created by Purushoth on 19/07/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - FindRightDeviceReportModel
struct FindRightDeviceReportModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: FindRightDeviceReportModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct FindRightDeviceReportModelDataClass: Codable {
    var audiogramTestReports: [FindRightDeviceReportModelAudiogramTestReport]?
    
    enum CodingKeys: String, CodingKey {
        case audiogramTestReports = "audiogram_test_reports"
    }
}

// MARK: - AudiogramTestReport
struct FindRightDeviceReportModelAudiogramTestReport: Codable {
    let sessionUid, sessionKey, patientName: String?
    let reportName, reportLink, reportDate: String?
    
    enum CodingKeys: String, CodingKey {
        case sessionUid = "session_uid"
        case sessionKey = "session_key"
        case patientName = "patient_name"
        case reportName = "report_name"
        case reportLink = "report_link"
        case reportDate = "report_date"
    }
}

