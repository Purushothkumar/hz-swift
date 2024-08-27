//
//  CustomerDetailModel.swift
//  HEARZAP
//
//  Created by Purushoth on 12/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CustomerDetailModel
struct CustomerDetailModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CustomerDetailModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CustomerDetailModelDataClass: Codable {
    var customerName, customerUid: String?
    var customerGender: String?
    //    var customerAge: String?
    var customerMobile, customerEmail, customerCity, customerState: String?
    var customerAddress1, customerAddress2: String?
    var customerZipcode: String?
    var patientList: [PatientList]?
    var profilePicture: String?
    
    enum CodingKeys: String, CodingKey {
        case customerName = "customer_name"
        case customerUid = "customer_uid"
        case customerGender = "customer_gender"
        //        case customerAge = "customer_age"
        case customerMobile = "customer_mobile"
        case customerEmail = "customer_email"
        case customerCity = "customer_city"
        case customerState = "customer_state"
        case customerAddress1 = "customer_address_1"
        case customerAddress2 = "customer_address_2"
        case customerZipcode = "customer_zipcode"
        case patientList = "patient_list"
        case profilePicture = "profile_picture"
    }
}
