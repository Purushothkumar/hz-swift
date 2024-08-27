//
//  SRDQuantityTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 26/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SRDQuantityTableViewCell: UITableViewCell {
    @IBOutlet var quantityTitleLabel: Caption1FontLabel!
    @IBOutlet var quantityLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
