//
//  SRHAServiceQuoteTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 04/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SRHAServiceQuoteTableViewCell: UITableViewCell {

    @IBOutlet var deviceTitleLabel: Caption1FontLabel!
    @IBOutlet var deviceQuoteLabel: Caption1FontLabel!

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
        var deviceRevisedQuoteAmount = ""

        if !(serviceDevice.deviceIndex.isNilOrEmpty) {
            deviceIndex = serviceDevice.deviceIndex!
        }

        if !(serviceDevice.deviceRevisedQuoteAmount.isNilOrEmpty) {
            deviceRevisedQuoteAmount = serviceDevice.deviceRevisedQuoteAmount!
        }

        self.deviceTitleLabel.text = deviceIndex
        self.deviceQuoteLabel.text = deviceRevisedQuoteAmount
    }
}
