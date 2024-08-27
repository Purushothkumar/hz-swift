//
//  CheckOutSummaryPriceTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 08/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CheckOutSummaryPriceTableViewCell: UITableViewCell {

    @IBOutlet var priceTitleLabel: Caption1FontLabel!
    @IBOutlet var priceDescLabel: Caption1FontLabel!
    @IBOutlet var priceQtyLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(pricingDetail: PricingDetail, indexpath: Int) {
        var name = ""
        var info = ""
        var price = ""

        if !(pricingDetail.name.isNilOrEmpty) {
            name = pricingDetail.name!.capitalized
        }
        if !(pricingDetail.info.isNilOrEmpty) {
            info = pricingDetail.info!
        }
        if !(pricingDetail.price.isNilOrEmpty) {
            price = pricingDetail.price!
        }
        self.priceTitleLabel.text = name
        self.priceDescLabel.text = price
        self.priceQtyLabel.text = info
    }
}
