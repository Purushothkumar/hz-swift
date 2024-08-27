//
//  CompareProductTagCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCompareProductTagCollectionViewCell {
    func tagButtonPressedCompareProductTagCollectionViewCell(senderTag: Int)
}

class CompareProductTagCollectionViewCell: UICollectionViewCell {
    @IBOutlet var tagLabel: Caption1FontLabel!
    @IBOutlet var tagButton: FootnoteOutlineButton!
    var delegate: ProtocolCompareProductTagCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(compareTag: CompareTagModel, indexpath: Int) {
        self.tagButton.tag = indexpath
        self.tagLabel.text = ""
        if !(compareTag.name.isEmpty) {
            self.tagLabel.text = compareTag.name
        }
    }
    @IBAction func tagButtonPressed(_ sender: UIButton) {
        self.delegate?.tagButtonPressedCompareProductTagCollectionViewCell(senderTag: sender.tag)
    }
}
