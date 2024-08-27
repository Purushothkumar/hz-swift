//
//  Caption1FontTextfield.swift
//  HEARZAP
//
//  Created by Purushoth on 06/03/23.
//  Copyright © 2023 SeaAnt. All rights reserved.
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
        font = AppFont.regular.size(13)
    }
}
