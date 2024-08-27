//
//  ReturnOrderListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 31/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - ReturnOrderListModel
struct ReturnOrderListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: ReturnOrderListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct ReturnOrderListModelDataClass: Codable {
    var orderList: [OrderList]?
    
    enum CodingKeys: String, CodingKey {
        case orderList = "order_list"
    }
}
