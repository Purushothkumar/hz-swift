//
//  FindRightDeviceIntroductionResultTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 08/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AuthenticationServices

class FindRightDeviceIntroductionResultTableViewCell: UITableViewCell {
    
    @IBOutlet var stackview: UIStackView!
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var timeLabel: Caption2FontLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(previousResult: PreviousResult, indexPath: Int) {
        let view0 = self.stackview.arrangedSubviews[0]// title
        let view1 = self.stackview.arrangedSubviews[1]// time
        
        view0.isHidden = true
        view1.isHidden = true
        
        self.titleLabel.text = ""
        self.timeLabel.text = ""
        if !(previousResult.updatedOn.isNilOrEmpty) {
            view1.isHidden = false
            self.timeLabel.text = "\(String(describing: previousResult.updatedOn!))"
        }
        var lifestyle = ""
        var model = ""
        var earInfo = ""
        var dataToDisplay = ""
        
        if previousResult.input != nil {
            if !(previousResult.input!.lifestyle.isNilOrEmpty) {
                lifestyle = "\(String(describing: previousResult.input!.lifestyle!))"
            }
            if previousResult.input!.model != nil {
                let array = previousResult.input!.model
                model = ""
                if array!.count > 0 {
                    model = array!.joined(separator: ",")
                }
            }
            if !(previousResult.input!.earInfo.isNilOrEmpty) {
                earInfo = "\(String(describing: previousResult.input!.earInfo!))"
            }
            if !(lifestyle.isEmpty) {
                dataToDisplay = lifestyle
            }
            if !(dataToDisplay.isEmpty) && !(model.isEmpty) {
                dataToDisplay = "\(dataToDisplay) | \(model)"
            } else if !(model.isEmpty) {
                dataToDisplay = model
            }
            if !(dataToDisplay.isEmpty) && !(earInfo.isEmpty) {
                dataToDisplay = "\(dataToDisplay) | \(earInfo)"
            } else if !(earInfo.isEmpty) {
                dataToDisplay = earInfo
            }
        }
        if !(dataToDisplay.isEmpty) {
            view0.isHidden = false
        }
        self.titleLabel.text = dataToDisplay.capitalized
    }
}
