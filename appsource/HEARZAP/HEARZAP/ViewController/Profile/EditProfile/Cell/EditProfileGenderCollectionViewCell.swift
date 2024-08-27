//
//  EditProfileGenderCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 22/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolEditProfileGenderCollectionViewCell {
    func tagButtonPressedEditProfileGenderCollectionViewCell(senderTag: Int)
}

class EditProfileGenderCollectionViewCell: UICollectionViewCell {
    @IBOutlet var tagLabel: Caption1FontLabel!
    @IBOutlet var selectedView: UIView!
    @IBOutlet var tagButton: FootnoteOutlineButton!
    var delegate: ProtocolEditProfileGenderCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()

    }
    public func configure(gender: GenderRelationModelGender, selectedGenderSlug: String, indexpath: Int) {

        self.tagLabel.text = ""
        var genderSlug = ""
        self.tagButton.tag = indexpath
        if gender != nil {
            if !(gender.value.isNilOrEmpty) {
                self.tagLabel.text = gender.value!
            }
            if !(gender.key.isNilOrEmpty) {
                genderSlug = gender.key!
            }
            self.tagButton.tag = indexpath

            if selectedGenderSlug == genderSlug {
                self.tagLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
                self.selectedView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                self.selectedView.layer.borderWidth = 1.0
            } else {
                self.tagLabel.textColor = UIColor.colorLiteral.theme_grey_777777
                self.selectedView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
                self.selectedView.layer.borderWidth = 1.0
            }
        }
    }
    @IBAction func tagButtonPressed(_ sender: UIButton) {
        self.delegate?.tagButtonPressedEditProfileGenderCollectionViewCell(senderTag: sender.tag)
    }
}
