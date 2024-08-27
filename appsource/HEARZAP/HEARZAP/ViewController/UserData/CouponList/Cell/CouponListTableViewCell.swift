//
//  CouponListTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCouponListTableViewCell {
    func tapButtonPressedCouponListTableViewCell(senderTag: Int)
}
class CouponListTableViewCell: UITableViewCell {

    @IBOutlet var couponCardView: UIView!
    @IBOutlet var offerLabel: Title2FontLabel!
    @IBOutlet var dashView: UIView!

    @IBOutlet var couponHeaderLabel: Caption1FontLabel!
    @IBOutlet var couponCodeLabel: BodyFontLabel!
    @IBOutlet var couponValidityLabel: Caption1FontLabel!

    @IBOutlet var tapButton: CalloutOutlineButton!
    var delegate: ProtocolCouponListTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(couponList: CouponList, indexpath: Int) {
        var code = ""
        var name = ""
        var discountValue = ""
        var discountType = ""
        var validity = ""
        var category = ""
        self.offerLabel.text = discountValue
        self.tapButton.tag = indexpath
        self.tapButton.isHidden = true

        if !(couponList.couponCode.isNilOrEmpty) {
            code = String(format: "%@ \"%@\"", AppLocalizationString.use.uppercased(), couponList.couponCode!)
        }
        var couponData = CouponData()
        if couponList.couponData != nil {
            couponData = couponList.couponData!
            if !(couponData.couponName.isNilOrEmpty) {
                name = couponData.couponName!
            }
            if !(couponData.couponUsageEndDate.isNilOrEmpty) {
                validity = String(format: "%@ %@", AppLocalizationString.validtill, couponData.couponUsageEndDate!)
            }
            if !(couponData.couponCategory.isNilOrEmpty) {
                category = couponData.couponCategory!
            }
            if !(couponData.couponDiscountType.isNilOrEmpty) {
                discountType = couponData.couponDiscountType!
            }
           /* if couponData.couponDiscountValue != nil {
                if discountType.lowercased() == CouponType.flat.rawValue.lowercased() {
                    discountValue = String(format: "%d", couponData.couponDiscountValue!)

                    let combination = NSMutableAttributedString()

                    let priceFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.semibold.size(16)]
                    let amountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.semibold.size(16)]
                    let descFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.regular.size(16)]

                    let price = NSMutableAttributedString(string: String(format: "%@", AppConstantValue.rupeesymbol), attributes: priceFontAttributes as [NSAttributedString.Key: Any])
                    let cost = NSMutableAttributedString(string: String(format: "%@", discountValue), attributes: amountFontAttributes as [NSAttributedString.Key: Any])
                    let discount = NSMutableAttributedString(string: String(format: "\n%@", AppLocalizationString.discount.capitalized), attributes: descFontAttributes as [NSAttributedString.Key: Any])

                    combination.append(price)
                    combination.append(cost)
                    combination.append(discount)

                    self.offerLabel.attributedText = combination

                } else if discountType.lowercased() == CouponType.percentage.rawValue.lowercased() {
                    discountValue = String(format: "%d%%", couponData.couponDiscountValue!)
                    let combination = NSMutableAttributedString()

                    let amountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.semibold.size(16)]
                    let descFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.regular.size(16)]

                    let cost = NSMutableAttributedString(string: String(format: "%@", discountValue), attributes: amountFontAttributes as [NSAttributedString.Key: Any])
                    let discount = NSMutableAttributedString(string: String(format: "\n%@", AppLocalizationString.off.capitalized), attributes: descFontAttributes as [NSAttributedString.Key: Any])

                    combination.append(cost)
                    combination.append(discount)

                    self.offerLabel.attributedText = combination
                } else {
                    discountValue = String(format: "%d", couponData.couponDiscountValue!)
                    let combination = NSMutableAttributedString()
                    let amountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.semibold.size(16)]
                    let cost = NSMutableAttributedString(string: String(format: "%@", discountValue), attributes: amountFontAttributes as [NSAttributedString.Key: Any])
                    combination.append(cost)
                    self.offerLabel.attributedText = combination

                }
            }*/
        }

        self.couponHeaderLabel.text = name
        self.couponValidityLabel.text = validity
        self.couponCodeLabel.text = code
    }

    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedCouponListTableViewCell(senderTag: sender.tag)
    }
}
