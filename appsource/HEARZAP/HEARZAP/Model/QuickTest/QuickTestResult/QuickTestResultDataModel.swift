//
//  QuickTestResultDataModel.swift
//  HEARZAP
//
//  Created by Purushoth on 27/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - QuickTestResultDataModel
struct QuickTestResultDataModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: QuickTestResultDataModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct QuickTestResultDataModelDataClass: Codable {
    var patientData: PatientList?
    var quickcheckupSession: QuickcheckupSession?
    var testResult: TestResult?
    var quickcheckupSessionData: [QuickcheckupSessionDatum]?
    var quickcheckupSessionResults: QuickcheckupSessionResults?
    
    enum CodingKeys: String, CodingKey {
        case patientData = "patient_data"
        case quickcheckupSession = "quickcheckup_session"
        case testResult = "test_result"
        case quickcheckupSessionData = "quickcheckup_session_data"
        case quickcheckupSessionResults = "quickcheckup_session_results"
    }
}
// MARK: - QuickcheckupSession
// struct QuickcheckupSession: Codable {
//    var id: Int?
//    var uid, customerUid, customerPatientProfileUid, startTime: String?
//    var endTime: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, uid
//        case customerUid = "customer_uid"
//        case customerPatientProfileUid = "customer_patient_profile_uid"
//        case startTime = "start_time"
//        case endTime = "end_time"
//    }
// }

// MARK: - QuickcheckupSessionDatum
struct QuickcheckupSessionDatum: Codable {
    var id: Int?
    var quickcheckupMasterSessionFieldName: String?
    var value: [String: String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case quickcheckupMasterSessionFieldName = "quickcheckup_master_session_field_name"
        case value
    }
}

// MARK: - QuickcheckupSessionResults
struct QuickcheckupSessionResults: Codable {
    var id: Int?
    var quickcheckupSessionUid, testLeftAverage, testLeftImpression, testLeftRecommendation: String?
    var testLeftDescription, testRightAverage, testRightImpression, testRightRecommendation: String?
    var testRightDescription: String?
    var reportLink: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case quickcheckupSessionUid = "quickcheckup_session_uid"
        case testLeftAverage = "test_left_average"
        case testLeftImpression = "test_left_impression"
        case testLeftRecommendation = "test_left_recommendation"
        case testLeftDescription = "test_left_description"
        case testRightAverage = "test_right_average"
        case testRightImpression = "test_right_impression"
        case testRightRecommendation = "test_right_recommendation"
        case testRightDescription = "test_right_description"
        case reportLink = "report_link"
    }
}

// MARK: - TestResult
struct TestResult: Codable {
    var description, recommendation: String?
}
