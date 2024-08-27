//
//  SRHATuningSummaryTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 02/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SRHATuningSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var deviceNameLabel: Caption1FontLabel!
    @IBOutlet weak var reasonLabel: Caption1FontLabel!
    @IBOutlet weak var dateLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(tuningComplaint: SRDModelTuningComplaint) {
        var deviceName = ""
        var complaint = ""
        var nextTuningDate = ""

        if !(tuningComplaint.deviceName.isNilOrEmpty) {
            deviceName = tuningComplaint.deviceName!
        }
        if !(tuningComplaint.complaint.isNilOrEmpty) {
            complaint = tuningComplaint.complaint!
        }
        if !(tuningComplaint.nextTuningDate.isNilOrEmpty) {
            nextTuningDate = String(format: "Next Tuning Date %@", tuningComplaint.nextTuningDate!)
        }

        self.deviceNameLabel.text = deviceName
        self.reasonLabel.text = complaint
        self.dateLabel.text = nextTuningDate
    }
}
