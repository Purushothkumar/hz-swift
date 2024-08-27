//
//  LogoNavigationBar.swift
//  HEARZAP
//
//  Created by Purushoth on 22/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolMainLogoNavigationBar {
    func leftButtonPressed()
    func rightButtonPressed()
    func leftSecondaryButtonPressed()
    func rightSecondaryButtonPressed()
}

// @IBDesignable
class MainLogoNavigationBar: NibView {

    @IBOutlet var leftView: UIView!
    @IBOutlet var leftButton: FootnoteOutlineButton!
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var leftViewHeight: NSLayoutConstraint!

    @IBOutlet var leftSecondaryView: UIView!
    @IBOutlet var leftSecondaryButton: FootnoteOutlineButton!
    @IBOutlet var leftSecondaryImageView: UIImageView!
    @IBOutlet var leftSecondaryViewHeight: NSLayoutConstraint!

    @IBOutlet var rightView: UIView!
    @IBOutlet var rightButton: FootnoteOutlineButton!
    @IBOutlet var rightImageView: UIImageView!
    @IBOutlet var rightViewHeight: NSLayoutConstraint!

    @IBOutlet var rightSecondaryView: UIView!
    @IBOutlet var rightSecondaryButton: FootnoteOutlineButton!
    @IBOutlet var rightSecondaryImageView: UIImageView!
    @IBOutlet var rightSecondaryViewHeight: NSLayoutConstraint!
    
    @IBOutlet var logoImageView: UIImageView!

    @IBOutlet var backgroundView: UIView!

    var delegate: ProtocolMainLogoNavigationBar?

    var isLeftViewHidden = false
    var isLeftSecondaryViewHidden = false
    var isRightViewHidden = false
    var isRightSecondaryViewHidden = false
    var isLogoHidden = false

    var leftImage = ""
    var leftSecondaryImage = ""
    var rightImage = ""
    var rightSecondaryImage = ""
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

    @IBAction func leftButtonPressed(_ sender: UIButton) {
        self.delegate?.leftButtonPressed()
    }
    @IBAction func leftSecondaryButtonPressed(_ sender: UIButton) {
        self.delegate?.leftSecondaryButtonPressed()
    }
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        self.delegate?.rightButtonPressed()
    }
    @IBAction func rightSecondaryButtonPressed(_ sender: UIButton) {
        self.delegate?.rightSecondaryButtonPressed()
    }
    func setupView(backgroundColor: UIColor) {
        self.backgroundView.backgroundColor = backgroundColor

        self.leftViewHeight.constant = 0
        self.leftSecondaryViewHeight.constant = 0

        self.rightViewHeight.constant = 0
        self.rightSecondaryViewHeight.constant = 0

        self.leftView.isHidden = self.isLeftViewHidden
        self.leftSecondaryView.isHidden = self.isLeftSecondaryViewHidden

        self.rightView.isHidden = self.isRightViewHidden
        self.rightSecondaryView.isHidden = self.isRightSecondaryViewHidden

        //        isLeftViewHidden = false
        //        isLeftSecondaryViewHidden = false
        //        isRightViewHidden = false
        //        isRightSecondaryViewHidden = false

        if self.isLeftViewHidden == false {
            self.leftViewHeight.constant = CGFloat(AppConstantValue.navigationBarButtonHeight)
            self.leftImageView.image = UIImage(named: leftImage)
        }
        if self.isLeftSecondaryViewHidden == false {
            self.leftSecondaryViewHeight.constant = CGFloat(AppConstantValue.navigationBarButtonHeight)
            self.leftSecondaryImageView.image = UIImage(named: leftSecondaryImage)
        }
        if self.isRightViewHidden == false {
            self.rightViewHeight.constant = CGFloat(AppConstantValue.navigationBarButtonHeight)
            self.rightImageView.image = UIImage(named: rightImage)
        }
        if self.isRightSecondaryViewHidden == false {
            self.rightSecondaryViewHeight.constant = CGFloat(AppConstantValue.navigationBarButtonHeight)
            self.rightSecondaryImageView.image = UIImage(named: rightSecondaryImage)
        }
        if self.isLogoHidden == false {
            self.logoImageView.image = UIImage(named: logoImage.isEmpty ? Asset.hzlogo : logoImage)
        }
    }
}
