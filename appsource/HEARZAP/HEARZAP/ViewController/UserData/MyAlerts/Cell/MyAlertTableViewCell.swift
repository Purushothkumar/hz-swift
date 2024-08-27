//
//  MyAlertTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 28/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolMyAlertTableViewCell {
    func tapButtonPressedMyAlertTableViewCell(senderTag: Int)

}
class MyAlertTableViewCell: UITableViewCell {

    @IBOutlet var stackview: UIStackView!
    @IBOutlet var headerLabel: CalloutFontLabel!
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!
    @IBOutlet var tapButton: FootnoteOutlineButton!

    var delegate: ProtocolMyAlertTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(alert: MyAlertModelDatum, indexPath: Int) {
        var headermess = ""
        var titlemess = ""
        var descriptionmess = ""
        var buttonmess = ""
        self.tapButton.tag = indexPath

        self.tapButton.layer.borderWidth = 1.0
        self.tapButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor

        let view0 = self.stackview.arrangedSubviews[0]
        let view1 = self.stackview.arrangedSubviews[1]
        let view2 = self.stackview.arrangedSubviews[2]
        let view3 = self.stackview.arrangedSubviews[3]

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true

        if !(alert.alertTitle.isNilOrEmpty) {
            view0.isHidden = false
            headermess = alert.alertTitle!.capitalized
        }
        if !(alert.alertDescription.isNilOrEmpty) {
            view1.isHidden = false
            titlemess = alert.alertDescription!.capitalized
        }
        if !(alert.alertDate.isNilOrEmpty) {
            view3.isHidden = false
            descriptionmess = alert.alertDate!.capitalized
        }
        if !(alert.actionBtnName.isNilOrEmpty) {
            view2.isHidden = false
            buttonmess = alert.actionBtnName!.capitalized
        }
        self.titleLabel.text = titlemess
        self.headerLabel.text = headermess
        self.descriptionLabel.text = descriptionmess
        self.tapButton.setTitle(buttonmess, for: .normal)

    }

    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedMyAlertTableViewCell(senderTag: sender.tag)
    }

}
