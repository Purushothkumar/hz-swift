//
//  BottomSheetLifeStyleTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 11/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BottomSheetLifeStyleTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(data: String, indexpath: Int) {
        self.titleLabel.text = data
    }
}
