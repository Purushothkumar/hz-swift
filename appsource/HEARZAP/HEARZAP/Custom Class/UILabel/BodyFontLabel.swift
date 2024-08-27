//
//  BodyFontLabel.swift
//  HEARZAP
//
//  Created by Purushoth on 06/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

class BodyFontLabel: UILabel {
    
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
        font = AppFont.regular.size(16)
    }
}
