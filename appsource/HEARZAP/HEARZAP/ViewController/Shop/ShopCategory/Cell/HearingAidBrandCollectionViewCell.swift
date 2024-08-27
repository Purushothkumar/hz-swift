//
//  HearingAidBrandCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 25/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolHearingAidBrandCollectionViewCell {
    func brandButtonPressedHearingAidBrandCollectionViewCell(senderTag: Int)
}

class HearingAidBrandCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var brandButton: FootnoteOutlineButton!
    
    var delegate: ProtocolHearingAidBrandCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(hearingAidBrandList: HearingAidBrandList, indexpath: Int) {
        self.brandButton.tag = indexpath
        var productImage = ""
        if !(hearingAidBrandList.photo.isNilOrEmpty) {
            productImage = hearingAidBrandList.photo!
        }
        self.imageview.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
    }
    @IBAction func brandButtonPressed(_ sender: UIButton) {
        self.delegate?.brandButtonPressedHearingAidBrandCollectionViewCell(senderTag: sender.tag)
    }
}
