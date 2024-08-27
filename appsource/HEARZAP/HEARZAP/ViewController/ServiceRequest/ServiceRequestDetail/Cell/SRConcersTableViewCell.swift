//
//  SRConcersTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 05/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SRConcersTableViewCell: UITableViewCell {

    @IBOutlet var concernTitleLabel: Caption1FontLabel!
    @IBOutlet var concernLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(questions: SRDModelQuestion) {
        var question = ""
        var answer = ""

        if !(questions.question.isNilOrEmpty) {
            question = questions.question!.capitalized
        }
        if !(questions.answer.isNilOrEmpty) {
            answer = questions.answer!
        }

        self.concernLabel.text = answer
        self.concernTitleLabel.text = question
    }

}
