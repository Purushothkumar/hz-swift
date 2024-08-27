//
//  LogoNavigationBar.swift
//  HEARZAP
//
//  Created by Purushoth on 22/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolLogoNavigationBar {

    func leftButtonPressed()
    func rightButtonPressed()

}

// @IBDesignable
class LogoNavigationBar: NibView {

    @IBOutlet var leftView: UIView!
    @IBOutlet var leftButton: FootnoteOutlineButton!
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var rightView: UIView!
    @IBOutlet var rightButton: FootnoteOutlineButton!
    @IBOutlet var rightImageView: UIImageView!
    @IBOutlet var leftViewHeight: NSLayoutConstraint!
    @IBOutlet var rightViewHeight: NSLayoutConstraint!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var backgroundView: UIView!

    var delegate: ProtocolLogoNavigationBar?

    var isLeftViewHidden: Bool = false
    var isRightViewHidden: Bool = false
    var isLogoHidden = false
    var leftImage = ""
    var rightImage = ""
    var logoImage = ""


    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup view from .xib file
        self.setupView(backgroundColor: .clear)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Setup view from .xib file
        self.setupView(backgroundColor: .clear)
    }

    @IBAction func rightButtonPressed(_ sender: UIButton) {
        self.delegate?.rightButtonPressed()
    }
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        self.delegate?.leftButtonPressed()
    }

    func setupView(backgroundColor: UIColor) {
        self.backgroundView.backgroundColor = backgroundColor

        self.leftView.isHidden = self.isLeftViewHidden
        self.rightView.isHidden = self.isRightViewHidden
        self.leftViewHeight.constant = 0
        self.rightViewHeight.constant = 0
        if self.isLeftViewHidden == false {
            self.leftViewHeight.constant = CGFloat(AppConstantValue.navigationBarButtonHeight)
            self.leftImageView.image = UIImage(named: leftImage)
        }
        if self.isRightViewHidden == false {
            self.rightViewHeight.constant = CGFloat(AppConstantValue.navigationBarButtonHeight)
            self.rightImageView.image = UIImage(named: rightImage)
        }
        if self.isLogoHidden == false {
            self.logoImageView.image = UIImage(named: logoImage.isEmpty ? Asset.hzlogo : logoImage)
        }
    }
}
