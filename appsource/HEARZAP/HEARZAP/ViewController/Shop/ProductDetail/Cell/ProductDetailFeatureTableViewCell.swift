//
//  ProductDetailFeatureTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 03/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProductDetailFeatureTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descritionLabel: Caption2FontLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(productFeature: ProductFeature, indexpath: Int) {
        var keyString = ""
        var valueString = ""
        
        if productFeature != nil {
            if !(productFeature.name.isNilOrEmpty) {
                keyString = productFeature.name!
                if !(productFeature.value.isNilOrEmpty) {
                    valueString = productFeature.value!
                }
            }
        }
        if valueString.isEmpty {
            valueString = "-"
        }
        self.titleLabel.text = keyString.capitalized
        self.descritionLabel.text = valueString
    }
}
