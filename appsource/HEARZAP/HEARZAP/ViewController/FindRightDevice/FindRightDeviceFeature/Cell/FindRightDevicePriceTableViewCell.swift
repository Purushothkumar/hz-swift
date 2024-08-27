//
//  FindRightDevicePriceTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 14/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
protocol ProtocolFindRightDevicePriceTableViewCell {
    func selectButtonPressedFindRightDevicePriceTableViewCell(senderTag: Int)
}

class FindRightDevicePriceTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!
    @IBOutlet var bannerview: UIView!
    @IBOutlet var selectButton: FootnoteOutlineButton!
    
    var delegate: ProtocolFindRightDevicePriceTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(technology: FindRightDeviceFeatureModelTechnology, indexPath: Int, technologyID: String, viewCon: FindRightDeviceFeatureViewController) {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.selectButton.tag = indexPath
        self.bannerview.clipsToBounds = true
        self.bannerview.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.bannerview.layer.borderColor = UIColor.colorLiteral.theme_blue_E7F4FF.cgColor
        self.bannerview.layer.borderWidth = 2.0
        self.bannerview.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        var priceStartRange = ""
        var priceEndRange = ""
        var priceRange = ""
        if technology.priceStartRange != nil {
            priceStartRange = "\(AppConstantValue.rupeesymbol)\(String(describing: technology.priceStartRange!))"
        }
        if technology.priceEndRange != nil {
            priceEndRange = "\(AppConstantValue.rupeesymbol)\(String(describing: technology.priceEndRange!))"
        }
        if !(technology.name.isNilOrEmpty) {
            self.titleLabel.text = technology.name!.capitalized
        }
        
        if !(priceStartRange.isEmpty) && !(priceEndRange.isEmpty) {
            priceRange = "\(priceStartRange) - \(priceEndRange)"
        } else {
            if !(priceStartRange.isEmpty) && !(priceEndRange.isEmpty) {
                priceRange = "\(AppLocalizationString.above.capitalized) \(priceStartRange)"
            } else if !(priceEndRange.isEmpty) {
                priceRange = "\(AppLocalizationString.below.capitalized) \(priceEndRange)"
            }
        }
        self.descriptionLabel.text = priceRange
        if technology.id != nil {
            let id = String(format: "%d", technology.id!)
            if !(technologyID.isEmpty) {
                if id.isEqualToString(find: technologyID) {
                    self.bannerview.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                    self.bannerview.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
                    viewCon.scrolltoAditionalFeatures()
                }
            }
        }
    }
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedFindRightDevicePriceTableViewCell(senderTag: sender.tag)
    }
}
