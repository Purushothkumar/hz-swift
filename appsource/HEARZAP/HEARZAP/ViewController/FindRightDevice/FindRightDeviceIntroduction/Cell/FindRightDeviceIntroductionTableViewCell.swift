//
//  FindRightDeviceIntroductionTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 08/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class FindRightDeviceIntroductionTableViewCell: UITableViewCell {
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
    public func configure(step: Step, indexPath: Int) {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.countLabel.text = "\(indexPath + 1) "
        if !(step.serviceStepName.isNilOrEmpty) {
            self.titleLabel.text = step.serviceStepName!.capitalized
        }
        if !(step.serviceStepDescription.isNilOrEmpty) {
            self.descriptionLabel.text = step.serviceStepDescription!.capitalized
        }
    }
}
