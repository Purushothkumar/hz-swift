//
//  CompareProductTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 08/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCompareProductTableViewCell {
    func tapButtonPressedCompareProductTableViewCell(senderTag: Int)
    
}
class CompareProductTableViewCell: UITableViewCell {
    @IBOutlet var banner1ImageView: UIImageView!
    @IBOutlet var banner2ImageView: UIImageView!
    @IBOutlet var bannerImageViewHeight: NSLayoutConstraint!
    
    @IBOutlet var brandName1Label: Caption1FontLabel!
    @IBOutlet var brandName2Label: Caption1FontLabel!
    
    @IBOutlet var productName1Label: FootnoteFontLabel!
    @IBOutlet var productName2Label: FootnoteFontLabel!
    
    @IBOutlet var price1Label: Caption1FontLabel!
    @IBOutlet var price2Label: Caption1FontLabel!
    
    @IBOutlet var versusLabel: FootnoteFontLabel!
    @IBOutlet var versusView: UIView!
    @IBOutlet var compareBackgroundView: UIView!
    
    @IBOutlet var tapButton: CalloutBackgroundButton!
    
    var delegate: ProtocolCompareProductTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        self.tapButton.setTitle(AppLocalizationString.comparenow.uppercased(), for: .normal)
        self.tapButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.tapButton.layer.borderWidth = 1.0
        
        self.bannerImageViewHeight.constant = 139 * (screenFrameWidth/AppConstantValue.defaultDesignScreenWidth)
        
        self.versusView.layer.cornerRadius = self.versusView.frame.height / 2
        self.versusView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.versusView.layer.borderWidth = 1.0
        
        self.compareBackgroundView.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.compareBackgroundView.clipsToBounds = true
        
        self.banner1ImageView.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.banner1ImageView.clipsToBounds = true
        self.banner1ImageView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.banner1ImageView.layer.borderWidth = 1.0
        
        self.banner2ImageView.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.banner2ImageView.clipsToBounds = true
        self.banner2ImageView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.banner2ImageView.layer.borderWidth = 1.0
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    public func configure(productComparisonHistory: ProductComparisonHistory, indexpath: Int) {
        self.tapButton.setTitle(AppLocalizationString.comparenow.uppercased(), for: .normal)
        self.tapButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.tapButton.layer.borderWidth = 1.0
        self.bannerImageViewHeight.constant = 139 * (screenFrameHeight/AppConstantValue.defaultDesignScreenHeight)
        
        self.versusView.layer.cornerRadius = self.versusView.frame.height / 2
        self.compareBackgroundView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.compareBackgroundView.clipsToBounds = true
        
        self.banner1ImageView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.banner1ImageView.clipsToBounds = true
        self.banner1ImageView.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.banner1ImageView.layer.borderWidth = 1.0
        
        self.banner2ImageView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.banner2ImageView.clipsToBounds = true
        self.banner2ImageView.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.banner2ImageView.layer.borderWidth = 1.0
        self.tapButton.tag = indexpath
        
        self.brandName1Label.text = ""
        self.brandName2Label.text = ""
        self.productName1Label.text = ""
        self.productName2Label.text = ""
        self.price1Label.text = ""
        self.price2Label.text = ""
        var productImage1 = ""
        var productImage2 = ""
        
        if productComparisonHistory.product1 != nil {
            if !(productComparisonHistory.product1!.brand.isNilOrEmpty) {
                self.brandName1Label.text = productComparisonHistory.product1!.brand!
            }
            if !(productComparisonHistory.product1!.name.isNilOrEmpty) {
                self.productName1Label.text = productComparisonHistory.product1!.name!
            }
            
            if !(productComparisonHistory.product1!.unitSellingPrice.isNilOrEmpty) {
                self.price1Label.text = String(format: "%@%@", AppConstantValue.rupeesymbol, productComparisonHistory.product1!.unitSellingPrice!)
            }
            if !(productComparisonHistory.product1!.mainImage.isNilOrEmpty) {
                productImage1 = productComparisonHistory.product1!.mainImage!
            }
        }
        if productComparisonHistory.product2 != nil {
            if !(productComparisonHistory.product2!.brand.isNilOrEmpty) {
                self.brandName2Label.text = productComparisonHistory.product2!.brand!
            }
            if !(productComparisonHistory.product2!.name.isNilOrEmpty) {
                self.productName2Label.text = productComparisonHistory.product2!.name!
            }
            
            if !(productComparisonHistory.product2!.unitSellingPrice.isNilOrEmpty) {
                self.price2Label.text = String(format: "%@%@", AppConstantValue.rupeesymbol, productComparisonHistory.product2!.unitSellingPrice!)
            }
            if !(productComparisonHistory.product2!.mainImage.isNilOrEmpty) {
                productImage2 = productComparisonHistory.product2!.mainImage!
            }
        }
        self.banner1ImageView.setImage(imageUrl: productImage1, placeHolderImage: hearzapPlaceholder)
        self.banner2ImageView.setImage(imageUrl: productImage2, placeHolderImage: hearzapPlaceholder)
    }
    
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedCompareProductTableViewCell(senderTag: sender.tag)
    }
}
