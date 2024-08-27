//
//  BookAppointmentDateCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 24/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolBookAppointmentDateCollectionViewCell {
    func selectButtonPressedBookAppointmentDateCollectionViewCell(senderTag: Int)
}

class BookAppointmentDateCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var selectButton: FootnoteOutlineButton!
    
    var delegate: ProtocolBookAppointmentDateCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(dateSlot: DateSlot, indexpath: Int, selectedDate: String, viewCon: BookAppointmentAddressViewController) {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.clipsToBounds = true
        self.deselectState()
        var date = ""
        self.selectButton.tag = indexpath
        if dateSlot != nil {
            if !(dateSlot.label.isNilOrEmpty) {
                self.descriptionLabel.text = dateSlot.label!
            }
            if !(dateSlot.weekday.isNilOrEmpty) {
                self.titleLabel.text = dateSlot.weekday!
            }
            if !(dateSlot.value.isNilOrEmpty) {
                date = dateSlot.value!
            }
        }
        if !(selectedDate.isEmpty) {
            if date == selectedDate {
                self.selectState()
                viewCon.scrolltoTimeSlot()
            }
        }
    }
    func selectState() {
        self.layer.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF.cgColor
        self.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.titleLabel.font = AppFont.medium.size(13)
        self.descriptionLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
        
    }
    func deselectState() {
        self.layer.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        self.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.titleLabel.font = AppFont.regular.size(13)
        self.descriptionLabel.textColor = UIColor.colorLiteral.theme_grey_777777
    }
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedBookAppointmentDateCollectionViewCell(senderTag: sender.tag)
    }
}
