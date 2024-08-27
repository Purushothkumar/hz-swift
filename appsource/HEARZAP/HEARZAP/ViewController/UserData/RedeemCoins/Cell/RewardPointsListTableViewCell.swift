//
//  RedeemCoinsTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolRedeemCoinsTableViewCell {
    func tapButtonRedeemCoinsTableViewCell(senderTag: Int)
}
class RedeemCoinsTableViewCell: UITableViewCell {

    @IBOutlet var imageCardStackView: UIStackView!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var couponOfferTitleLabel: Caption1FontLabel!
    @IBOutlet var getUsingStackView: UIStackView!
    @IBOutlet var getUsingLabel: Caption1FontLabel!
    @IBOutlet var couponOfferPointLabel: Caption1FontLabel!

    @IBOutlet var tapButton: CalloutOutlineButton!

    var delegate: ProtocolRedeemCoinsTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(redeemCoin: RedeemCoin, indexpath: Int) {
        self.couponOfferTitleLabel.text = ""
        self.getUsingLabel.text = ""
        self.couponOfferPointLabel.text = ""
        self.tapButton.tag = indexpath

        var imgurl = ""
        if !(redeemCoin.rewardImage.isNilOrEmpty) {
            imgurl = redeemCoin.rewardImage!
        }
        if !(redeemCoin.rewardRedeemPoints.isNilOrEmpty) {
            self.couponOfferPointLabel.text = String(format: "  %@", redeemCoin.rewardRedeemPoints!)
        }
        if !(redeemCoin.rewardName.isNilOrEmpty) {
            self.couponOfferTitleLabel.text = String(format: "%@", redeemCoin.rewardName!.capitalized)
        }
        self.getUsingLabel.text = AppLocalizationString.getUsing
        self.getUsingStackView.clipsToBounds = true
        self.getUsingStackView.layer.cornerRadius = CGFloat(18)
        self.getUsingStackView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.getUsingStackView.layer.borderWidth = 1.0

        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)

    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonRedeemCoinsTableViewCell(senderTag: sender.tag)
    }
}
