//
//  SurveyQuestionTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 17/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SurveyQuestionTableViewCell: UITableViewCell {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var questionLabel: Caption2FontLabel!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var bannerImageViewHeight: NSLayoutConstraint!
    @IBOutlet var titleLabel: CalloutFontLabel!
    @IBOutlet var tableview: UITableView!
    @IBOutlet var contentViewHeight: NSLayoutConstraint!

    var selectedRow: Int?

    var answerArray = [SurveyModelAnswer]()
    var selectArray: NSMutableArray = NSMutableArray()
    var questionid = ""
    var viewCon: SurveyViewController = SurveyViewController()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(question: SurveyModelQuestion, indexpath: Int, selectArray: NSMutableArray, viewCon: SurveyViewController) {
        let view0 = self.stackView.arrangedSubviews[0] // question number
        let view1 = self.stackView.arrangedSubviews[1] // image
        let view2 = self.stackView.arrangedSubviews[2] // question
        let view3 = self.stackView.arrangedSubviews[3] // answerlist

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true

        self.questionLabel.text = ""
        self.titleLabel.text = ""

        var imgurl = ""
        self.bannerImageViewHeight.constant = 0

        if !(question.question.isNilOrEmpty) {
            self.questionLabel.text = String(format: "%@ %d", AppLocalizationString.question, indexpath + 1)
            self.titleLabel.text = question.question!
            view0.isHidden = false
            view2.isHidden = false
        }
        if question.id != nil {
            self.questionid = String(format: "%d", question.id!)
        }
        self.answerArray.removeAll()
        if question.answers != nil {
            self.answerArray = question.answers!
            view3.isHidden = false
        }
        if !(question.image.isNilOrEmpty) {
            self.bannerImageViewHeight.constant = 122.4 * (screenFrameWidth/AppConstantValue.defaultDesignScreenWidth)
            imgurl = question.image!
            view1.isHidden = false
        }
        self.viewCon = viewCon
        self.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
        self.calculateHeight()
        self.selectedRow = indexpath
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension

        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
    }

    func calculateHeight() {
        self.contentViewHeight.constant = 0
        var height: CGFloat = 0
        for answer in answerArray {
            if !(answer.answer.isNilOrEmpty) {
                let newheight = self.heightForText(text: answer.answer!, Font: AppFont.medium.size(13), Width: AppConstantValue.screenWidthminus32 - (32 + 32)) + 32
                height = newheight + height
            }
            self.contentViewHeight.constant = height + 16
        }
    }
}
extension SurveyQuestionTableViewCell: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.answerArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SurveyAnswerTableViewCell, for: indexPath) as! SurveyAnswerTableViewCell
        cell.configure(answer: self.answerArray[indexPath.row], indexpath: indexPath.row, selectedRow: selectedRow!, questionid: self.questionid, selectArray: viewCon.selectArray)
        cell.delegate = self
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension SurveyQuestionTableViewCell: ProtocolSurveyAnswerTableViewCell {
    func surveyAnswerTableViewCellTapButtonPressed(senderTag: Int, selectedRow: Int) {
        if viewCon.questionArray.count > 0 {
            var strKeyCode = ""
            var strValueCode = ""
            if viewCon.questionArray[selectedRow].id != nil {
                strKeyCode = String(format: "%d", viewCon.questionArray[selectedRow].id!)
                if !(strKeyCode.isEmpty) {
                    if viewCon.questionArray[selectedRow].answers != nil {
                        if viewCon.questionArray[selectedRow].answers!.count > 0 {
                            if viewCon.questionArray[selectedRow].answers![senderTag].id != nil {
                                strValueCode = String(format: "%d", viewCon.questionArray[selectedRow].answers![senderTag].id!)
                            }
                        }
                    }
                }
            }
            if !(strKeyCode.isEmpty) && !(strValueCode.isEmpty) {
                let filterTempArray = viewCon.selectArray.mutableCopy() as! NSMutableArray
                viewCon.selectArray.removeAllObjects()
                if filterTempArray.count > 0 {
                    for (index, item) in filterTempArray.enumerated() {
                        for (key, value) in (item as! NSDictionary) {
                            if key as! String == strKeyCode {
                                let dictTemp = NSMutableDictionary()
                                dictTemp.setValue(strValueCode, forKey: strKeyCode)
                                viewCon.selectArray.add(dictTemp)
                            } else {
                                viewCon.selectArray.add(item)
                            }
                        }
                    }
                }
            }
            viewCon.setUserInteractionButton()
            viewCon.reloadTableView()
            viewCon.scrolltoIndex(selectedRow: selectedRow)
        }
    }
}
