//
//  UserDataTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 23/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolUserDataTableViewCell {
    func userDataTableViewCellButtonPressed(senderTag: Int)
}

class UserDataTableViewCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: CalloutFontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!
    @IBOutlet var stackview: UIStackView!
    @IBOutlet var tapButton: CalloutOutlineButton!
    
    var delegate: ProtocolUserDataTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(menuModel: MenuModel, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.titleLabel.text = menuModel.title
        self.descriptionLabel.text = menuModel.description
        self.iconImageView.image = UIImage(named: menuModel.image)
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        self.delegate?.userDataTableViewCellButtonPressed(senderTag: sender.tag)
    }
}
