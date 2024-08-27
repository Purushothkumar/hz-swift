//
//  SRTrackingTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 02/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SRTrackingTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var dateLabel: Caption1FontLabel!
    @IBOutlet var commentLabel: Caption1FontLabel!
    @IBOutlet var topLabel: Caption1FontLabel!
    @IBOutlet var bottomLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(serviceTimeline: SRDModelServiceTimeline, indexpath: Int, totalArrayCount: Int) {
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
        var description = ""

        if !(serviceTimeline.statusName.isNilOrEmpty) {
            statusName = serviceTimeline.statusName!
        }
        if !(serviceTimeline.description.isNilOrEmpty) {
            description = serviceTimeline.description!
        }
        if !(serviceTimeline.createdOn.isNilOrEmpty) {
            createdOn = serviceTimeline.createdOn!
        }

        self.titleLabel.text = statusName
        self.dateLabel.text = createdOn
        self.commentLabel.text = description

    }

}
