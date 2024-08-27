//
//  ReturnReasonProductTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 11/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ReturnReasonProductTableViewCell: UITableViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var deviceNameLabel: Caption1FontLabel!
    @IBOutlet var productbrandLabel: Caption1FontLabel!
    @IBOutlet var productCodeLabel: Caption1FontLabel!

    var delegate: ProtocolBottomSheetAddDeviceTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func configure(device: OrderItemList, indexpath: Int) {
        var deviceName = ""
        var deviceBrand = ""
        var deviceCode = ""
        var deviceImage = ""
        let placeHolderImage: UIImage = UIImage(named: Asset.registereddeviceblue)!

        if !(device.productName.isNilOrEmpty) {
            deviceName = device.productName!.capitalized
        }
        if !(device.brandName.isNilOrEmpty) {
            deviceBrand = device.brandName!.capitalized
        }
        if device.qty != nil {
            deviceCode = String(format: "  %@%d  ", AppLocalizationString.qty, device.qty!)
        }
        if !(device.itemImage.isNilOrEmpty) {
            deviceImage = device.itemImage!
        }

        self.deviceNameLabel.text = deviceName
        self.productbrandLabel.text = deviceBrand
        self.productCodeLabel.text = deviceCode
        self.productImageView.setImage(imageUrl: deviceImage, placeHolderImage: placeHolderImage)
    }
}
