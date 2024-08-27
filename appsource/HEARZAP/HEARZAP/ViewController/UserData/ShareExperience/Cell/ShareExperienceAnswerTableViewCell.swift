//
//  ShareExperienceAnswerTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 06/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolShareExperienceAnswerTableViewCell {
    func tapButtonPressedShareExperienceAnswerTableViewCell(senderTag: Int, selectedRow: Int)
}
class ShareExperienceAnswerTableViewCell: UITableViewCell {
    @IBOutlet var titleView: UIView!

    @IBOutlet var titleLabel: FootnoteFontLabel!
    @IBOutlet var tapButton: FootnoteOutlineButton!
    var selectedRow: Int?
    var delegate: ProtocolShareExperienceAnswerTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(answer: SurveyModelAnswer, indexpath: Int, selectedRow: Int, questionid: String, selectArray: NSMutableArray) {
        self.titleLabel.text = ""
        var answerid = ""
        self.tapButton.tag = indexpath
        self.selectedRow = selectedRow
        self.titleLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.titleView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.titleView.clipsToBounds = true
        self.titleView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.titleView.layer.borderWidth = 1.0
        if !(answer.answer.isNilOrEmpty) {
            self.titleLabel.text = answer.answer!
        }
        if answer.id != nil {
            answerid = String(format: "%d", answer.id!)
        }
        if selectArray.count > 0 {
            for (index, item) in selectArray.enumerated() {
                for (key, value) in (item as! NSDictionary) {
                    if key as! String == questionid {
                        let valueCode: String  = value as! String
                        if !(valueCode.isEmpty) && (valueCode == answerid) {
                            self.titleView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                            self.titleLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
                        }
                    }
                }
            }
        }
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedShareExperienceAnswerTableViewCell(senderTag: sender.tag, selectedRow: self.selectedRow!)
    }
}
