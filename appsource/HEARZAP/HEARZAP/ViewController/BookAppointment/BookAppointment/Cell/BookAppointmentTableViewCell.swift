//
//  BookAppointmentTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 23/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolBookAppointmentTableViewCell {
    func detailButtonPressedBookAppointmentTableViewCell(senderTag: Int)
    func selectButtonPressedBookAppointmentTableViewCell(senderTag: Int)
}
class BookAppointmentTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: SubheadFontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!
    @IBOutlet var priceLabel: Caption1FontLabel!
    @IBOutlet var selectLabel: Caption1FontLabel!
    @IBOutlet var detailButton: FootnoteOutlineButton!
    @IBOutlet var selectButton: FootnoteBackgroundButton!
    @IBOutlet var stackview: UIStackView!
    
    var delegate: ProtocolBookAppointmentTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    public func configure(service: ServiceList, indexPath: Int, viewCon: BookAppointmentViewController) {
        self.selectButton.tag = indexPath
        self.detailButton.tag = indexPath
        var serviceName = ""
        var serviceCharge = ""
        var serviceDescription = ""
        var isDeviceNeeded = false
        var id = ""
        
        if service.isDeviceNeeded != nil {
            isDeviceNeeded = service.isDeviceNeeded!
        }
        if !(service.serviceName.isNilOrEmpty) {
            serviceName = service.serviceName!
        }
        if service.serviceCharge != nil {
            serviceCharge = String(format: "%@%d", AppConstantValue.rupeesymbol, service.serviceCharge!)
        }
        if !(service.serviceDescription.isNilOrEmpty) {
            serviceDescription = service.serviceDescription!
        }
        if !(service.serviceName.isNilOrEmpty) {
            serviceName = service.serviceName!
        }
        if service.id != nil {
            id = String(format: "%d", service.id!)
        }
        self.titleLabel.text = serviceName.capitalized
        self.descriptionLabel.text = serviceDescription.capitalized
        self.priceLabel.text = serviceCharge
        self.selectLabel.text = AppLocalizationString.serviceAdded
        
        self.selectButton.cornerRadius = AppConstantValue.cornerRadius4
        self.selectButton.layer.borderWidth = 1.0
        self.detailButton.setTitle(AppLocalizationString.viewDetails, for: .normal)
        
        let selectLabelview = self.stackview.arrangedSubviews[3]
        selectLabelview.isHidden = true
        
        self.selectButton.setTitle(AppLocalizationString.add.uppercased(), for: .normal)
        self.selectButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.selectButton.layer.backgroundColor = UIColor.colorLiteral.theme_orange_F7732F.cgColor
        if viewCon.selectedServiceArray.count > 0 {
            for item in viewCon.selectedServiceArray {
                let selectedid = item.serviceId
                let isSelected = item.isSelected
                if selectedid == id {
                    if isSelected == true {
                        self.selectButton.setTitle(AppLocalizationString.remove.uppercased(), for: .normal)
                        self.selectButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
                        self.selectButton.layer.backgroundColor = UIColor.colorLiteral.theme_grey_777777.cgColor
                        selectLabelview.isHidden = false
                    } else {
                    }
                } else {
                }
            }
        } else {
        }
    }
    
    @IBAction func detailButtonPressed(_ sender: UIButton) {
        self.delegate?.detailButtonPressedBookAppointmentTableViewCell(senderTag: sender.tag)
    }
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedBookAppointmentTableViewCell(senderTag: sender.tag)
    }
}
