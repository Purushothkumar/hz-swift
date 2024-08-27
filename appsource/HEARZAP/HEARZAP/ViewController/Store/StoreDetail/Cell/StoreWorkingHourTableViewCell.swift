//
//  StoreWorkingHourTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 01/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class StoreWorkingHourTableViewCell: UITableViewCell {
    
    @IBOutlet var workingHourLabel: FootnoteFontLabel!
    @IBOutlet var workingTimeLabel: Caption1FontLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    public func configure(storeWorkHour: StoreWorkHour, indexpath: Int) {
        self.workingHourLabel.text = ""
        self.workingTimeLabel.text = ""
        
        var day = ""
        var workingHours = ""
        
        if !(storeWorkHour.day.isNilOrEmpty) {
            day = storeWorkHour.day!
        }
        if !(storeWorkHour.workingHours.isNilOrEmpty) {
            workingHours = storeWorkHour.workingHours!
        }
        if !(day.isEmpty) {
            self.workingHourLabel.text = day
        }
        if !(workingHours.isEmpty) {
            self.workingTimeLabel.text = workingHours
        }
        
    }
    
}
