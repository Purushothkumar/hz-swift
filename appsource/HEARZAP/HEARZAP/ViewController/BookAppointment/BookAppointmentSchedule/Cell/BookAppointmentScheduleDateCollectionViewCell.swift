//
//  BookAppointmentScheduleDateCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 24/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolBookAppointmentScheduleDateCollectionViewCell {
    func selectButtonPressedBookAppointmentScheduleDateCollectionViewCell(senderTag: Int)
}

class BookAppointmentScheduleDateCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var selectButton: FootnoteOutlineButton!
    @IBOutlet var selectView: UIView!

    var delegate: ProtocolBookAppointmentScheduleDateCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(dateList: DateList, indexpath: Int, selectedDate: String) {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.clipsToBounds = true
        self.deselectState()
        var date = ""
        self.selectButton.tag = indexpath
        if dateList != nil {
            if !(dateList.date.isNilOrEmpty) {
                self.descriptionLabel.text = dateList.date!
                date = dateList.date!
            }
            if !(dateList.day.isNilOrEmpty) {
                self.titleLabel.text = dateList.day!
            }
        }

        if !(selectedDate.isEmpty) {
            if date == selectedDate {
                self.selectState()
            }
        }
    }
    func selectState() {
        self.selectView.layer.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF.cgColor
        self.selectView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.selectView.layer.borderWidth = 1.0
        self.titleLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.titleLabel.font = AppFont.medium.size(13)
        self.descriptionLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF

    }
    func deselectState() {
        self.selectView.layer.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        self.selectView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.selectView.layer.borderWidth = 1.0
        self.titleLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.titleLabel.font = AppFont.regular.size(13)
        self.descriptionLabel.textColor = UIColor.colorLiteral.theme_grey_777777
    }
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedBookAppointmentScheduleDateCollectionViewCell(senderTag: sender.tag)
    }
}
