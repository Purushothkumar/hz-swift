//
//  TipsDetailTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 31/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolTipsDetailTableViewCell {
    func tapButtonPressedTipsDetailTableViewCell(senderTag: Int)

}
class TipsDetailTableViewCell: UITableViewCell {
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var countLabel: Caption2FontLabel!
    @IBOutlet var tapButton: FootnoteOutlineButton!

    var delegate: ProtocolTipsDetailTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(tips: Tips, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.titleLabel.text = ""
        self.countLabel.text = ""
        self.descriptionLabel.text = ""
        self.bannerImageView.setImage(imageUrl: "", placeHolderImage: hearzapPlaceholder)
        if !(tips.title.isNilOrEmpty) {
            self.descriptionLabel.text = tips.title
        }
        if tips.tipDetailCount != nil {
            if tips.tipDetailCount! > 1 {
                self.countLabel.text = "\(String(describing: tips.tipDetailCount!)) \(AppLocalizationString.tips)"
            } else {
                self.countLabel.text = "\(String(describing: tips.tipDetailCount!)) \(AppLocalizationString.tip)"
            }
        }
        if !(tips.image.isNilOrEmpty) {
            self.bannerImageView.setImage(imageUrl: tips.image!, placeHolderImage: hearzapPlaceholder)
        }
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedTipsDetailTableViewCell(senderTag: sender.tag)
    }
}
