//
//  RewardPointsViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 15/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class RewardPointsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var rewardPointsHeaderView: UIView!
    @IBOutlet var rewardPointsHeaderStackView: UIStackView!
    @IBOutlet var redeemPointsHeaderlabel: Title2FontLabel!
    @IBOutlet var totalHZHeaderlabel: BodyFontLabel!
    @IBOutlet var redeemCoinsButton: FootnoteBackgroundButton!

    @IBOutlet var rewardPointsView: UIView!
    @IBOutlet var rewardPointsCollectionView: UICollectionView!
    @IBOutlet var rewardPointsCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var rewardPointsTableView: UITableView!
    @IBOutlet var rewardPointsTableViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    var rewardPointsViewModel = RewardPointsViewModel()
    var rewardPointsTranscationArray = [RewardTransaction]()
    var rewardPointsArray = [Reward]()

    let rewardPointsCollectionViewMargin = 0
    let rewardPointsCollectionViewItemSpacing =  CGFloat(16)
    var rewardPointsCollectionViewItemHeight = CGFloat(308)
    var rewardPointsCollectionViewItemWidth = CGFloat(343)
    let rewardPointsCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var customerRewardPoints: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.commonAPICALL(retryAPIID: 1000)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.rewardPointsTranscationArray.count > 0 {
            self.rewardPointsTableViewHeight.constant = self.rewardPointsTableView.contentSize.height + CGFloat(20)
        } else {
            self.rewardPointsTableViewHeight.constant = 0
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

        self.rewardPointsTableView.tableFooterView = UIView()
        self.rewardPointsTableView.separatorColor = UIColor.clear
        self.rewardPointsTableView.backgroundColor = UIColor.clear
        self.rewardPointsTableView.rowHeight = UITableView.automaticDimension
        self.rewardPointsTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadRewardPointsTableView()
        self.reloadRewardPointsCollectionView()

        let view0 = self.mainStackView.arrangedSubviews[0]// Rewards
        let view1 = self.mainStackView.arrangedSubviews[1]// TableView
        let view2 = self.mainStackView.arrangedSubviews[2]// CollectionView

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.myRewards
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.totalHZHeaderlabel.text = AppLocalizationString.totalHZcoins
        self.redeemCoinsButton.setTitle(AppLocalizationString.redeemyourCoins.uppercased(), for: .normal)
    }
    // MARK: - Reload
    func reloadRewardPointsTableView() {
        self.rewardPointsTableView.delegate = self
        self.rewardPointsTableView.dataSource = self
        self.rewardPointsTableView.reloadData()
    }
    func reloadRewardPointsCollectionView() {
        self.rewardPointsCollectionViewHeight.constant = 0
        self.rewardPointsCollectionViewItemHeight = CGFloat(130 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + CGFloat(86)
        self.rewardPointsCollectionViewItemWidth = CGFloat(199 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth))
        self.rewardPointsCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.rewardPointsCollectionViewlayout.itemSize = CGSize(width: self.rewardPointsCollectionViewItemWidth, height: self.rewardPointsCollectionViewItemHeight)
        self.rewardPointsCollectionViewlayout.minimumLineSpacing = self.rewardPointsCollectionViewItemSpacing
        self.rewardPointsCollectionViewlayout.minimumInteritemSpacing = self.rewardPointsCollectionViewItemSpacing
        self.rewardPointsCollectionViewlayout.scrollDirection = .horizontal
        self.rewardPointsCollectionView!.collectionViewLayout = self.rewardPointsCollectionViewlayout
        self.rewardPointsCollectionView.dataSource = self
        self.rewardPointsCollectionView.delegate = self
        self.rewardPointsCollectionView.reloadData()
        if self.rewardPointsArray.count > 0 {
            self.rewardPointsCollectionViewHeight.constant = CGFloat(130 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + CGFloat(86)
        } else {
            self.rewardPointsCollectionViewHeight.constant = 0
        }
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getRewardsList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getRewardsList(retryAPIID: Int, canShowLoader: Bool) {
        self.rewardPointsViewModel.getRewardsList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getRewardsList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func redeemCoinsButtonPressed(_ sender: UIButton) {
        self.navigateToRedeemCoinsViewController()
    }

    // MARK: - Custom Methods

}

extension RewardPointsViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    func rightButtonPressed() {
    }
}
extension RewardPointsViewController: ProtocolNetworkRechabilityDelegate {
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

extension RewardPointsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rewardPointsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.RewardPointsCollectionViewCell, for: indexPath) as! RewardPointsCollectionViewCell
        cell.configure(reward: self.rewardPointsArray[indexPath.item], indexPath: indexPath.item)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.rewardPointsArray.count > 0 {
            cellWidth = self.rewardPointsCollectionViewItemWidth
            cellHeight = self.rewardPointsCollectionViewItemHeight
        }
        self.view.layoutIfNeeded()
        self.viewWillLayoutSubviews()
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension RewardPointsViewController: ProtocolRewardPointsCollectionViewCell {
    func tapButtonRewardPointsCollectionViewCell(senderTag: Int) {
        if self.customerRewardPoints > 0 {
            if self.rewardPointsArray.count > 0 {
                if !(self.rewardPointsArray[senderTag].rewardUid.isNilOrEmpty) {
                    self.navigateToRewardPointsDetailViewController(rewardUid: self.rewardPointsArray[senderTag].rewardUid!)
                }
            }
        } else {
            self.showToastAlert(AppLocalizationString.redeemErrorMessage, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
}
extension RewardPointsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rewardPointsTranscationArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.RewardPointsTableViewCell, for: indexPath) as! RewardPointsTableViewCell
        cell.configure(rewardTransaction: self.rewardPointsTranscationArray[indexPath.row], indexpath: indexPath.row, rewardTransactionCount: self.rewardPointsTranscationArray.count)
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
        self.rewardPointsTableViewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
