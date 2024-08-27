//
//  QuickTestProfileCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 06/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolQuickTestProfileCollectionViewCell {
    func selectProfileButtonPressedQuickTestProfileCollectionViewCell(senderTag: Int)
}

class QuickTestProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var profileRelationLabel: FootnoteFontLabel!
    @IBOutlet weak var selectProfileButton: FootnoteOutlineButton!
    var delegate: ProtocolQuickTestProfileCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
    }
    public func configure(patientList: PatientList, indexpath: Int, canHideShimmering:Bool) {
        self.selectProfileButton.tag = indexpath
        
        var age = ""
        var gender = ""
        var name = ""
        var relationship = ""
        var relationshipType = ""

        var displayinfo = ""
        if !(patientList.name.isNilOrEmpty) {
            name = patientList.name!
        }
        if !(patientList.gender.isNilOrEmpty) {
            gender = patientList.gender!
        }
        if !(patientList.relationshipType.isNilOrEmpty) {
            relationshipType = patientList.relationshipType!
        }
        if !(patientList.relationship.isNilOrEmpty) {
            relationship = patientList.relationship!
        }
        if gender.lowercased() == GenderType.addnew.rawValue.lowercased(){
            self.genderImageView.image = UIImage(named: Asset.addnewgrey)
        }
        else if gender.lowercased() == GenderType.female.rawValue.lowercased(){
            self.genderImageView.image = UIImage(named: Asset.femalegrey)
        }
        else{
            self.genderImageView.image = UIImage(named: Asset.malegrey)
        }
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            displayinfo = relationship
        }
        else{
            displayinfo = name
        }
        self.profileRelationLabel.text = displayinfo
//        self.genderImageView.shimmerEffectView(canStop: canHideShimmering)
//        self.profileRelationLabel.shimmerEffectView(canStop: canHideShimmering)
        
    }
    @IBAction func selectProfileButtonPressed(_ sender: UIButton) {
        self.delegate?.selectProfileButtonPressedQuickTestProfileCollectionViewCell(senderTag: sender.tag)
    }
}
