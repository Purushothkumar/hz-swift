//
//  CustomerTestimonialTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 03/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCustomerTestimonialTableViewCell {
    func tapButtonPressedCustomerTestimonialTableViewCell(senderTag: Int)
}
class CustomerTestimonialTableViewCell: UITableViewCell {
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var timeLabel: Caption2FontLabel!
    @IBOutlet var tapButton: CalloutOutlineButton!

    var delegate: ProtocolCustomerTestimonialTableViewCell?

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
        self.bannerImageView.setImage(imageUrl: "", placeHolderImage: hearzapPlaceholder)
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
        self.delegate?.tapButtonPressedCustomerTestimonialTableViewCell(senderTag: sender.tag)
    }
}
