//
//  ProductDetailLifeStyleTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 03/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolProductDetailLifeStyleTableViewCell {
    func infoButtonProductDetailLifeStyleTableViewCell(senderTag: Int)
}

class ProductDetailLifeStyleTableViewCell: UITableViewCell {
    @IBOutlet var headerLabel: FootnoteFontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!
    @IBOutlet var styleImageView: UIImageView!
    @IBOutlet var contentMessageLabel: Caption1FontLabel!
    @IBOutlet var supportLabel: Caption1FontLabel!
    
    @IBOutlet var statusView: UIView!
    @IBOutlet var statusLabel: FootnoteFontLabel!
    @IBOutlet var infoButton: FootnoteOutlineButton!
    
    var delegate: ProtocolProductDetailLifeStyleTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    public func configure(productLifeStyle: ProductLifestyle, indexpath: Int, knowMorebool: Bool) {
        self.headerLabel.text = ""
        self.descriptionLabel.text = ""
        self.contentMessageLabel.text = ""
        self.supportLabel.text = ""
        self.statusLabel.text = ""
        
        var lifestyleName = ""
        var productImage = ""
        
        var displaycolor = UIColor.colorLiteral.theme_blue_2AACEF
        var productscore = ""
        var fitLevel = ""
        
        if !(productLifeStyle.colorCode.isNilOrEmpty) {
            //            self.statusView.backgroundColor = UIColor(hexString: productLifeStyle.colorCode!, alpha: 1.0)
            displaycolor = UIColor(hexString: productLifeStyle.colorCode!, alpha: 1.0)
        }
        if !(productLifeStyle.lifestyleImage.isNilOrEmpty) {
            productImage = productLifeStyle.lifestyleImage!
        }
        if productLifeStyle.compatibilityScore != nil {
            productscore = String(format: "%d%%", productLifeStyle.compatibilityScore!)
        }
        if !(productLifeStyle.lifestyleName.isNilOrEmpty) {
            lifestyleName = productLifeStyle.lifestyleName!.capitalized
            self.headerLabel.text = lifestyleName
        }
        if !(productLifeStyle.lifestyleDescription.isNilOrEmpty) {
            self.descriptionLabel.text = productLifeStyle.lifestyleDescription!.capitalized
        }
        if !(productLifeStyle.fitLevel.isNilOrEmpty) {
            fitLevel = productLifeStyle.fitLevel!.capitalized
        }
        if !(productscore.isEmpty) && !(fitLevel.isEmpty) {
            self.statusLabel.text = String(format: "%@ (%@)", fitLevel, productscore)
        } else {
            if !(productscore.isEmpty) {
                self.statusLabel.text = String(format: "%@", productscore )
            } else if !(fitLevel.isEmpty) {
                self.statusLabel.text = String(format: "%@", fitLevel )
            }
        }
        self.statusLabel.textColor = displaycolor
        
        var datatoload = [String]()
        var contentmessage = ""
        
        if knowMorebool == false {
            if productLifeStyle.situation != nil {
                if productLifeStyle.situation!.count > 0 {
                    var index = 0
                    datatoload.append("<ul style=\"padding-left:0px;\">")
                    for item in productLifeStyle.situation! {
                        if !(item.isEmpty) {
                            datatoload.append("<li>\(item.capitalized)</li>")
                        }
                        index += 1
                        if index >= productLifeStyle.situation!.count {
                            datatoload.append("</ul>")
                            contentmessage = datatoload.joined(separator: "")
                            self.contentMessageLabel.setHTMLFromString(htmlText: contentmessage, fontFamily: AppConstantValue.poppinsregular, fontSize: 13.0, fontColor: AppConstantValue.fontGrey777777)
                        }
                    }
                }
            }
            
            if !(productscore.isEmpty) {
                self.setSupportLabel(productscore: productscore, displaycolor: displaycolor, lifestyleName: lifestyleName)
            }
        }
        self.styleImageView.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
    }
    
    func setSupportLabel(productscore: String, displaycolor: UIColor, lifestyleName: String) {
        let productSupport = AppLocalizationString.support
        let productscore = productscore
        let productMessage = String(format: "\(AppLocalizationString.ofyourlifestylehearingneeds)", lifestyleName)
        
        let supportFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        
        let scoreFontAttributes = [NSAttributedString.Key.foregroundColor: displaycolor, NSAttributedString.Key.font: AppFont.medium.size(13)]
        
        let messsageFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        
        let support = NSMutableAttributedString(string: String(format: "%@ ", productSupport), attributes: supportFontAttributes as [NSAttributedString.Key: Any])
        let score = NSMutableAttributedString(string: String(format: "%@", productscore), attributes: scoreFontAttributes as [NSAttributedString.Key: Any])
        let message = NSMutableAttributedString(string: String(format: " %@", productMessage), attributes: messsageFontAttributes as [NSAttributedString.Key: Any])
        
        let combination = NSMutableAttributedString()
        combination.append(support)
        combination.append(score)
        combination.append(message)
        
        self.supportLabel.attributedText = combination
        
    }
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        self.delegate?.infoButtonProductDetailLifeStyleTableViewCell(senderTag: sender.tag)
    }
}
