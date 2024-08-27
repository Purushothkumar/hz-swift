//
//  CompareProductHeaderView.swift
//  HEARZAP
//
//  Created by Purushoth on 23/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CompareProductHeaderView: NibView {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!

    @IBOutlet var brandLabel: Caption2FontLabel!
    @IBOutlet var priceLabel: Caption2FontLabel!
    @IBOutlet var styleLabel: Caption2FontLabel!
    @IBOutlet var modelLabel: Caption2FontLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup view from .xib file
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Setup view from .xib file
    }

    func setupView(currentPage: String) {
        self.backgroundView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.brandLabel.textColor = currentPage == CompareProductHeader.brand.rawValue ? UIColor.colorLiteral.theme_blue_112F70 : UIColor.colorLiteral.theme_grey_777777
        self.priceLabel.textColor = currentPage == CompareProductHeader.price.rawValue ? UIColor.colorLiteral.theme_blue_112F70 : UIColor.colorLiteral.theme_grey_777777
        self.styleLabel.textColor = currentPage == CompareProductHeader.style.rawValue ? UIColor.colorLiteral.theme_blue_112F70 : UIColor.colorLiteral.theme_grey_777777
        self.modelLabel.textColor = currentPage == CompareProductHeader.model.rawValue ? UIColor.colorLiteral.theme_blue_112F70 : UIColor.colorLiteral.theme_grey_777777
    }
}
