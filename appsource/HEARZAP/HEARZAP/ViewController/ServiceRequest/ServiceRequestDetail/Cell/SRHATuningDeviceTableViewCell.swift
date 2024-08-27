//
//  SRHATuningDeviceTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 02/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SRHATuningDeviceTableViewCell: UITableViewCell {

    @IBOutlet var deviceTitleLabel: Caption1FontLabel!
    @IBOutlet var deviceLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(tuningComplaint: SRDModelTuningComplaint) {
        var deviceName = ""
        var deviceIndex = ""

        if !(tuningComplaint.deviceName.isNilOrEmpty) {
            deviceName = tuningComplaint.deviceName!
        }

        if !(tuningComplaint.deviceIndex.isNilOrEmpty) {
            deviceIndex = tuningComplaint.deviceIndex!
        }

        self.deviceLabel.text = deviceName
        self.deviceTitleLabel.text = deviceIndex
    }
}
