//
//  OnlineConsultationAudiologistModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - OnlineConsultationAudiologistModel
struct OnlineConsultationAudiologistModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: OnlineConsultationAudiologistModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct OnlineConsultationAudiologistModelDataClass: Codable {
    var audiologistProfileList: [AudiologistProfileList]?
    
    enum CodingKeys: String, CodingKey {
        case audiologistProfileList = "audiologist_profile_list"
    }
}

// MARK: - AudiologistProfileList
struct AudiologistProfileList: Codable {
    var audiologistProfile: AudiologistProfile?
    var langPreference: [String]?
    var averageRating: Int?
    var isVaccinated: Bool?
    
    enum CodingKeys: String, CodingKey {
        case audiologistProfile = "audiologist_profile"
        case langPreference = "lang_preference"
        case averageRating = "average_rating"
        case isVaccinated = "is_vaccinated"
    }
}

// MARK: - AudiologistProfile
struct AudiologistProfile: Codable {
    var id: Int?
    var storeStaffUid, storeStaff, specialization, specializationDesc: String?
    var specializationDegree: String?
    var industryExperienceInYrs: Int?
    var rciNumber: String?
    var signature: String?
    var staffPhoto: String?
    var onlineConsultationCharge: Int?
    var isOnlineConsultationEnabled: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case storeStaffUid = "store_staff_uid"
        case storeStaff = "store_staff"
        case specialization
        case specializationDesc = "specialization_desc"
        case specializationDegree = "specialization_degree"
        case industryExperienceInYrs = "industry_experience_in_yrs"
        case rciNumber = "RCI_Number"
        case signature
        case staffPhoto = "staff_photo"
        case onlineConsultationCharge = "online_consultation_charge"
        case isOnlineConsultationEnabled = "is_online_consultation_enabled"
    }
}
