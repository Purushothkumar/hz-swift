//
//  BookAppointmentAddressStoreTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 24/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolBookAppointmentAddressStoreTableViewCell {
    func selectButtonPressedBookAppointmentAddressStoreTableViewCell(senderTag: Int)
}

class BookAppointmentAddressStoreTableViewCell: UITableViewCell {
    
    @IBOutlet var selectionView: UIView!
    @IBOutlet var addressStackView: UIStackView!
    
    @IBOutlet var nameLabel: Caption1FontLabel!
    @IBOutlet var addressLabel: Caption1FontLabel!
    @IBOutlet var statusLabel: Caption1FontLabel!
    
    @IBOutlet var storeStatusView: UIView!
    @IBOutlet var storeStatusLabel: Caption1FontLabel!
    @IBOutlet var checkButton: FootnoteOutlineButton!
    
    @IBOutlet var selectButton: FootnoteOutlineButton!
    
    var delegate: ProtocolBookAppointmentAddressStoreTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(storeDeliveryAddressModelStoreList: StoreDeliveryAddressModelStoreList, indexpath: Int, storeUID: String, viewCon: BookAppointmentAddressViewController) {
        self.selectButton.tag = indexpath
        self.nameLabel.text = ""
        self.addressLabel.text = ""
        var storeAddress = ""
        var name = ""
        var addressLine1 = ""
        var addressLine2 = ""
        var storeCityArea = ""
        var storeCity = ""
        var storeState = ""
        var zipcode = ""
        var status = ""
        var statusDescription = ""
        var storeIDCurrent = ""
        var uid = ""
        
        self.addressStackView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.nameLabel.textColor = UIColor.colorLiteral.theme_black_333333
        self.nameLabel.font = AppFont.regular.size(13)
        
        if storeDeliveryAddressModelStoreList.store != nil {
            let store = storeDeliveryAddressModelStoreList.store!
            if store.id != nil {
                storeIDCurrent = String(format: "%d", store.id!)
            }
            if !(store.uid.isNilOrEmpty) {
                uid = String(format: "%@", store.uid!)
            }
            if !(store.name.isNilOrEmpty) {
                name = String(format: "%@", store.name!)
            }
            if !(store.addressLine1.isNilOrEmpty) {
                addressLine1 = String(format: "%@", store.addressLine1!)
            }
            if !(store.addressLine2.isNilOrEmpty) {
                addressLine2 = String(format: "%@", store.addressLine2!)
            }
            if !(store.storeCityArea.isNilOrEmpty) {
                storeCityArea = String(format: "%@", store.storeCityArea!)
            }
            if !(store.storeCity.isNilOrEmpty) {
                storeCity = String(format: "%@", store.storeCity!)
            }
            if !(store.storeState.isNilOrEmpty) {
                storeState = String(format: "%@", store.storeState!)
            }
            if !(store.zipcode.isNilOrEmpty) {
                zipcode = String(format: "%@", store.zipcode!)
            }
            if store.storeWorkingHourStatus != nil {
                if !(store.storeWorkingHourStatus!.status.isNilOrEmpty) {
                    status = String(format: "%@", store.storeWorkingHourStatus!.status!)
                }
                if !(store.storeWorkingHourStatus!.statusDescription.isNilOrEmpty) {
                    statusDescription = String(format: "%@", store.storeWorkingHourStatus!.statusDescription!)
                }
            }
        }
        self.nameLabel.text = name
        
        if !(addressLine1.isEmpty) {
            storeAddress = addressLine1
        }
        if !(addressLine2.isEmpty) && !(storeAddress.isEmpty) {
            storeAddress = "\(storeAddress) \(addressLine2)"
        } else if !(addressLine2.isEmpty) {
            storeAddress = addressLine2
        }
        if !(storeCityArea.isEmpty) && !(storeAddress.isEmpty) {
            storeAddress = "\(storeAddress) \(storeCityArea)"
        } else if !(storeCityArea.isEmpty) {
            storeAddress = storeCityArea
        }
        if !(storeCity.isEmpty) && !(storeAddress.isEmpty) {
            storeAddress = "\(storeAddress) \(storeCity)"
        } else if !(storeCity.isEmpty) {
            storeAddress = storeCity
        }
        if !(storeState.isEmpty) && !(storeAddress.isEmpty) {
            storeAddress = "\(storeAddress) \(storeState)"
        } else  if !(storeState.isEmpty) {
            storeAddress = storeState
        }
        if !(zipcode.isEmpty) && !(storeAddress.isEmpty) {
            storeAddress = "\(storeAddress) - \(zipcode)"
        } else if !(zipcode.isEmpty) {
            storeAddress = zipcode
        }
        self.addressLabel.text = storeAddress
        
        if status.lowercased() == StoreOpenCloseStatus.open.rawValue.lowercased() {
            //            self.storeStatusView.backgroundColor = UIColor.colorLiteral.theme_green_E5FFF0
            self.storeStatusLabel.textColor = UIColor.colorLiteral.theme_green_27AE60
        } else {
            //            self.storeStatusView.backgroundColor = UIColor.colorLiteral.theme_red_FFE6E4
            self.storeStatusLabel.textColor = UIColor.colorLiteral.theme_red_FF6961
        }
        self.storeStatusLabel.text = status.capitalized
        self.statusLabel.text = statusDescription.capitalized
        self.addressStackView.clipsToBounds = true
        self.addressStackView.layer.borderWidth = 1.0
        self.addressStackView.layer.borderColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        
        self.checkButton.clipsToBounds = true
        self.checkButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.checkButton.setImage(UIImage(named: Asset.circleblue), for: .normal)
        self.checkButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        if !(uid.isEmpty) {
            if uid == storeUID {
                self.checkButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
                self.checkButton.setImage(UIImage(named: Asset.circlelightbluethick), for: .normal)
                self.addressStackView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                self.addressStackView.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
                self.nameLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
                self.nameLabel.font = AppFont.semibold.size(13)
                if !(viewCon.addressID.isEmpty) && (DeliveryType.home.rawValue == viewCon.deliveryType) {
                    viewCon.scrolltoDateSlot()
                } else if DeliveryType.store.rawValue == viewCon.deliveryType {
                    viewCon.scrolltoDateSlot()
                }
            }
        }
    }
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedBookAppointmentAddressStoreTableViewCell(senderTag: sender.tag)
    }
}
