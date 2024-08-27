//
//  ProfileInformationModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct ProfileInformationModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ProfileInformationModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ProfileInformationModelDataClass: Codable {
    var profileData: ProfileData?
    
    enum CodingKeys: String, CodingKey {
        case profileData = "profile_data"
    }
}

// MARK: - ProfileData
struct ProfileData: Codable {
    var id: Int?
    var uid, name, mobile, email: String?
    var gender, dob, photo, accountUser: String?
    var userStatus, createdOn: String?
    var patientList: [PatientList]?
    var accountDetials: AccountDetials?
    
    enum CodingKeys: String, CodingKey {
        case id, uid, name, mobile, email, gender, dob, photo
        case accountUser = "account_user"
        case userStatus = "user_status"
        case createdOn = "created_on"
        case patientList = "patient_list"
        case accountDetials = "account_detials"
    }
}

// MARK: - AccountDetials
struct AccountDetials: Codable {
    var accountID, accountName, accountType, managedBy: String?
    var createdOn, status: String?
    
    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case accountName = "account_name"
        case accountType = "account_type"
        case managedBy = "managed_by"
        case createdOn = "created_on"
        case status
    }
}

// MARK: - PatientList
// struct PatientList: Codable {
//    var id: Int?
//    var uid, customerUid, name: String?
//    var age, dob, gender: JSONNull?
//    var relationship: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, uid
//        case customerUid = "customer_uid"
//        case name, age, dob, gender, relationship
//    }
// }
