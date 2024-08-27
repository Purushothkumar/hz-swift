//
//  ProductDetailBoxTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 03/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProductDetailBoxTableViewCell: UITableViewCell {
    
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
    public func configure(productBoxing: ProductBoxing, indexpath: Int) {
        self.titleLabel.text = ""
        self.descritionLabel.text = ""
        
        if !(productBoxing.itemName.isNilOrEmpty) {
            self.titleLabel.text = productBoxing.itemName!
            
            if productBoxing.itemCount != nil {
                if productBoxing.itemCount! > 1 {
                    self.descritionLabel.text = String(format: "%d %@", productBoxing.itemCount!, AppLocalizationString.items)
                } else {
                    self.descritionLabel.text = String(format: "%d %@", productBoxing.itemCount!, AppLocalizationString.item)
                }
            } else {
                self.descritionLabel.text = String(format: "%d %@", 0, AppLocalizationString.item)
            }
        }
    }
}
