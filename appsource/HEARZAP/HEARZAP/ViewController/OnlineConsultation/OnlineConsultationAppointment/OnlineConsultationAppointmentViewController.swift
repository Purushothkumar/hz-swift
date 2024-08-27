//
//  OnlineConsultationAppointmentViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 30/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
class OnlineConsultationAppointmentViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var fiveDotCircleView: FiveDotCircleView!
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var audiologistImageView: UIImageView!
    @IBOutlet var audiologistNameLabel: CalloutFontLabel!
    @IBOutlet var audiologistExperienceLabel: Caption1FontLabel!
    @IBOutlet var audiologistSpecialisationLabel: Caption1FontLabel!

    @IBOutlet var slotStackView: UIStackView!
    @IBOutlet var selectDateTitleView: UIView!
    @IBOutlet var selectDateTitleLabel: CalloutFontLabel!

    @IBOutlet var selectDateCollectionView: UICollectionView!
    @IBOutlet var selectDateCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var selectTimeTitleView: UIView!
    @IBOutlet var selectTimeTitleLabel: CalloutFontLabel!

    @IBOutlet var selectTimeCollectionView: UICollectionView!
    @IBOutlet var selectTimeCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var chargeTitleView: UIView!
    @IBOutlet var chargeTimeTitleLabel: Caption2FontLabel!

    @IBOutlet var buttonView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!
    @IBOutlet var buttonViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    var isFrom = ""
    var patientUid = ""
    var concernArraySelected: NSMutableArray = NSMutableArray()
    var onlineConsultationAppointmentViewModel = OnlineConsultationAppointmentViewModel()
    var audiologistProfile: AudiologistProfile?

    let selectDateCollectionViewMargin = CGFloat(0)
    let selectDateCollectionViewItemSpacing = CGFloat(12)
    var selectDateCollectionViewItemHeight = CGFloat(50)
    var selectDateCollectionViewItemWidth = CGFloat(80)
    let selectDateCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    let selectTimeCollectionViewMargin = CGFloat(0)
    let selectTimeCollectionViewItemSpacing = CGFloat(12)
    var selectTimeCollectionViewItemHeight = CGFloat(178)
    var selectTimeCollectionViewItemWidth = CGFloat(139)
    let selectTimeCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var dateListArray = [DateSlot]()
    var timeListArray = [AvailableTimeSlot]()

    var selectedDate = ""
    var selectedTime = ""
    var signature = ""
    var name = ""
    var degree = ""
    var specialization = ""
    var experience = ""
    var audiologistuid = ""
    var staffPhoto = ""

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.setNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        if self.dateListArray.count > 0 {
        //            self.selectDateCollectionViewHeight.constant = CGFloat(85)
        //        } else {
        //            self.selectDateCollectionViewHeight.constant = 0
        //        }
        self.view.layoutIfNeeded()
    }

    // MARK: -  Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_blue_112F70,style: StatusBarTheme.lightContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: - Set Initial View
    func setInitialView() {
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.setFiveDotCircleView()
        self.setCommonTitleView()
        self.setUserInteractionButton()

        let view0 = self.mainStackView.arrangedSubviews[0]// profile
        let view1 = self.mainStackView.arrangedSubviews[1]// date
        view0.isHidden = true
        view1.isHidden = true

        if audiologistProfile != nil {
            if !(audiologistProfile!.signature.isNilOrEmpty) {
                self.signature = audiologistProfile!.signature!
                view0.isHidden = false
            }
            if !(audiologistProfile!.storeStaff.isNilOrEmpty) {
                self.name = audiologistProfile!.storeStaff!
                view0.isHidden = false
            }
            if !(audiologistProfile!.specializationDegree.isNilOrEmpty) {
                self.degree = audiologistProfile!.specializationDegree!
                view0.isHidden = false
            }
            if audiologistProfile!.industryExperienceInYrs != nil {
                let experience = audiologistProfile!.industryExperienceInYrs!
                self.experience = String(format: "%d %@", experience, experience > 1 ? AppLocalizationString.yearsExp :  AppLocalizationString.yearExp)
                view0.isHidden = false
            }
            if  !(audiologistProfile!.specialization.isNilOrEmpty) {
                self.specialization = audiologistProfile!.specialization!
                view0.isHidden = false
            }
            if !(audiologistProfile!.storeStaffUid.isNilOrEmpty) {
                self.audiologistuid = audiologistProfile!.storeStaffUid!
            }
            if !(audiologistProfile!.staffPhoto.isNilOrEmpty) {
                self.staffPhoto = audiologistProfile!.staffPhoto!
            }
        }

        self.audiologistExperienceLabel.text = ""
        self.audiologistImageView.setImage(imageUrl: self.staffPhoto, placeHolderImage: profileBlue)
        self.audiologistNameLabel.text = self.name
        if !(self.degree.isEmpty) && !(self.experience.isEmpty) {
            self.audiologistExperienceLabel.text = String(format: "%@ (%@)", self.degree, self.experience)
        } else if !(self.degree.isEmpty) || !(self.experience.isEmpty) {
            if !(self.degree.isEmpty) {
                self.audiologistExperienceLabel.text = self.degree
            } else if !(experience.isEmpty) {
                self.audiologistExperienceLabel.text = self.experience
            }
        }
        self.audiologistSpecialisationLabel.text = self.specialization
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.consultAudiologistOnline
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Set Four Dot Circle View
    func setFiveDotCircleView() {
        self.fiveDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.checkcircleblue, button3image: Asset.checkcircleblue, button4image: Asset.recordcircleblue, button5image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.OCStep4Title.capitalized
        let descriptionMessage = AppLocalizationString.OCStep4Desc.capitalized
        self.commonTitleView.setupView(titleMessage: titlemessage, descriptionMessage: descriptionMessage,commonTitlebackgroundViewColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
        if !(titlemessage.isEmpty) && !(descriptionMessage.isEmpty) {
            self.commonTitleViewHeight.constant = 8 + self.heightForText(text: titlemessage, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32) + 2 + self.heightForText(text: descriptionMessage, Font: AppFont.regular.size(11), Width: AppConstantValue.screenWidthminus32) + 8
        } else if !(titlemessage.isEmpty) {
            self.commonTitleViewHeight.constant = 8 + self.heightForText(text: titlemessage, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32) + 10
        } else if !(descriptionMessage.isEmpty) {
            self.commonTitleViewHeight.constant = 10 + self.heightForText(text: descriptionMessage, Font: AppFont.regular.size(11), Width: AppConstantValue.screenWidthminus32) + 8
        } else {
            self.commonTitleViewHeight.constant = 0
        }
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.selectTimeTitleLabel.text = AppLocalizationString.selectTimeSlot.capitalized
        self.selectDateTitleLabel.text = AppLocalizationString.selectDate.capitalized
        self.chargeTimeTitleLabel.text = AppLocalizationString.chargeOnlineConsultation
        self.nextButton.setTitle(AppLocalizationString.next.uppercased(), for: .normal)
        self.setCommonTitleView()
    }

    // MARK: - Reload
    func reloadSelectTimeCollectionView() {
        DispatchQueue.main.async {
            self.selectTimeCollectionViewItemHeight = CGFloat(38)
            self.selectTimeCollectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32) - CGFloat(32)
            self.selectTimeCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.selectTimeCollectionViewlayout.itemSize = CGSize(width: self.selectTimeCollectionViewItemWidth, height: self.selectTimeCollectionViewItemHeight)
            self.selectTimeCollectionViewlayout.minimumLineSpacing = self.selectTimeCollectionViewItemSpacing
            self.selectTimeCollectionViewlayout.minimumInteritemSpacing = self.selectTimeCollectionViewItemSpacing
            self.selectTimeCollectionViewlayout.scrollDirection = .vertical
            self.selectTimeCollectionView!.collectionViewLayout = self.selectTimeCollectionViewlayout
            self.selectTimeCollectionView.dataSource = self
            self.selectTimeCollectionView.delegate = self
            self.selectTimeCollectionView.reloadData()
            if self.timeListArray.count > 0 {
                if self.timeListArray.count > 2 {
                    self.selectTimeCollectionViewHeight.constant = (CGFloat(self.timeListArray.count) * self.selectTimeCollectionViewItemHeight) + (CGFloat((self.timeListArray.count) - 1) * 12)
                } else {
                    self.selectTimeCollectionViewHeight.constant = self.selectTimeCollectionViewItemHeight
                }
            } else {
                self.selectTimeCollectionViewHeight.constant = 0
            }
            self.view.layoutIfNeeded()
        }
    }
    func reloadSelectDateCollectionView() {
        DispatchQueue.main.async {
            self.selectDateCollectionViewItemHeight = 60
            self.selectDateCollectionViewItemWidth = (CGFloat(AppConstantValue.screenWidthminus32) - (CGFloat(self.selectDateCollectionViewItemSpacing) + 32)) / 2
            self.selectDateCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.selectDateCollectionViewlayout.itemSize = CGSize(width: self.selectDateCollectionViewItemWidth, height: self.selectDateCollectionViewItemHeight)
            self.selectDateCollectionViewlayout.minimumLineSpacing = self.selectDateCollectionViewItemSpacing
            self.selectDateCollectionViewlayout.minimumInteritemSpacing = self.selectDateCollectionViewItemSpacing
            self.selectDateCollectionViewlayout.scrollDirection = .vertical
            self.selectDateCollectionView!.collectionViewLayout = self.selectDateCollectionViewlayout
            self.selectDateCollectionView.dataSource = self
            self.selectDateCollectionView.delegate = self
            self.selectDateCollectionView.reloadData()
            if self.dateListArray.count > 0 {
                if self.dateListArray.count % 2 == 0 {
                    self.selectDateCollectionViewHeight.constant = (CGFloat(self.dateListArray.count / 2) * self.selectDateCollectionViewItemHeight) + ((CGFloat(self.dateListArray.count / 2)) * 12)
                    self.selectDateCollectionView.isScrollEnabled = false
                } else {
                    self.selectDateCollectionViewHeight.constant = (CGFloat(self.dateListArray.count / 2) * self.selectDateCollectionViewItemHeight) + ((CGFloat(self.dateListArray.count / 2)) * 12)  + self.selectDateCollectionViewItemHeight + 12
                    self.selectDateCollectionView.isScrollEnabled = false
                }
            } else {
                self.selectDateCollectionViewHeight.constant = 0
            }
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getBookingDateSlotList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.postOnlineConsultationTimeSlotList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 {
                    self.postOnlineConsultationCreateBooking(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getBookingDateSlotList(retryAPIID: Int, canShowLoader: Bool) {
        self.onlineConsultationAppointmentViewModel.getBookingDateSlotList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getBookingDateSlotList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postOnlineConsultationTimeSlotList(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "booking_date=%@&audiologist_uid=%@", self.selectedDate, self.audiologistuid)
        self.onlineConsultationAppointmentViewModel.postOnlineConsultationTimeSlotList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postOnlineConsultationTimeSlotList, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postOnlineConsultationCreateBooking(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.postOnlineConsultationCreateBooking)\(patientUid)/"
        var paramdict  = [String: [String]]()
        for (index, item) in concernArraySelected.enumerated() {
            for (key, value) in (item as! NSDictionary) {
                let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                if arrayValueCode.count > 0 {
                    paramdict[key as! String] = value as! [String]
                }
            }
        }
        let param = String(format: "staff_id=%@&booking_date=%@&booking_time=%@&questionnaire=%@", self.audiologistuid, self.selectedDate, self.selectedTime, paramdict.count > 0 ? self.stringifyArray(json: paramdict, prettyPrinted: false) : "{}")
        self.onlineConsultationAppointmentViewModel.postOnlineConsultationCreateBooking(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1002)
    }

    // MARK: - Custom Methods
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if !(self.selectedDate.isEmpty) && !(self.selectedTime.isEmpty) {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
        }
    }
    func setButtonDisable() {
        self.nextButton.isUserInteractionEnabled = false
        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.nextButton.setNeedsDisplay()
        self.nextButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.nextButton.isUserInteractionEnabled = true
        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.nextButton.setNeedsDisplay()
        self.nextButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

    @objc func scrolltoTimeSlot() {
        let slotStackview0 = self.slotStackView.arrangedSubviews[0]// date title
        let slotStackview1 = self.slotStackView.arrangedSubviews[1]// date slot
        let slotStackview2 = self.slotStackView.arrangedSubviews[2]// time title
        let timeSlotViewY = slotStackview0.frame.height + slotStackview1.frame.height + slotStackview2.frame.height

        UIView.animate(withDuration: 100) {
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: timeSlotViewY), animated: true)
        }
    }

    func stringifyArray(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        return "{}"
    }
}

extension OnlineConsultationAppointmentViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension OnlineConsultationAppointmentViewController: ProtocolNetworkRechabilityDelegate {
    // MARK: - InternetError
    func showInternetPopupScreen(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Common, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.NetworkRechabilityViewController) as! NetworkRechabilityViewController
            viewCon.retryAPIID = retryAPIID
            viewCon.protocolNetworkRechabilityDelegate = self
            viewCon.modalPresentationStyle = .fullScreen
            viewCon.modalTransitionStyle = .coverVertical
            self.present(viewCon, animated: true, completion: nil)
        }
    }
    // MARK: - NetworkRechabilityDelegate
    func tryAgainWithID(retryAPIID: Int) {
        self.commonAPICALL(retryAPIID: retryAPIID)
    }
}

extension OnlineConsultationAppointmentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.selectTimeCollectionView {
            return self.timeListArray.count
        } else {
            return self.dateListArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.selectTimeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.OnlineConsultationTimeCollectionViewCell, for: indexPath) as! OnlineConsultationTimeCollectionViewCell
            cell.configure(availableTimeSlot: self.timeListArray[indexPath.item], indexpath: indexPath.item, selectedTime: self.selectedTime)
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.OnlineConsultationDateCollectionViewCell, for: indexPath) as! OnlineConsultationDateCollectionViewCell
            cell.configure(dateSlot: self.dateListArray[indexPath.item], indexpath: indexPath.item, selectedDate: self.selectedDate)
            cell.delegate = self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.selectTimeCollectionView {
            if self.timeListArray.count > 0 {
                cellWidth = self.selectTimeCollectionViewItemWidth
                cellHeight = self.selectTimeCollectionViewItemHeight
            }
        } else if collectionView == self.selectDateCollectionView {
            if self.dateListArray.count > 0 {
                cellWidth = self.selectDateCollectionViewItemWidth
                cellHeight = self.selectDateCollectionViewItemHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.mainScrollView {
            let slotStackview0 = self.slotStackView.arrangedSubviews[0]// date title
            let slotStackview1 = self.slotStackView.arrangedSubviews[1]// date slot
            let slotStackview2 = self.slotStackView.arrangedSubviews[2]// time title
            let slotStackview3 = self.slotStackView.arrangedSubviews[3]// time slot
            let slotStackview4 = self.slotStackView.arrangedSubviews[4]// charge

            let stackviewY = slotStackview0.frame.height + slotStackview1.frame.height + slotStackview2.frame.height + slotStackview3.frame.height + slotStackview4.frame.height
        }
    }
}

extension OnlineConsultationAppointmentViewController: ProtocolOnlineConsultationTimeCollectionViewCell, ProtocolOnlineConsultationDateCollectionViewCell {
    func selectButtonPressedOnlineConsultationDateCollectionViewCell(senderTag: Int) {
        if self.dateListArray.count > 0 {
            if !(self.dateListArray[senderTag].value.isNilOrEmpty) {
                self.selectedDate = self.dateListArray[senderTag].value!
                self.reloadSelectDateCollectionView()
                self.commonAPICALL(retryAPIID: 1001)
                self.setUserInteractionButton()
            }
        }
    }
    func selectButtonPressedOnlineConsultationTimeCollectionViewCell(senderTag: Int) {
        if self.timeListArray.count > 0 {
            if self.timeListArray[senderTag].id != nil {
                self.selectedTime = String(format: "%d", self.timeListArray[senderTag].id!)
                self.reloadSelectTimeCollectionView()
                self.setUserInteractionButton()
            }
        }
    }
}
