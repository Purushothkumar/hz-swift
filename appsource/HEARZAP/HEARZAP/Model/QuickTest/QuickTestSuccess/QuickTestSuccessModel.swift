//
//  QuickTestSuccessModel.swift
//  HEARZAP
//
//  Created by Purushoth on 20/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
// MARK: - QuickTestSuccessModel
struct QuickTestSuccessModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: QuickTestSuccessModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct QuickTestSuccessModelDataClass: Codable {
    var patientData: PatientList?
    var quickcheckupSession: QuickcheckupSession?
    
    enum CodingKeys: String, CodingKey {
        case patientData = "patient_data"
        case quickcheckupSession = "quickcheckup_session"
    }
}

// MARK: - QuickcheckupSession
struct QuickcheckupSession: Codable {
    var id: Int?
    var uid, customerUid, customerPatientProfileUid, startTime: String?
    var endTime: String?
    
    enum CodingKeys: String, CodingKey {
        case id, uid
        case customerUid = "customer_uid"
        case customerPatientProfileUid = "customer_patient_profile_uid"
        case startTime = "start_time"
        case endTime = "end_time"
    }
}
