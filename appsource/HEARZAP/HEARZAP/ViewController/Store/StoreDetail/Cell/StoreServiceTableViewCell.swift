//
//  StoreServiceTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 24/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class StoreServiceTableViewCell: UITableViewCell {
    @IBOutlet var serviceLabel: Caption1FontLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(storeService: StoreService, indexpath: Int) {
        self.serviceLabel.text = ""
        if !(storeService.description.isNilOrEmpty) {
            self.serviceLabel.text = storeService.description!.capitalized
        }
    }
}
