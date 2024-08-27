//
//  StoreDetailReviewRatingCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 28/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//
import UIKit
import Cosmos

class StoreDetailReviewRatingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var reviewMessageLabel: Caption2FontLabel!
    @IBOutlet var reviewByLabel: FootnoteFontLabel!
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet var stackview: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(storeReview: StoreReview, indexpath: Int) {
        var reviewByName = ""
        var review = ""
        var reviewRating = Double(0)
        if !(storeReview.review.isNilOrEmpty) {
            review = "\"\(String(describing: storeReview.review!))\""
        }
        if !(storeReview.createdBy.isNilOrEmpty) {
            reviewByName = "\(String(describing: storeReview.createdBy!))"
        }
        if !(storeReview.rating.isNilOrEmpty) {
            reviewRating = Double(storeReview.rating!)!
        }
        self.reviewByLabel.text = reviewByName
        self.reviewMessageLabel.text = review
        self.ratingView.rating = reviewRating
    }
}
