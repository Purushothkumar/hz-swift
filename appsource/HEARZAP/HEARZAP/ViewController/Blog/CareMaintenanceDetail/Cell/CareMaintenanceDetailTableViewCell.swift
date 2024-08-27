//
//  CareMaintenanceDetailTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 29/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCareMaintenanceDetailTableViewCell {
    func tapButtonPressedCareMaintenanceDetailTableViewCell(senderTag: Int)
}
class CareMaintenanceDetailTableViewCell: UITableViewCell {
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var timeLabel: Caption2FontLabel!
    @IBOutlet var tapButton: CalloutOutlineButton!

    var delegate: ProtocolCareMaintenanceDetailTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(careMaintenanceDetailModel: CareMaintenanceDetailModelCareAndMaintenance, indexpath: Int) {
        self.tapButton.tag = indexpath
        var imgurl = ""

        self.titleLabel.text = ""
        self.timeLabel.text = ""
        self.descriptionLabel.text = ""
        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)

        if !(careMaintenanceDetailModel.categoryName.isNilOrEmpty) {
            self.titleLabel.text = careMaintenanceDetailModel.categoryName
        }
        if !(careMaintenanceDetailModel.createdOnDate.isNilOrEmpty) {
            self.timeLabel.text = careMaintenanceDetailModel.createdOnDate
        }
        if !(careMaintenanceDetailModel.title.isNilOrEmpty) {
            self.descriptionLabel.text = careMaintenanceDetailModel.title
        }
        if !(careMaintenanceDetailModel.image.isNilOrEmpty) {
            imgurl = careMaintenanceDetailModel.image!
        }
        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedCareMaintenanceDetailTableViewCell(senderTag: sender.tag)
    }
}
