//
//  TipsDetailViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 31/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class TipsDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var tipsBannerView: UIView!
    @IBOutlet var tipsBannerImageView: UIImageView!
    @IBOutlet var tipsBannerImageViewHeight: NSLayoutConstraint!

    @IBOutlet var tipsListHeaderView: UIView!
    @IBOutlet var tipsListTableHeaderView: UITableView!
    @IBOutlet var tipsListTableHeaderViewHeight: NSLayoutConstraint!

    @IBOutlet var heartView: UIView!
    @IBOutlet var heartCountLabel: BodyFontLabel!

    @IBOutlet var tipsListView: UIView!
    @IBOutlet var tipsListTableView: UITableView!
    @IBOutlet var tipsListTableViewHeight: NSLayoutConstraint!

    @IBOutlet var nextTipsView: UIView!
    @IBOutlet var nextTipsImageView: UIImageView!
    @IBOutlet var shareButton: FootnoteOutlineButton!
    @IBOutlet var shareLabel: FootnoteFontLabel!
    @IBOutlet var nextLabel: BodyFontLabel!
    @IBOutlet var nextButton: FootnoteOutlineButton!
    @IBOutlet var nextArrowButton: FootnoteOutlineButton!

    // MARK: - Lets and Var
    var tipsDetailViewModel = TipsDetailViewModel()
    var listArray = [Tips]()
    var headerListArray = [TipDetailList]()
    var slug = ""
    var nextTipSlug = ""
    var nextTipLink = ""

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
        if self.listArray.count > 0 {
            self.tipsListTableViewHeight.constant = self.tipsListTableView.contentSize.height
        } else {
            self.tipsListTableViewHeight.constant = 0
        }
        if self.headerListArray.count > 0 {
            self.tipsListTableHeaderViewHeight.constant = self.tipsListTableHeaderView.contentSize.height
        } else {
            self.tipsListTableHeaderViewHeight.constant = 0
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

        let view0 = self.mainStackView.arrangedSubviews[1]// banner
        let view1 = self.mainStackView.arrangedSubviews[1]// header List
        let view2 = self.mainStackView.arrangedSubviews[2]// heartview
        let view3 = self.mainStackView.arrangedSubviews[3]// list view
        let view4 = self.mainStackView.arrangedSubviews[4]// empty

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true

        self.nextTipsView.isHidden = true

        self.tipsListTableView.tableFooterView = UIView()
        self.tipsListTableView.separatorColor = UIColor.clear
        self.tipsListTableView.backgroundColor = UIColor.clear
        self.tipsListTableView.rowHeight = UITableView.automaticDimension
        self.tipsListTableView.estimatedRowHeight = UITableView.automaticDimension

        self.tipsListTableHeaderView.tableFooterView = UIView()
        self.tipsListTableHeaderView.separatorColor = UIColor.clear
        self.tipsListTableHeaderView.backgroundColor = UIColor.clear
        self.tipsListTableHeaderView.rowHeight = UITableView.automaticDimension
        self.tipsListTableHeaderView.estimatedRowHeight = UITableView.automaticDimension

        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.tips
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.nextLabel.text = AppLocalizationString.nextTip
    }

    // MARK: - Reload
    func reloadHeaderTableView() {
        self.tipsListTableHeaderView.delegate = self
        self.tipsListTableHeaderView.dataSource = self
        self.tipsListTableHeaderView.reloadData()
    }
    func reloadListTableView() {
        self.tipsListTableView.delegate = self
        self.tipsListTableView.dataSource = self
        self.tipsListTableView.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getTipsList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getTipsList(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.slug.isEmpty) {
            let suburl = "\(SubAPIUrl.getTipsList)\(slug.allowSpecialCharacters)/"
            self.tipsDetailViewModel.getTipsDetails(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: suburl, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    // MARK: - IBAction

    @IBAction func shareButtonPressed(_ sender: UIButton) {
        if !(self.nextTipLink.isEmpty) {
            let objectsToShare = [nextTipLink.checkhttpCharacter]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func nextPressed(_ sender: UIButton) {
        if !(self.nextTipSlug.isEmpty) {
            self.navigateToTipsDetailViewController(slug: self.nextTipSlug.allowSpecialCharacters)
        }
    }
    // MARK: - Custom Methods

}

extension TipsDetailViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension TipsDetailViewController: ProtocolNetworkRechabilityDelegate {
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
extension TipsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tipsListTableHeaderView {
            return self.headerListArray.count
        } else {
            return self.listArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tipsListTableHeaderView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.TipsDetailHeaderTableViewCell, for: indexPath) as! TipsDetailHeaderTableViewCell
            cell.configure(tips: self.headerListArray[indexPath.row], indexpath: indexPath.row)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.TipsDetailTableViewCell, for: indexPath) as! TipsDetailTableViewCell
            cell.configure(tips: self.listArray[indexPath.row], indexpath: indexPath.row)
            cell.delegate = self
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
        if tableView == self.tipsListTableHeaderView {
            self.tipsListTableHeaderViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()

        } else {
            self.tipsListTableViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        }
    }

}
extension TipsDetailViewController: ProtocolTipsDetailTableViewCell {
    func tapButtonPressedTipsDetailTableViewCell(senderTag: Int) {
        if self.listArray.count > 0 {
            if !(self.listArray[senderTag].slug.isNilOrEmpty) {
                self.navigateToTipsDetailViewController(slug: self.listArray[senderTag].slug!.allowSpecialCharacters)
            }
        }
    }
}
