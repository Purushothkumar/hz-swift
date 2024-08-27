//
//  QuickTestStatusView.swift
//  HEARZAP
//
//  Created by Purushoth on 23/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class QuickTestStatusView: NibView {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var stackView: UIStackView!

    @IBOutlet var view1: UIView!
    @IBOutlet var activityIndicator1: UIActivityIndicatorView!
    @IBOutlet var imageview1: UIImageView!
    @IBOutlet var label1: Caption2FontLabel!

    @IBOutlet var view2: UIView!
    @IBOutlet var activityIndicator2: UIActivityIndicatorView!
    @IBOutlet var imageview2: UIImageView!
    @IBOutlet var label2: Caption2FontLabel!

  

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup view from .xib file
        self.label1.text = AppLocalizationString.connecttabHeadphone
        self.label2.text = AppLocalizationString.noiseLeveltabCheck
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Setup view from .xib file
    }

    func setupView(showImage1: Bool, showImage2: Bool, showImage3: Bool, isHeadsetConnected: Bool, isNoiseDetected: Bool, isEarchecked: Bool) {
        self.backgroundView.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD

        if showImage1 == true {
            self.imageview1.isHidden = false
            self.activityIndicator1.stopAnimating()
            self.activityIndicator1.isHidden = true
        } else {
            self.imageview1.isHidden = true
            self.activityIndicator1.isHidden = false
            if isHeadsetConnected == true {
                self.activityIndicator1.color = UIColor.colorLiteral.theme_blue_2AACEF
                self.activityIndicator1.startAnimating()
            } else {
                self.activityIndicator1.color = UIColor.colorLiteral.theme_blue_2AACEF
                self.activityIndicator1.startAnimating()
            }
        }
        if showImage2 == true {
            self.imageview2.isHidden = false
            self.activityIndicator2.stopAnimating()
            self.activityIndicator2.isHidden = true
        } else {
            self.imageview2.isHidden = true
            self.activityIndicator2.isHidden = false
            if isNoiseDetected == true {
                self.activityIndicator2.color = UIColor.colorLiteral.theme_blue_2AACEF
                self.activityIndicator2.startAnimating()
            } else {
                self.activityIndicator2.color = UIColor.colorLiteral.theme_blue_2AACEF
                self.activityIndicator2.startAnimating()
            }
        }
    }
}
