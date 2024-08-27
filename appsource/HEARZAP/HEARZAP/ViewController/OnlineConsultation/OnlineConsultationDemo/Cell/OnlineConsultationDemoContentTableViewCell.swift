//
//  OnlineConsultationDemoContentTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class OnlineConsultationDemoContentTableViewCell: UITableViewCell {
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
    public func configure(ocSteps: OcStep, indexpath: Int) {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.countLabel.text = ""
        if !(ocSteps.serviceStepName.isNilOrEmpty) {
            self.titleLabel.text = ocSteps.serviceStepName!.capitalized
        }
        if !(ocSteps.serviceDesc.isNilOrEmpty) {
            self.descriptionLabel.text = ocSteps.serviceDesc!.capitalized
        }
        if ocSteps.serviceStepOrder != nil {
            self.countLabel.text = "\(ocSteps.serviceStepOrder!)"
        }
    }
}
