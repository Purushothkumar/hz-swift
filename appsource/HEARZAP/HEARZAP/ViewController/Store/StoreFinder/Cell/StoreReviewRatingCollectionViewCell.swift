//
//  StoreReviewRatingCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 27/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Cosmos

class StoreReviewRatingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var reviewMessageLabel: Caption1FontLabel!
    @IBOutlet var reviewByLabel: FootnoteFontLabel!
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet var stackview: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(storeFinderCustomerTestimonialResult: StoreFinderCustomerTestimonialResult, indexpath: Int) {
        var reviewByName = ""
        var review = ""
        var reviewRating = Double(0)
        
        if !(storeFinderCustomerTestimonialResult.reviewBySubline.isNilOrEmpty) {
            review = "\"\(String(describing: storeFinderCustomerTestimonialResult.reviewBySubline!))\""
        }
        if !(storeFinderCustomerTestimonialResult.reviewByName.isNilOrEmpty) {
            reviewByName = "\(String(describing: storeFinderCustomerTestimonialResult.reviewByName!))"
        }
        if !(storeFinderCustomerTestimonialResult.reviewRating.isNilOrEmpty) {
            reviewRating = Double(storeFinderCustomerTestimonialResult.reviewRating!)!
        }
        self.reviewByLabel.text = reviewByName
        self.reviewMessageLabel.text = review
        self.ratingView.rating = reviewRating
    }
}
