//
//  CompareProductLifestyleTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 10/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCompareProductLifestyleTableViewCell {
    func infoButtonCompareProductLifestyleTableViewCell(senderTag: Int)
}

class CompareProductLifestyleTableViewCell: UITableViewCell {
    @IBOutlet var headerLabel: FootnoteFontLabel!
    @IBOutlet var descriptionLabel: Caption2FontLabel!
    @IBOutlet var styleImageView: UIImageView!

    @IBOutlet var statusView1: UIView!
    @IBOutlet var statusView2: UIView!
    @IBOutlet var statusLabel1: SubheadFontLabel!
    @IBOutlet var statusLabel2: SubheadFontLabel!
    @IBOutlet var contentLabel1: Caption2FontLabel!
    @IBOutlet var contentLabel2: Caption2FontLabel!
    @IBOutlet var infoButton: FootnoteOutlineButton!

    var delegate: ProtocolCompareProductLifestyleTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(compareLifeStyleModel: CompareProductModelProductCompatability, indexpath: Int, product1: String, product2: String) {
        self.headerLabel.text = ""
        self.descriptionLabel.text = ""
        self.statusLabel1.text = ""
        self.statusLabel2.text = ""
        self.contentLabel1.text = ""
        self.contentLabel2.text = ""
        var productImage = ""

        if compareLifeStyleModel.key != nil {
            if !(compareLifeStyleModel.key!.name.isNilOrEmpty) {
                self.headerLabel.text = compareLifeStyleModel.key!.name!.capitalized
            }
            if !(compareLifeStyleModel.key!.description.isNilOrEmpty) {
                self.descriptionLabel.text = compareLifeStyleModel.key!.description!.capitalized
            }
            if !(compareLifeStyleModel.key!.image.isNilOrEmpty) {
                productImage = compareLifeStyleModel.key!.image!
            }
        }
        if !(product1.isEmpty) {
            if compareLifeStyleModel.product1 != nil {
                var fitlevel = ""
                var compatibilityScore = ""
                var colorCode = UIColor.colorLiteral.theme_blue_2AACEF
                self.statusView1.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF

                if compareLifeStyleModel.product1!.compatibilityScore != nil {
                    self.contentLabel1.text = String(format: AppLocalizationString.supportsofyourneeds, compareLifeStyleModel.product1!.compatibilityScore!)
                    compatibilityScore = String(format: "%d", compareLifeStyleModel.product1!.compatibilityScore!)
                }
                if !(compareLifeStyleModel.product1!.fitLevel.isNilOrEmpty) {
                    fitlevel = compareLifeStyleModel.product1!.fitLevel!
                }
                if !(compareLifeStyleModel.product1!.colorCode.isNilOrEmpty) {
                    colorCode = UIColor(hexString: compareLifeStyleModel.product1!.colorCode!, alpha: 1.0)
                }
                self.statusLabel1.textColor = colorCode
                if !(fitlevel.isEmpty) && !(compatibilityScore.isEmpty) {
                    self.statusLabel1.text = String(format: "%@ (%@%%)", fitlevel, compatibilityScore)
                } else if !(fitlevel.isEmpty) {
                    self.statusLabel1.text = String(format: "%@", fitlevel)
                } else if !(compatibilityScore.isEmpty) {
                    self.statusLabel1.text = String(format: "%@%%", compatibilityScore)
                }
            } else {
                self.contentLabel1.text = "-"
            }
        }

        if !(product2.isEmpty) {
            if compareLifeStyleModel.product2 != nil {
                var fitlevel = ""
                var compatibilityScore = ""
                var colorCode = UIColor.colorLiteral.theme_blue_2AACEF
                self.statusView2.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF

                if compareLifeStyleModel.product2!.compatibilityScore != nil {
                    self.contentLabel2.text = String(format: AppLocalizationString.supportsofyourneeds, compareLifeStyleModel.product2!.compatibilityScore!)
                    compatibilityScore = String(format: "%d", compareLifeStyleModel.product2!.compatibilityScore!)
                }
                if !(compareLifeStyleModel.product2!.fitLevel.isNilOrEmpty) {
                    fitlevel = compareLifeStyleModel.product2!.fitLevel!
                }
                if !(compareLifeStyleModel.product2!.colorCode.isNilOrEmpty) {
                    colorCode = UIColor(hexString: compareLifeStyleModel.product2!.colorCode!, alpha: 1.0)
                }
                self.statusLabel2.textColor = colorCode
                if !(fitlevel.isEmpty) && !(compatibilityScore.isEmpty) {
                    self.statusLabel2.text = String(format: "%@ (%@%%)", fitlevel, compatibilityScore)
                } else if !(fitlevel.isEmpty) {
                    self.statusLabel2.text = String(format: "%@", fitlevel)
                } else if !(compatibilityScore.isEmpty) {
                    self.statusLabel2.text = String(format: "%@%%", compatibilityScore)
                }
            } else {
                self.contentLabel2.text = "-"
            }
        }

        self.styleImageView.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
    }
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        self.delegate?.infoButtonCompareProductLifestyleTableViewCell(senderTag: sender.tag)
    }
}
