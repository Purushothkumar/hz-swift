//
//  CompareProductBrandCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCompareProductBrandCollectionViewCell {
    func tapButtonPressedCompareProductBrandCollectionViewCell(senderTag: Int)
}
class CompareProductBrandCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var tapButton: FootnoteOutlineButton!

    var delegate: ProtocolCompareProductBrandCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(productBrand: HearingAidBrandList, indexpath: Int) {
        self.tapButton.tag = indexpath
        var productImage = ""
        if !(productBrand.photo.isNilOrEmpty) {
            productImage = productBrand.photo!
        }
        self.imageview.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedCompareProductBrandCollectionViewCell(senderTag: sender.tag)
    }
}
