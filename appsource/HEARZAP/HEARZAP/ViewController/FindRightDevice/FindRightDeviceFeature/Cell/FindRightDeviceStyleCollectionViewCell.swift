//
//  FindRightDeviceStyleCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 14/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolFindRightDeviceStyleCollectionViewCell {
    func selectButtonPressedFindRightDeviceStyleCollectionViewCell(senderTag: Int)
    func infoButtonPressedFindRightDeviceStyleCollectionViewCell(senderTag: Int)
}
class FindRightDeviceStyleCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var selectButton: FootnoteOutlineButton!
    @IBOutlet var infoButton: FootnoteOutlineButton!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var titleview: UIView!
    
    var delegate: ProtocolFindRightDeviceStyleCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func configure(findRightDeviceFeatureModelModel: FindRightDeviceFeatureModelModel, indexPath: Int, modelSelectedArray: [Int]) {
        self.titleLabel.text = ""
        var imgurl = ""
        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
        self.infoButton.tag = indexPath
        self.selectButton.tag = indexPath
        
        self.bannerImageView.clipsToBounds = true
        self.bannerImageView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.bannerImageView.layer.borderColor = UIColor.colorLiteral.theme_blue_E7F4FF.cgColor
        self.bannerImageView.layer.borderWidth = 1.0
        
        self.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.layer.borderColor = UIColor.colorLiteral.theme_blue_E7F4FF.cgColor
        self.layer.borderWidth = 2.0
        
        self.titleview.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        
        if findRightDeviceFeatureModelModel.id != nil {
            let id = findRightDeviceFeatureModelModel.id!
            if modelSelectedArray.count > 0 {
                if modelSelectedArray.contains(id) {
                    self.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                    self.titleview.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
                }
            }
        }
        if !(findRightDeviceFeatureModelModel.name.isNilOrEmpty) {
            self.titleLabel.text = findRightDeviceFeatureModelModel.name!.capitalized
        }
        if findRightDeviceFeatureModelModel.image != nil {
            if !(findRightDeviceFeatureModelModel.image!.isEmpty) {
                imgurl = (findRightDeviceFeatureModelModel.image)!
                self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
            }
        }
    }
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        self.delegate?.infoButtonPressedFindRightDeviceStyleCollectionViewCell(senderTag: sender.tag)
    }
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedFindRightDeviceStyleCollectionViewCell(senderTag: sender.tag)
    }
}
