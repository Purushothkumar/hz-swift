//
//  QuickCheckSessionModel.swift
//  HEARZAP
//
//  Created by Purushoth on 19/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - QuickCheckSessionModel
struct QuickCheckSessionModel: Codable {
    let statusCode: Int?
    let message: String?
    let data: QuickCheckSessionModelDataClass?
    let errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct QuickCheckSessionModelDataClass: Codable {
    let patientData: PatientList?
    let sessionID: String?
    
    enum CodingKeys: String, CodingKey {
        case patientData = "patient_data"
        case sessionID = "session_id"
    }
}

//// MARK: - PatientData
//struct PatientData: Codable {
//    let id: Int?
//    let uid, customerUid, name: String?
//    let age: String?
//    let gender, relationship: String?
//    var dob: String?
//    var relationshipType: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case id, uid
//        case customerUid = "customer_uid"
//        case name, age, dob, gender, relationship
//        case relationshipType = "relationship_type"
//        
//    }
//}
