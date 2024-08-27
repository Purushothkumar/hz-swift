//
//  BottomSheetFeatureDeviceCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 21/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BottomSheetFeatureDeviceCollectionViewCell: UICollectionViewCell {
    @IBOutlet var bannerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(bannerimageurl: String, indexpath: Int) {
        let imgurl = ""
        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
        if !(bannerimageurl.isEmpty) {
            self.bannerImageView.setImage(imageUrl: bannerimageurl, placeHolderImage: hearzapPlaceholder)
        }
    }
}
