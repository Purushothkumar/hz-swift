//
//  OnlineConsultationTimeCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 30/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolOnlineConsultationTimeCollectionViewCell {
    func selectButtonPressedOnlineConsultationTimeCollectionViewCell(senderTag: Int)
}

class OnlineConsultationTimeCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var selectButton: Caption1FontLabel!
    @IBOutlet var selectView: UIView!

    var delegate: ProtocolOnlineConsultationTimeCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(availableTimeSlot: AvailableTimeSlot, indexpath: Int, selectedTime: String) {
        var isAvailable = false
        var time = ""
        var availableTime = ""
        var timeslot = NSMutableAttributedString()
        let combination = NSMutableAttributedString()

        self.selectButton.tag = indexpath
        if !(availableTimeSlot.time.isNilOrEmpty) {
            availableTime = availableTimeSlot.time!
        }
        if availableTimeSlot.id != nil {
            time = String(format: "%d", availableTimeSlot.id!)
        }
        if availableTimeSlot.isAvailable != nil {
            isAvailable = availableTimeSlot.isAvailable!
        }
        self.titleLabel.attributedText = combination

        let selectFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.medium.size(13)]
        let deselectFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let deselectStrikeFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13), NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.strikethroughColor: UIColor.colorLiteral.theme_grey_777777] as [NSAttributedString.Key: Any]

        self.deselectState()
        self.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.clipsToBounds = true

        if isAvailable == true {
            self.selectButton.isUserInteractionEnabled = true
            if !(selectedTime.isEmpty) {
                if time == selectedTime {
                    timeslot = NSMutableAttributedString(string: String(format: "%@", availableTime), attributes: selectFontAttributes as [NSAttributedString.Key: Any])
                    combination.append(timeslot)
                    self.titleLabel.attributedText = combination
                    self.selectState()
                } else {
                    timeslot = NSMutableAttributedString(string: String(format: "%@", availableTime), attributes: deselectFontAttributes as [NSAttributedString.Key: Any])
                    combination.append(timeslot)
                    self.titleLabel.attributedText = combination
                    self.deselectState()
                }
            } else {
                timeslot = NSMutableAttributedString(string: String(format: "%@", availableTime), attributes: deselectFontAttributes as [NSAttributedString.Key: Any])
                combination.append(timeslot)
                self.titleLabel.attributedText = combination
                self.deselectState()
            }
        } else {
            self.selectButton.isUserInteractionEnabled = false
            timeslot = NSMutableAttributedString(string: String(format: "%@", availableTime), attributes: deselectStrikeFontAttributes as [NSAttributedString.Key: Any])
            combination.append(timeslot)
            self.titleLabel.attributedText = combination
            self.deselectState()
        }
    }
    func selectState() {
        self.selectView.layer.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF.cgColor
        self.selectView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.selectView.layer.borderWidth = 1.0
    }
    func deselectState() {
        self.selectView.layer.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        self.selectView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.selectView.layer.borderWidth = 1.0
    }
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedOnlineConsultationTimeCollectionViewCell(senderTag: sender.tag)
    }
}
