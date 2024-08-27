//
//  FindRightDeviceStyleTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 14/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolFindRightDeviceStyleTableViewCell {
    func detailButtonFindRightDeviceStyleTableViewCell(senderTag: Int)
    func selectButtonFindRightDeviceStyleTableViewCell(senderTag: Int)
}
class FindRightDeviceStyleTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: FootnoteFontLabel!
    @IBOutlet var descriptionLabel: Caption2FontLabel!
    @IBOutlet var detailButton: FootnoteOutlineButton!
    @IBOutlet var selectButton: FootnoteOutlineButton!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var stackview: UIStackView!
    
    var delegate: ProtocolFindRightDeviceStyleTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectButton.setTitle(AppLocalizationString.select.uppercased(), for: .normal)
        self.selectButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.selectButton.layer.borderWidth = 1.0
        self.detailButton.setTitle(AppLocalizationString.viewDetails.capitalized, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    public func configure(findRightDeviceStyleModelLifestyle: FindRightDeviceStyleModelLifestyle, indexPath: Int) {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.selectButton.tag = indexPath
        self.detailButton.tag = indexPath
        var imgurl = ""
        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
        self.selectButton.setTitle(AppLocalizationString.select.uppercased(), for: .normal)
        self.selectButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.selectButton.layer.borderWidth = 1.0
        
        let view0 = self.stackview.arrangedSubviews[0]// title
        let view1 = self.stackview.arrangedSubviews[1]// description
        view0.isHidden = true
        view1.isHidden = true
        self.detailButton.isHidden = true
        if !(findRightDeviceStyleModelLifestyle.lifestyleDescription.isNilOrEmpty) {
            self.descriptionLabel.text = findRightDeviceStyleModelLifestyle.lifestyleDescription!.capitalized
            view0.isHidden = false
        }
        if !(findRightDeviceStyleModelLifestyle.name.isNilOrEmpty) {
            self.titleLabel.text = findRightDeviceStyleModelLifestyle.name!.capitalized
            view1.isHidden = false
        }
        if findRightDeviceStyleModelLifestyle.situation != nil {
            if findRightDeviceStyleModelLifestyle.situation!.count > 0 {
                self.detailButton.isHidden = false
            }
        }
        if findRightDeviceStyleModelLifestyle.image != nil {
            if !(findRightDeviceStyleModelLifestyle.image!.isEmpty) {
                imgurl = (findRightDeviceStyleModelLifestyle.image)!
            }
        }
        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
    }
    @IBAction func detailButtonPressed(_ sender: UIButton) {
        self.delegate?.detailButtonFindRightDeviceStyleTableViewCell(senderTag: sender.tag)
    }
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonFindRightDeviceStyleTableViewCell(senderTag: sender.tag)
    }
}
