//
//  FourDotCircleView.swift
//  HEARZAP
//
//  Created by Purushoth on 23/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class FourDotCircleView: NibView {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!

    @IBOutlet var button1: FootnoteOutlineButton!
    @IBOutlet var button2: FootnoteOutlineButton!
    @IBOutlet var button3: FootnoteOutlineButton!
    @IBOutlet var button4: FootnoteOutlineButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup view from .xib file
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Setup view from .xib file
    }

    func setupView(button1image: String, button2image: String, button3image: String, button4image: String,circleViewBackgroundColor:UIColor) {
        self.backgroundView.backgroundColor = circleViewBackgroundColor
        self.button1.setImage(button1image.isEmpty ? UIImage(named: Asset.circlegrey): UIImage(named: button1image), for: .normal)
        self.button2.setImage(button2image.isEmpty ? UIImage(named: Asset.circlegrey): UIImage(named: button2image), for: .normal)
        self.button3.setImage(button3image.isEmpty ? UIImage(named: Asset.circlegrey): UIImage(named: button3image), for: .normal)
        self.button4.setImage(button4image.isEmpty ? UIImage(named: Asset.circlegrey): UIImage(named: button4image), for: .normal)
    }
}
