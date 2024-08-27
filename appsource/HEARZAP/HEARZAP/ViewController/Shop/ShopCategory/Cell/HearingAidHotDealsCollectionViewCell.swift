//
//  HearingAidHotDealsCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 17/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolHearingAidHotDealsCollectionViewCell {
    
    func tapButtonPressedHearingAidHotDealsCollectionViewCell(senderTag: Int)
    func wishlistButtonPressedHearingAidHotDealsCollectionViewCell(senderTag: Int)
    
}

class HearingAidHotDealsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var wishlistView: UIView!
    @IBOutlet var wishlistImageView: UIImageView!
    @IBOutlet var wishlistButton: FootnoteOutlineButton!
    
    @IBOutlet var productDiscountView: UIView!
    @IBOutlet var productDiscountLabel: FootnoteFontLabel!
    
    @IBOutlet var ProductView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productImageViewHeight: NSLayoutConstraint!
    
    @IBOutlet var productBrandLabel: Caption1FontLabel!
    @IBOutlet var productNameLabel: FootnoteFontLabel!
    @IBOutlet var productPriceLabel: Caption1FontLabel!
    @IBOutlet var tapButton: FootnoteOutlineButton!
    
    var delegate: ProtocolHearingAidHotDealsCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(product: ShopProductList, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.wishlistButton.tag = indexpath
        
        var brandName = ""
        var name = ""
        self.productPriceLabel.text = ""
        self.productDiscountLabel.text = ""
        var productImage = ""
        var productSell = ""
        var productCost = ""
        var productDiscount = ""
        let productoff = AppLocalizationString.off
        var isWishlist = false
        self.wishlistView.isHidden = true
        self.productDiscountView.isHidden = true
        self.productImageViewHeight.constant = CGFloat(252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth))
        
        let sellFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_black_333333, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let costFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13), NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                  NSAttributedString.Key.strikethroughColor: UIColor.colorLiteral.theme_grey_777777] as [NSAttributedString.Key: Any]
        
        let discountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_white_FFFFFF, NSAttributedString.Key.font: AppFont.medium.size(13)]
        let offFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_white_FFFFFF, NSAttributedString.Key.font: AppFont.regular.size(13)] as [NSAttributedString.Key: Any]
        
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
        if product.productDiscount != nil {
            if product.productDiscount != 0 {
                productDiscount = String(format: "%d%%", product.productDiscount!)
            }
        }
        let discountcombination = NSMutableAttributedString()
        if !(productDiscount.isEmpty) {
            let discount = NSMutableAttributedString(string: String(format: "%@", productDiscount), attributes: discountFontAttributes as [NSAttributedString.Key: Any])
            let off = NSMutableAttributedString(string: String(format: "\n%@", productoff), attributes: offFontAttributes as [NSAttributedString.Key: Any])
            discountcombination.append(discount)
            discountcombination.append(off)
            self.productDiscountView.isHidden = false
        }
        self.productDiscountLabel.attributedText = discountcombination
        
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
        self.delegate?.wishlistButtonPressedHearingAidHotDealsCollectionViewCell(senderTag: sender.tag)
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedHearingAidHotDealsCollectionViewCell(senderTag: sender.tag)
    }
}
