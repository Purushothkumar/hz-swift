//
//  ReviewRatingCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 24/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Cosmos

class ReviewRatingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var reviewMessageLabel: Caption1FontLabel!
    @IBOutlet var reviewByLabel: FootnoteFontLabel!
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet var stackview: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(testimonial: CustomerTestimonial, indexpath: Int) {
        self.reviewByLabel.text = ""
        self.reviewMessageLabel.text = ""
        self.ratingView.rating = Double(0)
        
        if !(testimonial.reviewByName.isNilOrEmpty) {
            self.reviewByLabel.text = testimonial.reviewByName!
        }
        if !(testimonial.reviewBySubline.isNilOrEmpty) {
            self.reviewMessageLabel.text = testimonial.reviewBySubline!
        }
        if testimonial.reviewRating != nil {
            self.ratingView.rating = Double(testimonial.reviewRating!)!
        }
    }
}
