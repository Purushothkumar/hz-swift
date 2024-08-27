//
//  UITableviewCell+TableviewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 04/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit
import ShimmerEffect_iOS

extension UITableViewCell {
    // MARK: - Show/hide separator lines in tableview cell
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
    func showSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)// UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    // MARK: - shadow effect
    func addTableViewCellShadow(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowColor: UIColor) {
        self.contentView.layer.cornerRadius = cornerRadius// 4.0
        self.contentView.layer.borderWidth = borderWidth// 1.0
        self.contentView.layer.borderColor = borderColor.cgColor// UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = shadowColor.cgColor// UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = shadowRadius// 2.0
        self.layer.shadowOpacity = shadowOpacity// 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
