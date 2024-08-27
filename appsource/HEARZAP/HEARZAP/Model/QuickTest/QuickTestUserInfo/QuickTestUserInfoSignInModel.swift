//
//  QuickTestUserInfoSignInModel.swift
//  HEARZAP
//
//  Created by Purushoth on 17/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - QuickTestUserInfoSignInModel
struct QuickTestUserInfoSignInModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: QuickTestUserInfoSignInModelDataClass?
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct QuickTestUserInfoSignInModelDataClass: Codable {
    var phoneToken: String?

    enum CodingKeys: String, CodingKey {
        case phoneToken = "phone_token"
    }
}
