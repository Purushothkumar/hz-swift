//
//  FindRightDeviceReportBannerTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 10/01/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit


protocol ProtocolFindRightDeviceReportBannerTableViewCell {
    func quickTestButtonPressedFindRightDeviceReportBannerTableViewCell(senderTag: Int)
    func bookAppointmentPressedFindRightDeviceReportBannerTableViewCell(senderTag: Int)
    
}
class FindRightDeviceReportBannerTableViewCell: UITableViewCell {
    
    @IBOutlet var orLabel: FootnoteFontLabel!
    
    var delegate: ProtocolFindRightDeviceReportBannerTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        self.orLabel.text = AppLocalizationString.or
    }
    @IBAction func quickTestButtonPressed(_ sender: UIButton) {
        self.delegate?.quickTestButtonPressedFindRightDeviceReportBannerTableViewCell(senderTag: sender.tag)
    }
    @IBAction func bookAppointmentPressed(_ sender: UIButton) {
        self.delegate?.bookAppointmentPressedFindRightDeviceReportBannerTableViewCell(senderTag: sender.tag)
    }
}
