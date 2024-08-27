//
//  RewardPointsCouponModel.swift
//  HEARZAP
//
//  Created by Purushoth on 07/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - RewardPointsCouponModel
struct RewardPointsCouponModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: RewardPointsCouponModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct RewardPointsCouponModelDataClass: Codable {
    var reward: Reward?
    var howToSteps: [HowToStep]?
    var rewardPoints: Int?
    var couponCode, couponName, couponUsageEndDate: String?
    //    var couponDiscountValue: Double?
    var couponDiscountType, couponDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case reward
        case howToSteps = "how_to_steps"
        case rewardPoints = "reward_points"
        case couponCode = "coupon_code"
        case couponName = "coupon_name"
        case couponUsageEndDate = "coupon_usage_end_date"
        //        case couponDiscountValue = "coupon_discount_value"
        case couponDiscountType = "coupon_discount_type"
        case couponDescription = "coupon_description"
    }
}

// MARK: - HowToStep
// struct HowToStep: Codable {
//    var id: Int?
//    var serviceStepName, serviceDesc: String?
//    var serviceStepOrder: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case serviceStepName = "service_step_name"
//        case serviceDesc = "service_desc"
//        case serviceStepOrder = "service_step_order"
//    }
// }
//
// MARK: - Reward
// struct Reward: Codable {
//    var rewardUid, rewardName, rewardCode, rewardMode: String?
//    var rewardImage: String?
//    var rewardTitle, rewardRedeemPoints: String?
//    var rewardUsageSteps: JSONNull?
//    var rewardType, rewardDiscountValue: Int?
//    var rewardDiscountType: String?
//
//    enum CodingKeys: String, CodingKey {
//        case rewardUid = "reward_uid"
//        case rewardName = "reward_name"
//        case rewardCode = "reward_code"
//        case rewardMode = "reward_mode"
//        case rewardImage = "reward_image"
//        case rewardTitle = "reward_title"
//        case rewardRedeemPoints = "reward_redeem_points"
//        case rewardUsageSteps = "reward_usage_steps"
//        case rewardType = "reward_type"
//        case rewardDiscountValue = "reward_discount_value"
//        case rewardDiscountType = "reward_discount_type"
//    }
// }
