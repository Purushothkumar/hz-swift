//
//  CareMaintenanceListTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 29/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCareMaintenanceListTableViewCell {
    func tapButtonPressedCareMaintenanceListTableViewCell(senderTag: Int)
}
class CareMaintenanceListTableViewCell: UITableViewCell {
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var timeLabel: Caption2FontLabel!
    @IBOutlet var tapButton: CalloutOutlineButton!

    var delegate: ProtocolCareMaintenanceListTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(careAndMaintenance: CareAndMaintenance, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.titleLabel.text = ""
        self.timeLabel.text = ""
        self.descriptionLabel.text = ""
        self.bannerImageView.setImage(imageUrl: "", placeHolderImage: hearzapPlaceholder)

        if !(careAndMaintenance.categoryName.isNilOrEmpty) {
            self.titleLabel.text = careAndMaintenance.categoryName
        }
        if !(careAndMaintenance.createdOnDate.isNilOrEmpty) {
            self.timeLabel.text = careAndMaintenance.createdOnDate
        }
        if !(careAndMaintenance.title.isNilOrEmpty) {
            self.descriptionLabel.text = "\(String(describing: careAndMaintenance.title!))"
        }
        if !(careAndMaintenance.image.isNilOrEmpty) {
            self.bannerImageView.setImage(imageUrl: careAndMaintenance.image!, placeHolderImage: hearzapPlaceholder)
        }
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedCareMaintenanceListTableViewCell(senderTag: sender.tag)
    }
}
