//
//  SupportTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 26/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolSupportTableViewCell {
    func buttonPressedSupportTableViewCell(senderTag: Int)
}
class SupportTableViewCell: UITableViewCell {

    var delegate: ProtocolSupportTableViewCell?
    @IBOutlet var titleLabel: Title2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var button: FootnoteBackgroundButton!
    @IBOutlet var supportImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(supportModel: SupportModel, indexpath: Int) {
        self.button.tag = indexpath
        self.titleLabel.text = supportModel.title
        if supportModel.supportDeskType == SupportDeskType.call.rawValue {
            let combination = NSMutableAttributedString()
            let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
            let contentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.medium.size(13)]
            let title = NSMutableAttributedString(string: String(format: "%@ ", supportModel.description), attributes: titleAttributes as [NSAttributedString.Key: Any])
            let content = NSMutableAttributedString(string: String(format: "%@", supportModel.supportdata.toPhoneNumberFormate()), attributes: contentFontAttributes as [NSAttributedString.Key: Any])

            combination.append(title)
            combination.append(content)
            self.descriptionLabel.attributedText = combination
        } else {
            self.descriptionLabel.text = supportModel.description
        }
        self.supportImageView.image = UIImage(named: supportModel.image)
        self.button.setTitle(supportModel.buttonTitle, for: .normal)
        self.button.setImage(UIImage(named: Asset.chevronrightwhite), for: .normal)
        self.button.imageEdgeInsets.left = self.button.frame.width - 20
        self.button.titleEdgeInsets.left = -(self.button.frame.width - 100)
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        self.delegate?.buttonPressedSupportTableViewCell(senderTag: sender.tag)
    }
}
