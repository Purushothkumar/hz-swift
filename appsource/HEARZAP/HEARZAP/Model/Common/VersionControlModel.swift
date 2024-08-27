//
//  VersionControlModel.swift
//  HEARZAP
//
//  Created by Purushoth on 12/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - VersionControlModel
struct VersionControlModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: VersionControlModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct VersionControlModelDataClass: Codable {
    var canShowPrimaryMsg, canShowSecondaryMsg, canShowBtn, isHavingAction: Bool?
    var btnText: String?
    var androidBtnLink, iosBtnLink: String?
    var primaryMsgText, secondaryMsgText: String?
    
    enum CodingKeys: String, CodingKey {
        case canShowPrimaryMsg = "can_show_primary_msg"
        case canShowSecondaryMsg = "can_show_secondary_msg"
        case canShowBtn = "can_show_btn"
        case isHavingAction = "is_having_action"
        case btnText = "btn_text"
        case androidBtnLink = "android_btn_link"
        case iosBtnLink = "ios_btn_link"
        case primaryMsgText = "primary_msg_text"
        case secondaryMsgText = "secondary_msg_text"
    }
}
