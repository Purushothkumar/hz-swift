//
//  CompareProductPriceCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCompareProductPriceCollectionViewCell {
    func priceButtonPressedCompareProductPriceCollectionViewCell(senderTag: Int)
}

class CompareProductPriceCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: FootnoteFontLabel!
    @IBOutlet var priceLabel: BodyFontLabel!
    @IBOutlet var priceButton: FootnoteOutlineButton!

    var delegate: ProtocolCompareProductPriceCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(priceRangeList: HearingAidPriceRangeList, indexpath: Int) {
        self.priceButton.tag = indexpath
        self.titleLabel.text = ""
        self.priceLabel.text = ""
        var priceStartRange = ""
        var priceEndRange = ""

        if !(priceRangeList.name.isNilOrEmpty) {
            self.titleLabel.text = priceRangeList.name
        }
        if priceRangeList.priceStartRange != nil {
            if priceRangeList.priceStartRange != 0 {
                priceStartRange = String(format: "%@%d", AppConstantValue.rupeesymbol, priceRangeList.priceStartRange!)
            }
        }
        if priceRangeList.priceEndRange != nil {
            if priceRangeList.priceEndRange != 0 {
                priceEndRange = String(format: "%@%d", AppConstantValue.rupeesymbol, priceRangeList.priceEndRange!)
            }
        }
        if !(priceStartRange.isEmpty) && !(priceEndRange.isEmpty) {
            self.priceLabel.text = "\(priceStartRange) - \(priceEndRange)"
        } else {
            if !(priceStartRange.isEmpty) {
                self.priceLabel.text = "\(AppLocalizationString.above.capitalized) \(priceStartRange)"
            } else if  !(priceEndRange.isEmpty) {
                self.priceLabel.text = "\(AppLocalizationString.below.capitalized) \(priceEndRange)"
            }
        }
    }
    @IBAction func priceButtonPressed(_ sender: UIButton) {
        self.delegate?.priceButtonPressedCompareProductPriceCollectionViewCell(senderTag: sender.tag)
    }
}
