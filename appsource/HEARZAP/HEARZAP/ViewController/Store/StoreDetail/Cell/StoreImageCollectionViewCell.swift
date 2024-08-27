//
//  StoreImageCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 27/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class StoreImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var storeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(storePhoto: StorePhoto, indexpath: Int) {
        var imgurl = ""
        self.storeImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
        if storePhoto.photo != nil {
            if !(storePhoto.photo!.isEmpty) {
                imgurl = (storePhoto.photo)!
                self.storeImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
            }
        }
    }
}
