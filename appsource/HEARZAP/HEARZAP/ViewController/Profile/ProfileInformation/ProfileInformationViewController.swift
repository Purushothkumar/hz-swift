//
//  ProfileInformationViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 14/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class ProfileInformationViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var profileInformationView: UIView!
    @IBOutlet var profileInformationStackView: UIStackView!

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userName: SubheadFontLabel!

    @IBOutlet var userCustomerIDView: UIView!
    @IBOutlet var userCustomerIDTitleLabel: Caption1FontLabel!
    @IBOutlet var userCustomerIDLabel: Caption1FontLabel!

    @IBOutlet var userCustomerFullNameView: UIView!
    @IBOutlet var userCustomerFullNameTitleLabel: Caption1FontLabel!
    @IBOutlet var userCustomerFullNameLabel: Caption1FontLabel!

    @IBOutlet var userCustomerGenderView: UIView!
    @IBOutlet var userCustomerGenderTitleLabel: Caption1FontLabel!
    @IBOutlet var userCustomerGenderLabel: Caption1FontLabel!

    @IBOutlet var userCustomerDobView: UIView!
    @IBOutlet var userCustomerDobTitleLabel: Caption1FontLabel!
    @IBOutlet var userCustomerDobLabel: Caption1FontLabel!

    @IBOutlet var userCustomerCityView: UIView!
    @IBOutlet var userCustomerCityTitleLabel: Caption1FontLabel!
    @IBOutlet var userCustomerCityLabel: Caption1FontLabel!

    @IBOutlet var userCustomerStateView: UIView!
    @IBOutlet var userCustomerStateTitleLabel: Caption1FontLabel!
    @IBOutlet var userCustomerStateLabel: Caption1FontLabel!

    @IBOutlet var userCustomerStatusView: UIView!
    @IBOutlet var userCustomerStatusTitleLabel: Caption1FontLabel!
    @IBOutlet var userCustomerStatusLabel: Caption1FontLabel!

    @IBOutlet var editprofileView: UIView!
    @IBOutlet var editprofileButton: FootnoteOutlineButton!

    @IBOutlet var emailView: UIView!
    @IBOutlet var emailStackView: UIStackView!

    @IBOutlet var emailTitleLabel: Caption1FontLabel!
    @IBOutlet var emailLabel: Caption2FontLabel!
    @IBOutlet var changeEmailButton: FootnoteOutlineButton!

    @IBOutlet var mobileNumberView: UIView!
    @IBOutlet var mobileNumberStackView: UIStackView!

    @IBOutlet var mobileNumberTitleLabel: Caption1FontLabel!
    @IBOutlet var mobileNumberLabel: Caption2FontLabel!
    @IBOutlet var changeMobileNumberButton: FootnoteOutlineButton!

    @IBOutlet var accountView: UIView!
    @IBOutlet var accountStackView: UIStackView!

    @IBOutlet var accountTitleView: UIView!
    @IBOutlet var accountTitleLabel: CalloutFontLabel!

    @IBOutlet var accountIDView: UIView!
    @IBOutlet var accountIDTitleLabel: Caption1FontLabel!
    @IBOutlet var accountIDLabel: Caption1FontLabel!

    @IBOutlet var accountNameView: UIView!
    @IBOutlet var accountNameTitleLabel: Caption1FontLabel!
    @IBOutlet var accountNameLabel: Caption1FontLabel!

    @IBOutlet var accountTypeView: UIView!
    @IBOutlet var accountTypeTitleLabel: Caption1FontLabel!
    @IBOutlet var accountTypeLabel: Caption1FontLabel!

    @IBOutlet var accountManagedView: UIView!
    @IBOutlet var accountManagedTitleLabel: Caption1FontLabel!
    @IBOutlet var accountManagedLabel: Caption1FontLabel!

    @IBOutlet var accountCreatedView: UIView!
    @IBOutlet var accountCreatedTitleLabel: Caption1FontLabel!
    @IBOutlet var accountCreatedLabel: Caption1FontLabel!

    @IBOutlet var accountStatusView: UIView!
    @IBOutlet var accountStatusTitleLabel: Caption1FontLabel!
    @IBOutlet var accountStatusLabel: Caption1FontLabel!

    @IBOutlet var disableView: UIView!
    @IBOutlet var disableStackView: UIStackView!

    @IBOutlet var disableLabel: Caption2FontLabel!
    @IBOutlet var disableButton: FootnoteOutlineButton!

    @IBOutlet var patientListView: UIView!
    @IBOutlet var patientListStackView: UIStackView!

    @IBOutlet var userProfileLabel: CalloutFontLabel!
    @IBOutlet var tableview: UITableView!
    @IBOutlet var tableviewHeight: NSLayoutConstraint!
    @IBOutlet var addProfileButton: FootnoteOutlineButton!

    @IBOutlet var deleteView: UIView!
    @IBOutlet var deleteStackView: UIStackView!

    @IBOutlet var deleteLabel: Caption2FontLabel!
    @IBOutlet var deleteButton: FootnoteOutlineButton!

    // MARK: - Lets and Var
    var profileInformationViewModel = ProfileInformationViewModel()
    var patientList = [PatientList]()

    //    var id = ""
    var uid = ""
    var name = ""
    var mobile = ""
    var email = ""
    var gender = ""
    var photo = ""
    var userStatus = ""
    var dob = ""

    var accountID = ""
    var accountName = ""
    var accountType = ""
    var managedBy = ""
    var status = ""
    var createdOn = ""

    var deleteUID = ""

    var isForAccount = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.patientList.count > 0 {
            self.tableviewHeight.constant = self.tableview.contentSize.height + 4
        } else {
            self.tableviewHeight.constant = 0
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

        let profileview7 = self.profileInformationStackView.arrangedSubviews[7]// customer city
        let profileview8 = self.profileInformationStackView.arrangedSubviews[8]// customer state

        profileview7.isHidden = true
        profileview8.isHidden = true

        self.tableview.tableFooterView = UIView()
        //        self.tableview.separatorColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension

        self.changeEmailButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.changeEmailButton.layer.borderWidth = 1.0
        self.changeEmailButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.changeEmailButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.changeEmailButton.clipsToBounds = true

        self.changeMobileNumberButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.changeMobileNumberButton.layer.borderWidth = 1.0
        self.changeMobileNumberButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.changeMobileNumberButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.changeMobileNumberButton.clipsToBounds = true

        self.editprofileButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.editprofileButton.layer.borderWidth = 1.0
        self.editprofileButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.editprofileButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.editprofileButton.clipsToBounds = true

        self.disableButton.layer.borderColor = UIColor.colorLiteral.theme_red_FF6961.cgColor
        self.disableButton.layer.borderWidth = 1.0
        self.disableButton.setTitleColor(UIColor.colorLiteral.theme_red_FF6961, for: .normal)
        self.disableButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.disableButton.clipsToBounds = true

        self.deleteButton.layer.borderColor = UIColor.colorLiteral.theme_red_FF6961.cgColor
        self.deleteButton.layer.borderWidth = 1.0
        self.deleteButton.setTitleColor(UIColor.colorLiteral.theme_red_FF6961, for: .normal)
        self.deleteButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.deleteButton.clipsToBounds = true

        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.myProfile
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.editprofileButton.setTitle(AppLocalizationString.editProfile.uppercased(), for: .normal)
        self.changeEmailButton.setTitle(AppLocalizationString.changeEmail.uppercased(), for: .normal)
        self.changeMobileNumberButton.setTitle(AppLocalizationString.changemobilenumber.uppercased(), for: .normal)
        self.deleteButton.setTitle(AppLocalizationString.deleteaccount.uppercased(), for: .normal)
        self.disableButton.setTitle(AppLocalizationString.disableaccount.uppercased(), for: .normal)

        self.userCustomerIDTitleLabel.text = AppLocalizationString.customerID
        self.userCustomerFullNameTitleLabel.text = AppLocalizationString.fullName
        self.userCustomerGenderTitleLabel.text = AppLocalizationString.gender
        self.userCustomerDobTitleLabel.text = AppLocalizationString.dateOfBirth
        self.userCustomerCityTitleLabel.text = AppLocalizationString.city
        self.userCustomerStateTitleLabel.text = AppLocalizationString.state
        self.userCustomerStatusTitleLabel.text = AppLocalizationString.status
        self.emailTitleLabel.text = AppLocalizationString.emailAddress
        self.mobileNumberTitleLabel.text = AppLocalizationString.phoneNumber
        self.accountTitleLabel.text = AppLocalizationString.hearzapAccountDetails
        self.accountIDTitleLabel.text = AppLocalizationString.accountID
        self.accountNameTitleLabel.text = AppLocalizationString.accountName
        self.accountTypeTitleLabel.text = AppLocalizationString.accountType
        self.accountManagedTitleLabel.text = AppLocalizationString.accountManangedBy
        self.accountCreatedTitleLabel.text = AppLocalizationString.accountCreatedOn
        self.accountStatusTitleLabel.text = AppLocalizationString.accountStatus
        self.deleteLabel.text = AppLocalizationString.ifyoudeleteyouraccountyouwillloseallyourdata
        self.disableLabel.text = AppLocalizationString.ifyoudisableyouraccountyoucanenableitagainanytime
    }
    // MARK: - Reload
    func reloadTableView() {
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
                    self.getProfileInformation(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.deleteAccount(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 {
                    self.disableAccount(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1003 {
                    self.deletePatient(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.getProfileInformation(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getProfileInformation(retryAPIID: Int, canShowLoader: Bool) {
        self.profileInformationViewModel.getProfileInformation(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getProfileInformation, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func deleteAccount(retryAPIID: Int, canShowLoader: Bool) {
        self.profileInformationViewModel.deleteAccount(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.deleteAccount, methodName: HTTPMethods.post, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func disableAccount(retryAPIID: Int, canShowLoader: Bool) {
        self.profileInformationViewModel.disableAccount(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.disableAccount, methodName: HTTPMethods.post, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func deletePatient(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.deletePatient)\(deleteUID)/"
        self.profileInformationViewModel.deletePatient(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        self.navigateToEditProfileViewController(name: self.name, dob: self.dob, genderSlug: self.gender, photo: self.photo)
    }
    @IBAction func changeEmailButtonPressed(_ sender: UIButton) {
        self.navigateToChangeInformationViewController(toChangeNumber: false)
    }
    @IBAction func changeMobileNumberButtonPressed(_ sender: UIButton) {
        self.navigateToChangeInformationViewController(toChangeNumber: true)
    }
    @IBAction func disableButtonPressed(_ sender: UIButton) {
        self.showDeletePopupScreen(isDelete: false)
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        self.showDeletePopupScreen(isDelete: true)
    }
    @IBAction func addProfileButtonPressed(_ sender: UIButton) {
        self.navigateToAddUserViewController(isEdit: false, isFrom: IsNavigateFrom.addUserProfile.rawValue, uid: "", name: "", dob: "", genderSlug: "", relationShipSlug: "", relationShip: "")
    }

    // MARK: - Custom Methods

}

extension ProfileInformationViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension ProfileInformationViewController: ProtocolNetworkRechabilityDelegate {
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
extension ProfileInformationViewController: ProtocolBottomSheetProfileViewControllerDelegate, BottomPopupDelegate {
    // MARK: - DeletePopupScreen
    func showDeletePopupScreen(isDelete: Bool) {
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetProfileViewController) as? BottomSheetProfileViewController else { return }
        popupVC.topCornerRadius = CGFloat(25)
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0
        self.isForAccount = true
        let primaryMsgText = isDelete == true ? AppLocalizationString.areyousureyouwanttodelete :AppLocalizationString.areyousureyouwanttodisable
        let secondaryMsgText = isDelete == true ? AppLocalizationString.alltheparentinformationwillbedeletedfromyouaccount : AppLocalizationString.alltheparentinformationwillbedisablefromyouaccount
        let deleteText = isDelete == true ? AppLocalizationString.yesdelete : AppLocalizationString.yesdisable
        let cancelText = isDelete == true ? AppLocalizationString.nocancel : AppLocalizationString.nocancel

        let popvcheight = 37/*image top*/ + 36/*image height*/ + 25/*image bottom*/ + CGFloat(self.heightForText(text: primaryMsgText, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - 32))/*primary height*/ + 5/*primary bottom*/ + CGFloat(self.heightForText(text: secondaryMsgText, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - 32))/*secondary height*/ + 5/*secondary bottom*/ + 20/*button top*/ + 38/*button height*/ + 25/*button bottom*/

        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        popupVC.height = popvcheight + bottomPadding + topPadding

        popupVC.popupDelegate = self
        popupVC.protocolBottomSheetProfileViewControllerDelegate = self
        popupVC.primaryMsgText = primaryMsgText
        popupVC.secondaryMsgText = secondaryMsgText
        popupVC.deleteText = deleteText
        popupVC.cancelText = cancelText
        popupVC.isDelete = isDelete
        self.present(popupVC, animated: true, completion: nil)
    }

    func showProfileDeletePopupScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetProfileViewController) as? BottomSheetProfileViewController else { return }
        popupVC.topCornerRadius = CGFloat(25)
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0
        self.isForAccount = false
        let primaryMsgText = AppLocalizationString.areyousureyouwanttodelete
        let secondaryMsgText = ""
        let deleteText = AppLocalizationString.yesdelete
        let cancelText = AppLocalizationString.nocancel

        let popvcheight = 37/*image top*/ + 36/*image height*/ + 25/*image bottom*/ + CGFloat(self.heightForText(text: primaryMsgText, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - 32))/*primary height*/ + 5/*primary bottom*/ + CGFloat(self.heightForText(text: secondaryMsgText, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - 32))/*secondary height*/ + 5/*secondary bottom*/ + 20/*button top*/ + 38/*button height*/ + 25/*button bottom*/

        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        popupVC.height = popvcheight + bottomPadding + topPadding

        popupVC.popupDelegate = self
        popupVC.protocolBottomSheetProfileViewControllerDelegate = self
        popupVC.primaryMsgText = primaryMsgText
        popupVC.secondaryMsgText = secondaryMsgText
        popupVC.deleteText = deleteText
        popupVC.cancelText = cancelText
        popupVC.isDelete = true
        self.present(popupVC, animated: true, completion: nil)
    }

    // MARK: - ProtocolBottomSheetProfileViewControllerDelegate
    func deleteButtonPressedBottomSheetProfileViewController(isDelete: Bool) {
        if self.isForAccount == true {
            if isDelete == true {
                self.isForAccount = false
                self.commonAPICALL(retryAPIID: 1001)
            } else {
                self.commonAPICALL(retryAPIID: 1002)
            }
        } else {
            self.commonAPICALL(retryAPIID: 1003)
        }
    }
}
extension ProfileInformationViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patientList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProfileInformationTableViewCell, for: indexPath) as! ProfileInformationTableViewCell
        cell.delegate = self
        cell.configure(patientList: self.patientList[indexPath.row], indexPath: indexPath.row)
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableviewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension ProfileInformationViewController: ProtocolProfileInformationTableViewCell {
    func editButtonPressedProfileInformationTableViewCell(senderTag: Int) {
        if self.patientList.count > 0 {
            var patientuid = ""
            var patientname = ""
            var patientdob = ""
            var patientgenderSlug = ""
            var patientrelationShipSlug = ""
            var patientrelationShip = ""

            if !(self.patientList[senderTag].uid.isNilOrEmpty) {
                patientuid = self.patientList[senderTag].uid!
            }
            if !(self.patientList[senderTag].name.isNilOrEmpty) {
                patientname = self.patientList[senderTag].name!.capitalized
            }
            if !(self.patientList[senderTag].dob.isNilOrEmpty) {
                patientdob = self.patientList[senderTag].dob!.capitalized
            }
            if !(self.patientList[senderTag].gender.isNilOrEmpty) {
                patientgenderSlug = self.patientList[senderTag].gender!.capitalized
            }
            if !(self.patientList[senderTag].relationshipType.isNilOrEmpty) {
                patientrelationShipSlug = self.patientList[senderTag].relationshipType!
            }
            if !(self.patientList[senderTag].relationship.isNilOrEmpty) {
                patientrelationShip = self.patientList[senderTag].relationship!.capitalized
            }
            self.navigateToAddUserViewController(isEdit: true, isFrom: IsNavigateFrom.addUserProfile.rawValue, uid: patientuid, name: patientname, dob: patientdob, genderSlug: patientgenderSlug, relationShipSlug: patientrelationShipSlug, relationShip: patientrelationShip)
        }
    }
    func deleteButtonPressedProfileInformationTableViewCell(senderTag: Int) {
        if self.patientList.count > 0 {
            if !(self.patientList[senderTag].uid.isNilOrEmpty) {
                self.deleteUID = self.patientList[senderTag].uid!
                self.showProfileDeletePopupScreen()
            }
        }
    }
}
