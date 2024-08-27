//
//  StoreFeatureTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 28/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class StoreFeatureTableViewCell: UITableViewCell {
    
    @IBOutlet var featureLabel: Caption1FontLabel!
    @IBOutlet var featureview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(storeFeature: StoreFeature, indexpath: Int) {
        self.featureLabel.text = ""
        if !(storeFeature.description.isNilOrEmpty) {
            self.featureLabel.text = storeFeature.description!.capitalized
        }
    }
}
