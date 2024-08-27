//
//  RewardPointsModel.swift
//  HEARZAP
//
//  Created by Purushoth on 15/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - RewardPointsModel
struct RewardPointsModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: RewardPointsModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct RewardPointsModelDataClass: Codable {
    var rewards: [Reward]?
    var customerRewardPoints: Int?
    var rewardTransactions: [RewardTransaction]?
    
    enum CodingKeys: String, CodingKey {
        case rewards
        case customerRewardPoints = "customer_reward_points"
        case rewardTransactions = "reward_transactions"
    }
}

// MARK: - RewardTransaction
struct RewardTransaction: Codable {
    var txnDate, txnUsage, txnDetail, txnInfo: String?
    
    enum CodingKeys: String, CodingKey {
        case txnDate = "txn_date"
        case txnUsage = "txn_usage"
        case txnDetail = "txn_detail"
        case txnInfo = "txn_info"
    }
}

// MARK: - Reward
struct Reward: Codable {
    var rewardUid, rewardName, rewardCode, rewardMode: String?
    var rewardImage: String?
    var rewardTitle, rewardRedeemPoints: String?
    //    var rewardUsageSteps: JSONNull?
    var rewardType, rewardDiscountValue: Int?
    var rewardDiscountType: String?
    
    enum CodingKeys: String, CodingKey {
        case rewardUid = "reward_uid"
        case rewardName = "reward_name"
        case rewardCode = "reward_code"
        case rewardMode = "reward_mode"
        case rewardImage = "reward_image"
        case rewardTitle = "reward_title"
        case rewardRedeemPoints = "reward_redeem_points"
        //        case rewardUsageSteps = "reward_usage_steps"
        case rewardType = "reward_type"
        case rewardDiscountValue = "reward_discount_value"
        case rewardDiscountType = "reward_discount_type"
    }
}

