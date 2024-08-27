//
//  RewardPointsDetailViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 15/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class RewardPointsDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var imageCardView: UIView!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var couponOfferView: UIView!
    @IBOutlet var couponOfferStackView: UIStackView!

    @IBOutlet var couponOfferTitleLabel: BodyFontLabel!
    @IBOutlet var couponOfferClaimedLabel: Title2FontLabel!
    @IBOutlet var couponOfferValidLabel: Caption1FontLabel!

    @IBOutlet var getUsingStackView: UIStackView!
    @IBOutlet var getUsingLabel: Caption1FontLabel!
    @IBOutlet var couponOfferPointLabel: Caption1FontLabel!

    @IBOutlet var couponCardView: UIView!
    @IBOutlet var offerLabel: Title2FontLabel!
    @IBOutlet var dashView: UIView!

    @IBOutlet var couponHeaderLabel: Caption2FontLabel!
    @IBOutlet var couponCodeLabel: BodyFontLabel!
    @IBOutlet var couponValidityLabel: Caption2FontLabel!

    @IBOutlet var listView: UIView!
    @IBOutlet var tableviewHeight: NSLayoutConstraint!
    @IBOutlet var tableview: UITableView!

    @IBOutlet var redeemCoinsView: UIView!
    @IBOutlet var redeemCoinsButton: CalloutBackgroundButton!
    @IBOutlet var redeemCoinsButtonHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    var rewardPointsDetailViewModel = RewardPointsDetailViewModel()

    var stepsArray = [HowToStep]()
    var rewardUid = ""

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
        self.tableviewHeight.constant = tableview.contentSize.height + CGFloat(20)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: -  Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_blue_112F70_30,style: StatusBarTheme.lightContent.rawValue)
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
        self.tableview.separatorColor = UIColor.colorLiteral.theme_white_F2F2F2
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.tableview.reloadData()
        self.getUsingStackView.layer.cornerRadius = CGFloat(18)
        self.getUsingStackView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.getUsingStackView.layer.borderWidth = 1.0

        self.redeemCoinsView.isHidden = true
        self.redeemCoinsButtonHeight.constant = 0
        self.commonAPICALL(retryAPIID: 1000)

    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.myRewards.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {}
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
                    self.getRewardsToCouponList(retryAPIID: retryAPIID, canShowLoader: true)
                }
                if retryAPIID == 1001 {
                    self.postRewardsToCouponList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getRewardsToCouponList(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getRewardsToCouponList)\(rewardUid)/"
        self.rewardPointsDetailViewModel.getRewardsToCouponList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postRewardsToCouponList(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getRewardsToCouponList)\(rewardUid)/"
        self.rewardPointsDetailViewModel.postRewardsToCouponList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func redeemCoinsButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1001)
    }

    // MARK: - Custom Methods

}

extension RewardPointsDetailViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension RewardPointsDetailViewController: ProtocolNetworkRechabilityDelegate {
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
extension RewardPointsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.stepsArray.count > 0 {
            return 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.stepsArray.count > 0 {
            if section == 0 {
                return 1
            } else {
                return self.stepsArray.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.stepsArray.count > 0 {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.RewardPointsDetailTitleTableViewCell, for: indexPath) as! RewardPointsDetailTitleTableViewCell
                cell.titleLabel.text = AppLocalizationString.howtouse
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.RewardPointsDetailTableViewCell, for: indexPath) as! RewardPointsDetailTableViewCell
                cell.configure(step: self.stepsArray[indexPath.row], indexpath: indexPath.row)
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.RewardPointsDetailTitleTableViewCell, for: indexPath) as! RewardPointsDetailTitleTableViewCell
            cell.titleLabel.text = ""
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
