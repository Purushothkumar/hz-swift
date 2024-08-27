//
//  CompareProductModelTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCompareProductModelTableViewCell {
    func modelButtonPressedCompareProductModelTableViewCell(senderTag: Int)
}

class CompareProductModelTableViewCell: UITableViewCell {
    @IBOutlet var brandNameLabel: Caption1FontLabel!
    @IBOutlet var productNameLabel: FootnoteFontLabel!
    @IBOutlet var productCodeLabel: Caption1FontLabel!
    @IBOutlet var priceLabel: Caption1FontLabel!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var modelButton: FootnoteOutlineButton!

    var delegate: ProtocolCompareProductModelTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(product: ShopProductList, indexpath: Int) {
        self.modelButton.tag = indexpath
        self.productCodeLabel.text = ""
        self.brandNameLabel.text = ""
        self.priceLabel.text = ""
        var productImage = ""
        var productcode = ""
        var brandName = ""
        var name = ""

        if !(product.uid.isNilOrEmpty) {
            productcode = product.uid!
        }

        if !(product.name.isNilOrEmpty) {
            name = product.name!
        }

        if !(product.brand.isNilOrEmpty) {
            brandName = product.brand!
        }

        if !(product.name.isNilOrEmpty) {
            name = product.name!
        }

        self.brandNameLabel.text = brandName
        self.productNameLabel.text = name

        if !(product.mainImage.isNilOrEmpty) {
            productImage = product.mainImage!
        }
        self.productImageView.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
        self.setPriceLabelColor(product: product)

    }
    func setPriceLabelColor(product: ShopProductList) {
        var productSell = ""
        var productCost = ""
        var productDiscount = ""

        if !(product.unitSellingPrice.isNilOrEmpty) {
            productSell = String(format: "%@%@", AppConstantValue.rupeesymbol, product.unitSellingPrice!)
        }
        if !(product.unitPrice.isNilOrEmpty) {
            productCost = String(format: "%@%@", AppConstantValue.rupeesymbol, product.unitPrice!)
        }
        if product.productDiscount != nil {
            if product.productDiscount != 0 {
                productDiscount = String(format: "%d%% %@", product.productDiscount!, AppLocalizationString.off)
            }
        }

        let combination = NSMutableAttributedString()

        let sellFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_black_333333, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let costFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13), NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                  NSAttributedString.Key.strikethroughColor: UIColor.colorLiteral.theme_grey_777777] as [NSAttributedString.Key: Any]
        let discountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_red_FF6961, NSAttributedString.Key.font: AppFont.regular.size(13)]

        var sell = NSMutableAttributedString(string: String(format: "%@", productSell), attributes: sellFontAttributes as [NSAttributedString.Key: Any])
        if !(productCost.isEmpty) || !(productDiscount.isEmpty) {
            sell = NSMutableAttributedString(string: String(format: "%@ ", productSell), attributes: sellFontAttributes as [NSAttributedString.Key: Any])
        }
        let cost = NSMutableAttributedString(string: String(format: "%@", productCost), attributes: costFontAttributes as [NSAttributedString.Key: Any])
        var discount = NSMutableAttributedString(string: String(format: "%@", productDiscount), attributes: discountFontAttributes as [NSAttributedString.Key: Any])
        if !(productCost.isEmpty) {
            discount = NSMutableAttributedString(string: String(format: " %@", productDiscount), attributes: discountFontAttributes as [NSAttributedString.Key: Any])
        }

        if !(productSell.isEmpty) {
            combination.append(sell)
        }
        if !(productCost.isEmpty) {
            combination.append(cost)
        }
        if !(productDiscount.isEmpty) {
            combination.append(discount)
        }
        self.priceLabel.attributedText = combination
    }

    @IBAction func modelButtonPressed(_ sender: UIButton) {
        self.delegate?.modelButtonPressedCompareProductModelTableViewCell(senderTag: sender.tag)
    }
}
