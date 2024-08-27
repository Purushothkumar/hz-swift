//
//  ProductDetailImageCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 02/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProductDetailImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
