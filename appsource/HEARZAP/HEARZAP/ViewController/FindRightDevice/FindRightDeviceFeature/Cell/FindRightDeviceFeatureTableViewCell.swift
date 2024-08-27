//
//  FindRightDeviceFeatureTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 14/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class FindRightDeviceFeatureTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var avialableImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(feature: FindRightDeviceFeatureModelFeature, indexPath: Int) {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.avialableImageView.image = UIImage(named: Asset.xlargered)
        
        if feature.isAvailable != nil {
            if feature.isAvailable == true {
                self.avialableImageView.image = UIImage(named: Asset.checklightblue)
            } else {
                self.avialableImageView.image = UIImage(named: Asset.xlargered)
            }
        }
        if !(feature.name.isNilOrEmpty) {
            self.titleLabel.text = feature.name!.capitalized
        }
        //        if !(feature.featureDescription.isNilOrEmpty) {
        //            self.descriptionLabel.text = feature.featureDescription!.capitalized
        //        }
        if feature.tagsList !=  nil {
            var combination = NSMutableAttributedString()
            var index = 0
            if feature.tagsList!.count > 0 {
                for item in feature.tagsList! {
                    let normalFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
                    let selectedFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_green_27AE60, NSAttributedString.Key.font: AppFont.regular.size(13)]
                    
                    if !(item.name.isNilOrEmpty) {
                        if index > 0 {
                            let normaltext = NSMutableAttributedString(string: " / ", attributes: normalFontAttributes as [NSAttributedString.Key: Any])
                            combination.append(normaltext)
                        }
                        if item.isSelected == true {
                            let highlighttext = NSMutableAttributedString(string: String(format: "%@", item.name!.capitalized), attributes: selectedFontAttributes as [NSAttributedString.Key: Any])
                            combination.append(highlighttext)
                            index += 1
                        } else {
                            let normaltext = NSMutableAttributedString(string: String(format: "%@", item.name!.capitalized), attributes: normalFontAttributes as [NSAttributedString.Key: Any])
                            combination.append(normaltext)
                            index += 1
                        }
                    }
                }
                self.descriptionLabel.attributedText = combination
            }
        }
    }
}
