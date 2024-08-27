//
//  OnlineConsultationScheduleViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 26/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift

class OnlineConsultationScheduleViewController: UIViewController,UITextFieldDelegate {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var threeDotCircleView: ThreeDotCircleView!

    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var clearBackgroundView: UIView!
    @IBOutlet var borderBackgroundView: UIView!
    @IBOutlet var borderStackView: UIStackView!

    @IBOutlet var dateView: UIView!
    @IBOutlet var dateStackView: UIStackView!
    @IBOutlet var selectDateTitleView: UIView!
    @IBOutlet var selectDateTitleLabel: FootnoteFontLabel!
    @IBOutlet var selectDateView: UIView!
    @IBOutlet var selectDateCollectionView: UICollectionView!
    @IBOutlet var selectDateCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var timeView: UIView!
    @IBOutlet var selectTimeStackView: UIStackView!
    @IBOutlet var selectTimeTitleView: UIView!
    @IBOutlet var selectTimeTitleLabel: FootnoteFontLabel!

    @IBOutlet var selectTimeView: UIView!
    @IBOutlet var selectTimeCollectionView: UICollectionView!
    @IBOutlet var selectTimeCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var buttonView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!

    // MARK: - Lets and Var
    var isFrom = ""
    var selectedDate = ""
    var selectedTime = ""
    var selectedStore = ""
    var visitType = ""
    var concernID = ""
    var activeField = UITextField()
    var timeListArray = [AvailableTimeSlot]()
    var dateListArray = [DateList]()
    var newUser = false
    var selectedCity = ""

    let selectTimeCollectionViewMargin = CGFloat(0)
    let selectTimeCollectionViewItemSpacing = CGFloat(16)
    var selectTimeCollectionViewItemHeight = CGFloat(178)
    var selectTimeCollectionViewItemWidth = CGFloat(139)
    let selectTimeCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    let selectDateCollectionViewMargin = CGFloat(0)
    let selectDateCollectionViewItemSpacing = CGFloat(16)
    var selectDateCollectionViewItemHeight = CGFloat(50)
    var selectDateCollectionViewItemWidth = CGFloat(80)
    let selectDateCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    var componentsMinimumDay = 0
    var componentsMaximumDay = 30
    var onlineConsultationScheduleViewModel = OnlineConsultationScheduleViewModel()

    var storeList = [String]()
    var storeListID = [Int]()
    var currentDateSlots = [AvailableTimeSlot]()
    var otherDateSlots = [AvailableTimeSlot]()

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
        self.setUserInteractionButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    // MARK: -  Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_white_FFFFFF,style: StatusBarTheme.darkContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    // MARK: - Set Initial View
    func setInitialView() {
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.setThreeDotCircleView()
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        self.setButtonDisable()
        self.reloadSelectTimeCollectionView()
        self.reloadSelectDateCollectionView()
        self.setUserInteractionButton()
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftdarkblue
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.onlineConsultation.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF,titleTextColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.OnlineConsultationStep2Title.uppercased()
        let descriptionMessage = AppLocalizationString.OnlineConsultationStep2Desc
        self.commonTitleView.setupView(titleMessage: titlemessage, descriptionMessage: descriptionMessage,commonTitlebackgroundViewColor: UIColor.colorLiteral.theme_blue_E7F4FF)
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
    // MARK: - Set Three Dot Circle View recordcircleblue
    func setThreeDotCircleView() {
        self.threeDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.recordcircleblue, button3image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_blue_E7F4FF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.selectDateTitleLabel.setStarAttributtedText(textmessage: AppLocalizationString.selectDatestar.capitalized, color: UIColor.colorLiteral.theme_red_FF6961)
        self.selectTimeTitleLabel.setStarAttributtedText(textmessage: AppLocalizationString.selectTimeSlotstar.capitalized, color: UIColor.colorLiteral.theme_red_FF6961)
        self.nextButton.setTitle(AppLocalizationString.bookNow.uppercased(), for: .normal)
        self.setCommonTitleView()
    }
    // MARK: - Reload
    func reloadSelectTimeCollectionView() {
        DispatchQueue.main.async {
            self.selectTimeCollectionViewItemHeight = CGFloat(60)
            self.selectTimeCollectionViewItemWidth = (CGFloat(AppConstantValue.screenWidthminus32) - (CGFloat(self.selectTimeCollectionViewItemSpacing) + 32)) / 2
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
                if self.timeListArray.count % 2 == 0 {
                    if self.timeListArray.count > 4 {
                        self.selectTimeCollectionViewHeight.constant = (CGFloat(self.timeListArray.count / 2) * self.selectTimeCollectionViewItemHeight) + (CGFloat((self.timeListArray.count / 2) - 1) * 16)
                    } else {
                        self.selectTimeCollectionViewHeight.constant = (CGFloat(self.timeListArray.count / 2) * self.selectTimeCollectionViewItemHeight) + 16
                    }
                } else {
                    if self.timeListArray.count > 2 {
                        self.selectTimeCollectionViewHeight.constant = (CGFloat(self.timeListArray.count / 2) * self.selectTimeCollectionViewItemHeight) + (CGFloat((self.timeListArray.count / 2) - 1) * 16) + self.selectTimeCollectionViewItemHeight + 16
                    } else {
                        self.selectTimeCollectionViewHeight.constant = (CGFloat(self.timeListArray.count / 2) * self.selectTimeCollectionViewItemHeight) + self.selectTimeCollectionViewItemHeight + 16
                    }
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
                    if self.dateListArray.count > 4 {
                        self.selectDateCollectionViewHeight.constant = (CGFloat(self.dateListArray.count / 2) * self.selectDateCollectionViewItemHeight) + (CGFloat((self.dateListArray.count / 2) - 1) * 16)
                    } else {
                        self.selectDateCollectionViewHeight.constant = (CGFloat(self.dateListArray.count / 2) * self.selectDateCollectionViewItemHeight) + 16
                    }
                } else {
                    if self.dateListArray.count > 2 {
                        self.selectDateCollectionViewHeight.constant = (CGFloat(self.dateListArray.count / 2) * self.selectDateCollectionViewItemHeight) + (CGFloat((self.dateListArray.count / 2) - 1) * 16) + self.selectDateCollectionViewItemHeight + 16
                    } else {
                        self.selectDateCollectionViewHeight.constant = (CGFloat(self.dateListArray.count / 2) * self.selectDateCollectionViewItemHeight) + self.selectDateCollectionViewItemHeight + 16
                    }
                }
            } else {
                self.selectDateCollectionViewHeight.constant = 0
            }

            self.view.layoutIfNeeded()
        }
    }
    func commonAPICALL(retryAPIID: Int) {
            DispatchQueue.main.async {
                self.view.endEditing(true)
                if Reachability.isConnectedToNetwork() {
                    if retryAPIID == 1000 {
                        self.getOnlineConsultationSelectDate(retryAPIID: retryAPIID, canShowLoader: true)
                    }
                    else if retryAPIID == 1001 {
                        self.postOnlineConsultationSelectDate(retryAPIID: retryAPIID, canShowLoader: true)
                    }
                } else {
                    self.showInternetPopupScreen(retryAPIID: retryAPIID)
                }
            }
        }
        func getOnlineConsultationSelectDate(retryAPIID: Int, canShowLoader: Bool) {
            let strurl = String(format: "%@%@/", SubAPIUrl.getOnlineConsultationSelectDate,self.concernID)
            self.onlineConsultationScheduleViewModel.getOnlineConsultationSelectDate(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: strurl, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
        func postOnlineConsultationSelectDate(retryAPIID: Int, canShowLoader: Bool) {
            var param = String(format: "appointment_date=%@&time_slot_id=%@", self.selectedDate, self.selectedTime)
            let strurl = String(format: "%@%@/", SubAPIUrl.postOnlineConsultationSelectDate,self.concernID)
            self.onlineConsultationScheduleViewModel.postOnlineConsultationSelectDate(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: strurl, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
        // MARK: - IBAction
        @IBAction func nextButtonPressed(_ sender: UIButton) {
            self.commonAPICALL(retryAPIID: 1001)
        }

    // MARK: - Custom Methods
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
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if !(self.selectedTime.isEmpty) && !(self.selectedDate.isEmpty) {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
        }
    }

    // MARK: - TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeField.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    @objc func editingChanged(_ textField: UITextField) {
        self.setUserInteractionButton()
    }
}
extension OnlineConsultationScheduleViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension OnlineConsultationScheduleViewController: ProtocolNetworkRechabilityDelegate {
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
extension OnlineConsultationScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.OnlineConsultationScheduleTimeSlotCollectionViewCell, for: indexPath) as! OnlineConsultationScheduleTimeSlotCollectionViewCell
            cell.configure(availableTimeSlot: self.timeListArray[indexPath.item], indexpath: indexPath.item, selectedTime: self.selectedTime)
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.OnlineConsultationScheduleDateCollectionViewCell, for: indexPath) as! OnlineConsultationScheduleDateCollectionViewCell
            cell.configure(dateList: self.dateListArray[indexPath.item], indexpath: indexPath.item, selectedDate: self.selectedDate)
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
        }
    }
}

extension OnlineConsultationScheduleViewController: ProtocolOnlineConsultationScheduleTimeSlotCollectionViewCell, ProtocolOnlineConsultationScheduleDateCollectionViewCell {
    func selectButtonPressedOnlineConsultationScheduleTimeSlotCollectionViewCell(senderTag: Int) {
        if self.timeListArray.count > 0 {
            if self.timeListArray[senderTag].id != nil {
                self.selectedTime = String(format: "%d", self.timeListArray[senderTag].id!)
                self.reloadSelectTimeCollectionView()
                self.setUserInteractionButton()

            }
        }
    }
    func selectButtonPressedOnlineConsultationScheduleDateCollectionViewCell(senderTag: Int) {
        if self.dateListArray.count > 0 {
            if !(self.dateListArray[senderTag].date.isNilOrEmpty) {
                self.selectedDate = self.dateListArray[senderTag].date!
                self.reloadSelectDateCollectionView()
                self.selectedTime = ""
                if (senderTag == 0){
                    self.timeListArray.removeAll()
                    self.timeListArray = self.currentDateSlots
                }
                else{
                    self.timeListArray.removeAll()
                    self.timeListArray = self.otherDateSlots
                }
                self.reloadSelectTimeCollectionView()
                self.setUserInteractionButton()
                let slotStackview0 = self.borderStackView.arrangedSubviews[0]// date slot
                let slotStackview1 = self.borderStackView.arrangedSubviews[1]// time slot
                let slotStackview2 = self.borderStackView.arrangedSubviews[2]// button

                let defaultScrollingHeight = 16.0
                let dateSlotViewY = slotStackview0.frame.height + defaultScrollingHeight

                UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.mainScrollView.setContentOffset(CGPoint(x: 0, y: dateSlotViewY), animated: false)
                }, completion: nil)
            }
        }
    }
}

