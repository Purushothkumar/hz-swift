//
//  CustomerTestimonialDetailViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 28/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import YouTubePlayer
import WebKit

class CustomerTestimonialDetailViewController: UIViewController, WKNavigationDelegate {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var playerView: UIView!
    @IBOutlet var youTubePlayerView: YouTubePlayerView!
    @IBOutlet var playerViewHeight: NSLayoutConstraint!

    @IBOutlet var customerTestimonialContentView: UIView!
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var timeLabel: Caption2FontLabel!

    @IBOutlet var descriptionView: UIView!
    @IBOutlet var webview: WKWebView!
    @IBOutlet var webviewheight: NSLayoutConstraint!

    @IBOutlet var customerTestimonialDetailView: UIView!
    @IBOutlet var listTableView: UITableView!
    @IBOutlet var listTableViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    var customerTestimonialDetailViewModel = CustomerTestimonialDetailViewModel()
    var listArray = [Testimonial]()
    var slug = ""
    var htmlstring = ""

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
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.webviewheight.constant = self.webview.scrollView.contentSize.height
        if self.listArray.count > 0 {
            self.listTableViewHeight.constant = self.listTableView.contentSize.height
        } else {
            self.listTableViewHeight.constant = 0
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        self.listTableView.tableFooterView = UIView()
        self.listTableView.separatorColor = UIColor.clear
        self.listTableView.backgroundColor = UIColor.clear
        self.listTableView.rowHeight = UITableView.automaticDimension
        self.listTableView.estimatedRowHeight = UITableView.automaticDimension
        self.webview.backgroundColor = UIColor.clear
        self.webview.scrollView.showsHorizontalScrollIndicator = false
        self.webview.scrollView.showsVerticalScrollIndicator = false
        self.webview.translatesAutoresizingMaskIntoConstraints = false

        let view0 = self.mainStackView.arrangedSubviews[0]// playerview
        let view1 = self.mainStackView.arrangedSubviews[1]// contentView
        let view2 = self.mainStackView.arrangedSubviews[2]// descriptionView
        let view3 = self.mainStackView.arrangedSubviews[3]// empty
        let view4 = self.mainStackView.arrangedSubviews[4]// list
        let view5 = self.mainStackView.arrangedSubviews[5]// empty

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        self.commonAPICALL(retryAPIID: 1000)
    }
    //    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.customerTestimonials
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {}
    // MARK: - Reload
    func reloadListTableView() {
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.reloadData()
    }
    func reloadWebView() {
        if !(self.htmlstring.isEmpty) {
            self.webview.loadHTMLString("<!DOCTYPE html><head><meta charset='utf-8'><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' /><link href='https://fonts.googleapis.com/css?family=Poppins' rel='stylesheet'><style>:root,* {font-family: 'Poppins';text-align: left;-webkit-user-select: none;user-select: none;}</style></head><body style='color:black;'>\(self.htmlstring)</body>", baseURL: nil)
            self.webview.navigationDelegate = self
            self.webview.reload()
            self.viewWillLayoutSubviews()
        }
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getCustomerTestimonialsList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCustomerTestimonialsList(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.slug.isEmpty) {
            let suburl = "\(SubAPIUrl.getCustomerTestimonialsList)\(slug.allowSpecialCharacters)/"
            self.customerTestimonialDetailViewModel.getCustomerTestimonialDetailList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: suburl, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }
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
        var websiteLink = ""
        websiteLink = navigationAction.request.url?.absoluteString ?? ""
        if !(websiteLink.isEmpty) {
            guard let appURL = URL(string: websiteLink.checkhttpCharacter) else {
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
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
}
extension CustomerTestimonialDetailViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension CustomerTestimonialDetailViewController: ProtocolNetworkRechabilityDelegate {
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
extension CustomerTestimonialDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CustomerTestimonialDetailTableViewCell, for: indexPath) as! CustomerTestimonialDetailTableViewCell
        cell.configure(testimonial: self.listArray[indexPath.row], indexpath: indexPath.row)
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
        self.listTableViewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension CustomerTestimonialDetailViewController: ProtocolCustomerTestimonialDetailTableViewCell {
    func tapButtonPressedCustomerTestimonialDetailTableViewCell(senderTag: Int) {
        if self.listArray.count > 0 {
            if !(self.listArray[senderTag].uid.isNilOrEmpty) {
                self.navigateToCustomerTestimonialDetailViewController(slug: self.listArray[senderTag].uid!.allowSpecialCharacters)
            }
        }
    }
}
