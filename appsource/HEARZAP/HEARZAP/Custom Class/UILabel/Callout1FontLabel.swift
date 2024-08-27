//
//  Callout1FontLabel.swift
//  HEARZAP
//
//  Created by Purushoth on 15/04/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

class Callout1FontLabel: UILabel {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureLabel()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureLabel()
    }
    
    func configureLabel() {
        if #available(iOS 14.0, *) {
            self.lineBreakStrategy = []
        }
        font = AppFont.semibold.size(40)
    }
}
