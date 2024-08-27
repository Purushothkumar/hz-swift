//
//  OrderDetailItemTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 10/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class OrderDetailItemTableViewCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var itemTitleLabel: Caption1FontLabel!
    @IBOutlet weak var itemQuantityLabel: Caption1FontLabel!
    @IBOutlet weak var itemSpecificationLabel: Caption2FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(item: OrderItemList, indexpath: Int) {
        var productName = ""
        var qty = ""
        var specifications = ""
        if !(item.productName.isNilOrEmpty) {
            productName = item.productName!
        }
        if !(item.specifications.isNilOrEmpty) {
            specifications = item.specifications!
        }
        if item.qty != nil {
            qty = String(format: "%@%d", AppLocalizationString.qty, item.qty!)
        }
        self.itemTitleLabel.text = productName
        self.itemQuantityLabel.text = qty
        self.itemSpecificationLabel.text = specifications
    }
}
