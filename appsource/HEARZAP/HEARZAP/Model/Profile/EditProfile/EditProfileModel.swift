//
//  EditProfileModel.swift
//  HEARZAP
//
//  Created by Purushoth on 22/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - EditProfileModel
struct EditProfileModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: EditProfileModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct EditProfileModelDataClass: Codable {
    var profileData: ProfileData?
    
    enum CodingKeys: String, CodingKey {
        case profileData = "profile_data"
    }
}

// MARK: - ProfileData
// struct ProfileData: Codable {
//    var id: Int?
//    var uid, name, mobile, email: String?
//    var gender, dob, photo, accountUser: String?
//    var userStatus, createdOn: String?
//    var patientList: [PatientList]?
//    var accountDetials: AccountDetials?
//
//    enum CodingKeys: String, CodingKey {
//        case id, uid, name, mobile, email, gender, dob, photo
//        case accountUser = "account_user"
//        case userStatus = "user_status"
//        case createdOn = "created_on"
//        case patientList = "patient_list"
//        case accountDetials = "account_detials"
//    }
// }
//
// MARK: - AccountDetials
// struct AccountDetials: Codable {
//    var accountID, accountName, accountType, managedBy: String?
//    var createdOn, status: String?
//
//    enum CodingKeys: String, CodingKey {
//        case accountID = "account_id"
//        case accountName = "account_name"
//        case accountType = "account_type"
//        case managedBy = "managed_by"
//        case createdOn = "created_on"
//        case status
//    }
// }
//
// MARK: - PatientList
// struct PatientList: Codable {
//    var id: Int?
//    var uid, customerUid, name: String?
//    var age: String?
//    var dob, gender, relationshipType, relationship: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, uid
//        case customerUid = "customer_uid"
//        case name, age, dob, gender
//        case relationshipType = "relationship_type"
//        case relationship
//    }
// }
