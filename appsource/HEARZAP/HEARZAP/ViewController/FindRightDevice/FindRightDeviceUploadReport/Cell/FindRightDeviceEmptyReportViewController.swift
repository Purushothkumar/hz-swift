//
//  FindRightDeviceEmptyReportTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 19/07/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class FindRightDeviceEmptyReportTableViewCell: UITableViewCell {
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var errorTapButton: CalloutOutlineButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        self.primaryMessageLabel.text = AppLocalizationString.noreportFound
        self.secondaryMessageLabel.text = AppLocalizationString.noreportDesc
    }
    // MARK: - IBAction
    @IBAction func errorTapButtonPressed(_ sender: UIButton) {
        
    }
}
