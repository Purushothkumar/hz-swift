//
//  RegisterDeviceCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 23/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolRegisterDeviceCollectionViewCell {
    func tapButtonPressedRegisterDeviceCollectionViewCell(senderTag: Int)
    func wishlistButtonPressedRegisterDeviceCollectionViewCell(senderTag: Int)
}

class RegisterDeviceCollectionViewCell: UICollectionViewCell {
    @IBOutlet var wishlistView: UIView!
    @IBOutlet var wishlistImageView: UIImageView!
    @IBOutlet var wishlistButton: FootnoteOutlineButton!

    @IBOutlet var productView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productImageViewHeight: NSLayoutConstraint!

    @IBOutlet var productNameLabel: Caption1FontLabel!
    @IBOutlet var productBrandLabel: FootnoteFontLabel!
    @IBOutlet var productPriceLabel: Caption1FontLabel!
    @IBOutlet var tapButton: FootnoteOutlineButton!

    var delegate: ProtocolRegisterDeviceCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(product: RegisterDeviceModelAccessories, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.wishlistButton.tag = indexpath

        self.productNameLabel.text = ""
        self.productPriceLabel.text = ""
        var productImage = ""
        var productSell = ""
        var isWishlist = false
        self.wishlistView.isHidden = true
        self.productImageViewHeight.constant = 239.38 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
        let sellFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_black_333333, NSAttributedString.Key.font: AppFont.regular.size(13)]

        var brandName = ""
        var name = ""

        if !(product.brand.isNilOrEmpty) {
            brandName = product.brand!.capitalized
        }
        if !(product.name.isNilOrEmpty) {
            name = product.name!.capitalized
        }

        self.productBrandLabel.text = brandName
        self.productNameLabel.text = name

        if !(product.unitSellingPrice.isNilOrEmpty) {
            productSell = String(format: "%@%@", AppConstantValue.rupeesymbol, product.unitSellingPrice!)
        }
        let combination = NSMutableAttributedString()
        let sell = NSMutableAttributedString(string: String(format: "%@", productSell), attributes: sellFontAttributes as [NSAttributedString.Key: Any])
        combination.append(sell)
        self.productPriceLabel.attributedText = combination

        if product.isWishlist != nil {
            isWishlist = product.isWishlist!
            self.wishlistView.isHidden = true
        }
        self.wishlistImageView.image = isWishlist == true ? UIImage(named: Asset.heartorangecircle) : UIImage(named: Asset.heartwhitecircle)

        if !(product.mainImage.isNilOrEmpty) {
            productImage = product.mainImage!
        }
        self.productImageView.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
    }
    @IBAction func wishlistButtonPressed(_ sender: UIButton) {
        self.delegate?.wishlistButtonPressedRegisterDeviceCollectionViewCell(senderTag: sender.tag)
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedRegisterDeviceCollectionViewCell(senderTag: sender.tag)
    }
}
