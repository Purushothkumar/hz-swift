//
//  Caption1FontEditableTextfield.swift
//  HEARZAP
//
//  Created by Purushoth on 22/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

class Caption1FontEditableTextfield: UITextField {

    public override func awakeFromNib() {
        super.awakeFromNib()
        configureLabel()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureLabel()
    }

    func configureLabel() {
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
}
