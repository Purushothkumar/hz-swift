//
//  ProductDetailSpecificationTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 03/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProductDetailSpecificationTableViewCell: UITableViewCell {
    
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
    public func configure(productSpecification: ProductSpecification, indexpath: Int) {
        var keyString = ""
        var valueString = ""
        
        if productSpecification != nil {
            if !(productSpecification.name.isNilOrEmpty) {
                keyString = productSpecification.name!
                if productSpecification.values != nil {
                    if productSpecification.values!.count > 0 {
                        let arrayValue: [String] = productSpecification.values!.compactMap {$0.name}
                        valueString = arrayValue.joined(separator: ",")
                    }
                }
            }
        }
        
        self.titleLabel.text = keyString.capitalized
        self.descritionLabel.text = valueString
    }
}
