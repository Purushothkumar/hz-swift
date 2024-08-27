//
//  OrderListModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - OrderListModel
struct OrderListModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: OrderListModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct OrderListModelDataClass: Codable {
    var orderList: [OrderList]?
    
    enum CodingKeys: String, CodingKey {
        case orderList = "order_list"
    }
}

// MARK: - OrderList
struct OrderList: Codable {
    var orderNumber, orderDate, statusName, statusCode: String?
    var statusTextColor, statusBgColor: String?
    
    enum CodingKeys: String, CodingKey {
        case orderNumber = "order_number"
        case orderDate = "order_date"
        case statusName = "status_name"
        case statusCode = "status_code"
        case statusTextColor = "status_text_color"
        case statusBgColor = "status_bg_color"
    }
}
