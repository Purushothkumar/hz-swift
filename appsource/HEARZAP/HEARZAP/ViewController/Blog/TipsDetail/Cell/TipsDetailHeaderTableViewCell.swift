//
//  TipsDetailHeaderHeaderTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 31/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class TipsDetailHeaderTableViewCell: UITableViewCell {
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var bannerHeaderImageView: UIImageView!
    @IBOutlet var headerLabel: Title2FontLabel!
    @IBOutlet var titleLabel: CalloutFontLabel!
    @IBOutlet var descriptionLabel: BodyFontLabel!
    @IBOutlet var headerStackview: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(tips: TipDetailList, indexpath: Int) {
        let view0 = self.headerStackview.arrangedSubviews[0]
        let view1 = self.headerStackview.arrangedSubviews[1]
        let view2 = self.headerStackview.arrangedSubviews[2]
        let view3 = self.headerStackview.arrangedSubviews[3]
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        self.bannerImageView.setImage(imageUrl: tips.image!, placeHolderImage: hearzapPlaceholder)

        self.headerLabel.text = String(format: "%@ %d", AppLocalizationString.tip, (1 + indexpath))

        if !(tips.title.isNilOrEmpty) {
            view0.isHidden = false
            view1.isHidden = false
            self.titleLabel.text = tips.title
        }
        if !(tips.content.isNilOrEmpty) {
            view0.isHidden = false
            view3.isHidden = false
            self.descriptionLabel.setHTMLFromString(htmlText: "\(String(describing: tips.content!))", fontFamily: AppConstantValue.poppinsregular, fontSize: 16.0, fontColor: AppConstantValue.fontGrey777777)
        }
        if !(tips.image.isNilOrEmpty) {
            view0.isHidden = false
            view2.isHidden = false
            self.bannerImageView.setImage(imageUrl: tips.image!, placeHolderImage: hearzapPlaceholder)
        }
    }
}
