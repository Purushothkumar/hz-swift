//
//  BlogsShimmerCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 06/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BlogsShimmerCollectionViewCell: UICollectionViewCell {

    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: Footnote1FontLabel!
    @IBOutlet var timeLabel: Caption2FontLabel!

    var delegate: ProtocolBlogsListCollectionViewCell?
    var listIndexpath = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(canHideShimmering:Bool) {

        self.titleLabel.text = ""
        self.timeLabel.text = ""
        self.descriptionLabel.text = ""
        self.bannerImageView.setImage(imageUrl: "", placeHolderImage: hearzapPlaceholder)

        self.bannerImageView.shimmerEffectView(canStop: canHideShimmering)
        self.titleLabel.shimmerEffectView(canStop: canHideShimmering)
        self.descriptionLabel.shimmerEffectView(canStop: canHideShimmering)
        self.timeLabel.shimmerEffectView(canStop: canHideShimmering)
    }

    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedBlogsListCollectionViewCell(senderTag: sender.tag)
    }
}
