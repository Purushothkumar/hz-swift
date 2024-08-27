//
//  CheckOutModel.swift
//  HEARZAP
//
//  Created by Purushoth on 21/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - CheckOutModel
struct CheckOutModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: CheckOutModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct CheckOutModelDataClass: Codable {
    var order: Order?
    var storeAddress: StoreAddress?
    var homeAddress: HomeAddress?
    var orderItem: [OrderItem]?
    var eshopOrderAmountDetail: EshopOrderAmountDetail?
    var eshopOrderDiscountDetail: Errors?
    var orderID: String?
    
    enum CodingKeys: String, CodingKey {
        case order
        case storeAddress = "store_address"
        case homeAddress = "home_address"
        case orderItem = "order_item"
        case eshopOrderAmountDetail = "eshop_order_amount_detail"
        case eshopOrderDiscountDetail = "eshop_order_discount_detail"
        case orderID = "order_id"
    }
}

// MARK: - EshopOrderAmountDetail
struct EshopOrderAmountDetail: Codable {
    var id, subAmountTotal, mrpDiscountTotalAmount, couponDiscountTotalAmount: Int?
    var taxTotalAmount, deliveryChargesAmount, finalTotalAmount, order: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case subAmountTotal = "sub_amount_total"
        case mrpDiscountTotalAmount = "mrp_discount_total_amount"
        case couponDiscountTotalAmount = "coupon_discount_total_amount"
        case taxTotalAmount = "tax_total_amount"
        case deliveryChargesAmount = "delivery_charges_amount"
        case finalTotalAmount = "final_total_amount"
        case order
    }
}

// MARK: - HomeAddress
struct HomeAddress: Codable {
    var id: Int?
    var customerName, mobile, addressType: String?
    var isPrimary: Bool?
    var address1, address2, address3, landmark: String?
    var city, state: String?
    var zipcode: Int?
    var lat, lng: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case customerName = "customer_name"
        case mobile
        case addressType = "address_type"
        case isPrimary = "is_primary"
        case address1 = "address_1"
        case address2 = "address_2"
        case address3 = "address_3"
        case landmark, city, state, zipcode, lat, lng
    }
}

// MARK: - Order
struct Order: Codable {
    var id: Int?
    var orderNumber, orderType, orderCustomerUid: String?
    var orderPatientUid: String?
    var orderCustomerName, orderCustomerMobileNumber, orderCustomerEmail, orderDeliveryStore: String?
    var orderCheckOptIn, isHomeDelivery: Bool?
    var paymentStatus: String?
    var orderItems, orderAmount: Int?
    var addressType: String?
    var addressID: Int?
    var shippingAddressLine1, shippingAddressLine2, shippingAddressLine3, shippingCountry: String?
    var shippingState, shippingCity: String?
    var shippingCityArea: String?
    var shippingZipcode, billingAddressLine1, billingAddressLine2, billingAddressLine3: String?
    var billingCountry, billingState, billingCity: String?
    var billingCityArea: String?
    var billingZipcode, source, subSource: String?
    var orderStatus: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderNumber = "order_number"
        case orderType = "order_type"
        case orderCustomerUid = "order_customer_uid"
        case orderPatientUid = "order_patient_uid"
        case orderCustomerName = "order_customer_name"
        case orderCustomerMobileNumber = "order_customer_mobile_number"
        case orderCustomerEmail = "order_customer_email"
        case orderDeliveryStore = "order_delivery_store"
        case orderCheckOptIn = "order_check_opt_in"
        case isHomeDelivery = "is_home_delivery"
        case paymentStatus = "payment_status"
        case orderItems = "order_items"
        case orderAmount = "order_amount"
        case addressType = "address_type"
        case addressID = "address_id"
        case shippingAddressLine1 = "shipping_address_line_1"
        case shippingAddressLine2 = "shipping_address_line_2"
        case shippingAddressLine3 = "shipping_address_line_3"
        case shippingCountry = "shipping_country"
        case shippingState = "shipping_state"
        case shippingCity = "shipping_city"
        case shippingCityArea = "shipping_city_area"
        case shippingZipcode = "shipping_zipcode"
        case billingAddressLine1 = "billing_address_line_1"
        case billingAddressLine2 = "billing_address_line_2"
        case billingAddressLine3 = "billing_address_line_3"
        case billingCountry = "billing_country"
        case billingState = "billing_state"
        case billingCity = "billing_city"
        case billingCityArea = "billing_city_area"
        case billingZipcode = "billing_zipcode"
        case source
        case subSource = "sub_source"
        case orderStatus = "order_status"
    }
}

// MARK: - OrderItem
// struct OrderItem: Codable {
//    var id: Int?
//    var itemDiscountPriceApplied: Bool?
//    var itemPrice, itemDiscountAmount, itemTaxAmount, itemCount: Int?
//    var itemTotalPrice: Int?
//    var brand: String?
//    var productDiscount: Int?
//    var isHearingAidAvailable: Bool?
//    var mainImage: String?
//    var totalCostPrice: Int?
//    var itemName: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case itemDiscountPriceApplied = "item_discount_price_applied"
//        case itemPrice = "item_price"
//        case itemDiscountAmount = "item_discount_amount"
//        case itemTaxAmount = "item_tax_amount"
//        case itemCount = "item_count"
//        case itemTotalPrice = "item_total_price"
//        case brand
//        case productDiscount = "product_discount"
//        case isHearingAidAvailable = "is_hearing_aid_available"
//        case mainImage = "main_image"
//        case totalCostPrice = "total_cost_price"
//        case itemName = "item_name"
//    }
// }

// MARK: - StoreAddress
struct StoreAddress: Codable {
    var name, addressLine1, addressLine2, storeCountry: String?
    var storeState, storeCity, storeCityArea, zipcode: String?
    var phoneNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case addressLine1 = "address_line_1"
        case addressLine2 = "address_line_2"
        case storeCountry = "store_country"
        case storeState = "store_state"
        case storeCity = "store_city"
        case storeCityArea = "store_city_area"
        case zipcode
        case phoneNumber = "phone_number"
    }
}
