//
//  RegisterDeviceSpecificationsTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 08/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class RegisterDeviceSpecificationsTableViewCell: UITableViewCell {

    @IBOutlet var stackview: UIStackView!
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var descriptionlabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(spec: RegisterDeviceModelProductSpecification, indexPath: Int) {
        self.titleLabel.text = ""
        self.descriptionlabel.text = "-"

        if !(spec.key.isNilOrEmpty) {
            self.titleLabel.text = spec.key!.capitalized
            if !(spec.value.isNilOrEmpty) {
                self.descriptionlabel.text = spec.value!.capitalized
            }
        }
    }
}
