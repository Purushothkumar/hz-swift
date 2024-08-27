//
//  BlogsSearchCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 05/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
protocol ProtocolBlogsSearchCollectionViewCell {
    func tapButtonPressedBlogsSearchCollectionViewCell(senderTag: Int)
}
class BlogsSearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: Footnote1FontLabel!
    @IBOutlet var timeLabel: Caption2FontLabel!
    @IBOutlet var tapButton: CalloutOutlineButton!

    var delegate: ProtocolBlogsSearchCollectionViewCell?
    var listIndexpath = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(article: BlogsListModelArticle, indexpath: Int) {
        self.tapButton.tag = indexpath

        self.titleLabel.text = ""
        self.timeLabel.text = ""
        self.descriptionLabel.text = ""
        self.bannerImageView.setImage(imageUrl: "", placeHolderImage: hearzapPlaceholder)
        var authorName = ""
        var displayDate = ""

        if !(article.authorName.isNilOrEmpty) {
            authorName = article.authorName!
        }
        if !(article.displayDate.isNilOrEmpty) {
            displayDate = article.displayDate!
        }

        if !(authorName.isEmpty) && !(displayDate.isEmpty){
            self.timeLabel.text = "By \(authorName) | \(displayDate)"
        }
        else if !(authorName.isEmpty) {
            self.timeLabel.text = "By \(authorName)"
        } else if !(displayDate.isEmpty){
            self.timeLabel.text = "\(displayDate)"
        }
        if !(article.title.isNilOrEmpty) {
            self.descriptionLabel.text = article.title
        }
        if !(article.image.isNilOrEmpty) {
            self.bannerImageView.setImage(imageUrl: article.image!, placeHolderImage: hearzapPlaceholder)
        }
        if !(article.categoryName.isNilOrEmpty) {
            self.titleLabel.text = article.categoryName
        }
    }

    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedBlogsSearchCollectionViewCell(senderTag: sender.tag)
    }
}
