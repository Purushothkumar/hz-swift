//
//  PatientList.swift
//  HEARZAP
//
//  Created by Purushoth on 18/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - PatientList
struct PatientList: Codable {
    var id: Int?
    var uid: String?
    var customerUid: String?
    var name: String?
    var age: String?
    var dob: String?
    var gender: String?
    var relationship: String?
    var relationshipType: String?
    
    enum CodingKeys: String, CodingKey {
        case id, uid
        case customerUid = "customer_uid"
        case name, age, dob, gender, relationship
        case relationshipType = "relationship_type"
    }
}

