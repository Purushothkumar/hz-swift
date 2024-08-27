//
//  CheckOutSummaryProductTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 08/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CheckOutSummaryProductTableViewCell: UITableViewCell {

    @IBOutlet var productView: UIView!
    @IBOutlet var productImageView: UIImageView!

    @IBOutlet var productBrandLabel: Caption1FontLabel!
    @IBOutlet var productNameLabel: Caption1FontLabel!
    @IBOutlet var productSellingLabel: Caption1FontLabel!
    @IBOutlet var productPriceLabel: Caption1FontLabel!

    @IBOutlet var quantityView: UIView!
    @IBOutlet var productQtyLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(data: OrderItem, indexpath: Int) {
        var productbrand = ""
        var productName = ""
        var productQuantity = ""

        var productImage = ""
        var productSell = ""
        var productCost = ""
        var productDiscount = ""
        var canShowMrpPrice = false

        self.productSellingLabel.text = ""
        self.productPriceLabel.text = ""

        if !(data.productImage.isNilOrEmpty) {
            productImage = data.productImage!
        }

        if data.canShowMrpPrice != nil {
            canShowMrpPrice = data.canShowMrpPrice!
        }
        let sellingcombination = NSMutableAttributedString()
        let combination = NSMutableAttributedString()

        let sellFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_orange_F7732F, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let costFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13), NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                  NSAttributedString.Key.strikethroughColor: UIColor.colorLiteral.theme_grey_777777] as [NSAttributedString.Key: Any]
        let discountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_green_27AE60, NSAttributedString.Key.font: AppFont.regular.size(13)]

        if !(data.mrpPrice.isNilOrEmpty) {
            productCost = String(format: "%@", data.mrpPrice!)
        }
        if !(data.sellingPrice.isNilOrEmpty) {
            productSell = String(format: "%@", data.sellingPrice!)
        }
        if data.productDiscount != nil {
            if data.productDiscount! > 0 {
                productDiscount = String(format: "%d%% %@", data.productDiscount!, AppLocalizationString.off)
            }
        }
        var sell = NSMutableAttributedString(string: String(format: "%@", productSell), attributes: sellFontAttributes as [NSAttributedString.Key: Any])
        sellingcombination.append(sell)
        self.productSellingLabel.attributedText = sellingcombination

        if canShowMrpPrice == true {
            var cost = NSMutableAttributedString(string: String(format: "%@", productCost), attributes: costFontAttributes as [NSAttributedString.Key: Any])
            if !(productCost.isEmpty) && !(productDiscount.isEmpty) {
                cost = NSMutableAttributedString(string: String(format: "%@ ", productCost), attributes: costFontAttributes as [NSAttributedString.Key: Any])
            }
            let discount = NSMutableAttributedString(string: String(format: "%@", productDiscount), attributes: discountFontAttributes as [NSAttributedString.Key: Any])

            combination.append(cost)
            combination.append(discount)
            self.productPriceLabel.attributedText = combination
        }

        if !(data.brandName.isNilOrEmpty) {
            productbrand = data.brandName!
        }
        if !(data.productName.isNilOrEmpty) {
            productName =  data.productName!
        }

        if data.qty !=  nil {
            productQuantity =  String(format: "%@ %d", AppLocalizationString.qty, data.qty!)
        }

        self.productBrandLabel.text = productbrand.capitalized
        self.productNameLabel.text = productName.capitalized

        self.productQtyLabel.text = productQuantity
        self.productImageView.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
    }

}
