//
//  SupportViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 25/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import MessageUI

class SupportViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: LogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var titleView: UIView!
    @IBOutlet var titleLabel: Title2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var backgroundViewHeight: NSLayoutConstraint!
    @IBOutlet var titleViewHeight: NSLayoutConstraint!
    @IBOutlet var imageViewHeight: NSLayoutConstraint!

    @IBOutlet var contentView: UIView!
    @IBOutlet var contentViewHeight: NSLayoutConstraint!
    @IBOutlet var tableview: UITableView!

    // MARK: - Lets and Var
    let supportViewModel = SupportViewModel()
    var supportArray = [SupportModel]()
    var isFrom = ""

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
        if self.supportArray.count > 0 {
            self.contentViewHeight.constant = self.tableview.contentSize.height
            self.backgroundViewHeight.constant = (self.contentViewHeight.constant + self.titleViewHeight.constant + CGFloat(AppConstantValue.navigationBarHeight)) - CGFloat(40)
        } else {
            self.contentViewHeight.constant = 0
            self.backgroundViewHeight.constant = self.titleViewHeight.constant +  CGFloat(AppConstantValue.navigationBarHeight) + self.imageViewHeight.constant
        }
        self.mainScrollView.sizeToFit()
        self.mainScrollView.contentSize = CGSize(width: self.mainScrollView.frame.size.width, height: self.contentViewHeight.constant + self.tableview.frame.origin.y)
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
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.imageViewHeight.constant = screenFrameWidth * CGFloat(AppConstantValue.screen211slash375)
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTableview()

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
        self.titleLabel.text = AppLocalizationString.support
        self.descriptionLabel.text = AppLocalizationString.havinghearingproblemsandlookingforassistance
        self.titleViewHeight.constant = 20 + self.heightForText(text: AppLocalizationString.support, Font: AppFont.bold.size(22), Width: AppConstantValue.screenWidthminus32) + 4 + self.heightForText(text: AppLocalizationString.havinghearingproblemsandlookingforassistance, Font: AppFont.medium.size(13), Width: AppConstantValue.screenWidthminus32) + 16 + self.imageViewHeight.constant + 40

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
                    self.getSupportData(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getSupportData(retryAPIID: Int, canShowLoader: Bool) {
        self.supportViewModel.getSupportData(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getSupportData, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
}
extension SupportViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.supportMenu.rawValue {
            self.navigateBackToMenuViewController()
        } else if self.isFrom == IsNavigateFrom.supportShop.rawValue {
            self.navigateBackToShopCategoryViewController()
        } else if self.isFrom == IsNavigateFrom.supportBuyBack.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.supportSurvey.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.supportOrder.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.supportSRD.rawValue {
            self.navigateBackToViewController()
        } else {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        }
    }
    func rightButtonPressed() {}
}
extension SupportViewController: ProtocolNetworkRechabilityDelegate {
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
extension SupportViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.supportArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.SupportTableViewCell, for: indexPath) as! SupportTableViewCell
        cell.configure(supportModel: self.supportArray[indexPath.row], indexpath: indexPath.row)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.contentViewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension SupportViewController: ProtocolSupportTableViewCell {
    func buttonPressedSupportTableViewCell(senderTag: Int) {
        if self.supportArray.count > 0 {
            if self.supportArray[senderTag].supportDeskType == SupportDeskType.call.rawValue {
                self.makeCall(phoneNumber: self.supportArray[senderTag].supportdata)
            } else if self.supportArray[senderTag].supportDeskType == SupportDeskType.whatsapp.rawValue {
                self.openWhatsapp(phoneNumber: self.supportArray[senderTag].supportdata)
            } else if self.supportArray[senderTag].supportDeskType == SupportDeskType.email.rawValue {
                self.openMail(emailAddress: self.supportArray[senderTag].supportdata)
            }
        }
    }
}

extension SupportViewController: MFMailComposeViewControllerDelegate {
    // MARK: - To Open Email
    func openMail(emailAddress: String) {
        // Modify following variables with your text / recipient
        let recipientEmail = emailAddress
        let subject = ""
        let body = ""
        if recipientEmail.isEmailValid {
            // Show default mail composer
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([recipientEmail])
                mail.setSubject(subject)
                mail.setMessageBody(body, isHTML: false)
                present(mail, animated: true)

                // Show third party email composer if default Mail app is not present
            } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
                UIApplication.shared.open(emailUrl)
            }
        }
    }
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")

        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        return defaultUrl
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
