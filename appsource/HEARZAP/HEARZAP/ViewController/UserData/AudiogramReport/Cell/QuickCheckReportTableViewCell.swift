//
//  QuickCheckReportTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 08/05/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class QuickCheckReportTableViewCell: UITableViewCell {

    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var bannerImageViewHeight: NSLayoutConstraint!

    @IBOutlet var stackview: UIStackView!
    @IBOutlet var nameLabel: FootnoteFontLabel!
    @IBOutlet var reportLabel: Caption1FontLabel!
    @IBOutlet var dateLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(report: QuickTestReport, indexPath: Int) {
        var patientName = ""
        var reportName = ""
        var reportDate = ""

        let view0 = self.stackview.arrangedSubviews[0]
        let view1 = self.stackview.arrangedSubviews[1]
        let view2 = self.stackview.arrangedSubviews[2]

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true

        if !(report.patientName.isNilOrEmpty) {
            patientName = report.patientName!.capitalized
            view0.isHidden = false
        }
        if !(report.reportName.isNilOrEmpty) {
            reportName = report.reportName!.capitalized
            view1.isHidden = false
        }
        if !(report.reportDate.isNilOrEmpty) {
            reportDate = report.reportDate!.capitalized
            view2.isHidden = false
        }
        self.nameLabel.text = patientName
        self.reportLabel.text = reportName
        self.dateLabel.text = reportDate
    }
}
