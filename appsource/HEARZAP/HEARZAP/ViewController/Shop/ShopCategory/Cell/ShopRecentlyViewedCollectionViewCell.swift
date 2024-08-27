//
//  ShopRecentlyViewedCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 08/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolShopRecentlyViewedCollectionViewCell {
    func shopButtonPressedShopRecentlyViewedCollectionViewCell(senderTag: Int)
}

class ShopRecentlyViewedCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var shopButton: FootnoteOutlineButton!
    
    var delegate: ProtocolShopRecentlyViewedCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(recentlyViewedModel: RecentlyViewedModel, indexpath: Int) {
        self.imageview.image = UIImage(named: recentlyViewedModel.image)
    }
    @IBAction func shopButtonPressed(_ sender: UIButton) {
        self.delegate?.shopButtonPressedShopRecentlyViewedCollectionViewCell(senderTag: sender.tag)
    }
}
