//
//  ServiceCouponListTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 30/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolServiceCouponListTableViewCell {
    func tapButtonPressedServiceCouponListTableViewCell(senderTag: Int)
}
class ServiceCouponListTableViewCell: UITableViewCell {

    @IBOutlet var couponCardView: UIView!
    @IBOutlet var offerLabel: Title2FontLabel!
    @IBOutlet var dashView: UIView!

    @IBOutlet var couponHeaderLabel: Caption1FontLabel!
    @IBOutlet var couponCodeLabel: BodyFontLabel!
    @IBOutlet var couponValidityLabel: Caption1FontLabel!

    @IBOutlet var tapButton: FootnoteOutlineButton!

    var delegate: ProtocolServiceCouponListTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(customerCoupon: ServiceCouponListModelCustomerCoupon, indexpath: Int) {
        var code = ""
        var name = ""
        var discountValue = ""
        var discountType = ""
        var validity = ""
        var category = ""
        self.offerLabel.text = discountValue
        self.tapButton.tag = indexpath

        if !(customerCoupon.couponCode.isNilOrEmpty) {
            code = String(format: "%@ \"%@\"", AppLocalizationString.use.uppercased(), customerCoupon.couponCode!)
        }
        if !(customerCoupon.couponName.isNilOrEmpty) {
            name = customerCoupon.couponName!.capitalized
        }
        if !(customerCoupon.couponUsageEndDate.isNilOrEmpty) {
            validity = String(format: "%@ %@", AppLocalizationString.validtill, customerCoupon.couponUsageEndDate!)
        }
        if !(customerCoupon.couponCategory.isNilOrEmpty) {
            category = customerCoupon.couponCategory!
        }
        if !(customerCoupon.couponDiscountType.isNilOrEmpty) {
            discountType = customerCoupon.couponDiscountType!
        }
        /*
        if customerCoupon.couponDiscountValue != nil {
            if discountType.lowercased() == CouponType.flat.rawValue.lowercased() {
                discountValue = String(format: "%d", customerCoupon.couponDiscountValue!)

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

                self.offerLabel.attributedText = combination
            } else if discountType.lowercased() == CouponType.percentage.rawValue.lowercased() {
                discountValue = String(format: "%d%%", customerCoupon.couponDiscountValue!)
                let combination = NSMutableAttributedString()

                let amountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.semibold.size(22)]
                let descFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.regular.size(16)]

                let cost = NSMutableAttributedString(string: String(format: "%@", discountValue), attributes: amountFontAttributes as [NSAttributedString.Key: Any])
                let discount = NSMutableAttributedString(string: String(format: "\n%@", AppLocalizationString.off.capitalized), attributes: descFontAttributes as [NSAttributedString.Key: Any])

                combination.append(cost)
                combination.append(discount)

                self.offerLabel.attributedText = combination
            } else {
                discountValue = String(format: "%d", customerCoupon.couponDiscountValue!)
                let combination = NSMutableAttributedString()
                let amountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_pink_FF6482, NSAttributedString.Key.font: AppFont.semibold.size(22)]
                let cost = NSMutableAttributedString(string: String(format: "%@", discountValue), attributes: amountFontAttributes as [NSAttributedString.Key: Any])
                combination.append(cost)
                self.offerLabel.attributedText = combination
            }
        }*/
        self.couponHeaderLabel.text = name
        self.couponValidityLabel.text = validity
        self.couponCodeLabel.text = code
    }

    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedServiceCouponListTableViewCell(senderTag: sender.tag)
    }

}
