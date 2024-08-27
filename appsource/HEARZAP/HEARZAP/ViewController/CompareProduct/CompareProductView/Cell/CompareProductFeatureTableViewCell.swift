//
//  CompareProductFeatureTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 10/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CompareProductFeatureTableViewCell: UITableViewCell {
    @IBOutlet var headerLabel: FootnoteFontLabel!
    @IBOutlet var contentLabel1: Caption2FontLabel!
    @IBOutlet var contentLabel2: Caption2FontLabel!
    @IBOutlet var statusImageView1: UIImageView!
    @IBOutlet var statusImageView2: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(compareFeaturesModel: CompareProductModelProductFeatureElement, indexpath: Int, product1: String, product2: String) {
        self.headerLabel.text = ""
        self.contentLabel1.text = ""
        self.contentLabel2.text = ""
        var bool1 = false
        var bool2 = false
        if !(compareFeaturesModel.key.isNilOrEmpty) {
            self.headerLabel.text = compareFeaturesModel.key!.capitalized

            if !(product1.isEmpty) {
                if !(compareFeaturesModel.product1Value.isNilOrEmpty) {
                    self.contentLabel1.text = compareFeaturesModel.product1Value!.capitalized
                } else {
                    self.contentLabel1.text = "-"
                }
                if compareFeaturesModel.product1 != nil {
                    bool1 = compareFeaturesModel.product1!
                }
                self.statusImageView1.image = bool1 == true ? UIImage(named: Asset.hearzapicongreen) : UIImage(named: Asset.hearzapiconred)
            }

            if !(product2.isEmpty) {
                if !(compareFeaturesModel.product2Value.isNilOrEmpty) {
                    self.contentLabel2.text = compareFeaturesModel.product2Value!.capitalized
                } else {
                    self.contentLabel2.text = "-"
                }
                if compareFeaturesModel.product2 != nil {
                    bool2 = compareFeaturesModel.product2!
                }
                self.statusImageView2.image = bool2 == true ? UIImage(named: Asset.hearzapicongreen) : UIImage(named: Asset.hearzapiconred)
            }
        }
    }
}
