//
//  RedeemCoinsModel.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

// MARK: - RedeemCoinsModel
struct RedeemCoinsModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: RedeemCoinsModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct RedeemCoinsModelDataClass: Codable {
    var redeemCoins: [RedeemCoin]?
    //    var howToSteps: [JSONAny]?
    
    enum CodingKeys: String, CodingKey {
        case redeemCoins = "redeem_coins"
        //        case howToSteps = "how_to_steps"
    }
}
// MARK: - RedeemCoin
struct RedeemCoin: Codable {
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
