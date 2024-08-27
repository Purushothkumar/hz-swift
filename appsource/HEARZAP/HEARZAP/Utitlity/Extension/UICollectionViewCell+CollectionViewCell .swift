//
//  UICollectionViewCell+CollectionViewCell .swift
//  HEARZAP
//
//  Created by Purushoth on 20/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit
import ShimmerEffect_iOS

extension UICollectionViewCell {
    // MARK: - shadow effect
    func addCollectionViewCellShadow(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowColor: UIColor) {
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
