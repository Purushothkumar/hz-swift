//
//  SelectUserTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 22/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolSelectUserTableViewCell {
    func tapButtonSelectUserTableViewCell(senderTag: Int)
}
class SelectUserTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: CalloutFontLabel!
    @IBOutlet var detailsLabel: Caption1FontLabel!
    @IBOutlet var selectButton: FootnoteOutlineButton!
    @IBOutlet var tapButton: FootnoteOutlineButton!
    @IBOutlet var selectionView: UIView!

    var delegate: ProtocolSelectUserTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(patientList: PatientList, indexPath: Int, selectedPerson: String) {
        self.nameLabel.text = ""
        self.detailsLabel.text = ""
        self.selectionView.layer.borderWidth = 1.0
        self.selectionView.layer.borderColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        var personuid = ""
        self.selectButton.setImage(UIImage(named: Asset.checkcirclegrey), for: .normal)
        self.selectButton.tag = indexPath
        self.tapButton.tag = indexPath
        if !(patientList.name.isNilOrEmpty) {
            self.nameLabel.text = patientList.name!.capitalized
        }
        var relationship = ""
        var age = ""
        var gender = ""
        var detaildata = ""

        if !(patientList.relationship.isNilOrEmpty) {
            relationship = patientList.relationship!
        }
        if !(patientList.age.isNilOrEmpty) {
            age =  patientList.age!
        }
        if !(patientList.gender.isNilOrEmpty) {
            gender = patientList.gender!
        }
        if (relationship.isEmpty) &&  (age.isEmpty) && (gender.isEmpty) {
            self.detailsLabel.text = ""
        } else {
            if !(relationship.isEmpty) && !(age.isEmpty) && !(gender.isEmpty) {
                detaildata = String(format: "%@ | %@ | %@", relationship, age, gender)
            } else {
                if (relationship.isEmpty) || (age.isEmpty) || (gender.isEmpty) {
                    if !(relationship.isEmpty) {
                        if !(age.isEmpty) {
                            detaildata = String(format: "%@ | %@", relationship, age)
                        } else if !(gender.isEmpty) {
                            detaildata = String(format: "%@ | %@", relationship, gender)
                        } else {
                            detaildata = String(format: "%@", relationship)
                        }
                    } else if !(age.isEmpty) {
                        if !(relationship.isEmpty) {
                            detaildata = String(format: "%@ | %@", relationship, age)
                        } else if !(gender.isEmpty) {
                            detaildata = String(format: "%@ | %@", age, gender)
                        } else {
                            detaildata = String(format: "%@", age)
                        }
                    } else if !(gender.isEmpty) {
                        if !(relationship.isEmpty) {
                            detaildata = String(format: "%@ | %@", relationship, gender)
                        } else if !(age.isEmpty) {
                            detaildata = String(format: "%@ | %@", age, gender)
                        } else {
                            detaildata = String(format: "%@", gender)
                        }
                    }
                }
            }
        }
        self.detailsLabel.text = detaildata.capitalized
        if !(patientList.uid.isNilOrEmpty) {
            personuid = patientList.uid!
        }
        if personuid == selectedPerson {
            self.selectionView.layer.borderWidth = 1.0
            self.selectionView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            self.selectButton.setImage(UIImage(named: Asset.checkcirclelightblue), for: .normal)
        }
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonSelectUserTableViewCell(senderTag: sender.tag)
    }
}
