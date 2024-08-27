//
//  BottomSheetReturnProductTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 11/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolBottomSheetReturnProductTableViewCell {
    func selectButtonPressedBottomSheetReturnProductTableViewCell(senderTag: Int)
}

class BottomSheetReturnProductTableViewCell: UITableViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var deviceNameLabel: Caption1FontLabel!
    @IBOutlet var productbrandLabel: Caption1FontLabel!
    @IBOutlet var productCodeLabel: Caption1FontLabel!
    @IBOutlet var tapButton: CalloutOutlineButton!
    @IBOutlet var checkedImage: UIImageView!
    @IBOutlet var gradiantlayer: UIView!

    var delegate: ProtocolBottomSheetReturnProductTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func configure(device: OrderItemList, indexpath: Int, viewCon: BottomSheetReturnProductViewController) {
        var deviceName = ""
        var deviceBrand = ""
        var deviceCode = ""
        var deviceImage = ""
        var id = ""
        self.gradiantlayer.isHidden = true

        self.tapButton.tag = indexpath
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
        if device.itemID != nil {
            id = String(format: "%d", device.itemID!)
        }
        self.deviceNameLabel.text = deviceName
        self.productbrandLabel.text = deviceBrand
        self.productCodeLabel.text = deviceCode
        self.productImageView.setImage(imageUrl: deviceImage, placeHolderImage: placeHolderImage)
        self.checkedImage.image = UIImage(named: Asset.checksquareblue)
        if viewCon.selectArray.contains(id) {
            self.checkedImage.image = UIImage(named: Asset.checksquareblueFill)
        }
        if device.canShowInReturn == false {
            self.gradiantlayer.isHidden = false
        }
    }
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedBottomSheetReturnProductTableViewCell(senderTag: sender.tag)
    }
}
