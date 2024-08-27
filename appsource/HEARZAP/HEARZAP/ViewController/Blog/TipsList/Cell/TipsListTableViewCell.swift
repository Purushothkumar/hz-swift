//
//  TipsListTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 29/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolTipsListTableViewCell {
    func tapButtonPressedTipsListTableViewCell(senderTag: Int)
}
class TipsListTableViewCell: UITableViewCell {
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var titleLabel: FootnoteFontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var countLabel: FootnoteFontLabel!
    @IBOutlet var tapButton: CalloutOutlineButton!

    var delegate: ProtocolTipsListTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(tips: TipsListModelTip, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.titleLabel.text = ""
        self.countLabel.text = ""
        self.descriptionLabel.text = ""
        self.bannerImageView.setImage(imageUrl: "", placeHolderImage: hearzapPlaceholder)
        if !(tips.title.isNilOrEmpty) {
            self.titleLabel.text = tips.title
        }
        if tips.tipDetailCount != nil {
            if tips.tipDetailCount! > 1 {
                self.descriptionLabel.text = "\(String(describing: tips.tipDetailCount!)) \(AppLocalizationString.tips)"
            } else {
                self.descriptionLabel.text = "\(String(describing: tips.tipDetailCount!)) \(AppLocalizationString.tip)"
            }

        }
        if !(tips.image.isNilOrEmpty) {
            self.bannerImageView.setImage(imageUrl: tips.image!, placeHolderImage: hearzapPlaceholder)
        }
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedTipsListTableViewCell(senderTag: sender.tag)
    }
}
