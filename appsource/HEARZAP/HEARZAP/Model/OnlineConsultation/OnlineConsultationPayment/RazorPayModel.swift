//
//  RazorPayModel.swift
//  HEARZAP
//
//  Created by Purushoth on 25/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - RazorPayModel
struct RazorPayModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: RazorPayModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct RazorPayModelDataClass: Codable {
    var razorpayResponse: RazorpayResponse?
    
    enum CodingKeys: String, CodingKey {
        case razorpayResponse = "razorpay_response"
    }
}

// MARK: - RazorpayResponse
struct RazorpayResponse: Codable {
    var id, entity: String?
    var amount, amountPaid, amountDue: Int?
    var currency, receipt: String?
    //    var offerID: JSONNull?
    var status: String?
    var attempts: Int?
    //    var notes: [JSONAny]?
    var createdAt: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, entity, amount
        case amountPaid = "amount_paid"
        case amountDue = "amount_due"
        case currency, receipt
        //        case offerID = "offer_id"
        case status, attempts
        //        case notes
        case createdAt = "created_at"
    }
}
