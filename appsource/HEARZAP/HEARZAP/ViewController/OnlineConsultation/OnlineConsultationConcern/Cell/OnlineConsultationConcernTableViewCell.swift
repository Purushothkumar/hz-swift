//
//  OnlineConsultationConcernTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 21/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class OnlineConsultationConcernTableViewCell: UITableViewCell {

    @IBOutlet var concernStackView: UIStackView!
    @IBOutlet var concernLabel: BodyFontLabel!

    @IBOutlet var singleCollectionView: UICollectionView!
    @IBOutlet var singleCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var multiCollectionView: UICollectionView!
    @IBOutlet var multiCollectionViewHeight: NSLayoutConstraint!

    let multiCollectionViewMargin = 0
    let multiCollectionViewItemSpacing =  CGFloat(16)
    var multiCollectionViewItemHeight = CGFloat(129)
    var multiCollectionViewItemWidth = CGFloat(307)
    let multiCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var possibleAnswerArray = [String]()
    var rowIndex: Int?
    var selectedQuestion = ""

    //    var delegate: ProtocolHearingAidBrandListCollectionViewCell?
    var viewCon: OnlineConsultationConcernViewController?
    var concernAnswerArray = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    public func configure(customerConcernQuestion: CustomerConcernQuestion, indexpath: Int, viewCon: OnlineConsultationConcernViewController) {
        self.viewCon = viewCon
        self.rowIndex = indexpath
        let view0 = self.concernStackView.arrangedSubviews[0]// question
        let view1 = self.concernStackView.arrangedSubviews[1]// single
        let view2 = self.concernStackView.arrangedSubviews[2]// multi
        let view3 = self.concernStackView.arrangedSubviews[3]// empty
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = false
        self.concernLabel.text = ""

        if customerConcernQuestion != nil {
            if customerConcernQuestion.id != nil {
                self.selectedQuestion = String(format: "%d", customerConcernQuestion.id!)
            }
            if !(customerConcernQuestion.question.isNilOrEmpty) {
                self.concernLabel.text = customerConcernQuestion.question!.capitalized
                view0.isHidden = false
            }
            if customerConcernQuestion.possibleAnswers != nil {
                self.possibleAnswerArray = customerConcernQuestion.possibleAnswers!
            }
            if customerConcernQuestion.isSingleSelect != nil {
                if customerConcernQuestion.isSingleSelect == true {
                    view1.isHidden = false
                    self.reloadSingleCollectionView()
                } else {
                    view2.isHidden = false
                    self.reloadMultiCollectionView()
                }
            }
        }
    }
    func reloadMultiCollectionView() {
            self.multiCollectionViewItemHeight = CGFloat(AppConstantValue.screenWidthminus32) * (104/375.0)
            self.multiCollectionViewItemWidth = (AppConstantValue.screenWidthminus32 - (16/*center*/ + 32/*right and left*/)) / 2
            self.multiCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.multiCollectionViewlayout.itemSize = CGSize(width: self.multiCollectionViewItemWidth, height: self.multiCollectionViewItemHeight)
            self.multiCollectionViewlayout.minimumLineSpacing = self.multiCollectionViewItemSpacing
            self.multiCollectionViewlayout.minimumInteritemSpacing = self.multiCollectionViewItemSpacing
            self.multiCollectionViewlayout.scrollDirection = .vertical
            self.multiCollectionView!.collectionViewLayout = self.multiCollectionViewlayout
            self.multiCollectionView.dataSource = self
            self.multiCollectionView.delegate = self
            self.multiCollectionView.reloadData()

        if self.possibleAnswerArray.count > 0 {
            if self.possibleAnswerArray.count % 2 == 0 {
                if self.possibleAnswerArray.count > 4 {
                    self.multiCollectionViewHeight.constant = (CGFloat(self.possibleAnswerArray.count / 2) * multiCollectionViewItemHeight) + (CGFloat((self.possibleAnswerArray.count / 2) - 1) * 16)

                } else {
                    self.multiCollectionViewHeight.constant = (CGFloat(self.possibleAnswerArray.count / 2) * multiCollectionViewItemHeight) + 16
                }
            } else {
                if self.possibleAnswerArray.count > 2 {
                    self.multiCollectionViewHeight.constant = (CGFloat(self.possibleAnswerArray.count / 2) * multiCollectionViewItemHeight) + (CGFloat((self.possibleAnswerArray.count / 2) - 1) * 16) + multiCollectionViewItemHeight + 16
                } else {
                    self.multiCollectionViewHeight.constant = (CGFloat(self.possibleAnswerArray.count / 2) * multiCollectionViewItemHeight) + multiCollectionViewItemHeight + 16
                }
            }
        } else {
            self.multiCollectionViewHeight.constant = 0
        }
        self.layoutIfNeeded()
    }
    func reloadSingleCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .horizontal
        self.singleCollectionView.delegate = self
        self.singleCollectionView.dataSource = self
        self.singleCollectionView.collectionViewLayout = layout
        self.singleCollectionView.reloadData()
        self.singleCollectionView.collectionViewLayout.invalidateLayout()
        self.singleCollectionView!.layoutSubviews()
        self.singleCollectionViewHeight.constant = tagHeight
        self.layoutIfNeeded()
    }
}

extension OnlineConsultationConcernTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.singleCollectionView {
            return self.possibleAnswerArray.count
        } else {
            return self.possibleAnswerArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.singleCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.OnlineConsultationSingleSelectCollectionViewCell, for: indexPath) as! OnlineConsultationSingleSelectCollectionViewCell
            cell.configure(possibleAnswer: self.possibleAnswerArray[indexPath.item], indexpath: indexPath.item, rowIndex: rowIndex!, concernArraySelected: viewCon!.concernArraySelected, selectedQuestion: self.selectedQuestion)
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.OnlineConsultationMultiSelectCollectionViewCell, for: indexPath) as! OnlineConsultationMultiSelectCollectionViewCell
            cell.configure(possibleAnswer: self.possibleAnswerArray[indexPath.item], indexpath: indexPath.item, rowIndex: rowIndex!, concernArraySelected: viewCon!.concernArraySelected, selectedQuestion: self.selectedQuestion)
            cell.delegate = self
            return cell
        }

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.singleCollectionView {
            if self.possibleAnswerArray.count > 0 {
                var tag = ""
                if !(self.possibleAnswerArray[indexPath.item].isEmpty) {
                    tag = self.possibleAnswerArray[indexPath.item]
                }
                let font = AppFont.medium.size(13)
                let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
                cellWidth = 12 + size.width + 12
                cellHeight = tagHeight
            }
        } else if collectionView == self.multiCollectionView {
            if self.possibleAnswerArray.count > 0 {
                cellWidth = self.multiCollectionViewItemWidth
                cellHeight = self.multiCollectionViewItemHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension OnlineConsultationConcernTableViewCell: ProtocolOnlineConsultationSingleSelectCollectionViewCell, ProtocolOnlineConsultationMultiSelectCollectionViewCell {
    func selectButtonPressedOnlineConsultationSingleSelectCollectionViewCell(senderTag: Int, rowIndex: Int) {
        var selectedAnswer = ""
        var selectedQuestion = ""

        if viewCon!.concernArray.count > 0 {
            if viewCon!.concernArray[rowIndex].id != nil {
                selectedQuestion = String(format: "%d", viewCon!.concernArray[rowIndex].id!)
            }
            if viewCon!.concernArray[rowIndex].possibleAnswers != nil {
                if viewCon!.concernArray[rowIndex].possibleAnswers!.count > 0 {
                    selectedAnswer = viewCon!.concernArray[rowIndex].possibleAnswers![senderTag]
                    if !(selectedAnswer.isEmpty) && !(selectedQuestion.isEmpty) {
                        for item in viewCon!.concernArraySelected {
                            for (key, value) in (item as! NSDictionary) {
                                if (key as! String) == selectedQuestion {
                                    let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                                    if arrayValueCode.count > 0 {
                                        arrayValueCode.removeAllObjects()
                                        arrayValueCode.add(selectedAnswer)
                                        viewCon!.concernArraySelected.setValue(arrayValueCode, forKey: selectedQuestion)
                                        self.updateData()
                                    } else {
                                        arrayValueCode.add(selectedAnswer)
                                        viewCon!.concernArraySelected.setValue(arrayValueCode, forKey: selectedQuestion)
                                        self.updateData()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func selectButtonPressedOnlineConsultationMultiSelectCollectionViewCell(senderTag: Int, rowIndex: Int) {
        var selectedAnswer = ""
        var selectedQuestion = ""
        if viewCon!.concernArray.count > 0 {
            if viewCon!.concernArray[rowIndex].id != nil {
                selectedQuestion = String(format: "%d", viewCon!.concernArray[rowIndex].id!)
            }
            if viewCon!.concernArray[rowIndex].possibleAnswers != nil {
                if viewCon!.concernArray[rowIndex].possibleAnswers!.count > 0 {
                    selectedAnswer = viewCon!.concernArray[rowIndex].possibleAnswers![senderTag]
                    if !(selectedAnswer.isEmpty) && !(selectedQuestion.isEmpty) {
                        for item in viewCon!.concernArraySelected {
                            for (key, value) in (item as! NSDictionary) {
                                if (key as! String) == selectedQuestion {
                                    let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                                    if arrayValueCode.count > 0 {
                                        if arrayValueCode.contains(selectedAnswer) {
                                            arrayValueCode.remove(selectedAnswer)
                                            viewCon!.concernArraySelected.setValue(arrayValueCode, forKey: selectedQuestion)
                                            self.updateData()
                                        } else {
                                            arrayValueCode.add(selectedAnswer)
                                            viewCon!.concernArraySelected.setValue(arrayValueCode, forKey: selectedQuestion)
                                            self.updateData()
                                        }
                                    } else {
                                        arrayValueCode.add(selectedAnswer)
                                        viewCon!.concernArraySelected.setValue(arrayValueCode, forKey: selectedQuestion)
                                        self.updateData()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func updateData() {
        viewCon!.reloadTableview()
        viewCon!.setUserInteractionButton()
        return
    }
}
