//
//  BuyBackContentTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 21/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BuyBackContentTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var descriptionLabel: Caption2FontLabel!
    @IBOutlet var bannerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(buybackStep: BuybackStep, indexPath: Int) {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        if !(buybackStep.serviceStepName.isNilOrEmpty) {
            self.titleLabel.text = buybackStep.serviceStepName!.capitalized
        }
        if !(buybackStep.serviceDesc.isNilOrEmpty) {
            self.descriptionLabel.text = buybackStep.serviceDesc!.capitalized
        }
    }
}
