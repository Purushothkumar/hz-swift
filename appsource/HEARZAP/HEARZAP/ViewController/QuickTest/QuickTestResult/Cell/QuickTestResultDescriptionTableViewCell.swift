//
//  QuickTestResultDescriptionTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 08/12/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class QuickTestResultDescriptionTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: FootnoteFontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!
    @IBOutlet var warningView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(quickTestResultModel: QuickTestResultModel, indexpath: Int,canHideShimmering: Bool) {
        if (canHideShimmering == false){
            self.backgroundColor = UIColor.clear
        }
        else{
            self.backgroundColor = quickTestResultModel.bgcolorcode
        }
        self.warningView.backgroundColor = quickTestResultModel.colorcode
        self.titleLabel.text = quickTestResultModel.title
        self.descriptionLabel.text = quickTestResultModel.message
        
        self.warningView.shimmerEffectView(canStop: canHideShimmering)
        self.titleLabel.shimmerEffectView(canStop: canHideShimmering)
        self.descriptionLabel.shimmerEffectView(canStop: canHideShimmering)
        
    }
}
