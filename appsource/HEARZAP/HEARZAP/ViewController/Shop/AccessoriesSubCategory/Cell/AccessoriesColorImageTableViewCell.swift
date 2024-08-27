//
//  AccessoriesColorImageTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 09/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolAccessoriesColorImageTableViewCell {
    func tapButtonPressedAccessoriesColorImageTableViewCell(senderTag: Int)
}
class AccessoriesColorImageTableViewCell: UITableViewCell {
    
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var tapButton: FootnoteOutlineButton!
    
    var delegate: ProtocolAccessoriesColorImageTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    public func configure(subCategorySpec: SubCategorySpec, indexpath: Int) {
        self.tapButton.tag = indexpath
        var productImage = ""
        if !(subCategorySpec.value.isNilOrEmpty) {
            productImage = subCategorySpec.value!
        }
        self.bannerImageView.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedAccessoriesColorImageTableViewCell(senderTag: sender.tag)
    }
}
