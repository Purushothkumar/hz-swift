//
//  OnlineConsultationSingleSelectCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 21/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolOnlineConsultationSingleSelectCollectionViewCell {
    func selectButtonPressedOnlineConsultationSingleSelectCollectionViewCell(senderTag: Int, rowIndex: Int)
}

class OnlineConsultationSingleSelectCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var selectButton: FootnoteOutlineButton!
    @IBOutlet var selectView: UIView!

    var delegate: ProtocolOnlineConsultationSingleSelectCollectionViewCell?
    var rowIndex: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }

    public func configure(possibleAnswer: String, indexpath: Int, rowIndex: Int, concernArraySelected: NSMutableArray, selectedQuestion: String) {
        self.titleLabel.text = possibleAnswer
        self.selectButton.tag = indexpath
        self.rowIndex = rowIndex
        self.setDisableColor()

        for item in concernArraySelected {
            for (key, value) in (item as! NSDictionary) {
                if (key as! String) == selectedQuestion {
                    let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                   if arrayValueCode.contains(possibleAnswer) {
                       for index in 0..<arrayValueCode.count {
                           if arrayValueCode[index] as! String == possibleAnswer {
                               self.setEnableColor()
                           } else {
                               self.setDisableColor()
                           }
                       }
                    } else {
                        self.setDisableColor()
                    }
                }
            }
        }
    }
    func setEnableColor() {
        self.selectView.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
        self.selectView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.selectView.layer.borderWidth = 1.0
        self.titleLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
    }
    func setDisableColor() {
        self.titleLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.selectView.layer.borderColor = UIColor.colorLiteral.theme_white_F6FAFD.cgColor
        self.selectView.layer.borderWidth = 1.0
        self.selectView.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD

    }

    @IBAction func selectButtonPressed(_ sender: UIButton) {
        self.delegate?.selectButtonPressedOnlineConsultationSingleSelectCollectionViewCell(senderTag: sender.tag, rowIndex: rowIndex!)
    }
}
