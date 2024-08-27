//
//  BookAppointmentDemoViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BookAppointmentDemoViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: LogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var bannerImageView: UIImageView!

    @IBOutlet var contentStackView: UIStackView!
    @IBOutlet var titleView: UIView!
    @IBOutlet var titlelabel: Title2FontLabel!
    @IBOutlet var descriptionlabel: FootnoteFontLabel!

    @IBOutlet var contentView: UIView!
    @IBOutlet var tableviewHeight: NSLayoutConstraint!
    @IBOutlet var tableview: UITableView!

    @IBOutlet var policyView: UIView!
    @IBOutlet var policylabel: Caption1FontLabel!

    @IBOutlet var emptyView: UIView!

    @IBOutlet var bookAppointmentView: UIView!
    @IBOutlet var bookAppointmentButton: CalloutBackgroundButton!
    @IBOutlet var bookAppointmentButtonHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    var isFrom = ""
    let bookAppointmentDemoViewModel = BookAppointmentDemoViewModel()
    var bookAppointmentArray = [BookingStep]()

    var serviceType = ""
    var serviceName = ""
    var serviceDesc = ""
    var servicePosterPhoto = ""
    var serviceMarketingVideoLink = ""

    var strText = ""

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.bookAppointmentArray.count > 0 {
            self.tableviewHeight.constant = self.tableview.contentSize.height
        } else {
            self.tableviewHeight.constant = 0
        }
        self.mainScrollView.sizeToFit()
        self.mainScrollView.contentSize = CGSize(width: self.mainScrollView.frame.size.width, height: self.emptyView.frame.height + self.emptyView.frame.origin.y )
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
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        let view0 = self.mainStackView.arrangedSubviews[0]// banner Image
        let view1 = self.mainStackView.arrangedSubviews[1]// content
        let view2 = self.mainStackView.arrangedSubviews[2]// empty
        view0.isHidden = false
        view1.isHidden = true
        view2.isHidden = true
        self.bookAppointmentView.isHidden = true
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBar.isLogoHidden = false
        self.navigationBar.logoImage = Asset.hzlogo
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.titlelabel.text = serviceName.capitalized
        self.descriptionlabel.text = serviceDesc.capitalized
        self.bookAppointmentButton.setTitle(AppLocalizationString.startBooking.uppercased(), for: .normal)
        self.bannerImageView.setImage(imageUrl: servicePosterPhoto, placeHolderImage: hearzapPlaceholder)

        //        let strText1 = ""
        let strText2 = AppLocalizationString.bycontinuingyouhavereadandagreetothe
        let strText3 = AppLocalizationString.termsandConditions
        let strText4 = AppLocalizationString.ofhearzap
        //        self.strText = String(format: "%@ %@ %@ %@", strText1, strText2, strText3, strText4)
        self.strText = String(format: "%@ %@ %@", strText2, strText3, strText4)

        let regularUndelineFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(11), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.colorLiteral.theme_blue_2AACEF] as [NSAttributedString.Key: Any]

        let regularFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(11)]
        //        let part1 = NSMutableAttributedString(string: String(format: "%@", strText1), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
        let part2 = NSMutableAttributedString(string: String(format: "%@ ", strText2), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
        let part3 = NSMutableAttributedString(string: String(format: "%@", strText3), attributes: regularUndelineFontAttributes as [NSAttributedString.Key: Any])
        let part4 = NSMutableAttributedString(string: String(format: " %@", strText4), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
        let combination = NSMutableAttributedString()
        //        combination.append(part1)
        combination.append(part2)
        combination.append(part3)
        combination.append(part4)
        self.policylabel.attributedText = combination
        self.policylabel.isUserInteractionEnabled = true
        self.policylabel.lineBreakMode = .byWordWrapping
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.policylabel.addGestureRecognizer(tapgesture)

    }
    // MARK: - Reload
    func reloadTableview() {
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getBookAppointmentStepsList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getBookAppointmentStepsList(retryAPIID: Int, canShowLoader: Bool) {
        self.bookAppointmentDemoViewModel.getBookAppointmentStepsList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getBookAppointmentStepsList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func bookAppointmentButtonPressed(_ sender: UIButton) {
        self.checkVerifiedUser()
    }
    // MARK: - Custom Methods
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.policylabel.text else { return }
        let termsandConditionsRange = (text as NSString).range(of: AppLocalizationString.termsandConditions)
        let texttap = (text as NSString).range(of: text)

        //        if gesture.didTapAttributedTextInLabel(label: self.policylabel, inRange: termsandConditionsRange) {
        //            self.navigateToTermsConditionsViewController(isFrom: isFrom)
        //        }
        if gesture.didTapAttributedTextInLabel(label: self.policylabel, inRange: termsandConditionsRange) {
            self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseBookAppointment.rawValue)
        } else if gesture.didTapAttributedTextInLabel(label: self.policylabel, inRange: texttap) {
            self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseBookAppointment.rawValue)
        } else {
            
        }
    }
    func checkVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginBookAppointment.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToSelectUserViewControllerToBookAppointment(isFrom: self.isFrom, showFourDotView: true, showFiveDotView: false, showSixDotView: false)
        }
    }
    func verifiedUser(isFrom: String, isWishlist: Bool, productUID: String) {
        if isFrom == IsNavigateFrom.loginBookAppointment.rawValue {
            self.checkVerifiedUser()
        }
    }
}
extension BookAppointmentDemoViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.baHomeStatic.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.baHearingCare.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.baStore.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabStores, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.baShop.rawValue {
            self.navigateBackToShopCategoryViewController()
        } else if self.isFrom == IsNavigateFrom.baMenu.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.baStoreDetail.rawValue {
            self.navigateBackToStoreDetailViewController()
        } else  if self.isFrom == IsNavigateFrom.baHAProductDetail.rawValue {
            self.navigateBackToHAProductDetailViewController()
        } else if self.isFrom == IsNavigateFrom.baFHA.rawValue {
            self.navigateBackToFindRightDeviceRecommendViewController()
        } else if self.isFrom == IsNavigateFrom.baQuickCheck.rawValue {
            self.navigateBackToQuickTestResultViewController()
        } else if (self.isFrom == IsNavigateFrom.baSurveySuccess.rawValue) {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.baSurveyRegisterDevice.rawValue {
            self.navigateBackToRegisterDeviceViewControllerUpdated()
        } else if self.isFrom == IsNavigateFrom.baFRDUploadReport.rawValue {
            self.navigateBackToFindRightDeviceUploadReportViewController()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {}
}
extension BookAppointmentDemoViewController: ProtocolNetworkRechabilityDelegate {
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
extension BookAppointmentDemoViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.bookAppointmentArray.count > 0 {
            return 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.bookAppointmentArray.count > 0 {
            if section == 0 {
                return 1
            } else {
                return self.bookAppointmentArray.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.bookAppointmentArray.count > 0 {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BookAppointmentDemoTitleTableViewCell, for: indexPath) as! BookAppointmentDemoTitleTableViewCell
                cell.titleLabel.text = AppLocalizationString.howitworks
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BookAppointmentDemoContentTableViewCell, for: indexPath) as! BookAppointmentDemoContentTableViewCell
                cell.configure(bookingStep: self.bookAppointmentArray[indexPath.row], indexPath: indexPath.row)
                if self.bookAppointmentArray.count > 0 {
                    if indexPath.row == (self.bookAppointmentArray.count - 1) {
                        cell.hideSeparator()
                    }
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BookAppointmentDemoContentTableViewCell, for: indexPath) as! BookAppointmentDemoContentTableViewCell
            cell.configure(bookingStep: self.bookAppointmentArray[indexPath.row], indexPath: indexPath.row)
            return cell
        }
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
