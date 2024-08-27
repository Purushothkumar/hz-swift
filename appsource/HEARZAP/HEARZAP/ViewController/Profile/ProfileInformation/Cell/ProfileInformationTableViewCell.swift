//
//  ProfileInformationTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 13/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolProfileInformationTableViewCell {
    func editButtonPressedProfileInformationTableViewCell(senderTag: Int)
    func deleteButtonPressedProfileInformationTableViewCell(senderTag: Int)
}
class ProfileInformationTableViewCell: UITableViewCell {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: Caption1FontLabel!
    @IBOutlet var detailsLabel: Caption1FontLabel!

    @IBOutlet var stackview: UIStackView!
    @IBOutlet var editButton: FootnoteOutlineButton!
    @IBOutlet var deleteButton: FootnoteOutlineButton!

    var delegate: ProtocolProfileInformationTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(patientList: PatientList, indexPath: Int) {
        self.nameLabel.text = ""
        self.detailsLabel.text = ""
        self.editButton.tag = indexPath
        self.deleteButton.tag = indexPath

        self.deleteButton.setTitle(AppLocalizationString.delete.uppercased(), for: .normal)
        self.editButton.setTitle(AppLocalizationString.edit.uppercased(), for: .normal)

        self.editButton

        if !(patientList.name.isNilOrEmpty) {
            self.nameLabel.text = patientList.name!
        }
        var relationship = ""
        var age = ""
        var gender = ""
        var relationshipType = ""

        if !(patientList.relationship.isNilOrEmpty) {
            relationship = patientList.relationship!
        }
        if !(patientList.age.isNilOrEmpty) {
            age =  patientList.age!
        }
        if !(patientList.gender.isNilOrEmpty) {
            gender = patientList.gender!
        }
        if !(patientList.relationshipType.isNilOrEmpty) {
            relationshipType = patientList.relationshipType!
        }
        self.userImage.image = UIImage(named: Asset.maleblue)
        if !(gender.isEmpty) {
            if gender.lowercased() == "male" {
                self.userImage.image = UIImage(named: Asset.maleblue)
            } else if gender.lowercased() == "female" {
                self.userImage.image = UIImage(named: Asset.femaleblue)
            } else if gender.lowercased() == "others" {
                self.userImage.image = UIImage(named: Asset.profilegrey)
            }
        }

        if (relationship.isEmpty) &&  (age.isEmpty) && (gender.isEmpty) {
            self.detailsLabel.text = ""
        } else {
            if !(relationship.isEmpty) && !(age.isEmpty) && !(gender.isEmpty) {
                self.detailsLabel.text = String(format: "%@ | %@ | %@", relationship, age, gender)
            } else {
                if (relationship.isEmpty) || (age.isEmpty) || (gender.isEmpty) {
                    if !(relationship.isEmpty) {
                        if !(age.isEmpty) {
                            self.detailsLabel.text = String(format: "%@ | %@", relationship, age)
                        } else if !(gender.isEmpty) {
                            self.detailsLabel.text = String(format: "%@ | %@", relationship, gender)
                        } else {
                            self.detailsLabel.text = String(format: "%@", relationship)
                        }
                    } else if !(age.isEmpty) {
                        if !(relationship.isEmpty) {
                            self.detailsLabel.text = String(format: "%@ | %@", relationship, age)
                        } else if !(gender.isEmpty) {
                            self.detailsLabel.text = String(format: "%@ | %@", age, gender)
                        } else {
                            self.detailsLabel.text = String(format: "%@", age)
                        }
                    } else if !(gender.isEmpty) {
                        if !(relationship.isEmpty) {
                            self.detailsLabel.text = String(format: "%@ | %@", relationship, gender)
                        } else if !(age.isEmpty) {
                            self.detailsLabel.text = String(format: "%@ | %@", age, gender)
                        } else {
                            self.detailsLabel.text = String(format: "%@", gender)
                        }
                    }
                }
            }
        }

        let view0 = self.stackview.arrangedSubviews[0] // delete
        let view1 = self.stackview.arrangedSubviews[1] // edit

        view0.isHidden = false
        view1.isHidden = false
        if (relationshipType.lowercased() == "self") || (relationshipType.isEmpty) {
            view0.isHidden = true
            view1.isHidden = true
        }

    }
    @IBAction func editButtonPressed(_ sender: UIButton) {
        self.delegate?.editButtonPressedProfileInformationTableViewCell(senderTag: sender.tag)
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        self.delegate?.deleteButtonPressedProfileInformationTableViewCell(senderTag: sender.tag)
    }
}
