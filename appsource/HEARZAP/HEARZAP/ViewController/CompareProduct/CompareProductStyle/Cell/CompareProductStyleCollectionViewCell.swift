//
//  CompareProductStyleCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCompareProductStyleCollectionViewCell {
    func styleButtonPressedCompareProductStyleCollectionViewCell(senderTag: Int)
}

class CompareProductStyleCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var styleButton: FootnoteOutlineButton!

    var delegate: ProtocolCompareProductStyleCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()

    }
    public func configure(modelList: ShopModelList, indexpath: Int) {
        self.styleButton.tag = indexpath
        self.titleLabel.text = ""
        var productImage = ""
        if !(modelList.name.isNilOrEmpty) {
            self.titleLabel.text = modelList.name?.capitalized
        }
        if modelList.info != nil{
            if modelList.info!.image != nil{
                if !(modelList.info!.image.isNilOrEmpty){
                    productImage = modelList.info!.image!
                }
            }
        }
        self.imageview.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
    }
    @IBAction func styleButtonPressed(_ sender: UIButton) {
        self.delegate?.styleButtonPressedCompareProductStyleCollectionViewCell(senderTag: sender.tag)
    }
}
