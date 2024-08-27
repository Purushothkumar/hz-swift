//
//  AudiologistLangCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 26/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class AudiologistLangCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
