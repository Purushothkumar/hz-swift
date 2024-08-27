//
//  BottomSheetCartColorCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 13/07/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolBottomSheetCartColorCollectionViewCell {
    func tagButtonPressedBottomSheetCartColorCollectionViewCell(senderTag: Int, selectedRow: Int)
}

class BottomSheetCartColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet var tagLabel: Caption1FontLabel!
    @IBOutlet var tagButton: CalloutOutlineButton!
    @IBOutlet var selectionView: UIView!

    var delegate: ProtocolBottomSheetCartColorCollectionViewCell?

    var selectedRow: Int?

    var viewCon: BottomSheetCartViewController = BottomSheetCartViewController()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(value: Value, indexpath: Int, selectedRow: Int, titleID: String, selectArray: NSMutableArray, viewCon: BottomSheetCartViewController) {
        self.selectedRow = selectedRow
        self.tagButton.tag = indexpath
        self.viewCon = viewCon
        self.tagLabel.text = ""
        var id = ""
        var valueName = ""
        viewCon.colorName = ""

        if !(value.id.isNilOrEmpty) {
            id = value.id!
        }
        if !(value.name.isNilOrEmpty) {
            valueName = "\(value.name!)"
        }
        self.selectionView.clipsToBounds = true
        self.selectionView.layer.cornerRadius = tagHeight / 2

        self.tagLabel.clipsToBounds = true
        self.tagLabel.layer.borderWidth = 3.0
        self.tagLabel.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.tagLabel.layer.cornerRadius = tagHeight / 2
        self.tagLabel.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF

        if id.lowercased() == "Beige".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorBeige
            self.tagLabel.textColor = UIColor.ProductColor.productColorBeige
        } else if id.lowercased() == "Taupe".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorTaupe
            self.tagLabel.textColor = UIColor.ProductColor.productColorTaupe
        } else if id.lowercased() == "Dark gray".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorDarkGray
            self.tagLabel.textColor = UIColor.ProductColor.productColorDarkGray
        } else if id.lowercased() == "Gray".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorGray
            self.tagLabel.textColor = UIColor.ProductColor.productColorGray
        } else if id.lowercased() == "Black".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorBlack
            self.tagLabel.textColor = UIColor.ProductColor.productColorBlack
        } else if id.lowercased() == "Brown".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorBrown
            self.tagLabel.textColor = UIColor.ProductColor.productColorBrown
        } else if id.lowercased() == "Blue".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorBlue
            self.tagLabel.textColor = UIColor.ProductColor.productColorBlue
        } else if id.lowercased() == "Red".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorRed
            self.tagLabel.textColor = UIColor.ProductColor.productColorRed
        } else if id.lowercased() == "Silver".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorSilver
            self.tagLabel.textColor = UIColor.ProductColor.productColorSilver
        } else if id.lowercased() == "Gold".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorGold
            self.tagLabel.textColor = UIColor.ProductColor.productColorGold
        } else if id.lowercased() == "Rose Gold".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorRoseGold
            self.tagLabel.textColor = UIColor.ProductColor.productColorRoseGold
        } else if id.lowercased() == "White".lowercased() {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorWhite
            self.tagLabel.textColor = UIColor.ProductColor.productColorBlack
        } else {
            self.tagLabel.backgroundColor = UIColor.ProductColor.productColorWhite
            self.tagLabel.textColor = UIColor.ProductColor.productColorBlack
        }
        if selectArray.count > 0 {
            for item in selectArray {
                for (key, value) in (item as! NSDictionary) {
                    if key as! String == titleID {
                        let valueCode: String  = value as! String
                        if !(valueCode.isEmpty) && (valueCode == id) {
                            self.tagLabel.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                            self.tagLabel.text = ""
                            viewCon.colorName = valueCode
                        }
                    }
                }
            }
        }
    }
    @IBAction func tagButtonPressed(_ sender: UIButton) {
        self.delegate?.tagButtonPressedBottomSheetCartColorCollectionViewCell(senderTag: sender.tag, selectedRow: self.selectedRow!)
    }
}
