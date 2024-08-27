//
//  MenuViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: MainLogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Lets and Var
    var menuViewModel = MenuViewModel()
    var menuArray = [[MenuModel]]()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var customerName = ""
    var customerMobile = ""
    var customerEmail = ""
    var customerUID = ""
    var profilePicture = ""
    
    var hasAlert = false
    var hasCart = false
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setInitialView()
        UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty) {
            self.commonAPICALL(retryAPIID: 1000)
        }
        if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty) {
            self.hasAlert = false
            self.hasCart = false
            self.commonAPICALL(retryAPIID: 2000)
        }
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
        UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTableView()
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = false
        self.navigationBar.isLeftSecondaryViewHidden = true
        self.navigationBar.isRightSecondaryViewHidden = false
        self.navigationBar.leftImage = Asset.homewhite
        self.navigationBar.rightImage = self.hasCart == false ? Asset.bagblue : Asset.bagnotificationblue
        self.navigationBar.rightSecondaryImage = self.hasAlert == false ? Asset.bellblue : Asset.bellbluenotification
        self.navigationBar.isLogoHidden = false
        self.navigationBar.logoImage = Asset.hzlogo
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        
    }
    // MARK: - Reload
    func reloadTableView() {
        self.menuArray.removeAll()
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.menuArray = self.menuViewModel.guestUserModel()
        } else {
            if UserDefaults.standard.value(forKey: UserDefaultsPreferenceKeys.customerName) != nil {
                if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.customerName).isNilOrEmpty) {
                    self.customerName = UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.customerName)!
                }
            }
            if UserDefaults.standard.value(forKey: UserDefaultsPreferenceKeys.customerMobile) != nil {
                
                if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.customerMobile).isNilOrEmpty) {
                    self.customerMobile = UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.customerMobile)!
                }
            }
            if UserDefaults.standard.value(forKey: UserDefaultsPreferenceKeys.customerEmail) != nil {
                if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.customerEmail).isNilOrEmpty) {
                    self.customerEmail = UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.customerEmail)!
                }
            }
            if UserDefaults.standard.value(forKey: UserDefaultsPreferenceKeys.profilePicture) != nil {
                if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.profilePicture).isNilOrEmpty) {
                    self.profilePicture = UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.profilePicture)!
                }
            }
            
            self.menuArray = self.menuViewModel.loggedInModel()
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getCustomerDetail(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 2000 {
                    self.getNotificationCount(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCustomerDetail(retryAPIID: Int, canShowLoader: Bool) {
        self.menuViewModel.getCustomerDetail(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCustomerDetail, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getNotificationCount(retryAPIID: Int, canShowLoader: Bool) {
        self.menuViewModel.getNotificationCount(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getNotificationCount, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - Custom Methods
    public func navigateToLogin() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.reloadTableView()
        }
    }
    func verifiedUser(isFrom: String, isWishlist: Bool, productUID: String) {
        if isFrom == IsNavigateFrom.loginMenu.rawValue {
            self.navigateToLogin()
        }
    }
    func checkSurveyVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginSurveyMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToShareExperienceViewController(isFrom: IsNavigateFrom.surveyMenu.rawValue, surveyType: SurveyType.feedbackservice.rawValue)
        }
    }
    func verifiedSurveyUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkSurveyVerifiedUser()
    }
    func checkReferFriendVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginReferFriendMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToReferFriendViewController(isFrom: IsNavigateFrom.reffrMenu.rawValue)
        }
    }
    func verifiedReferFriendUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkReferFriendVerifiedUser()
    }
    func checkRegisterDeviceVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginRegisterDeviceMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToRegisterDeviceViewController(isFrom: IsNavigateFrom.rdMenu.rawValue)
        }
    }
    func verifiedRegisterDeviceUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkRegisterDeviceVerifiedUser()
    }
    func checkCouponVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginCouponMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToCouponListViewController()
        }
    }
    func verifiedCouponUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkCouponVerifiedUser()
    }
    func checkAddressVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginAddressMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToAddressListViewController()
        }
    }
    func verifiedAddressUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkAddressVerifiedUser()
    }
    func checkProfileVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginProfileMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToProfileInformationViewController()
        }
    }
    func verifiedProfileUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkProfileVerifiedUser()
    }
    func checkRewardsVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginRewardsMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToRewardPointsViewController()
        }
    }
    func verifiedRewardsUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkRewardsVerifiedUser()
    }

    func checkBuyBackVerifiedUser() {
        self.navigateToBuyBackViewController(isFrom: IsNavigateFrom.buybackMenu.rawValue)
    }
    func verifiedBuyBackUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkBuyBackVerifiedUser()
    }
    func checkCartVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginCartMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToCartDetailViewController(isFrom: IsNavigateFrom.cartMenu.rawValue)
        }
    }
    func verifiedCartUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkCartVerifiedUser()
    }
    func checkAudiogramReportVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginAudiogramReportMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToAudiogramReportViewController(isFrom: IsNavigateFrom.audiogramReportMenu.rawValue)
        }
    }
    func verifiedAudiogramReportUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkAudiogramReportVerifiedUser()
    }
    func checkServiceRequestVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginServiceRequestMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToServiceRequestListViewController(isFrom: IsNavigateFrom.srMenu.rawValue)
        }
    }
    func verifiedServiceRequestUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkServiceRequestVerifiedUser()
    }
    func checkOrderListVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginOrderListMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToOrderListViewController(isFrom: IsNavigateFrom.orderMenu.rawValue)
        }
    }
    func verifiedOrderListUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkOrderListVerifiedUser()
    }
    func checkWishlistVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginWishlistMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToWishlistViewController(isFrom: IsNavigateFrom.wishlistMenu.rawValue)
        }
    }
    func verifiedWishlistUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkWishlistVerifiedUser()
    }
    
    func checkMyAlertVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginMyAlertMenu.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToMyAlertViewController(isFrom: IsNavigateFrom.myalertMenu.rawValue)
        }
    }
    func verifiedMyAlertUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkMyAlertVerifiedUser()
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.GuestAccountTableViewCell, for: indexPath) as! GuestAccountTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.UserDataTableViewCell, for: indexPath) as! UserDataTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            } else if indexPath.section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.UserProfileTableViewCell, for: indexPath) as! UserProfileTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            } else if indexPath.section == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.UserCouponTableViewCell, for: indexPath) as! UserCouponTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            } else if indexPath.section == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.HearzapDataTableViewCell, for: indexPath) as! HearzapDataTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            } else if indexPath.section == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.HearzapPolicyTableViewCell, for: indexPath) as! HearzapPolicyTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            }
        } else {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.UserAccountTableViewCell, for: indexPath) as! UserAccountTableViewCell
                cell.profileButton.tag = indexPath.row
                cell.userNameLabel.text = ""
                cell.userEmailPhoneLabel.text = ""
                cell.userNameLabel.text = self.customerName
                if self.customerEmail == "-" {
                    self.customerEmail = ""
                }
                if !(self.customerMobile.isEmpty) && !(self.customerEmail.isEmpty) {
                    cell.userEmailPhoneLabel.text = "\(self.customerMobile)\n\(self.customerEmail)"
                } else if (self.customerMobile.isEmpty) || (self.customerEmail.isEmpty) {
                    if !(self.customerMobile.isEmpty) {
                        cell.userEmailPhoneLabel.text = self.customerMobile
                    } else if !(self.customerEmail.isEmpty) {
                        cell.userEmailPhoneLabel.text = self.customerEmail
                    }
                }
                cell.profileImageView.setImage(imageUrl: profilePicture, placeHolderImage: profileGrey)
                cell.delegate = self
                return cell
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.UserDataTableViewCell, for: indexPath) as! UserDataTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            } else if indexPath.section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.UserProfileTableViewCell, for: indexPath) as! UserProfileTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            } else if indexPath.section == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.UserCouponTableViewCell, for: indexPath) as! UserCouponTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            } else if indexPath.section == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.HearzapDataTableViewCell, for: indexPath) as! HearzapDataTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            } else if indexPath.section == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.HearzapPolicyTableViewCell, for: indexPath) as! HearzapPolicyTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.LogoutTableViewCell, for: indexPath) as! LogoutTableViewCell
                let menuModel: MenuModel = menuArray[indexPath.section][indexPath.row]
                cell.configure(menuModel: menuModel, indexpath: indexPath.row)
                cell.delegate = self
                return cell
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 8))
        footerView.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return CGFloat(8)
    }
}

// MARK: - Menu Cell Delegates
extension MenuViewController: ProtocolUserProfileTableViewCell, ProtocolHearzapPolicyTableViewCell, ProtocolLogoutTableViewCell, ProtocolGuestAccountTableViewCell, ProtocolHearzapDataTableViewCell, ProtocolGuestProfileTableViewCell, ProtocolUserAccountTableViewCell, ProtocolUserDataTableViewCell, ProtocolUserCouponTableViewCell {
    func userCouponTableViewCellButtonPressed(senderTag: Int) {
        if senderTag == 0 {// referarefriend
            self.checkReferFriendVerifiedUser()
        } else if senderTag == 1 {// shareyourexperience
            self.checkSurveyVerifiedUser()
        }
    }
    func userDataTableViewCellButtonPressed(senderTag: Int) {
        if senderTag == 0 {// servicerequest
            self.checkServiceRequestVerifiedUser()
        } else if senderTag == 1 {// audiogramreport
            self.checkAudiogramReportVerifiedUser()
        } else if senderTag == 2 {// registerdevice
            self.checkRegisterDeviceVerifiedUser()
        } else if senderTag == 3 {// trackyourorder
            self.checkOrderListVerifiedUser()
        } else if senderTag == 4 {// wishlist
            self.checkWishlistVerifiedUser()
        } else if senderTag == 5 {// coupon
            self.checkCouponVerifiedUser()
        } else if senderTag == 6 {// reward
            self.checkRewardsVerifiedUser()
        }
    }
    func userProfileTableViewCellButtonPressed(senderTag: Int) {
        if senderTag == 0 {// myprofile
            self.checkProfileVerifiedUser()
        } else if senderTag == 1 {// myaddress
            self.checkAddressVerifiedUser()
        } else if senderTag == 2 {// myalert
            self.checkMyAlertVerifiedUser()
        }
    }
    func hearzapPolicyTableViewCellButtonPressed(senderTag: Int) {
        if senderTag == 0 {// aboutus
            self.navigateToAboutUsViewController(isFrom: IsNavigateFrom.aboutMenu.rawValue)
        } else if senderTag == 1 {// contactus
            self.navigateToSupportViewController(isFrom: IsNavigateFrom.supportMenu.rawValue)
        } else if senderTag == 2 {// privacypolicy
            self.navigateToPrivacyPolicyViewController(isFrom: IsNavigateFrom.privacyPolicyMenu.rawValue)
        } else if senderTag == 3 {// termofuse
            self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseMenu.rawValue)
        } else if senderTag == 4 {// legal
            self.navigateToLegalViewController(isFrom: IsNavigateFrom.legalMenu.rawValue)
        }
    }
    func hearzapDataTableViewCellButtonPressed(senderTag: Int) {
        if senderTag == 0 {// blogs/tips
            self.navigateToBlogsListViewController()
        } else if senderTag == 1 {// blogs/tips
            self.navigateToTipsListViewController()
        } else if senderTag == 2 {// faqs
            self.navigateToFAQViewController(isFrom: IsNavigateFrom.faqMenu.rawValue)
        } else if senderTag == 3 { // care and maintainence
            self.navigateToCareMaintenanceListViewController()
        } else if senderTag == 4 { // care and maintainence
            self.navigateToCustomerTestimonialListViewController()
        } else if senderTag == 5 {// buyBackOffers
            checkBuyBackVerifiedUser()
        }
    }
    func guestProfileTableViewCellButtonPressed(senderTag: Int) {
        if senderTag == 0 {// referyourfriends
            self.checkReferFriendVerifiedUser()
        }
    }
    func logoutTableViewCellButtonPressed() {
        self.view.endEditing(true)
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: AppLocalizationString.logout, message: AppLocalizationString.logoutMessage, preferredStyle: .alert)
            let okbtn = UIAlertAction(title: AppLocalizationString.ok.uppercased(), style: .default, handler: { (_) in
                self.signout()
            })
            let cancelbtn = UIAlertAction(title: AppLocalizationString.cancel, style: .cancel) { (_) in
            }
            alertViewController.addAction(cancelbtn)
            alertViewController.addAction(okbtn)
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    func guestAccountTableViewCellLoginButtonPressed() {// login
        self.navigateToLogin()
    }
    func userAccountTableViewCellProfileButtonPressed() {// profile
        self.checkProfileVerifiedUser()
    }
}
extension MenuViewController: ProtocolNetworkRechabilityDelegate {
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
extension MenuViewController: ProtocolMainLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftSecondaryButtonPressed() {}
    func rightSecondaryButtonPressed() {
        self.checkMyAlertVerifiedUser()
    }
    func leftButtonPressed() {
        UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    func rightButtonPressed() {
        self.checkCartVerifiedUser()
    }
}
