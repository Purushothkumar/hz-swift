//
//  ProductDetailTotalAmountTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 04/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProductDetailTotalAmountTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var priceLabel: Caption2FontLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    public func configure(total: String, indexpath: Int) {
        self.titleLabel.text = AppLocalizationString.totalprice
        self.priceLabel.text = "₹ 10000"
    }
}
