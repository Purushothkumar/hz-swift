//
//  LegalViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 13/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import WebKit

class LegalViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: LogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var imageViewHeight: NSLayoutConstraint!

    @IBOutlet var titleView: UIView!
    @IBOutlet var titleLabel: Title2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var titleViewHeight: NSLayoutConstraint!

    @IBOutlet var webview: WKWebView!
    @IBOutlet var webviewheight: NSLayoutConstraint!

    // MARK: - Lets and Var
    let legalViewModel = LegalViewModel()
    var supportDescription = ""
    var updatedOn = ""
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
        self.webview.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.webview.scrollView.showsHorizontalScrollIndicator = false
        self.webview.scrollView.showsVerticalScrollIndicator = false
        self.webview.translatesAutoresizingMaskIntoConstraints = false
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
        self.titleLabel.text = AppLocalizationString.legal
        if !(self.updatedOn.isEmpty) {
            //            self.descriptionLabel.text = self.updatedOn
            self.descriptionLabel.text = ""
        }
        self.titleViewHeight.constant =  20 + self.heightForText(text: AppLocalizationString.legal, Font: AppFont.bold.size(22), Width: AppConstantValue.screenWidthminus32) + 4 + self.heightForText(text: self.updatedOn, Font: AppFont.medium.size(13), Width: AppConstantValue.screenWidthminus32) + 16

        self.imageViewHeight.constant = self.titleViewHeight.constant + 50

    }
    // MARK: - Reload
    func reloadWebView() {
        if !(self.supportDescription.isEmpty) {
            self.webview.loadHTMLString("<!DOCTYPE html><head><meta charset='utf-8'><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' /><link href='https://fonts.googleapis.com/css?family=Poppins' rel='stylesheet'><style>:root,* {font-family: 'Poppins';text-align: left;-webkit-user-select: none;user-select: none;}</style></head><body style='color:grey;'>\(self.supportDescription)</body>", baseURL: nil)
            self.webview.navigationDelegate = self
            self.webview.reload()
            self.changeLanguageFormat()
        }
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getLegalData(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getLegalData(retryAPIID: Int, canShowLoader: Bool) {
        self.legalViewModel.getLegalData(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getLegalData, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
}
extension LegalViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.legalMenu.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {}
}
extension LegalViewController: ProtocolNetworkRechabilityDelegate {
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
extension LegalViewController: WKNavigationDelegate {
    // MARK: - WKWebview Delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.webview.frame.size.height = 1
            self.webview.frame.size = webView.scrollView.contentSize
            self.webviewheight.constant = webView.scrollView.contentSize.height
            self.view.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        }
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard case .linkActivated = navigationAction.navigationType,
              let url = navigationAction.request.url
        else {
            decisionHandler(.allow)
            return
        }
        decisionHandler(.cancel)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
