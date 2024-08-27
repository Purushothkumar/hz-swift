//
//  OnlineConsultationAudiologistTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolOnlineConsultationAudiologistTableViewCell {
    func moreButtonPressedOnlineConsultationAudiologistTableViewCell(senderTag: Int)
    func consultButtonPressedOnlineConsultationAudiologistTableViewCell(senderTag: Int)
}

class OnlineConsultationAudiologistTableViewCell: UITableViewCell {

    @IBOutlet var stackview: UIStackView!
    @IBOutlet var audiologistImageView: UIImageView!
    @IBOutlet var audiologistNameLabel: CalloutFontLabel!
    @IBOutlet var audiologistExperienceLabel: Caption1FontLabel!
    @IBOutlet var audiologistSpecialisationLabel: Caption1FontLabel!

    @IBOutlet var contentLabel: Caption1FontLabel!
    @IBOutlet var moreButton: FootnoteOutlineButton!

    @IBOutlet var infoStackview: UIStackView!
    @IBOutlet var ratingLabel: Caption1FontLabel!
    @IBOutlet var vaccinatedLabel: Caption1FontLabel!

    @IBOutlet var tagView: UIView!
    @IBOutlet var tagCollectionView: UICollectionView!
    @IBOutlet var tagCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var availableStatusLabel: Caption1FontLabel!
    @IBOutlet var availableStatusImageView: UIImageView!
    @IBOutlet var availableStatusView: UIView!

    @IBOutlet var consultButton: CalloutOutlineButton!

    var langPreferenceArray = [String]()
    let tagCollectionViewMargin = 0
    let tagCollectionViewItemSpacing = CGFloat(6)
    var tagCollectionViewItemHeight = CGFloat(178)
    var tagCollectionViewItemWidth = CGFloat(139)
    let tagCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var delegate: ProtocolOnlineConsultationAudiologistTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func configure(audiologistProfileList: AudiologistProfileList, indexpath: Int) {

        let view0 = self.stackview.arrangedSubviews[0]// audilogistinfo
        let view1 = self.stackview.arrangedSubviews[1]// desc
        let view2 = self.stackview.arrangedSubviews[2]// more
        let view3 = self.stackview.arrangedSubviews[3]// information
        let view4 = self.stackview.arrangedSubviews[4]// language
        let view5 = self.stackview.arrangedSubviews[5]// status
        let view6 = self.stackview.arrangedSubviews[6]// button

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        view6.isHidden = true

        let infoview0 = self.infoStackview.arrangedSubviews[0]// rating
        let infoview1 = self.infoStackview.arrangedSubviews[1]// vacinated

        infoview0.isHidden = true
        infoview1.isHidden = true

        self.reloadTagCollectionView()
        self.langPreferenceArray.removeAll()

        var signature = ""
        var name = ""
        var degree = ""
        var desc = ""
        var specialization = ""
        var experience = ""
        var isVaccinated = false
        var rating = ""
        var isOnlineConsultationEnabled = false
        self.consultButton.tag = indexpath
        self.consultButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.consultButton.layer.borderWidth = 1.0
        self.consultButton.setTitle(AppLocalizationString.consultNow.uppercased(), for: .normal)
        if audiologistProfileList.audiologistProfile != nil {
            if !(audiologistProfileList.audiologistProfile!.staffPhoto.isNilOrEmpty) {
                signature = audiologistProfileList.audiologistProfile!.staffPhoto!
                view0.isHidden = false
            }
            if !(audiologistProfileList.audiologistProfile!.storeStaff.isNilOrEmpty) {
                name = audiologistProfileList.audiologistProfile!.storeStaff!
                view0.isHidden = false
            }
            if !(audiologistProfileList.audiologistProfile!.specializationDegree.isNilOrEmpty) {
                degree = audiologistProfileList.audiologistProfile!.specializationDegree!
                view0.isHidden = false
            }
            if audiologistProfileList.audiologistProfile!.industryExperienceInYrs != nil {
                var industryExperienceInYrs = audiologistProfileList.audiologistProfile!.industryExperienceInYrs!
                experience = String(format: "%d %@", industryExperienceInYrs, industryExperienceInYrs > 1 ? AppLocalizationString.yearsExp :  AppLocalizationString.yearExp)
                view0.isHidden = false
            }
            if  !(audiologistProfileList.audiologistProfile!.specializationDesc.isNilOrEmpty) {
                desc = audiologistProfileList.audiologistProfile!.specializationDesc!
                view1.isHidden = false
            }
            if  !(audiologistProfileList.audiologistProfile!.specialization.isNilOrEmpty) {
                specialization = audiologistProfileList.audiologistProfile!.specialization!
                view0.isHidden = false
            }
            /* //Sravan asked to hide this, functionality not working based on staff login
            if audiologistProfileList.audiologistProfile!.isOnlineConsultationEnabled != nil {
                isOnlineConsultationEnabled = audiologistProfileList.audiologistProfile!.isOnlineConsultationEnabled!
                if isOnlineConsultationEnabled == true {
                    view5.isHidden = !isOnlineConsultationEnabled
                    view6.isHidden = !isOnlineConsultationEnabled
                }
            }
             */
            view6.isHidden = false
        }
        if audiologistProfileList.averageRating != nil {
            rating = String(format: "%0.1f", audiologistProfileList.averageRating!)
            view3.isHidden = false
            infoview0.isHidden = false
            self.ratingLabel.text = rating
        }
        if audiologistProfileList.isVaccinated != nil {
            isVaccinated = audiologistProfileList.isVaccinated!
            if isVaccinated == true {
                view3.isHidden = false
                infoview1.isHidden = false
            }
        }
        if audiologistProfileList.langPreference != nil {
            self.langPreferenceArray = audiologistProfileList.langPreference!
            if self.langPreferenceArray.count > 0 {
                view4.isHidden = false
                self.reloadTagCollectionView()
            }
        }
        self.audiologistExperienceLabel.text = ""
        self.audiologistImageView.setImage(imageUrl: signature, placeHolderImage: profileBlue)
        self.audiologistNameLabel.text = name
        if !(degree.isEmpty) && !(experience.isEmpty) {
            self.audiologistExperienceLabel.text = String(format: "%@ (%@)", degree, experience)
        } else if !(degree.isEmpty) || !(experience.isEmpty) {
            if !(degree.isEmpty) {
                self.audiologistExperienceLabel.text = degree
            } else if !(experience.isEmpty) {
                self.audiologistExperienceLabel.text = experience
            }
        }
        self.audiologistSpecialisationLabel.text = specialization
        self.contentLabel.text = desc
        self.availableStatusLabel.text = AppLocalizationString.onlineNow.capitalized
    }
    func reloadTagCollectionView() {
        DispatchQueue.main.async {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 12
            layout.scrollDirection = .horizontal
            self.tagCollectionView.delegate = self
            self.tagCollectionView.dataSource = self
            self.tagCollectionView.collectionViewLayout = layout
            self.tagCollectionView.reloadData()
            self.tagCollectionView.collectionViewLayout.invalidateLayout()
            self.tagCollectionView!.layoutSubviews()
            self.tagCollectionViewHeight.constant = tagHeight
        }
    }

    @IBAction func moreButtonPressed(_ sender: UIButton) {
        self.delegate?.moreButtonPressedOnlineConsultationAudiologistTableViewCell(senderTag: sender.tag)
    }
    @IBAction func consultButtonPressed(_ sender: UIButton) {
        self.delegate?.consultButtonPressedOnlineConsultationAudiologistTableViewCell(senderTag: sender.tag)
    }
}

extension OnlineConsultationAudiologistTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.langPreferenceArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.OnlineConsultationAudiologistLangCollectionViewCell, for: indexPath) as! OnlineConsultationAudiologistLangCollectionViewCell
        cell.titleLabel.text = self.langPreferenceArray[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.langPreferenceArray.count > 0 {
            let tag = self.langPreferenceArray[indexPath.item]
            let font = AppFont.regular.size(13)
            let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
            cellWidth = 12 + size.width + 5 + 16/*imagewidth*/ + 12
            cellHeight = tagHeight
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
