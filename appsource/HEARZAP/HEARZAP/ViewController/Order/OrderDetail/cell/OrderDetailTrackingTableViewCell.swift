//
//  OrderDetailTrackingTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 10/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class OrderDetailTrackingTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var dateLabel: Caption1FontLabel!
    @IBOutlet var topLabel: Caption1FontLabel!
    @IBOutlet var bottomLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(statusList: StatusList, indexpath: Int, totalArrayCount: Int) {
        self.topLabel.isHidden = false
        self.bottomLabel.isHidden = false

        if totalArrayCount == 1 {
            self.topLabel.isHidden = true
            self.bottomLabel.isHidden = true
        } else if indexpath == 0 {
            self.topLabel.isHidden = true
            self.layoutSubviews()
        } else if indexpath == totalArrayCount - 1 {
            self.bottomLabel.isHidden = true
        }

        var statusName = ""
        var createdOn = ""

        if !(statusList.statusName.isNilOrEmpty) {
            statusName = statusList.statusName!
        }

        if !(statusList.createdOn.isNilOrEmpty) {
            createdOn = statusList.createdOn!
        }

        self.titleLabel.text = statusName
        self.dateLabel.text = createdOn

    }
    @IBAction func quantityButtonPressed(_ sender: UIButton) {
    }
}
