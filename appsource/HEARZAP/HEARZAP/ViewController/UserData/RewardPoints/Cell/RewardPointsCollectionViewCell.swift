//
//  RewardPointsCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 15/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolRewardPointsCollectionViewCell {
    func tapButtonRewardPointsCollectionViewCell(senderTag: Int)
}
class RewardPointsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var messageLabel: SubheadFontLabel!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var heightBannerImageView: NSLayoutConstraint!
    @IBOutlet var getUsingLabel: Caption1FontLabel!
    @IBOutlet var rewardPointLabel: Caption1FontLabel!
    @IBOutlet var getUsingStackView: UIStackView!
    @IBOutlet var tapButton: FootnoteOutlineButton!

    var delegate: ProtocolRewardPointsCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    public func configure(reward: Reward, indexPath: Int) {
        self.messageLabel.text = ""
        self.getUsingLabel.text = ""
        self.rewardPointLabel.text = ""
        self.tapButton.tag = indexPath

        var imgurl = ""
        self.heightBannerImageView.constant = CGFloat(130) * CGFloat(screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
        if !(reward.rewardImage.isNilOrEmpty) {
            imgurl = reward.rewardImage!
        }
        if !(reward.rewardRedeemPoints.isNilOrEmpty) {
            self.rewardPointLabel.text = String(format: "  %@", reward.rewardRedeemPoints!)
        }
        if !(reward.rewardName.isNilOrEmpty) {
            self.messageLabel.text = String(format: "%@", reward.rewardName!.capitalized)
        }
        self.getUsingLabel.text = AppLocalizationString.getUsing
        self.getUsingStackView.clipsToBounds = true
        self.getUsingStackView.layer.cornerRadius = CGFloat(18)
        self.getUsingStackView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.getUsingStackView.layer.borderWidth = 1.0

        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)

    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonRewardPointsCollectionViewCell(senderTag: sender.tag)
    }
}
