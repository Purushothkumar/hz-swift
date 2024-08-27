//
//  CustomView.swift
//  HEARZAP
//
//  Created by Purushoth on 06/07/22.
//  Copyright © 2022 SeaAnt. All rights reserved.
//

import Foundation
import UIKit

class CustomView: UIView {
    // MARK: - Properties
    @IBInspectable  lazy var isRoundRectButton: Bool = true

//    @IBInspectable var color: UIColor =  .clear {
//        didSet {
//            self.backgroundColor = color
//        }
//    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupView()
        }

    // MARK: - UI Setup
     override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
//        self.backgroundColor = color
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
        UILabel.appearance().adjustsFontForContentSizeCategory = false

        if isRoundRectButton {
//            self.layer.cornerRadius = self.bounds.height/2
            self.layer.cornerRadius = self.cornerRadius
        } else {
            self.layer.cornerRadius = self.cornerRadius
        }
    }

}
