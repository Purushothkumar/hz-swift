//
//  SelectUserButtonButtonTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 22/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolSelectUserButtonTableViewCell {
    func tapButtonSelectUserButtonTableViewCell(senderTag: Int)
}
class SelectUserButtonTableViewCell: UITableViewCell {

    @IBOutlet var tapButton: CalloutOutlineButton!
    @IBOutlet var addpersonLabel: Caption1FontLabel!

    var delegate: ProtocolSelectUserButtonTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonSelectUserButtonTableViewCell(senderTag: sender.tag)
    }
}
