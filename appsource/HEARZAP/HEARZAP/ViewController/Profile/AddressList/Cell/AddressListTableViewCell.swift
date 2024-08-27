//
//  AddressListTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolAddressListTableViewCell {
    func editButtonPressedAddressListTableViewCell(senderTag: Int)
    func deleteButtonPressedAddressListTableViewCell(senderTag: Int)
}
class AddressListTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: FootnoteFontLabel!
    @IBOutlet var addressLabel: Caption1FontLabel!
    @IBOutlet var numberLabel: Caption1FontLabel!

    @IBOutlet var typeButton: FootnoteOutlineButton!
    @IBOutlet var editButton: FootnoteOutlineButton!
    @IBOutlet var deleteButton: FootnoteOutlineButton!

    var delegate: ProtocolAddressListTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(address: AddressDatum, indexpath: Int) {
        self.editButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.editButton.layer.borderWidth = 1.0
        self.editButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.editButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.editButton.clipsToBounds = true
        self.editButton.setTitle(AppLocalizationString.edit.uppercased(), for: .normal)
        self.editButton.tag = indexpath

        self.deleteButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.deleteButton.layer.borderWidth = 1.0
        self.deleteButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.deleteButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.deleteButton.clipsToBounds = true
        self.deleteButton.setTitle(AppLocalizationString.delete.uppercased(), for: .normal)
        self.deleteButton.tag = indexpath

        self.typeButton.isHidden = true

        var customerName = ""
        var customerAddress = ""
        var customerNumber = ""

        var address1 = ""
        var address2 = ""
        var address3 = ""
        var city = ""
        var state = ""
        var zipcode = ""
        var addressType = ""

        if !(address.customerName.isNilOrEmpty) {
            customerName = address.customerName!
        }
        if !(address.mobile.isNilOrEmpty) {
            customerNumber = String(format: "%@ %@", AppLocalizationString.mobileNumber, address.mobile!)
        }
        if !(address.address1.isNilOrEmpty) {
            address1 = address.address1!
        }
        if !(address.address2.isNilOrEmpty) {
            address2 = address.address2!
        }
        if !(address.address3.isNilOrEmpty) {
            address3 = address.address3!
        }
        if !(address.city.isNilOrEmpty) {
            city = address.city!
        }
        if !(address.state.isNilOrEmpty) {
            state = address.state!
        }
        if address.zipcode != nil {
            zipcode = String(format: "%d", address.zipcode!)
        }
        if !(address.addressType.isNilOrEmpty) {
            addressType = address.addressType!
            self.typeButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            self.typeButton.layer.borderWidth = 1.0
            self.typeButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
            self.typeButton.layer.cornerRadius = AppConstantValue.cornerRadius4
            self.typeButton.clipsToBounds = true
            self.typeButton.setTitle("  \(addressType)  ", for: .normal)
            self.typeButton.isHidden = false
        }
        // address1
        if !(address1.isEmpty) {
            customerAddress = "\(address1)"
        }
        // address2
        if !(customerAddress.isEmpty) && !(address2.isEmpty) {
            customerAddress = "\(customerAddress) \(address2)"
        } else if (customerAddress.isEmpty) && !(address2.isEmpty) {
            customerAddress = "\(address2)"
        }
        // address3
        if !(customerAddress.isEmpty) && !(address3.isEmpty) {
            customerAddress = "\(customerAddress) \(address3)"
        } else if (customerAddress.isEmpty) && !(address3.isEmpty) {
            customerAddress = "\(address3)"
        }
        // city
        if !(customerAddress.isEmpty) && !(city.isEmpty) {
            customerAddress = "\(customerAddress) \(city)"
        } else if (customerAddress.isEmpty) && !(city.isEmpty) {
            customerAddress = "\(city)"
        }
        // state
        if !(customerAddress.isEmpty) && !(state.isEmpty) {
            customerAddress = "\(customerAddress) \(state)"
        } else if (customerAddress.isEmpty) && !(state.isEmpty) {
            customerAddress = "\(state)"
        }
        // zipcode
        if !(customerAddress.isEmpty) && !(zipcode.isEmpty) {
            customerAddress = "\(customerAddress) - \(zipcode)"
        } else if (customerAddress.isEmpty) && !(zipcode.isEmpty) {
            customerAddress = "\(zipcode)"
        }

        self.nameLabel.text = customerName
        self.addressLabel.text = customerAddress
        self.numberLabel.text = customerNumber
    }

    @IBAction func editButtonPressed(_ sender: UIButton) {
        self.delegate?.editButtonPressedAddressListTableViewCell(senderTag: sender.tag)
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        self.delegate?.deleteButtonPressedAddressListTableViewCell(senderTag: sender.tag)
    }
}
