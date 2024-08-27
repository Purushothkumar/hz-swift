//
//  HomeStaticReviewCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 16/04/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Cosmos

class HomeStaticReviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var reviewMessageLabel: BodyFontLabel!
    @IBOutlet var reviewByLabel: HeadlineFontLabel!
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet var stackview: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(homeStaticReviewModel: HomeStaticReviewModel, indexpath: Int) {
        var reviewByName = ""
        var review = ""
        var reviewRating = Double(0)
        
        if !(homeStaticReviewModel.reviewBySubline.isEmpty) {
            review = "\"\(String(describing: homeStaticReviewModel.reviewBySubline))\""
        }
        if !(homeStaticReviewModel.reviewByName.isEmpty) {
            reviewByName = "\(String(describing: homeStaticReviewModel.reviewByName))"
        }
        if !(homeStaticReviewModel.reviewRating.isEmpty) {
            reviewRating = Double(homeStaticReviewModel.reviewRating)!
        }
        self.reviewByLabel.text = reviewByName
        self.reviewMessageLabel.text = review
        self.ratingView.rating = reviewRating
    }
}
