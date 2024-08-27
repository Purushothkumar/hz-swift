//
//  SRHAServiceDeviceTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 04/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SRHAServiceDeviceTableViewCell: UITableViewCell {

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
    public func configure(serviceDevice: SRDModelServiceDevice) {
        var deviceIndex = ""
        var deviceName = ""

        if !(serviceDevice.deviceName.isNilOrEmpty) {
            deviceName = serviceDevice.deviceName!
        }

        if !(serviceDevice.deviceIndex.isNilOrEmpty) {
            deviceIndex = serviceDevice.deviceIndex!
        }

        self.deviceLabel.text = deviceName
        self.deviceTitleLabel.text = deviceIndex
    }

}
