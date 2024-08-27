//
//  ReturnReasonTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 11/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolReturnReasonTableViewCell {
    func reasonButtonPressedReturnReasonTableViewCell(senderTag: Int)
}
class ReturnReasonTableViewCell: UITableViewCell {

    @IBOutlet var reasonView: UIView!
    @IBOutlet var reasonLabel: Caption1FontLabel!
    @IBOutlet var reasonButton: FootnoteOutlineButton!

    var delegate: ProtocolReturnReasonTableViewCell!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(reason: ReturnReasonList, indexpath: Int, selectID: String) {
        self.reasonButton.tag = indexpath
        self.reasonLabel.text = ""
        self.deselectState()
        var id = ""
        if !(reason.value.isNilOrEmpty) {
            self.reasonLabel.text = reason.value
        }
        if reason.id != nil {
            id = String(format: "%d", reason.id!)
        }
        if id == selectID {
            self.selectState()
        }
    }
    @IBAction func reasonButtonPressed(_ sender: UIButton) {
        self.delegate?.reasonButtonPressedReturnReasonTableViewCell(senderTag: sender.tag)
    }
    func selectState() {
        self.reasonView.layer.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF.cgColor
        self.reasonView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.reasonView.layer.borderWidth = 1.0
        self.reasonLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.reasonLabel.font = AppFont.regular.size(13)

    }
    func deselectState() {
        self.reasonView.layer.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        self.reasonView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.reasonView.layer.borderWidth = 1.0
        self.reasonLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.reasonLabel.font = AppFont.regular.size(13)
    }
}
