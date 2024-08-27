//
//  MetroStoreCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 26/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import SDWebImage

protocol ProtocolMetroStoreCollectionViewCell {
    func viewStoreButtonPressedMetroStoreCollectionViewCell(senderTag: Int)
}

class MetroStoreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var experienceView: UIView!
    @IBOutlet var experienceLabel: FootnoteFontLabel!
    @IBOutlet var cityNameLabel: CalloutFontLabel!
    
    @IBOutlet var storeNameLabel: FootnoteFontLabel!
    @IBOutlet var addressLabel: Caption1FontLabel!
    
    @IBOutlet var storeStatusView: UIView!
    @IBOutlet var storeTimingLabel: Caption1FontLabel!
    @IBOutlet var storeStatusLabel: FootnoteFontLabel!
    
    @IBOutlet var viewStoreButton: FootnoteOutlineButton!
    
    var delegate: ProtocolMetroStoreCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(storeList: StoreList, indexpath: Int) {
        
        let view0 = self.stackView.arrangedSubviews[0]// experience
        let view1 = self.stackView.arrangedSubviews[1]// city name
        
        view0.isHidden = true
        view1.isHidden = false
        
        self.viewStoreButton.tag = indexpath
        self.cityNameLabel.text = ""
        self.addressLabel.text = ""
        self.storeNameLabel.text = ""
        
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
        
        self.addCollectionViewCellShadow(cornerRadius: AppConstantValue.cornerRadius4, borderWidth: 2.0, borderColor: UIColor.colorLiteral.theme_white_FFFFFF, shadowRadius: AppConstantValue.cornerRadius4, shadowOpacity: 0.5, shadowColor: UIColor.colorLiteral.theme_blue_E7F4FF)
        var isExperienceStore = false
        
        if storeList.store != nil {
            if !(storeList.store!.name.isNilOrEmpty) {
                name = String(format: "%@", storeList.store!.name!)
            }
            if !(storeList.store!.addressLine1.isNilOrEmpty) {
                addressLine1 = String(format: "%@", storeList.store!.addressLine1!)
            }
            if !(storeList.store!.addressLine2.isNilOrEmpty) {
                addressLine2 = String(format: "%@", storeList.store!.addressLine2!)
            }
            if !(storeList.store!.storeCityArea.isNilOrEmpty) {
                storeCityArea = String(format: "%@", storeList.store!.storeCityArea!)
            }
            if !(storeList.store!.storeCity.isNilOrEmpty) {
                storeCity = String(format: "%@", storeList.store!.storeCity!)
            }
            if !(storeList.store!.storeState.isNilOrEmpty) {
                storeState = String(format: "%@", storeList.store!.storeState!)
            }
            if !(storeList.store!.zipcode.isNilOrEmpty) {
                zipcode = String(format: "%@", storeList.store!.zipcode!)
            }
            if storeList.store!.isExperienceStore != nil {
                isExperienceStore = storeList.store!.isExperienceStore!
            }
            
            if storeList.store!.storeWorkingHourStatus != nil {
                if !(storeList.store!.storeWorkingHourStatus!.status.isNilOrEmpty) {
                    status = String(format: "%@", storeList.store!.storeWorkingHourStatus!.status!)
                }
                if !(storeList.store!.storeWorkingHourStatus!.statusDescription.isNilOrEmpty) {
                    statusDescription = String(format: "%@", storeList.store!.storeWorkingHourStatus!.statusDescription!)
                }
            }
        }
        
        if isExperienceStore == true {
            view0.isHidden = false
            self.experienceLabel.text = AppLocalizationString.experienceStore.capitalized
            self.experienceView.backgroundColor =  UIColor.colorLiteral.theme_orange_F7732F
            self.experienceLabel.textColor = UIColor.colorLiteral.theme_white_FFFFFF
        }
        else{
            view0.isHidden = false
            self.experienceLabel.text = AppLocalizationString.store.capitalized
            self.experienceView.backgroundColor =  UIColor.colorLiteral.theme_blue_2AACEF
            self.experienceLabel.textColor = UIColor.colorLiteral.theme_white_FFFFFF
        }
        if !(storeCity.isEmpty) && !(storeCityArea.isEmpty) {
            self.cityNameLabel.text = "\(storeCityArea) - \(storeCity)"
        } else {
            if !(storeCity.isEmpty) {
                self.cityNameLabel.text = storeCity
            } else if !(storeCityArea.isEmpty) {
                self.cityNameLabel.text = storeCityArea
            }
        }
        
        if !(name.isEmpty) {
            self.storeNameLabel.text = name
        }
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
        self.storeTimingLabel.text = statusDescription
        self.viewStoreButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.viewStoreButton.layer.borderWidth = 1.0
    }
    @IBAction func viewStoreButtonPressed(_ sender: UIButton) {
        self.delegate?.viewStoreButtonPressedMetroStoreCollectionViewCell(senderTag: sender.tag)
    }
}
