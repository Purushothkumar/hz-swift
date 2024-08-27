//
//  HearingAidShopBrandCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 25/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
protocol ProtocolHearingAidShopBrandCollectionViewCell {
    func shopBrandButtonPressedHearingAidShopBrandCollectionViewCell(senderTag: Int)
}
class HearingAidShopBrandCollectionViewCell: UICollectionViewCell {
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var shopBrandButton: FootnoteOutlineButton!
    
    var delegate: ProtocolHearingAidShopBrandCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
    }
    
    @IBAction func shopBrandButtonPressed(_ sender: UIButton) {
        self.delegate?.shopBrandButtonPressedHearingAidShopBrandCollectionViewCell(senderTag: sender.tag)
    }
}
