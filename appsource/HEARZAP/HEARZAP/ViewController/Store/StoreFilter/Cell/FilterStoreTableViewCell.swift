//
//  FilterStoreTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 27/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolFilterStoreTableViewCell {
    func viewStoreButtonFilterStoreTableViewCell(senderTag: Int)
}

class FilterStoreTableViewCell: UITableViewCell {
    @IBOutlet var mainStackView: UIStackView!
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
    
    var delegate: ProtocolFilterStoreTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    public func configure(storeList: StoreFilterModelStoreList, indexpath: Int) {
        self.viewStoreButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.viewStoreButton.layer.borderWidth = 1.0
        
        let view0 = self.stackView.arrangedSubviews[0]// experience
        let view1 = self.stackView.arrangedSubviews[1]// city name
        
        view0.isHidden = true
        view1.isHidden = false
        
        self.viewStoreButton.tag = indexpath
        self.cityNameLabel.text = ""
        self.addressLabel.text = ""
        self.storeNameLabel.text = ""
        self.mainStackView.addShadow(cornerRadius: AppConstantValue.cornerRadius4, borderWidth: 2.0, borderColor: UIColor.colorLiteral.theme_white_FFFFFF, shadowRadius: AppConstantValue.cornerRadius4, shadowOpacity: 1.0, shadowColor: UIColor.colorLiteral.theme_blue_E7F4FF)
        
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
        
        var isExperienceStore = false
        
        if !(storeList.name.isNilOrEmpty) {
            name = String(format: "%@", storeList.name!)
        }
        if !(storeList.addressLine1.isNilOrEmpty) {
            addressLine1 = String(format: "%@", storeList.addressLine1!)
        }
        if !(storeList.addressLine2.isNilOrEmpty) {
            addressLine2 = String(format: "%@", storeList.addressLine2!)
        }
        if !(storeList.storeCityArea.isNilOrEmpty) {
            storeCityArea = String(format: "%@", storeList.storeCityArea!)
        }
        if !(storeList.storeCity.isNilOrEmpty) {
            storeCity = String(format: "%@", storeList.storeCity!)
        }
        if !(storeList.storeState.isNilOrEmpty) {
            storeState = String(format: "%@", storeList.storeState!)
        }
        if !(storeList.zipcode.isNilOrEmpty) {
            zipcode = String(format: "%@", storeList.zipcode!)
        }
        if storeList.isExperienceStore != nil {
            isExperienceStore = storeList.isExperienceStore!
        }
        
        if storeList.storeWorkingHourStatus != nil {
            if !(storeList.storeWorkingHourStatus!.status.isNilOrEmpty) {
                status = String(format: "%@", storeList.storeWorkingHourStatus!.status!)
            }
            if !(storeList.storeWorkingHourStatus!.statusDescription.isNilOrEmpty) {
                statusDescription = String(format: "%@", storeList.storeWorkingHourStatus!.statusDescription!)
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
        if storeList.storeWorkingHourStatus != nil {
            if !(storeList.storeWorkingHourStatus!.status.isNilOrEmpty) {
                status = "\(String(describing: storeList.storeWorkingHourStatus!.status!))"
            }
            if !(storeList.storeWorkingHourStatus!.statusDescription.isNilOrEmpty) {
                statusDescription = "\(String(describing: storeList.storeWorkingHourStatus!.statusDescription!))"
            }
        }
        if status.lowercased() == StoreOpenCloseStatus.open.rawValue.lowercased() {
            //            self.storeStatusView.backgroundColor = UIColor.colorLiteral.theme_green_E5FFF0
            self.storeStatusLabel.textColor = UIColor.colorLiteral.theme_green_27AE60
        } else {
            //            self.storeStatusView.backgroundColor = UIColor.colorLiteral.theme_red_FFE6E4
            self.storeStatusLabel.textColor = UIColor.colorLiteral.theme_red_FF6961
        }
        self.storeStatusLabel.text = status.capitalized
        self.storeTimingLabel.text = statusDescription
    }
    @IBAction func viewStoreButtonPressed(_ sender: UIButton) {
        self.delegate?.viewStoreButtonFilterStoreTableViewCell(senderTag: sender.tag)
    }
}
