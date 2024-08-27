//
//  BookAppointmentModel.swift
//  HEARZAP
//
//  Created by Purushoth on 23/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - BookAppointmentModel
struct BookAppointmentModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: BookAppointmentModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct BookAppointmentModelDataClass: Codable {
    var serviceList: [ServiceList]?
    var patientData: BookAppointmentModelPatientData?
    
    enum CodingKeys: String, CodingKey {
        case serviceList = "service_list"
        case patientData = "patient_data"
    }
}

// MARK: - PatientData
struct BookAppointmentModelPatientData: Codable {
    //    var customer: Customer?
    var patient: Patient?
}

// MARK: - Customer
struct Customer: Codable {
    var uid: String?
    //    var accountUser: JSONNull?
    var name: String?
    var dob, age, gender: String?
    var mobile, email: String?
    //    var language1, language2, language3: JSONNull?
    var mobileAppUsage: Bool?
    var source, subSource: String?
    
    enum CodingKeys: String, CodingKey {
        case uid
        //        case accountUser = "account_user"
        case name, dob, age, gender, mobile, email
        //        case language1 = "language_1"
        //        case language2 = "language_2"
        //        case language3 = "language_3"
        case mobileAppUsage = "mobile_app_usage"
        case source
        case subSource = "sub_source"
    }
}

// MARK: - Patient
struct Patient: Codable {
    var id: Int?
    var uid, customerUid, name: String?
    var age: String?
    var dob, gender, relationshipType, relationship: String?
    
    enum CodingKeys: String, CodingKey {
        case id, uid
        case customerUid = "customer_uid"
        case name, age, dob, gender
        case relationshipType = "relationship_type"
        case relationship
    }
}

// MARK: - ServiceList
struct ServiceList: Codable {
    var id: Int?
    var serviceCode: String?
    var servicePosterPhoto: String?
    var serviceName, serviceDescription: String?
    var isDeviceNeeded: Bool?
    var serviceMarketingVideoLink: String?
    var serviceCharge: Int?
    var serviceStepsList: [ServiceStepsList]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case serviceCode = "service_code"
        case servicePosterPhoto = "service_poster_photo"
        case serviceName = "service_name"
        case serviceDescription = "service_description"
        case isDeviceNeeded = "is_device_needed"
        case serviceMarketingVideoLink = "service_marketing_video_link"
        case serviceCharge = "service_charge"
        case serviceStepsList = "service_steps_list"
    }
}

// MARK: - ServiceStepsList
struct ServiceStepsList: Codable {
    var stepName: String?
    var serviceStepDescription: String?
    var serviceStepOrder: Int?
    
    enum CodingKeys: String, CodingKey {
        case stepName = "step_name"
        case serviceStepDescription = "service_step_description"
        case serviceStepOrder = "service_step_order"
    }
}
