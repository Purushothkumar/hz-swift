//
//  RewardPointsDetailTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 15/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class RewardPointsDetailTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var descriptionLabel: Caption2FontLabel!
    @IBOutlet var countLabel: Caption2FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(step: HowToStep, indexpath: Int) {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.countLabel.text = ""
        if !(step.serviceStepName.isNilOrEmpty) {
            self.titleLabel.text = step.serviceStepName!.capitalized
        }
        if !(step.serviceDesc.isNilOrEmpty) {
            self.descriptionLabel.text = step.serviceDesc!.capitalized
        }
        if step.serviceStepOrder != nil {
            self.countLabel.text = "\(step.serviceStepOrder!)"
        }
    }
}
