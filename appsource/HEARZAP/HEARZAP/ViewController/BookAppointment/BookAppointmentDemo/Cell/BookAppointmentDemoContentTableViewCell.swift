//
//  BookAppointmentDemoContentTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 22/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BookAppointmentDemoContentTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var descriptionLabel: Caption2FontLabel!
    @IBOutlet var countLabel: Caption2FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(bookingStep: BookingStep, indexPath: Int) {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.countLabel.text = ""
        if !(bookingStep.serviceStepName.isNilOrEmpty) {
            self.titleLabel.text = bookingStep.serviceStepName!.capitalized
        }
        if !(bookingStep.serviceDesc.isNilOrEmpty) {
            self.descriptionLabel.text = bookingStep.serviceDesc!.capitalized
        }
        if bookingStep.serviceStepOrder != nil {
            self.countLabel.text = "\(bookingStep.serviceStepOrder!)"
        }
    }
}
