//
//  ServiceCouponListContentTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 30/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ServiceCouponListContentTableViewCell: UITableViewCell {
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
    public func configure(serviceStep: ServiceStep, indexpath: Int) {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.countLabel.text = ""
        if !(serviceStep.serviceStepName.isNilOrEmpty) {
            self.titleLabel.text = serviceStep.serviceStepName!.capitalized
        }
        if !(serviceStep.serviceDesc.isNilOrEmpty) {
            self.descriptionLabel.text = serviceStep.serviceDesc!.capitalized
        }
        if serviceStep.serviceStepOrder != nil {
            self.countLabel.text = "\(serviceStep.serviceStepOrder!)"
        }
    }
}
