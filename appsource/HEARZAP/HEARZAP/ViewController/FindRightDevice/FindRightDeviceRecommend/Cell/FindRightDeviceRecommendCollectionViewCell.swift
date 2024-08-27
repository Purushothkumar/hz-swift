//
//  FindRightDeviceRecommendCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 14/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolFindRightDeviceRecommendCollectionViewCell {
    func selectButtonPressedFindRightDeviceRecommendCollectionViewCell(senderTag: Int)
    func productDetailButtonFindRightDeviceRecommendCollectionViewCell(senderTag: Int)
    
}
class FindRightDeviceRecommendCollectionViewCell: UICollectionViewCell {
    @IBOutlet var brandLabel: Caption1FontLabel!
    @IBOutlet var nameLabel: FootnoteFontLabel!
    @IBOutlet var priceLabel: Caption1FontLabel!
    @IBOutlet var selectButton: FootnoteOutlineButton!
    @IBOutlet var productDetailButton: FootnoteOutlineButton!
    @IBOutlet var selectImageView: UIImageView!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var heightBannerImageView: NSLayoutConstraint!
    @IBOutlet var statusView: UIView!
    @IBOutlet var gradiantView: UIView!
    @IBOutlet var statusLabel: FootnoteFontLabel!
    @IBOutlet var contentLabel: Caption2FontLabel!
    
    var delegate: ProtocolFindRightDeviceRecommendCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func configure(output: FindRightDeviceRecommendModelOutput, indexPath: Int, selectedrecommendedArray: [String], selectedWishListArray: [String]) {
        self.brandLabel.text = ""
        self.nameLabel.text = ""
        self.priceLabel.text = ""
        self.statusLabel.text = ""
        self.contentLabel.text = ""
        
        self.statusView.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        
        self.selectButton.tag = indexPath
        self.productDetailButton.tag = indexPath
        var imgurl = ""
        self.heightBannerImageView.constant = 239.38 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
        self.statusView.isHidden = true
        self.selectImageView.image = UIImage(named: Asset.checkcirclesquarewhite)
        
        var currentuid = ""
        if output.product != nil {
            if !(output.product!.brand.isNilOrEmpty) {
                self.brandLabel.text = output.product!.brand!
            }
            if !(output.product!.name.isNilOrEmpty) {
                self.nameLabel.text = output.product!.name!
            }
            if !(output.product!.unitSellingPrice.isNilOrEmpty) {
                self.priceLabel.text = String(format: "%@%@", AppConstantValue.rupeesymbol, output.product!.unitSellingPrice!)
            }
            if !(output.product!.uid.isNilOrEmpty) {
                currentuid = "\(String(describing: output.product!.uid!))"
            }
            if !(output.product!.mainImage.isNilOrEmpty) {
                imgurl = "\(String(describing: output.product!.mainImage!))"
            }
            if selectedrecommendedArray.contains(currentuid) {
                self.selectImageView.image = UIImage(named: Asset.checkcirclesquareblue)
            }
            if output.productCompatibility != nil {
                if output.productCompatibility!.compatibilityScore != nil {
                    self.contentLabel.text = String(format: "supports %d%% of your needs", output.productCompatibility!.compatibilityScore!)
                }
                if !(output.productCompatibility!.colorCode.isNilOrEmpty) {
                    self.statusView.backgroundColor = UIColor(hexString: output.productCompatibility!.colorCode!, alpha: 1.0)
                }
                if !(output.productCompatibility!.fitLevel.isNilOrEmpty) {
                    self.statusLabel.text = output.productCompatibility!.fitLevel!
                    self.statusView.isHidden = false
                }
            }
        }
        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
        self.setGradientBackground()
    }
    func setGradientBackground() {
        DispatchQueue.main.async {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.colorLiteral.theme_black_333333.withAlphaComponent(0.5).cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.locations = [NSNumber(floatLiteral: 0.1), NSNumber(floatLiteral: 1.0)]
            gradientLayer.frame = self.gradiantView.bounds
            if let _ = (self.gradiantView.layer.sublayers?.compactMap { $0 as? CAGradientLayer })?.first {
                // already present
            } else {
                // already newly
                self.gradiantView.layer.insertSublayer(gradientLayer, at: 0)
            }
        }
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedFindRightDeviceRecommendCollectionViewCell(senderTag: sender.tag)
    }
    @IBAction func productDetailButtonPressed(_ sender: UIButton) {
        self.delegate?.productDetailButtonFindRightDeviceRecommendCollectionViewCell(senderTag: sender.tag)
    }
}
