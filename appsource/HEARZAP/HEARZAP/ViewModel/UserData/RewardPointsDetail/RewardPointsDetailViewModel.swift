//
//  RewardPointsDetailViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 15/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct RewardPointsDetailViewModel {
    func getRewardsToCouponList(canShowLoader: Bool, viewCon: RewardPointsDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// image
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// coupon
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// steps
        
        view0.isHidden = false
        view1.isHidden = true
        view2.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(RewardPointsDetailModel.self, from: result as Data)
                if json.data != nil {
                    let couponOfferview0 = viewCon.couponOfferStackView.arrangedSubviews[0]// empty
                    let couponOfferview1 = viewCon.couponOfferStackView.arrangedSubviews[1]// title
                    let couponOfferview2 = viewCon.couponOfferStackView.arrangedSubviews[2]// claim
                    let couponOfferview3 = viewCon.couponOfferStackView.arrangedSubviews[3]// validity
                    let couponOfferview4 = viewCon.couponOfferStackView.arrangedSubviews[4]// getUsing
                    let couponOfferview5 = viewCon.couponOfferStackView.arrangedSubviews[5]// empty
                    couponOfferview0.isHidden = true
                    couponOfferview1.isHidden = true
                    couponOfferview2.isHidden = true
                    couponOfferview3.isHidden = true
                    couponOfferview4.isHidden = true
                    couponOfferview5.isHidden = true
                    
                    viewCon.redeemCoinsButtonHeight.constant = 0
                    viewCon.redeemCoinsView.isHidden = true
                    viewCon.couponOfferPointLabel.text = ""
                    
                    var imgurl = ""
                    if json.data!.reward != nil {
                        if !(json.data!.reward!.rewardImage.isNilOrEmpty) {
                            imgurl = json.data!.reward!.rewardImage!
                        }
                    }
                    view0.isHidden = false
                    viewCon.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
                    
                    if json.data!.reward != nil {
                        couponOfferview0.isHidden = false
                        couponOfferview5.isHidden = false
                        
                        if !(json.data!.reward!.rewardRedeemPoints.isNilOrEmpty) {
                            viewCon.couponOfferPointLabel.text = String(format: "%@", json.data!.reward!.rewardRedeemPoints!)
                            couponOfferview4.isHidden = false
                            viewCon.redeemCoinsButtonHeight.constant = CGFloat(80)
                            viewCon.redeemCoinsView.isHidden = false
                            viewCon.redeemCoinsButton.setTitle(String(format: AppLocalizationString.redeemforHZcoins.uppercased(), json.data!.reward!.rewardRedeemPoints!), for: .normal)
                        }
                        if !(json.data!.reward!.rewardName.isNilOrEmpty) {
                            viewCon.couponOfferTitleLabel.text = String(format: "%@", json.data!.reward!.rewardName!.capitalized)
                            couponOfferview1.isHidden = false
                        }
                        
                        viewCon.getUsingLabel.text = AppLocalizationString.getUsing
                        viewCon.getUsingStackView.clipsToBounds = true
                        viewCon.getUsingStackView.layer.cornerRadius = CGFloat(18)
                        viewCon.getUsingStackView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                        viewCon.getUsingStackView.layer.borderWidth = 1.0
                        
                    }
                    
                    if json.data!.howToSteps != nil {
                        view2.isHidden = false
                        viewCon.stepsArray = json.data!.howToSteps!
                    }
                    viewCon.reloadTableview()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postRewardsToCouponList(canShowLoader: Bool, viewCon: RewardPointsDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// image
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// coupon
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// steps
        
        view0.isHidden = false
        view1.isHidden = true
        view2.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(RewardPointsCouponModel.self, from: result as Data)
                if json.data != nil {
                    let couponOfferview0 = viewCon.couponOfferStackView.arrangedSubviews[0]// empty
                    let couponOfferview1 = viewCon.couponOfferStackView.arrangedSubviews[1]// title
                    let couponOfferview2 = viewCon.couponOfferStackView.arrangedSubviews[2]// claim
                    let couponOfferview3 = viewCon.couponOfferStackView.arrangedSubviews[3]// validity
                    let couponOfferview4 = viewCon.couponOfferStackView.arrangedSubviews[4]// getUsing
                    let couponOfferview5 = viewCon.couponOfferStackView.arrangedSubviews[5]// empty
                    couponOfferview0.isHidden = true
                    couponOfferview1.isHidden = true
                    couponOfferview2.isHidden = true
                    couponOfferview3.isHidden = true
                    couponOfferview4.isHidden = true
                    couponOfferview5.isHidden = true
                    
                    viewCon.redeemCoinsButtonHeight.constant = 0
                    viewCon.redeemCoinsView.isHidden = true
                    viewCon.couponOfferPointLabel.text = ""
                    
                    var imgurl = ""
                    if json.data!.reward != nil {
                        if !(json.data!.reward!.rewardImage.isNilOrEmpty) {
                            imgurl = json.data!.reward!.rewardImage!
                        }
                    }
                    viewCon.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
                    viewCon.redeemCoinsButtonHeight.constant = 0
                    viewCon.redeemCoinsView.isHidden = true
                    
                    view0.isHidden = false
                    if json.data!.reward != nil {
                        couponOfferview0.isHidden = false
                        couponOfferview5.isHidden = false
                        couponOfferview2.isHidden = false
                        viewCon.couponOfferClaimedLabel.text = AppLocalizationString.claimed
                        if !(json.data!.reward!.rewardName.isNilOrEmpty) {
                            viewCon.couponOfferTitleLabel.text = String(format: "%@", json.data!.reward!.rewardName!.capitalized)
                            couponOfferview1.isHidden = false
                        }
                    }
                    if !(json.data!.couponUsageEndDate.isNilOrEmpty) {
                        viewCon.couponOfferValidLabel.text = String(format: "%@ %@", AppLocalizationString.validtill, json.data!.couponUsageEndDate!)
                        couponOfferview3.isHidden = false
                    }
                    view1.isHidden = false
                    var code = ""
                    var name = ""
                    var discountValue = ""
                    var discountType = ""
                    var validity = ""
                    viewCon.offerLabel.text = discountValue
                    if !(json.data!.couponCode.isNilOrEmpty) {
                        code = String(format: "%@ \"%@\"", AppLocalizationString.use.uppercased(), json.data!.couponCode!)
                    }
                    if !(json.data!.couponName.isNilOrEmpty) {
                        name = json.data!.couponName!
                    }
                    if !(json.data!.couponUsageEndDate.isNilOrEmpty) {
                        validity = String(format: "%@ %@", AppLocalizationString.validtill, json.data!.couponUsageEndDate!)
                    }
                    if !(json.data!.couponDiscountType.isNilOrEmpty) {
                        discountType = json.data!.couponDiscountType!
                    }
                    /*
                     if json.data!.couponDiscountValue != nil {
                     if discountType.lowercased() == CouponType.flat.rawValue.lowercased() {
                     discountValue = String(format: "%d", json.data!.couponDiscountValue!)
                     let combination = NSMutableAttributedString()
                     
                     let priceFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.regular.size(22)]
                     let amountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.semibold.size(22)]
                     let descFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.regular.size(16)]
                     
                     let price = NSMutableAttributedString(string: String(format: "%@", AppConstantValue.rupeesymbol), attributes: priceFontAttributes as [NSAttributedString.Key: Any])
                     let cost = NSMutableAttributedString(string: String(format: "%@", discountValue), attributes: amountFontAttributes as [NSAttributedString.Key: Any])
                     let discount = NSMutableAttributedString(string: String(format: "\n%@", AppLocalizationString.discount.capitalized), attributes: descFontAttributes as [NSAttributedString.Key: Any])
                     
                     combination.append(price)
                     combination.append(cost)
                     combination.append(discount)
                     
                     viewCon.offerLabel.attributedText = combination
                     
                     } else if discountType.lowercased() == CouponType.percentage.rawValue.lowercased() {
                     discountValue = String(format: "%d%%", json.data!.couponDiscountValue!)
                     let combination = NSMutableAttributedString()
                     
                     let amountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.semibold.size(22)]
                     let descFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.regular.size(16)]
                     
                     let cost = NSMutableAttributedString(string: String(format: "%@", discountValue), attributes: amountFontAttributes as [NSAttributedString.Key: Any])
                     let discount = NSMutableAttributedString(string: String(format: "\n%@", AppLocalizationString.off.capitalized), attributes: descFontAttributes as [NSAttributedString.Key: Any])
                     
                     combination.append(cost)
                     combination.append(discount)
                     
                     viewCon.offerLabel.attributedText = combination
                     } else {
                     discountValue = String(format: "%d", json.data!.couponDiscountValue!)
                     let combination = NSMutableAttributedString()
                     let amountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.semibold.size(22)]
                     let cost = NSMutableAttributedString(string: String(format: "%@", discountValue), attributes: amountFontAttributes as [NSAttributedString.Key: Any])
                     combination.append(cost)
                     viewCon.offerLabel.attributedText = combination
                     }
                     }*/
                    viewCon.couponHeaderLabel.text = name
                    viewCon.couponValidityLabel.text = validity
                    viewCon.couponCodeLabel.text = code
                    
                    if json.data!.howToSteps != nil {
                        view2.isHidden = false
                        viewCon.stepsArray = json.data!.howToSteps!
                    }
                    viewCon.reloadTableview()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
