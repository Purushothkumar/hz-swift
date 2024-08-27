//
//  FAQTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 09/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {

    @IBOutlet var stackview: UIStackView!
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var arrowImageView: UIImageView!
    @IBOutlet var descriptionLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    //    public func configure(faq: FAQCategoryModelFAQ, selectedSection: Int, indexpath: Int) {
    //        self.descriptionLabel.text = ""
    //        self.titleLabel.text = ""
    //
    /*       self.titleLabel.text = faqModelExpanded.question
     self.descriptionLabel.text = faqModelExpanded.answer
     let view_subtitle = stackview.arrangedSubviews[1]
     self.titleLabel.font = AppFont.regular.size(13)
     self.descriptionLabel.font = AppFont.regular.size(13)
     view_subtitle.isHidden = true
     if faqModelExpanded.expanded {
     self.titleLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
     self.titleLabel.font = AppFont.medium.size(13)
     titleLabel.isHidden = false
     view_subtitle.isHidden = false
     self.arrowImageView.image = UIImage(named: Asset.chevronupblue)
     } else {
     self.titleLabel.textColor = UIColor.colorLiteral.theme_grey_777777
     self.arrowImageView.image = UIImage(named: Asset.chevrondowngrey)
     view_subtitle.isHidden = true
     }*/
    //    }
}
