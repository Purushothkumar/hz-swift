//
//  ServiceCouponListTitleTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 30/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ServiceCouponListTitleTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: CalloutFontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
