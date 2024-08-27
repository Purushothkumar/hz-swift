//
//  BottomSheetCartQuantityCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 16/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolBottomSheetCartQuantityCollectionViewCell {
    func tagButtonPressedBottomSheetCartQuantityCollectionViewCell(senderTag: Int)
}

class BottomSheetCartQuantityCollectionViewCell: UICollectionViewCell {
    @IBOutlet var tagLabel: Caption1FontLabel!
    @IBOutlet var tagButton: CalloutOutlineButton!
    @IBOutlet var selectionView: UIView!

    var delegate: ProtocolBottomSheetCartQuantityCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(quantityTag: String, indexpath: Int, quantity: String) {
        self.tagButton.tag = indexpath
        self.tagLabel.text = quantityTag

        self.selectionView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.selectionView.clipsToBounds = true
        self.selectionView.layer.borderWidth = 1.0
        self.selectionView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.tagLabel.textColor = UIColor.colorLiteral.theme_grey_777777

        if quantityTag == quantity {
            self.selectionView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            self.tagLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
        }
    }
    @IBAction func tagButtonPressed(_ sender: UIButton) {
        self.delegate?.tagButtonPressedBottomSheetCartQuantityCollectionViewCell(senderTag: sender.tag)
    }
}
