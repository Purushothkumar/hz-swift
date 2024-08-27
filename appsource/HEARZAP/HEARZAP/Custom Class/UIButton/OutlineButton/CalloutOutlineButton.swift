//
//  CalloutOutlineButton.swift
//  HEARZAP
//
//  Created by Purushoth on 06/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

class CalloutOutlineButton: UIButton {
    // MARK: - Properties
    @IBInspectable  lazy var isRoundRectButton: Bool = true
    
    //    @IBInspectable var color: UIColor =  .clear {
    //        didSet {
    //            self.backgroundColor = color
    //        }
    //    }
    //    @IBInspectable var titleColour: UIColor = .black {
    //            didSet {
    //                setTitleColor(titleColour, for: .normal)
    //            }
    //        }
    @IBInspectable var cornerRadius: CGFloat = 4 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
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
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
        //        self.setTitleColor(titleColour, for: .normal)
        //        self.tintColor = titleColour
        self.titleLabel?.adjustsFontForContentSizeCategory = false
        self.titleLabel?.font = AppFont.semibold.size(16)
        
        if isRoundRectButton {
            //            self.layer.cornerRadius = self.bounds.height/2
            self.layer.cornerRadius = self.cornerRadius
        } else {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
}
