//
//  AccessoriesSubCategoryColorImageTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 19/09/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolAccessoriesSubCategoryColorImageTableViewCell {
    func tapButtonPressedAccessoriesSubCategoryColorImageTableViewCell(senderTag: Int)
}
class AccessoriesSubCategoryColorImageTableViewCell: UITableViewCell {
    
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var tapButton: FootnoteOutlineButton!
    
    var delegate: ProtocolAccessoriesSubCategoryColorImageTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    public func configure(accessoriesSubcategoriesImage: String, subCategorySpec: SubCategorySpec, indexpath: Int) {
        self.tapButton.tag = indexpath
        var productImage = ""
        if !(accessoriesSubcategoriesImage.isEmpty) {
            productImage = accessoriesSubcategoriesImage
        }
        self.bannerImageView.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        //        self.delegate?.tapButtonPressedAccessoriesSubCategoryColorImageTableViewCell(senderTag: sender.tag)
    }
}
