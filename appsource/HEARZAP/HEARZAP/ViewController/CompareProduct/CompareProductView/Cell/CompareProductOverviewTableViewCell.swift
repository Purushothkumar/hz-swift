//
//  CompareProductOverviewTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 10/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CompareProductOverviewTableViewCell: UITableViewCell {
    @IBOutlet var headerLabel: FootnoteFontLabel!
    @IBOutlet var contentLabel1: Caption2FontLabel!
    @IBOutlet var contentLabel2: Caption2FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(compareOverviewModel: CompareProductModelProductOverViewElement, indexpath: Int, product1: String, product2: String) {
        self.headerLabel.text = ""
        self.contentLabel1.text = ""
        self.contentLabel2.text = ""
        if !(compareOverviewModel.key.isNilOrEmpty) {
            self.headerLabel.text = compareOverviewModel.key!.capitalized
            if !(product1.isEmpty) {
                if !(compareOverviewModel.product1.isNilOrEmpty) {
                    self.contentLabel1.text = compareOverviewModel.product1!.capitalized
                } else {
                    self.contentLabel1.text = "-"
                }
            }

            if !(product2.isEmpty) {
                if !(compareOverviewModel.product2.isNilOrEmpty) {
                    self.contentLabel2.text = compareOverviewModel.product2!.capitalized
                } else {
                    self.contentLabel2.text = "-"
                }
            }
        }
    }
}
