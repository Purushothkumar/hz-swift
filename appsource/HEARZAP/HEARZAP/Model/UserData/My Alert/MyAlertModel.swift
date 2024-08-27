//
//  MyAlertModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - MyAlertModel
struct MyAlertModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: [MyAlertModelDatum]?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - Datum
struct MyAlertModelDatum: Codable {
    var alertDate, alertTitle, alertDescription, objID: String?
    var objType, redirectURL, actionBtnName: String?
    
    enum CodingKeys: String, CodingKey {
        case alertDate = "alert_date"
        case alertTitle = "alert_title"
        case alertDescription = "alert_description"
        case objID = "obj_id"
        case objType = "obj_type"
        case redirectURL = "redirect_url"
        case actionBtnName = "action_btn_name"
    }
}
