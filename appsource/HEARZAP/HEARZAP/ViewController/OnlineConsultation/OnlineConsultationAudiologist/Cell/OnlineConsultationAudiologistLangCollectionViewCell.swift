//
//  OnlineConsultationAudiologistLangCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class OnlineConsultationAudiologistLangCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
