//
//  CommonTitleView.swift
//  HEARZAP
//
//  Created by Purushoth on 23/07/23.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CommonTitleView: NibView {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var titleLabel: CalloutFontLabel!
    @IBOutlet var descriptionLabel: Caption2FontLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup view from .xib file
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.titleLabel.sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Setup view from .xib file
    }

    func setupView(titleMessage: String, descriptionMessage: String, commonTitlebackgroundViewColor:UIColor) {
        self.backgroundView.backgroundColor = commonTitlebackgroundViewColor
        self.titleLabel.text = titleMessage
        self.descriptionLabel.text = descriptionMessage
    }
}
