//
//  WishlistCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 11/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolWishlistCollectionViewCell {
    //    func tapButtonPressedWishlistCollectionViewCell(senderTag: Int)
    func removeWishlistButtonPressedWishlistCollectionViewCell(senderTag: Int)
    func viewProductButtonPressedWishlistCollectionViewCell(senderTag: Int)
}

class WishlistCollectionViewCell: UICollectionViewCell {

    @IBOutlet var removeWishlistButton: FootnoteOutlineButton!

    @IBOutlet var productView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productImageViewHeight: NSLayoutConstraint!

    @IBOutlet var productBrandLabel: Caption1FontLabel!
    @IBOutlet var productNameLabel: FootnoteFontLabel!
    @IBOutlet var productPriceLabel: Caption1FontLabel!
    @IBOutlet var tapButton: FootnoteOutlineButton!

    @IBOutlet var viewProductButton: FootnoteBackgroundButton!

    var delegate: ProtocolWishlistCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(product: WishlistModelData, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.removeWishlistButton.tag = indexpath
        self.viewProductButton.tag = indexpath

        self.productPriceLabel.text = ""
        var productImage = ""
        var productSell = ""
        var productCost = ""

        self.viewProductButton.setTitle(AppLocalizationString.viewProduct.uppercased(), for: .normal)
        self.productImageViewHeight.constant = CGFloat(239.38 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth))

        let sellFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_black_333333, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let costFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13), NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                  NSAttributedString.Key.strikethroughColor: UIColor.colorLiteral.theme_grey_777777] as [NSAttributedString.Key: Any]

        var brandName = ""
        var name = ""

        if !(product.brand.isNilOrEmpty) {
            brandName = product.brand!
        }
        if !(product.name.isNilOrEmpty) {
            name = product.name!
        }

        self.productBrandLabel.text = brandName
        self.productNameLabel.text = name

        if !(product.unitSellingPrice.isNilOrEmpty) {
            productSell = String(format: "%@%@", AppConstantValue.rupeesymbol, product.unitSellingPrice!)
        }
        if !(product.unitPrice.isNilOrEmpty) {
            productCost = String(format: "%@%@", AppConstantValue.rupeesymbol, product.unitPrice!)
        }
        let combination = NSMutableAttributedString()
        var sell = NSMutableAttributedString()
        var cost = NSMutableAttributedString()

        if !(productSell.isEmpty) {
            if !(productCost.isEmpty) {
                sell = NSMutableAttributedString(string: String(format: "%@ ", productSell), attributes: sellFontAttributes as [NSAttributedString.Key: Any])
            } else {
                sell = NSMutableAttributedString(string: String(format: "%@", productSell), attributes: sellFontAttributes as [NSAttributedString.Key: Any])
            }
            combination.append(sell)
        }
        if !(productCost.isEmpty) {
            cost = NSMutableAttributedString(string: String(format: "%@", productCost), attributes: costFontAttributes as [NSAttributedString.Key: Any])
            combination.append(cost)
        }
        self.productPriceLabel.attributedText = combination

        if !(product.mainImage.isNilOrEmpty) {
            productImage = product.mainImage!
        }
        self.productImageView.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)

    }
    @IBAction func removeWishlistButtonPressed(_ sender: UIButton) {
        self.delegate?.removeWishlistButtonPressedWishlistCollectionViewCell(senderTag: sender.tag)
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.viewProductButtonPressedWishlistCollectionViewCell(senderTag: sender.tag)
    }
    @IBAction func viewProductButtonPressed(_ sender: UIButton) {
        self.delegate?.viewProductButtonPressedWishlistCollectionViewCell(senderTag: sender.tag)
    }
}
