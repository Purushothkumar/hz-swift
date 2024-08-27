//
//  TipsListViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 28/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class TipsListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var tipsGridView: UIView!
    @IBOutlet var tipsGridCollectionView: UICollectionView!
    @IBOutlet var tipsGridCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var tipsListView: UIView!
    @IBOutlet var tipsListTableView: UITableView!
    @IBOutlet var tipsListTableViewHeight: NSLayoutConstraint!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!

    // MARK: - Lets and Var
    var tipsListViewModel = TipsListViewModel()

    var gridArray = [TipsListModelTip]()
    var listArray = [TipsListModelTip]()

    let tipsGridCollectionViewMargin = CGFloat(0)
    let tipsGridCollectionViewItemSpacing = CGFloat(0)
    var tipsGridCollectionViewItemHeight = CGFloat(206)
    var tipsGridCollectionViewItemWidth = CGFloat(343)
    let tipsGridCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setInitialView()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.listArray.count > 0 {
            self.tipsListTableViewHeight.constant = self.tipsListTableView.contentSize.height + CGFloat(10)
        } else {
            self.tipsListTableViewHeight.constant = 0
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        let view0 = self.mainStackView.arrangedSubviews[0]// empty
        let view1 = self.mainStackView.arrangedSubviews[1]// grid
        let view2 = self.mainStackView.arrangedSubviews[2]// list
        let view3 = self.mainStackView.arrangedSubviews[3]// empty
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        self.tipsListTableView.tableFooterView = UIView()
        self.tipsListTableView.separatorColor = UIColor.clear
        self.tipsListTableView.backgroundColor = UIColor.clear
        self.tipsListTableView.rowHeight = UITableView.automaticDimension
        self.tipsListTableView.estimatedRowHeight = UITableView.automaticDimension
        self.commonAPICALL(retryAPIID: 1000)
    }

    // MARK: - Localization String
    func changeLanguageFormat() {
        self.primaryMessageLabel.text = AppLocalizationString.noDataFound
        self.secondaryMessageLabel.text = ""
    }
    // MARK: - Reload
    func reloadListTableView() {
        self.tipsListTableView.delegate = self
        self.tipsListTableView.dataSource = self
        self.tipsListTableView.reloadData()
    }
    func reloadGridCollectionView() {
        if self.gridArray.count > 0 {
            self.tipsGridCollectionViewHeight.constant = (CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(206/343.0)) + CGFloat(80)
        } else {
            self.tipsGridCollectionViewHeight.constant = 0
        }
        self.tipsGridCollectionViewItemHeight = (CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(206/343.0)) + CGFloat(80)
        self.tipsGridCollectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32)
        self.tipsGridCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tipsGridCollectionViewlayout.itemSize = CGSize(width: self.tipsGridCollectionViewItemWidth, height: self.tipsGridCollectionViewItemHeight)
        self.tipsGridCollectionViewlayout.minimumLineSpacing = self.tipsGridCollectionViewItemSpacing
        self.tipsGridCollectionViewlayout.minimumInteritemSpacing = self.tipsGridCollectionViewItemSpacing
        self.tipsGridCollectionViewlayout.scrollDirection = .horizontal
        self.tipsGridCollectionView!.collectionViewLayout = self.tipsGridCollectionViewlayout
        self.tipsGridCollectionView.dataSource = self
        self.tipsGridCollectionView.delegate = self
        self.tipsGridCollectionView.reloadData()
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
        self.tipsListViewModel.getTipsList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getTipsList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
}
extension TipsListViewController: ProtocolNetworkRechabilityDelegate {
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
extension TipsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gridArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.TipsListCollectionViewCell, for: indexPath) as! TipsListCollectionViewCell
        cell.configure(tips: self.gridArray[indexPath.item], indexpath: indexPath.item)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.gridArray.count > 0 {
            cellWidth = self.tipsGridCollectionViewItemWidth
            cellHeight = self.tipsGridCollectionViewItemHeight
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension TipsListViewController: ProtocolTipsListCollectionViewCell {
    func tapButtonPressedTipsListCollectionViewCell(senderTag: Int) {
        if self.gridArray.count > 0 {
            if !(self.gridArray[senderTag].slug.isNilOrEmpty) {
                self.navigateToTipsDetailViewController(slug: self.gridArray[senderTag].slug!.allowSpecialCharacters)
            }
        }
    }
}
extension TipsListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.TipsListTableViewCell, for: indexPath) as! TipsListTableViewCell
        cell.configure(tips: self.listArray[indexPath.row], indexpath: indexPath.row)
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
        self.tipsListTableViewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension TipsListViewController: ProtocolTipsListTableViewCell {
    func tapButtonPressedTipsListTableViewCell(senderTag: Int) {
        if self.listArray.count > 0 {
            if !(self.listArray[senderTag].slug.isNilOrEmpty) {
                self.navigateToTipsDetailViewController(slug: self.listArray[senderTag].slug!.allowSpecialCharacters)
            }
        }
    }
}
