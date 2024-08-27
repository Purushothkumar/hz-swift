//
//  GuestAccountTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 23/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolGuestAccountTableViewCell {
    func guestAccountTableViewCellLoginButtonPressed()
}

class GuestAccountTableViewCell: UITableViewCell {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var helloLabel: BodyFontLabel!
    @IBOutlet var loginButton: CalloutBackgroundButton!
    @IBOutlet var profileImageView: UIImageView!
    
    var delegate: ProtocolGuestAccountTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(menuModel: MenuModel, indexpath: Int) {
        self.loginButton.tag = indexpath
        self.loginButton.setTitle(AppLocalizationString.loginSignup.uppercased(), for: .normal)
        self.helloLabel.text = String(format: "%@ !", AppLocalizationString.hello)
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.delegate?.guestAccountTableViewCellLoginButtonPressed()
    }
}
