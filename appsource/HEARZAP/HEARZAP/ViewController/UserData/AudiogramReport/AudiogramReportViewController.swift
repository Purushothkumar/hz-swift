//
//  AudiogramReportViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 24/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class AudiogramReportViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var quickTestButton: FootnoteBackgroundButton!
    @IBOutlet var audiogramTestButton: FootnoteBackgroundButton!

    @IBOutlet var tableview: UITableView!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var errorTapButton: CalloutOutlineButton!

    // MARK: - Lets and Var
    var audiogramReportViewModel = AudiogramReportViewModel()
    var audiogramReportListArray = [AudiogramTestReport]()
    var quickCheckReportListArray = [QuickTestReport]()

    var isFrom = ""
    var isQuickCheck = true

    // MARK: - App Life Cycle
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
        self.primaryMessageLabel.text = ""
        self.secondaryMessageLabel.text = ""
        self.errorView.isHidden = true
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()

        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTableView()
        self.setSelectedState()
        self.commonAPICALL(retryAPIID: 1001)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.testReports.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.primaryMessageLabel.text = AppLocalizationString.youdonthaveanytestreports
        let errorcombination = NSMutableAttributedString()
        let errorTitleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let errorContentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(13)]

        let errorTitle = NSMutableAttributedString(string: String(format: "%@ ", AppLocalizationString.exploreour), attributes: errorTitleAttributes as [NSAttributedString.Key: Any])
        let errorContent = NSMutableAttributedString(string: String(format: "%@", AppLocalizationString.hearingcareservices), attributes: errorContentFontAttributes as [NSAttributedString.Key: Any])

        errorcombination.append(errorTitle)
        errorcombination.append(errorContent)
        self.secondaryMessageLabel.attributedText = errorcombination

        self.quickTestButton.setTitle(AppLocalizationString.quickTest.capitalized, for: .normal)
        self.audiogramTestButton.setTitle(AppLocalizationString.audiogramTest.capitalized, for: .normal)

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
                    self.getAudiogramReportList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getQuickTestReportList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getAudiogramReportList(retryAPIID: Int, canShowLoader: Bool) {
        self.audiogramReportViewModel.getAudiogramReportList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getAudiogramReportList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    func getQuickTestReportList(retryAPIID: Int, canShowLoader: Bool) {
        self.audiogramReportViewModel.getQuickTestReportList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getQuickTestReportList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func errorTapButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }

    @IBAction func quickTestButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1001)
    }
    @IBAction func audiogramTestButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Custom Method
    func setSelectedState() {
        self.quickTestButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.quickTestButton.clipsToBounds = true
        self.quickTestButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.quickTestButton.cornerRadius = AppConstantValue.cornerRadius4

        self.audiogramTestButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.audiogramTestButton.clipsToBounds = true
        self.audiogramTestButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.audiogramTestButton.cornerRadius = AppConstantValue.cornerRadius4

        if self.isQuickCheck == false {
            self.audiogramTestButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
            self.audiogramTestButton.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
        } else {
            self.quickTestButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
            self.quickTestButton.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
        }
    }
    func checkQuickCheckReportVerifiedUser(sessionUID:String) {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginViewReportQuickCheck.rawValue, isWishlist: false, productUID: sessionUID)
        } else {
            self.navigateToQuickTestResultViewController(isFrom: IsNavigateFrom.qcMenuReport.rawValue, sessionID: sessionUID)
        }
    }
    func verifiedQuickCheckViewReportUser(isFrom: String, isWishlist: Bool, productUID: String) {
        if isFrom == IsNavigateFrom.loginViewReportQuickCheck.rawValue {
            self.checkQuickCheckReportVerifiedUser(sessionUID:productUID)
        }
    }
}

extension AudiogramReportViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension AudiogramReportViewController: ProtocolNetworkRechabilityDelegate {
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
extension AudiogramReportViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isQuickCheck == false {
            return self.audiogramReportListArray.count
        } else {
            return self.quickCheckReportListArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.isQuickCheck == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.AudiogramReportTableViewCell, for: indexPath) as! AudiogramReportTableViewCell
            cell.configure(report: self.audiogramReportListArray[indexPath.row], indexPath: indexPath.row)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.QuickCheckReportTableViewCell, for: indexPath) as! QuickCheckReportTableViewCell
            cell.configure(report: self.quickCheckReportListArray[indexPath.row], indexPath: indexPath.row)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isQuickCheck == false {
            if self.audiogramReportListArray.count > 0 {
                if self.audiogramReportListArray[indexPath.row].reportLink != nil {
                    if !(self.audiogramReportListArray[indexPath.row].reportLink.isNilOrEmpty) {
                        let reportlink = self.audiogramReportListArray[indexPath.row].reportLink!
                        if !(reportlink.isEmpty) {
                            guard let appURL = URL(string: reportlink.checkhttpCharacter) else {
                                // url error msg
                                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                                return
                            }
                            if UIApplication.shared.canOpenURL(appURL) {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                                } else {
                                    UIApplication.shared.openURL(appURL)
                                }
                            } else {
                                // error msg
                                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                            }
                        } else {
                            // empty msg
                            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                        }
                    }
                }
            }
        } else {
            if self.quickCheckReportListArray.count > 0 {
//                if self.quickCheckReportListArray[indexPath.row].reportLink != nil {
//                    if !(self.quickCheckReportListArray[indexPath.row].reportLink.isNilOrEmpty) {
//                        let reportlink = self.quickCheckReportListArray[indexPath.row].reportLink!
//                        if !(reportlink.isEmpty) {
//                            guard let appURL = URL(string: reportlink.checkhttpCharacter) else {
//                                // url error msg
//                                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
//                                return
//                            }
//                            if UIApplication.shared.canOpenURL(appURL) {
//                                if #available(iOS 10.0, *) {
//                                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
//                                } else {
//                                    UIApplication.shared.openURL(appURL)
//                                }
//                            } else {
//                                // error msg
//                                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
//                            }
//                        } else {
//                            // empty msg
//                            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
//                        }
//                    }
//                }
                if self.quickCheckReportListArray[indexPath.row].sessionUid != nil {
                    if !(self.quickCheckReportListArray[indexPath.row].sessionUid.isNilOrEmpty) {
                        let sessionUid = self.quickCheckReportListArray[indexPath.row].sessionUid!
                        if !(sessionUid.isEmpty) {
                            if !(sessionUid.isEmpty) {
                                self.navigateToQuickTestResultViewController(isFrom: IsNavigateFrom.qcMenuReport.rawValue, sessionID: sessionUid)
                            }
                        } else {
                            // empty msg
                            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                        }
                    }
                }
            }
        }
    }
}
