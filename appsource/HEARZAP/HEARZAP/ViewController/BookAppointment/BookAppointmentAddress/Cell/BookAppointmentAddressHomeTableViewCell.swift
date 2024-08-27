//
//  BookAppointmentAddressHomeTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 24/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolBookAppointmentAddressHomeTableViewCell {
    func selectButtonPressedBookAppointmentAddressHomeTableViewCell(senderTag: Int)
}

class BookAppointmentAddressHomeTableViewCell: UITableViewCell {
    
    @IBOutlet var selectionView: UIView!
    @IBOutlet var addressStackView: UIStackView!
    
    @IBOutlet var nameLabel: FootnoteFontLabel!
    @IBOutlet var addressLabel: Caption1FontLabel!
    
    @IBOutlet var addressTypeView: UIView!
    @IBOutlet var addressTypeLabel: Caption1FontLabel!
    
    @IBOutlet var checkButton: FootnoteOutlineButton!
    
    @IBOutlet var selectButton: FootnoteOutlineButton!
    
    var delegate: ProtocolBookAppointmentAddressHomeTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(address: AddressDatum, indexpath: Int, addressID: String, viewCon: BookAppointmentAddressViewController) {
        self.selectButton.tag = indexpath
        self.addressTypeView.isHidden = true
        
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
        var isPrimary = false
        var homeID = ""
        
        if address.id != nil {
            homeID = String(format: "%d", address.id!)
        }
        if address.isPrimary != nil {
            isPrimary = address.isPrimary!
        }
        if !(address.customerName.isNilOrEmpty) {
            customerName = address.customerName!
        }
        // address2
        if !(customerName.isEmpty) && (isPrimary == true) {
            customerName = "\(customerName) \(AppLocalizationString.defaultPrimary)"
        } else if (customerName.isEmpty) && (isPrimary == true) {
            customerName = AppLocalizationString.defaultPrimary
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
            self.addressTypeView.isHidden = false
        }
        self.addressTypeLabel.text = addressType
        
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
        
        self.addressStackView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.nameLabel.textColor = UIColor.colorLiteral.theme_black_333333
        self.nameLabel.font = AppFont.regular.size(13)
        
        self.addressStackView.clipsToBounds = true
        self.addressStackView.layer.borderWidth = 1.0
        self.addressStackView.layer.borderColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        
        self.checkButton.clipsToBounds = true
        self.checkButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        
        self.checkButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        
        self.checkButton.clipsToBounds = true
        self.checkButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.checkButton.setImage(UIImage(named: Asset.circleblue), for: .normal)
        self.checkButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        
        if !(homeID.isEmpty) {
            if homeID == addressID {
                self.checkButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
                self.checkButton.setImage(UIImage(named: Asset.circlelightbluethick), for: .normal)
                
                self.addressStackView.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
                self.nameLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
                self.nameLabel.font = AppFont.semibold.size(13)
                viewCon.scrolltoStore()
            }
        }
    }
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedBookAppointmentAddressHomeTableViewCell(senderTag: sender.tag)
        
    }
}
