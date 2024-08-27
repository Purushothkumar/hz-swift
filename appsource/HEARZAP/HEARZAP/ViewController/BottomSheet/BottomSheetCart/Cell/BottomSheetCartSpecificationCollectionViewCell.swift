//
//  BottomSheetCartSpecificationCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 16/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolBottomSheetCartSpecificationCollectionViewCell {
    func tagButtonPressedBottomSheetCartSpecificationCollectionViewCell(senderTag: Int, selectedRow: Int)
}

class BottomSheetCartSpecificationCollectionViewCell: UICollectionViewCell {
    @IBOutlet var tagLabel: Caption1FontLabel!
    @IBOutlet var tagButton: CalloutOutlineButton!
    @IBOutlet var selectionView: UIView!

    var delegate: ProtocolBottomSheetCartSpecificationCollectionViewCell?

    var selectedRow: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(value: Value, indexpath: Int, selectedRow: Int, titleID: String, selectArray: NSMutableArray) {
        self.selectedRow = selectedRow
        self.tagButton.tag = indexpath
        var id = ""

        if !(value.name.isNilOrEmpty) {
            self.tagLabel.text = "\(value.name!)"
        }
        if !(value.id.isNilOrEmpty) {
            id = value.id!
        }

        self.selectionView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.selectionView.clipsToBounds = true
        self.selectionView.layer.borderWidth = 2.0
        self.selectionView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.tagLabel.textColor = UIColor.colorLiteral.theme_grey_777777

        if selectArray.count > 0 {
            for item in selectArray {
                for (key, value) in (item as! NSDictionary) {
                    if key as! String == titleID {
                        let valueCode: String  = value as! String
                        if !(valueCode.isEmpty) && (valueCode == id) {
                            self.selectionView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                            self.tagLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
                        }
                    }
                }
            }
        }
    }
    @IBAction func tagButtonPressed(_ sender: UIButton) {
        self.delegate?.tagButtonPressedBottomSheetCartSpecificationCollectionViewCell(senderTag: sender.tag, selectedRow: self.selectedRow!)
    }
}
