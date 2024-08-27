//
//  TipsListCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 29/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolTipsListCollectionViewCell {
    func tapButtonPressedTipsListCollectionViewCell(senderTag: Int)
}
class TipsListCollectionViewCell: UICollectionViewCell {
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var titleLabel: FootnoteFontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var countLabel: FootnoteFontLabel!
    @IBOutlet var tapButton: CalloutOutlineButton!

    var delegate: ProtocolTipsListCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(tips: TipsListModelTip, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.titleLabel.text = ""
        self.countLabel.text = ""
        self.descriptionLabel.text = ""
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
        self.delegate?.tapButtonPressedTipsListCollectionViewCell(senderTag: sender.tag)
    }

}
