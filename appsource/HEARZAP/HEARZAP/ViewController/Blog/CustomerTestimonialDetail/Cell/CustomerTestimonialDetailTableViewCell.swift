//
//  CustomerTestimonialDetailTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 03/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCustomerTestimonialDetailTableViewCell {
    func tapButtonPressedCustomerTestimonialDetailTableViewCell(senderTag: Int)
}
class CustomerTestimonialDetailTableViewCell: UITableViewCell {
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var timeLabel: Caption2FontLabel!
    @IBOutlet var tapButton: FootnoteOutlineButton!

    var delegate: ProtocolCustomerTestimonialDetailTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(testimonial: Testimonial, indexpath: Int) {
        self.tapButton.tag = indexpath
        var imgurl = ""
        self.titleLabel.text = ""
        self.timeLabel.text = ""
        self.descriptionLabel.text = ""
        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
        if !(testimonial.reviewByName.isNilOrEmpty) {
            self.titleLabel.text = testimonial.reviewByName
        }
        if !(testimonial.createdOn.isNilOrEmpty) {
            self.timeLabel.text = testimonial.createdOn
        }
        if !(testimonial.reviewBySubline.isNilOrEmpty) {
            self.descriptionLabel.text = "\(String(describing: testimonial.reviewBySubline!))"
        }
        if !(testimonial.image.isNilOrEmpty) {
            imgurl = testimonial.image!
        }
        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedCustomerTestimonialDetailTableViewCell(senderTag: sender.tag)
    }
}
