//
//  UserAccountTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 23/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolUserAccountTableViewCell {
    func userAccountTableViewCellProfileButtonPressed()
}

class UserAccountTableViewCell: UITableViewCell {
    
    @IBOutlet var userNameLabel: CalloutFontLabel!
    @IBOutlet var userEmailPhoneLabel: Caption1FontLabel!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var profileButton: CalloutOutlineButton!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var stackview: UIStackView!
    
    var delegate: ProtocolUserAccountTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        self.delegate?.userAccountTableViewCellProfileButtonPressed()
    }
}
