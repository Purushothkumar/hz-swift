//
//  HearzapDifferenceCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 05/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class HearzapDifferenceCollectionViewCell: UICollectionViewCell {
    @IBOutlet var messageLabel: Caption1FontLabel!
    @IBOutlet var countLabel: Caption1FontLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(hearzapDifference: ShopHearzapDifferenceModelResult, indexpath: Int) {
        self.messageLabel.text = ""
        self.countLabel.text = ""
        var resultTitle = ""
        var resultDescription = ""
        
        if !(hearzapDifference.resultDescription.isNilOrEmpty) {
            resultDescription = "\(String(describing: hearzapDifference.resultDescription!))"
        }
        if !(hearzapDifference.title.isNilOrEmpty) {
            resultTitle = "\(String(describing: hearzapDifference.title!))"
        }
        
        let titleFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_orange_F7732F, NSAttributedString.Key.font: AppFont.medium.size(13)]
        let descriptionFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_black_333333, NSAttributedString.Key.font: AppFont.regular.size(13)]
        
        let title = NSMutableAttributedString(string: String(format: "%@\n", resultTitle), attributes: titleFontAttributes as [NSAttributedString.Key: Any])
        let description = NSMutableAttributedString(string: String(format: "%@", resultDescription), attributes: descriptionFontAttributes as [NSAttributedString.Key: Any])
        let combination = NSMutableAttributedString()
        combination.append(title)
        combination.append(description)
        self.messageLabel.attributedText = combination
        self.countLabel.text = "\(indexpath + 1)"
    }
}
