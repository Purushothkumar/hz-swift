//
//  QuickTestUserVerificationModel.swift
//  HEARZAP
//
//  Created by Purushoth on 17/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - QuickTestUserVerificationModel
struct QuickTestUserVerificationModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: QuickTestUserVerificationModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct QuickTestUserVerificationModelDataClass: Codable {
    var patientData: PatientList?
    var quickcheckupSession: QuickcheckupSession?
    var token: String?

    enum CodingKeys: String, CodingKey {
        case patientData = "patient_data"
        case quickcheckupSession = "quickcheckup_session"
        case token
    }
}

//// MARK: - PatientData
//struct PatientData: Codable {
//    var id: Int?
//    var uid, customerUid, name: String?
//    var age, dob: String?
//    var gender: String?
//    var relationshipType: String?
//    var relationship: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, uid
//        case customerUid = "customer_uid"
//        case name, age, dob, gender
//        case relationshipType = "relationship_type"
//        case relationship
//    }
//}

//// MARK: - QuickcheckupSession
//struct QuickcheckupSession: Codable {
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
//}
//
//// MARK: - Errors
//struct Errors: Codable {
//}
