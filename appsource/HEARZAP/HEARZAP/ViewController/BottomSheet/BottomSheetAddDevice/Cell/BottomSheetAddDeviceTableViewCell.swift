//
//  BottomSheetAddDeviceTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 24/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolBottomSheetAddDeviceTableViewCell {
    func selectButtonPressedBottomSheetAddDeviceTableViewCell(senderTag: Int)
}

class BottomSheetAddDeviceTableViewCell: UITableViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var deviceNameLabel: Caption1FontLabel!
    @IBOutlet var productbrandLabel: Caption1FontLabel!
    @IBOutlet var productCodeLabel: Caption1FontLabel!
    @IBOutlet var tapButton: CalloutOutlineButton!
    @IBOutlet var checkedImage: UIImageView!

    var delegate: ProtocolBottomSheetAddDeviceTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func configure(device: RegisterDeviceModelDeviceData, indexpath: Int, viewCon: BottomSheetAddDeviceViewController) {
        var deviceName = ""
        var deviceBrand = ""
        var deviceModel = ""
        var deviceImage = ""
        var id = ""
        self.tapButton.tag = indexpath
        let placeHolderImage: UIImage = UIImage(named: Asset.registereddeviceblue)!

        if !(device.deviceName.isNilOrEmpty) {
            deviceName = device.deviceName!.capitalized
        }
        if !(device.deviceBrand.isNilOrEmpty) {
            deviceBrand = device.deviceBrand!.capitalized
        }
        if !(device.deviceModel.isNilOrEmpty) {
            deviceModel = device.deviceModel!.capitalized
        }

        if !(device.deviceImage.isNilOrEmpty) {
            deviceImage = device.deviceImage!
        }
        if device.id != nil {
            id = String(format: "%d", device.id!)
        }
        self.deviceNameLabel.text = deviceName
        self.productbrandLabel.text = deviceBrand
        self.productCodeLabel.text = deviceModel
        self.productImageView.setImage(imageUrl: deviceImage, placeHolderImage: placeHolderImage)
        self.checkedImage.image = UIImage(named: Asset.checksquareblue)
        if viewCon.selectArray.contains(id) {
            self.checkedImage.image = UIImage(named: Asset.checksquareblueFill)
        }
    }

    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedBottomSheetAddDeviceTableViewCell(senderTag: sender.tag)
    }
}
