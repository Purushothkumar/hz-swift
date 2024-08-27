//
//  ProductFilterStyleTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 31/05/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProductFilterStyleTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var selectButton: FootnoteOutlineButton!
    @IBOutlet var checkMarkButton: FootnoteOutlineButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
