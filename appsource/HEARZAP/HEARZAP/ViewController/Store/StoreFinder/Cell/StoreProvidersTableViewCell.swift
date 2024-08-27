//
//  StoreProvidersTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 08/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class StoreProvidersTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: FootnoteFontLabel!
    @IBOutlet var hearzapImageview: UIImageView!
    @IBOutlet var otherImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(storeProvidersModel: StoreProvidersModel, indexpath: Int) {
        self.titleLabel.text = storeProvidersModel.title
        if storeProvidersModel.hearzap == true {
            self.hearzapImageview.image = UIImage(named: Asset.checkcirclegreenfill)
        } else {
            self.hearzapImageview.image = UIImage(named: Asset.xlargered)
        }
        if storeProvidersModel.others == true {
            self.otherImageview.image = UIImage(named: Asset.checkcirclegreenfill)
        } else {
            self.otherImageview.image = UIImage(named: Asset.xlargered)
        }
    }
}
