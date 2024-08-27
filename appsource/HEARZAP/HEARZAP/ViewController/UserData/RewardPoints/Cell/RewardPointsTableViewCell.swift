//
//  RewardPointsTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 15/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class RewardPointsTableViewCell: UITableViewCell {

    @IBOutlet var topLineLabel: Caption2FontLabel!
    @IBOutlet var bottomLineLabel: Caption2FontLabel!
    @IBOutlet var dateLabel: Caption1FontLabel!
    @IBOutlet var pointsLabel: BodyFontLabel!
    @IBOutlet var reasonLabel: Caption1FontLabel!
    @IBOutlet var appliedLabel: Caption2FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(rewardTransaction: RewardTransaction, indexpath: Int, rewardTransactionCount: Int) {
        self.topLineLabel.isHidden = true
        self.bottomLineLabel.isHidden = true

        self.dateLabel.text = ""
        self.pointsLabel.text = ""
        self.reasonLabel.text = ""
        self.appliedLabel.text = ""
        if indexpath == 0 {
            self.topLineLabel.isHidden = true
        } else {
            self.topLineLabel.isHidden = false
        }
        if indexpath >= rewardTransactionCount - 1 {
            self.bottomLineLabel.isHidden = true
        } else {
            self.bottomLineLabel.isHidden = false
        }

        if !(rewardTransaction.txnDate.isNilOrEmpty) {
            self.dateLabel.text = rewardTransaction.txnDate!
        }
        if !(rewardTransaction.txnInfo.isNilOrEmpty) {
            self.appliedLabel.text = rewardTransaction.txnInfo!.capitalized
        }
        if !(rewardTransaction.txnUsage.isNilOrEmpty) {
            self.pointsLabel.text = rewardTransaction.txnUsage!
        }
        if !(rewardTransaction.txnDetail.isNilOrEmpty) {
            self.reasonLabel.text = rewardTransaction.txnDetail!.capitalized
        }
    }
}
