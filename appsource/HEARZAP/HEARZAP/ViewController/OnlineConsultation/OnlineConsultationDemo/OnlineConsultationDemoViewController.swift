//
//  OnlineConsultationDemoViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class OnlineConsultationDemoViewController: UIViewController {
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

    @IBOutlet var termscondtionlabel: Caption1FontLabel!

    @IBOutlet var emptyView: UIView!

    @IBOutlet var onlineConsultationView: UIView!
    @IBOutlet var onlineConsultationButton: CalloutBackgroundButton!
    @IBOutlet var onlineConsultationButtonHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    let onlineConsultationDemoViewModel = OnlineConsultationDemoViewModel()
    var isFrom = ""
    var onlineConsultationArray = [OcStep]()
    var serviceType = ""
    var serviceName = ""
    var serviceDesc = ""
    var servicePosterPhoto = ""
    var serviceMarketingVideoLink = ""

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
        if self.onlineConsultationArray.count > 0 {
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
        let view0 = self.mainStackView.arrangedSubviews[0]// banner Image
        let view1 = self.mainStackView.arrangedSubviews[1]// content
        let view2 = self.mainStackView.arrangedSubviews[2]// policy
        let view3 = self.mainStackView.arrangedSubviews[3]// empty
        view0.isHidden = false
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        self.onlineConsultationView.isHidden = true
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.onlineConsultationView.isHidden = true
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
        self.onlineConsultationButton.setTitle(AppLocalizationString.startBooking.uppercased(), for: .normal)
        self.bannerImageView.setImage(imageUrl: servicePosterPhoto, placeHolderImage: hearzapPlaceholder)
        let strText1 = AppLocalizationString.onlineConsulationCondtionsMessage
        let strText2 = AppLocalizationString.termsandConditions
        let strText3 = AppLocalizationString.ofhearzap
        let regularFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(11)]
        let regularUndelineFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(11), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.colorLiteral.theme_blue_2AACEF] as [NSAttributedString.Key: Any]

        let part1 = NSMutableAttributedString(string: String(format: "%@ ", strText1), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
        let part2 = NSMutableAttributedString(string: String(format: "%@", strText2), attributes: regularUndelineFontAttributes as [NSAttributedString.Key: Any])
        let part3 = NSMutableAttributedString(string: String(format: " %@", strText3), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
        let combination = NSMutableAttributedString()
        combination.append(part1)
        combination.append(part2)
        combination.append(part3)
        self.termscondtionlabel.attributedText = combination
        self.termscondtionlabel.isUserInteractionEnabled = true
        self.termscondtionlabel.lineBreakMode = .byWordWrapping
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.termscondtionlabel.addGestureRecognizer(tapgesture)
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
                    self.getOnlineConsultationStepsList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getOnlineConsultationStepsList(retryAPIID: Int, canShowLoader: Bool) {
        self.onlineConsultationDemoViewModel.getOnlineConsultationStepsList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getOnlineConsultationStepsList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func onlineConsultationButtonPressed(_ sender: UIButton) {
        self.checkVerifiedUser()
    }
    // MARK: - Custom Methods
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.termscondtionlabel.text else { return }
        let termsandConditionsRange = (text as NSString).range(of: AppLocalizationString.termsandConditions)
        let texttap = (text as NSString).range(of: text)
        //        if gesture.didTapAttributedTextInLabel(label: self.policylabel, inRange: termsandConditionsRange) {
        //            self.navigateToTermsConditionsViewController(isFrom: isFrom)
        //        }
        if gesture.didTapAttributedTextInLabel(label: self.termscondtionlabel, inRange: termsandConditionsRange) {
            self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseOnlineConsultation.rawValue)
        } else if gesture.didTapAttributedTextInLabel(label: self.termscondtionlabel, inRange: texttap) {
            self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseOnlineConsultation.rawValue)
        } else {
        }
    }
    func checkVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginOnlineConsultation.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToSelectUserViewControllerToOnlineConsultation(isFrom: self.isFrom, showFourDotView: false, showFiveDotView: true, showSixDotView: false)
        }
    }
    func verifiedUser(isFrom: String, isWishlist: Bool, productUID: String) {
        if isFrom == IsNavigateFrom.loginOnlineConsultation.rawValue {
            self.checkVerifiedUser()
        }
    }
}
extension OnlineConsultationDemoViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.ocHomeStatic.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.ocHearingCare.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.ocSurveySuccess.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.ocQuickCheck.rawValue {
            self.navigateBackToQuickTestResultViewController()
        } else {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        }
    }
    func rightButtonPressed() {}
}
extension OnlineConsultationDemoViewController: ProtocolNetworkRechabilityDelegate {
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
extension OnlineConsultationDemoViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.onlineConsultationArray.count > 0 {
            return 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.onlineConsultationArray.count > 0 {
            if section == 0 {
                return 1
            } else {
                return self.onlineConsultationArray.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.onlineConsultationArray.count > 0 {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.OnlineConsultationDemoTitleTableViewCell, for: indexPath) as! OnlineConsultationDemoTitleTableViewCell
                cell.titleLabel.text = AppLocalizationString.howitworks
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.OnlineConsultationDemoContentTableViewCell, for: indexPath) as! OnlineConsultationDemoContentTableViewCell
                cell.configure(ocSteps: self.onlineConsultationArray[indexPath.row], indexpath: indexPath.row)
                if self.onlineConsultationArray.count > 0 {
                    if indexPath.row == (self.onlineConsultationArray.count - 1) {
                        cell.hideSeparator()
                    }
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.OnlineConsultationDemoContentTableViewCell, for: indexPath) as! OnlineConsultationDemoContentTableViewCell
            cell.configure(ocSteps: self.onlineConsultationArray[indexPath.row], indexpath: indexPath.row)
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
