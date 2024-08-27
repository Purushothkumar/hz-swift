//
//  HearzapDataTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 23/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolHearzapDataTableViewCell {
    func hearzapDataTableViewCellButtonPressed(senderTag: Int)
}

class HearzapDataTableViewCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: SubheadFontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!
    @IBOutlet var stackview: UIStackView!
    @IBOutlet var tapButton: CalloutOutlineButton!
    
    var delegate: ProtocolHearzapDataTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(menuModel: MenuModel, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.titleLabel.text = menuModel.title
        self.descriptionLabel.text = menuModel.description
        //        self.iconImageView.image = UIImage(named: menuModel.image)
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        self.delegate?.hearzapDataTableViewCellButtonPressed(senderTag: sender.tag)
    }
}
