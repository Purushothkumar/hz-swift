//
//  CartDetailTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 07/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCartDetailTableViewCell {
    func quantityButtonPressedCartDetailTableViewCell(senderTag: Int)
    func optionsButtonPressedCartDetailTableViewCell(senderTag: Int)
    func deleteButtonPressedCartDetailTableViewCell(senderTag: Int)
}

class CartDetailTableViewCell: UITableViewCell {

    @IBOutlet var productView: UIView!
    @IBOutlet var productImageView: UIImageView!

    @IBOutlet var productBrandLabel: Caption1FontLabel!
    @IBOutlet var productNameLabel: Caption1FontLabel!
    @IBOutlet var productSellingLabel: Caption1FontLabel!
    @IBOutlet var productPriceLabel: Caption1FontLabel!

    @IBOutlet var quantityView: UIView!
    @IBOutlet var quantityButton: FootnoteOutlineButton!
    @IBOutlet var productQtyLabel: Caption1FontLabel!

    @IBOutlet var optionsView: UIView!
    @IBOutlet var optionsButton: FootnoteOutlineButton!
    @IBOutlet var optionsLabel: Caption1FontLabel!

    @IBOutlet var deleteButton: FootnoteOutlineButton!

    var delegate: ProtocolCartDetailTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(data: CartDetailModelData, indexpath: Int) {
        self.quantityButton.tag = indexpath
        self.optionsButton.tag = indexpath
        self.deleteButton.tag = indexpath
        var productbrand = ""
        var productName = ""
        //        var productCode = ""
        //        var productIdentity = ""
        var productQuantity = ""

        var productImage = ""
        var productSell = ""
        var productCost = ""
        var productDiscount = ""

        self.productSellingLabel.text = ""
        self.productPriceLabel.text = ""
        self.optionsView.isHidden = true
        if data.product != nil {
            if !(data.product!.mainImage.isNilOrEmpty) {
                productImage = data.product!.mainImage!
            }

            let sellingcombination = NSMutableAttributedString()
            let combination = NSMutableAttributedString()

            let sellFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_orange_F7732F, NSAttributedString.Key.font: AppFont.regular.size(13)]
            let costFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13), NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                      NSAttributedString.Key.strikethroughColor: UIColor.colorLiteral.theme_grey_777777] as [NSAttributedString.Key: Any]
            let discountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_green_27AE60, NSAttributedString.Key.font: AppFont.regular.size(13)]

            if !(data.product!.unitPrice.isNilOrEmpty) {
                productCost = String(format: "%@%@", AppConstantValue.rupeesymbol, data.product!.unitPrice!)
            }
            if !(data.product!.unitSellingPrice.isNilOrEmpty) {
                productSell = String(format: "%@%@", AppConstantValue.rupeesymbol, data.product!.unitSellingPrice!)
            }
            if data.product!.productDiscount != nil {
                if data.product!.productDiscount! > 0 {
                    productDiscount = String(format: "%d%% %@", data.product!.productDiscount!, AppLocalizationString.off)
                }
            }
            var sell = NSMutableAttributedString(string: String(format: "%@", productSell), attributes: sellFontAttributes as [NSAttributedString.Key: Any])
            var cost = NSMutableAttributedString(string: String(format: "%@", productCost), attributes: costFontAttributes as [NSAttributedString.Key: Any])
            if !(productCost.isEmpty) && !(productDiscount.isEmpty) {
                cost = NSMutableAttributedString(string: String(format: "%@ ", productCost), attributes: costFontAttributes as [NSAttributedString.Key: Any])
            }
            let discount = NSMutableAttributedString(string: String(format: "%@", productDiscount), attributes: discountFontAttributes as [NSAttributedString.Key: Any])

            sellingcombination.append(sell)
            combination.append(cost)
            combination.append(discount)
            self.productPriceLabel.attributedText = combination
            self.productSellingLabel.attributedText = sellingcombination

            if !(data.product!.brand.isNilOrEmpty) {
                productbrand = data.product!.brand!
            }
            if !(data.product!.name.isNilOrEmpty) {
                productName =  data.product!.name!
            }
            //            if !(data.product!.uid.isNilOrEmpty) {
            //                productCode = data.product!.uid!
            //            }
            //            // brand
            //            if !(productbrand.isEmpty) {
            //                productIdentity = "\(productbrand)"
            //            }
            //            // name
            //            if !(productIdentity.isEmpty) && !(productName.isEmpty) {
            //                productIdentity = "\(productIdentity) | \(productName)"
            //            } else if (productIdentity.isEmpty) && !(productName.isEmpty) {
            //                productIdentity = "\(productName)"
            //            }
            //            // code
            //            if !(productIdentity.isEmpty) && !(productCode.isEmpty) {
            //                productIdentity = "\(productIdentity) | \(productCode)"
            //            } else if (productIdentity.isEmpty) && !(productCode.isEmpty) {
            //                productIdentity = "\(productCode)"
            //            }
        }
        if data.quantity !=  nil {
            productQuantity =  String(format: "%@ %d", AppLocalizationString.qty, data.quantity!)
        }

        self.productBrandLabel.text = productbrand.capitalized
        self.productNameLabel.text = productName.capitalized

        self.productQtyLabel.text = productQuantity
        self.productImageView.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)

        self.optionsLabel.text = AppLocalizationString.options

    }
    @IBAction func quantityButtonPressed(_ sender: UIButton) {
        //        self.delegate?.quantityButtonPressedCartDetailTableViewCell(senderTag: sender.tag)
    }
    @IBAction func optionsButtonPressed(_ sender: UIButton) {
        //        self.delegate?.optionsButtonPressedCartDetailTableViewCell(senderTag: sender.tag)
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        self.delegate?.deleteButtonPressedCartDetailTableViewCell(senderTag: sender.tag)
    }
}
