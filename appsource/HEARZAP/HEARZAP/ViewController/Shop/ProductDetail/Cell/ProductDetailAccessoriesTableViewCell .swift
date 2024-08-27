//
//  ProductDetailAccessoriesTableViewCell .swift
//  HEARZAP
//
//  Created by Purushoth on 04/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolProductDetailAccessoriesTableViewCell {
    func checkButtonPressedProductDetailAccessoriesTableViewCell(senderTag: Int)
}

class ProductDetailAccessoriesTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var priceLabel: Caption2FontLabel!
    @IBOutlet var productAccessoriesCheckButton: FootnoteOutlineButton!
    @IBOutlet var productAccessoriestapButton: FootnoteOutlineButton!
    
    var delegate: ProtocolProductDetailAccessoriesTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    //    public func configure(productItemModel: ProductItemModel, indexpath: Int, productAccessoriesSelectedArray: [String]) {
    //        self.titleLabel.text = "\(productItemModel.brandName) | \(productItemModel.productName)"
    //        self.priceLabel.text = productItemModel.productSell
    //        if productAccessoriesSelectedArray.count == 3 {
    //            self.productAccessoriesCheckButton.setTitle(AppLocalizationString.addbothtobag.uppercased(), for: .normal)
    //        } else if productAccessoriesSelectedArray.count == 2 {
    //            self.productAccessoriesCheckButton.setTitle(AppLocalizationString.addallthreetobag.uppercased(), for: .normal)
    //        } else {
    //                self.productAccessoriesCheckButton.setTitle(AppLocalizationString.addtobag.uppercased(), for: .normal)
    //        }
    //    }
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        self.delegate?.checkButtonPressedProductDetailAccessoriesTableViewCell(senderTag: sender.tag)
    }
}
