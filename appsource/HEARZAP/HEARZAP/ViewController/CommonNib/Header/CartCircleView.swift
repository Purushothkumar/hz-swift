//
//  CartCircleView.swift
//  HEARZAP
//
//  Created by Purushoth on 23/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CartCircleView: NibView {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!

    @IBOutlet var button1: FootnoteOutlineButton!
    @IBOutlet var button2: FootnoteOutlineButton!
    @IBOutlet var button3: FootnoteOutlineButton!

    @IBOutlet var label1: Caption2FontLabel!
    @IBOutlet var label2: Caption2FontLabel!
    @IBOutlet var label3: Caption2FontLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup view from .xib file
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Setup view from .xib file
    }

    func setupView(button1image: String, button2image: String, button3image: String, label1Color: UIColor, label2Color: UIColor, label3Color: UIColor,circleViewBackgroundColor:UIColor) {
        self.label1.text = AppLocalizationString.delivery
        self.label2.text = AppLocalizationString.overview
        self.label3.text = AppLocalizationString.payment

        self.backgroundView.backgroundColor = circleViewBackgroundColor
        self.button1.setImage(button1image.isEmpty ? UIImage(named: Asset.circlegrey): UIImage(named: button1image), for: .normal)
        self.button2.setImage(button1image.isEmpty ? UIImage(named: Asset.circlegrey): UIImage(named: button2image), for: .normal)
        self.button3.setImage(button1image.isEmpty ? UIImage(named: Asset.circlegrey): UIImage(named: button3image), for: .normal)
        self.label1.textColor = label1Color
        self.label2.textColor = label2Color
        self.label3.textColor = label3Color

    }
}
