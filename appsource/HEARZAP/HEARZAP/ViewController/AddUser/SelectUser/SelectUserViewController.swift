//
//  SelectUserViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SelectUserViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var dotStackView: UIStackView!
    @IBOutlet var fourDotCircleView: FourDotCircleView!
    @IBOutlet var fiveDotCircleView: FiveDotCircleView!
    @IBOutlet var sixDotCircleView: SixDotCircleView!

    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!

    @IBOutlet var tableview: UITableView!

    @IBOutlet var buttonView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!

    // MARK: - Lets and Var
    var selectUserViewModel = SelectUserViewModel()
    var isFrom = ""
    var patientList = [PatientList]()
    var selectedPerson = ""
    var patientData: PatientList?
    var sessionID = ""

    var showFourDotView = false
    var showFiveDotView = false
    var showSixDotView = false

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
        self.reloadTableview()
        self.updateUserAddUserViewController()
        self.setUserInteractionButton()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

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
        self.setFourDotCircleView()
        self.setFiveDotCircleView()
        self.setSixDotCircleView()
        self.setUserInteractionButton()
        let view0 = self.dotStackView.arrangedSubviews[0]// four dot
        let view1 = self.dotStackView.arrangedSubviews[1]// five dot
        let view2 = self.dotStackView.arrangedSubviews[2]// six dot
        view0.isHidden = !showFourDotView
        view1.isHidden = !showFiveDotView
        view2.isHidden = !showSixDotView

        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTableview()
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = Asset.xlargewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        if (self.isFrom == IsNavigateFrom.fhaHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.fhaHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.fhaShop.rawValue) || (self.isFrom == IsNavigateFrom.fhaSurveySuccess.rawValue) {
            self.navigationBar.title = AppLocalizationString.hearingAidFinder.capitalized
        } else if (self.isFrom == IsNavigateFrom.baHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.baHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.baStore.rawValue) || (self.isFrom == IsNavigateFrom.baShop.rawValue) || (self.isFrom == IsNavigateFrom.baMenu.rawValue) || (self.isFrom == IsNavigateFrom.baStoreDetail.rawValue) || (self.isFrom == IsNavigateFrom.baHAProductDetail.rawValue) || (self.isFrom == IsNavigateFrom.baFHA.rawValue) || (self.isFrom == IsNavigateFrom.baQuickCheck.rawValue) || (self.isFrom == IsNavigateFrom.baSurveySuccess.rawValue) || (self.isFrom == IsNavigateFrom.baSurveyRegisterDevice.rawValue) || (self.isFrom == IsNavigateFrom.baFRDUploadReport.rawValue) {
            self.navigationBar.title = AppLocalizationString.bookAppointment.capitalized
        } else if (self.isFrom == IsNavigateFrom.ocHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.ocHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.ocSurveySuccess.rawValue) || (self.isFrom == IsNavigateFrom.ocQuickCheck.rawValue) {
            self.navigationBar.title = AppLocalizationString.consultAudiologistOnline
        }

        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }

    // MARK: - Set Four Dot Circle View
    func setFourDotCircleView() {
        self.fourDotCircleView.setupView(button1image: Asset.recordcircleblue, button2image: Asset.circlegrey, button3image: Asset.circlegrey, button4image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)    }
    // MARK: - Set Five Dot Circle View
    func setFiveDotCircleView() {
        self.fiveDotCircleView.setupView(button1image: Asset.recordcircleblue, button2image: Asset.circlegrey, button3image: Asset.circlegrey, button4image: Asset.circlegrey, button5image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
    }
    // MARK: - Set Six Dot Circle View
    func setSixDotCircleView() {
        self.sixDotCircleView.setupView(button1image: Asset.recordcircleblue, button2image: Asset.circlegrey, button3image: Asset.circlegrey, button4image: Asset.circlegrey, button5image: Asset.circlegrey, button6image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
    }
    // MARK: - Set Add User Title View
    func setcommonTitleView() {

        var titlemessage = ""
        var descriptionMessage = ""

        if (self.isFrom == IsNavigateFrom.fhaHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.fhaHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.fhaShop.rawValue) || (self.isFrom == IsNavigateFrom.fhaSurveySuccess.rawValue) {
            titlemessage = AppLocalizationString.FHAStep1Title.capitalized
            descriptionMessage = AppLocalizationString.FHAStep1Desc.capitalized
        } else if (self.isFrom == IsNavigateFrom.baHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.baHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.baStore.rawValue) || (self.isFrom == IsNavigateFrom.baShop.rawValue) || (self.isFrom == IsNavigateFrom.baMenu.rawValue) || (self.isFrom == IsNavigateFrom.baStoreDetail.rawValue) || (self.isFrom == IsNavigateFrom.baHAProductDetail.rawValue) || (self.isFrom == IsNavigateFrom.baFHA.rawValue) || (self.isFrom == IsNavigateFrom.baQuickCheck.rawValue) || (self.isFrom == IsNavigateFrom.baSurveySuccess.rawValue) || (self.isFrom == IsNavigateFrom.baSurveyRegisterDevice.rawValue) || (self.isFrom == IsNavigateFrom.baFRDUploadReport.rawValue) {
            titlemessage = AppLocalizationString.BAStep1Title.capitalized
            descriptionMessage = AppLocalizationString.BAStep1Desc.capitalized
        } else if (self.isFrom == IsNavigateFrom.ocHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.ocHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.ocSurveySuccess.rawValue) || (self.isFrom == IsNavigateFrom.ocQuickCheck.rawValue) {
            titlemessage = AppLocalizationString.OCStep1Title.capitalized
            descriptionMessage = AppLocalizationString.OCStep1Desc.capitalized
        }
        self.commonTitleView.setupView(titleMessage: titlemessage, descriptionMessage: descriptionMessage,commonTitlebackgroundViewColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
        self.commonTitleViewHeight.constant = 8 + self.heightForText(text: AppLocalizationString.selectPerson, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32) + 2 + self.heightForText(text: AppLocalizationString.hiconfirmthepersonsdetails, Font: AppFont.regular.size(11), Width: AppConstantValue.screenWidthminus32) + 8
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.setcommonTitleView()
        self.nextButton.setTitle(AppLocalizationString.next.uppercased(), for: .normal)
    }
    // MARK: - Reload
    func reloadTableview() {
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getCustomerRelationPersonList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    if (self.isFrom == IsNavigateFrom.fhaHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.fhaHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.fhaShop.rawValue) || (self.isFrom == IsNavigateFrom.fhaSurveySuccess.rawValue) {
                        self.postFindTheRightDevicePersonList(retryAPIID: retryAPIID, canShowLoader: true)
                    } else if (self.isFrom == IsNavigateFrom.baHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.baHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.baStore.rawValue) || (self.isFrom == IsNavigateFrom.baShop.rawValue) || (self.isFrom == IsNavigateFrom.baMenu.rawValue) || (self.isFrom == IsNavigateFrom.baStoreDetail.rawValue) || (self.isFrom == IsNavigateFrom.baHAProductDetail.rawValue) || (self.isFrom == IsNavigateFrom.baFHA.rawValue) || (self.isFrom == IsNavigateFrom.baQuickCheck.rawValue) || (self.isFrom == IsNavigateFrom.baSurveySuccess.rawValue) || (self.isFrom == IsNavigateFrom.baSurveyRegisterDevice.rawValue) || (self.isFrom == IsNavigateFrom.baFRDUploadReport.rawValue) {
                        // no session call
                    } else if (self.isFrom == IsNavigateFrom.ocHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.ocHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.ocSurveySuccess.rawValue) || (self.isFrom == IsNavigateFrom.ocQuickCheck.rawValue) {
                        // no session call
                    }
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }

    func getCustomerRelationPersonList(retryAPIID: Int, canShowLoader: Bool) {
        self.selectUserViewModel.getCustomerRelationPersonList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCustomerRelationPersonList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    
    func postFindTheRightDevicePersonList(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "patient_uid=%@", self.selectedPerson)
        self.selectUserViewModel.postFindTheRightDevicePersonList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postFindTheRightDevicePersonList, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if (self.isFrom == IsNavigateFrom.fhaHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.fhaHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.fhaShop.rawValue) || (self.isFrom == IsNavigateFrom.fhaSurveySuccess.rawValue) {
            self.commonAPICALL(retryAPIID: 1001)
        } else if (self.isFrom == IsNavigateFrom.baHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.baHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.baStore.rawValue) || (self.isFrom == IsNavigateFrom.baShop.rawValue) || (self.isFrom == IsNavigateFrom.baMenu.rawValue) || (self.isFrom == IsNavigateFrom.baStoreDetail.rawValue) || (self.isFrom == IsNavigateFrom.baHAProductDetail.rawValue) || (self.isFrom == IsNavigateFrom.baFHA.rawValue) || (self.isFrom == IsNavigateFrom.baQuickCheck.rawValue) || (self.isFrom == IsNavigateFrom.baSurveySuccess.rawValue) || (self.isFrom == IsNavigateFrom.baSurveyRegisterDevice.rawValue) || (self.isFrom == IsNavigateFrom.baFRDUploadReport.rawValue) {
            self.navigateToBookAppointmentViewController(isFrom: self.isFrom, patientUid: self.selectedPerson)
        } else if (self.isFrom == IsNavigateFrom.ocHomeStatic.rawValue) || (self.isFrom == IsNavigateFrom.ocHearingCare.rawValue) || (self.isFrom == IsNavigateFrom.ocSurveySuccess.rawValue) || (self.isFrom == IsNavigateFrom.ocQuickCheck.rawValue) {
            self.navigateToOnlineConsultationConcernViewController(isFrom: self.isFrom, patientUid: self.selectedPerson)
        }
    }
    @IBAction func adduserButtonPressed(_ sender: UIButton) {
        self.navigateToAddUserViewController(isEdit: false, isFrom: IsNavigateFrom.addUser.rawValue, uid: "", name: "", dob: "", genderSlug: "", relationShipSlug: "", relationShip: "")
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
    func updateUserAddUserViewController() {
        self.commonAPICALL(retryAPIID: 1000)
    }
    func setUserInteractionButton() {
        if self.selectedPerson.isEmpty {
            self.setButtonDisable()
        } else {
            self.setButtonEnable()
        }
    }
}
extension SelectUserViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension SelectUserViewController: ProtocolNetworkRechabilityDelegate {
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
extension SelectUserViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.patientList.count > 0 {
            return 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.patientList.count > 0 {
            if section == 0 {
                return self.patientList.count
            } else {
                return 1
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.patientList.count > 0 {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SelectUserTableViewCell, for: indexPath) as! SelectUserTableViewCell
                cell.delegate = self
                cell.configure(patientList: self.patientList[indexPath.row], indexPath: indexPath.row, selectedPerson: self.selectedPerson)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SelectUserButtonTableViewCell, for: indexPath) as! SelectUserButtonTableViewCell
                let combination = NSMutableAttributedString()

                let highlightFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(13), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                               NSAttributedString.Key.underlineColor: UIColor.colorLiteral.theme_blue_2AACEF] as [NSAttributedString.Key: Any]

                let normalFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]

                let normaltext = NSMutableAttributedString(string: String(format: "%@ ", AppLocalizationString.dontfindyourprofileYoucanadditfromhere), attributes: normalFontAttributes as [NSAttributedString.Key: Any])

                let highlighttext = NSMutableAttributedString(string: String(format: "%@", AppLocalizationString.addperson.capitalized), attributes: highlightFontAttributes as [NSAttributedString.Key: Any])

                combination.append(normaltext)
                combination.append(highlighttext)
                cell.addpersonLabel.attributedText = combination
                cell.delegate = self
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SelectUserButtonTableViewCell, for: indexPath) as! SelectUserButtonTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SelectUserViewController: ProtocolSelectUserTableViewCell, ProtocolSelectUserButtonTableViewCell {
    func tapButtonSelectUserButtonTableViewCell(senderTag: Int) {
        self.navigateToAddUserViewController(isEdit: false, isFrom: IsNavigateFrom.addUser.rawValue, uid: "", name: "", dob: "", genderSlug: "", relationShipSlug: "", relationShip: "")
    }
    func tapButtonSelectUserTableViewCell(senderTag: Int) {
        self.setUserInteractionButton()
        if self.patientList.count > 0 {
            var uid = ""
            if !(self.patientList[senderTag].uid.isNilOrEmpty) {
                uid = self.patientList[senderTag].uid!
            }
            if self.selectedPerson.isEmpty {
                self.selectedPerson = uid
                self.setUserInteractionButton()
            } else if self.selectedPerson == uid {
                self.selectedPerson = ""
                self.setUserInteractionButton()
            } else {
                self.selectedPerson = uid
                self.setUserInteractionButton()
            }
            self.reloadTableview()
        }
    }
}
