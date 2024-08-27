//
//  StoreFAQTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 27/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolStoreFAQTableViewCell {
    func storeFAQButtonPressedStoreFAQTableViewCell()
}
class StoreFAQTableViewCell: UITableViewCell {
    @IBOutlet var descriptionLabel: Caption1FontLabel!
    @IBOutlet var stackview: UIStackView!
    @IBOutlet var titleLabel: Caption1FontLabel!
    @IBOutlet var arrowImageView: UIImageView!
    
    var delegate: ProtocolStoreFAQTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(FAQModelExpanded: FAQModelExpanded, indexpath: Int) {
        self.descriptionLabel.text = ""
        self.titleLabel.text = ""
        self.titleLabel.text = FAQModelExpanded.question
        self.descriptionLabel.text = FAQModelExpanded.answer
        let view_subtitle = stackview.arrangedSubviews[1]
        self.titleLabel.font = AppFont.regular.size(13)
        self.descriptionLabel.font = AppFont.regular.size(13)
        view_subtitle.isHidden = true
        if FAQModelExpanded.expanded {
            //            self.titleLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
            self.titleLabel.font = AppFont.medium.size(13)
            titleLabel.isHidden = false
            view_subtitle.isHidden = false
            self.arrowImageView.image = UIImage(named: Asset.chevronupblue)
        } else {
            //            self.titleLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
            self.arrowImageView.image = UIImage(named: Asset.chevrondowngrey)
            view_subtitle.isHidden = true
        }
    }
    @IBAction func storeFAQButtonPressed(_ sender: UIButton) {
        self.delegate?.storeFAQButtonPressedStoreFAQTableViewCell()
    }
}
