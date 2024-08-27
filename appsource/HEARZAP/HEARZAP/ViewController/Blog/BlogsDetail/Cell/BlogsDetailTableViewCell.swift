//
//  BlogsDetailTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 04/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolBlogsDetailTableViewCell {
    func tapButtonPressedBlogsDetailTableViewCell(senderTag: Int)
}
class BlogsDetailTableViewCell: UITableViewCell {

    @IBOutlet var layoutView: UIView!
    @IBOutlet var layoutStackView: UIStackView!

    @IBOutlet var descriptionLabel: Footnote1FontLabel!
    @IBOutlet var timeLabel: Caption2FontLabel!
    @IBOutlet var tapButton: FootnoteOutlineButton!

    var delegate: ProtocolBlogsDetailTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(article: BlogsDetailModelArticle, indexpath: Int) {
        self.tapButton.tag = indexpath

        self.timeLabel.text = ""
        self.descriptionLabel.text = ""
        var authorName = ""
        var displayDate = ""


        if !(article.title.isNilOrEmpty)  {
            self.descriptionLabel.text = article.title
        }
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
//        self.descriptionLabel.text = "dasjhgvuidsad subgisd ugifhsdiu hiusadhf iugfauisdgfugs aduigfius dadsgi ufgsd audfi gfiu adsgiu   fg iuasdgfigd  saiugfiasdgfiuasg dasjhgvuidsad subgisd ugifhsdiu hiusadhf iugfauisdgfugs aduigfius dadsgi ufgsd audfi gfiu adsgiu   fg iuasdgfigd  saiugfiasdgfiuasg"
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedBlogsDetailTableViewCell(senderTag: sender.tag)
    }
}
