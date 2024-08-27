//
//  AccessoriesCategoryCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 01/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolAccessoriesCategoryCollectionViewCell {
    func tapButtonPressedAccessoriesCategoryCollectionViewCell(senderTag: Int)
}

class AccessoriesCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var productView: UIView!
    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var productCategoryLabel: CalloutFontLabel!
    @IBOutlet var productItemLabel: Caption2FontLabel!
    @IBOutlet var tapButton: FootnoteBackgroundButton!
    
    var delegate: ProtocolAccessoriesCategoryCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(shopModelList: ShopModelList, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.productCategoryLabel.text = ""
        self.productItemLabel.text = ""
        self.tapButton.setTitle("  \(AppLocalizationString.shopnow.uppercased())  ", for: .normal)
        var productImage = ""
        if !(shopModelList.photo.isNilOrEmpty) {
            productImage = shopModelList.photo!
        }
        if !(shopModelList.name.isNilOrEmpty) {
            self.productCategoryLabel.text = shopModelList.name!
        }
        //        if shopModelList.productsCount != nil {
        //            if shopModelList.productsCount! > 1 {
        //                self.productItemLabel.text = String(format: "%d-%@", shopModelList.productsCount!, AppLocalizationString.items)
        //            } else if shopModelList.productsCount! >= 0 {
        //                self.productItemLabel.text = String(format: "%d-%@", shopModelList.productsCount!, AppLocalizationString.item)
        //            }
        //        }
        self.productImageView.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
    }
    
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedAccessoriesCategoryCollectionViewCell(senderTag: sender.tag)
    }
}
