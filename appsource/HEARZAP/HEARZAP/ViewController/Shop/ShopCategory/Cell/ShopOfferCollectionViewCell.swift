//
//  ShopOfferCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 26/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
protocol ProtocolShopOfferCollectionViewCell {
    func offerButtonPressedShopOfferCollectionViewCell(senderTag: Int)
}

class ShopOfferCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var offerButton: FootnoteOutlineButton!
    
    var delegate: ProtocolShopOfferCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(offerList: OfferList, indexpath: Int) {
        self.offerButton.tag = indexpath
        var productImage = ""
        if !(offerList.couponPhoto.isNilOrEmpty) {
            productImage = offerList.couponPhoto!
        }
        self.imageview.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
        
    }
    @IBAction func offerButtonPressed(_ sender: UIButton) {
        self.delegate?.offerButtonPressedShopOfferCollectionViewCell(senderTag: sender.tag)
    }
}
