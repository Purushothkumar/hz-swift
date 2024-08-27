//
//  Caption1FontTextfield.swift
//  HEARZAP
//
//  Created by Purushoth on 06/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

class Caption1FontTextfield: UITextField {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureLabel()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureLabel()
    }
    
    func configureLabel() {
        self.textContentType = .none
        font = AppFont.regular.size(13)
    }
    // MARK: - Set Image on the right of text fields
    func setupRightImage(imageName: String, color: UIColor) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 16, height: 16))
        imageView.image = UIImage(named: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageContainerView.addSubview(imageView)
        rightView = imageContainerView
        rightViewMode = .always
        self.tintColor = color
    }
    
    // MARK: - Set Image on left of text fields
    func setupLeftImage(imageName: String, color: UIColor) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 16, height: 16))
        imageView.image = UIImage(named: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
        self.tintColor = color
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // Disable the actions: cut, copy, paste, select, select all
        if self.isFirstResponder {
            DispatchQueue.main.async(execute: {
                if #available(iOS 13.0, *) {
                    (sender as? UIMenuController)?.hideMenu()
                } else {
                    (sender as? UIMenuController)?.setMenuVisible(false, animated: false)
                }
            })
            return false
        }
        let disabledSelectors: [Selector] = [
                    #selector(cut(_:)),
                    #selector(copy(_:)),
                    #selector(paste(_:)),
                    #selector(select(_:)),
                    #selector(selectAll(_:)),
                    #selector(delete(_:)),
                    #selector(makeTextWritingDirectionLeftToRight(_:)),
                    #selector(makeTextWritingDirectionRightToLeft(_:)),
                    #selector(toggleBoldface(_:)),
                    #selector(toggleItalics(_:)),
                    #selector(toggleUnderline(_:)),
                    #selector(increaseSize(_:)),
                    #selector(decreaseSize(_:))
                ]

                if disabledSelectors.contains(action) {
                    return false
                }

                return super.canPerformAction(action, withSender: sender)

    }
}
