//
//  CustomerTestimonialListViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 28/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CustomerTestimonialListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var titleView: UIView!
    @IBOutlet var titleLabel: Title2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!

    @IBOutlet var gridView: UIView!
    @IBOutlet var gridCollectionView: UICollectionView!
    @IBOutlet var gridCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var listView: UIView!
    @IBOutlet var listTableView: UITableView!
    @IBOutlet var listTableViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    var customerTestimonialListViewModel = CustomerTestimonialListViewModel()
    var listArray = [Testimonial]()
    var gridArray = [Testimonial]()
    let gridCollectionViewMargin = CGFloat(0)
    let gridCollectionViewItemSpacing = CGFloat(0)
    var gridCollectionViewItemHeight = CGFloat(308)
    var gridCollectionViewItemWidth = CGFloat(343)
    let gridCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

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
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        let view0 = self.mainStackView.arrangedSubviews[0]// titleview
        let view1 = self.mainStackView.arrangedSubviews[1]// grid
        let view2 = self.mainStackView.arrangedSubviews[2]// list
        let view3 = self.mainStackView.arrangedSubviews[3]// empty
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        self.listTableView.tableFooterView = UIView()
        self.listTableView.separatorColor = UIColor.clear
        self.listTableView.backgroundColor = UIColor.clear
        self.listTableView.rowHeight = UITableView.automaticDimension
        self.listTableView.estimatedRowHeight = UITableView.automaticDimension
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.customerTestimonials
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.titleLabel.text = AppLocalizationString.storiesfromcustomers
        self.descriptionLabel.text = AppLocalizationString.whatpeoplesayabouttheirhearingaidexperience
    }
    // MARK: - Reload
    func reloadListTableView() {
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.reloadData()
    }
    func reloadGridCollectionView() {
        if self.gridArray.count > 0 {
            self.gridCollectionViewHeight.constant = (CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(206/343.0)) + CGFloat(102)
        } else {
            self.gridCollectionViewHeight.constant = 0
        }
        self.gridCollectionViewItemHeight = (CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(206/343.0)) + CGFloat(102)
        self.gridCollectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32)
        self.gridCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.gridCollectionViewlayout.itemSize = CGSize(width: self.gridCollectionViewItemWidth, height: self.gridCollectionViewItemHeight)
        self.gridCollectionViewlayout.minimumLineSpacing = self.gridCollectionViewItemSpacing
        self.gridCollectionViewlayout.minimumInteritemSpacing = self.gridCollectionViewItemSpacing
        self.gridCollectionViewlayout.scrollDirection = .horizontal
        self.gridCollectionView!.collectionViewLayout = self.gridCollectionViewlayout
        self.gridCollectionView.dataSource = self
        self.gridCollectionView.delegate = self
        self.gridCollectionView.reloadData()
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
        self.customerTestimonialListViewModel.getCustomerTestimonialsList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCustomerTestimonialsList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
}
extension CustomerTestimonialListViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension CustomerTestimonialListViewController: ProtocolNetworkRechabilityDelegate {
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
extension CustomerTestimonialListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gridArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.CustomerTestimonialListCollectionViewCell, for: indexPath) as! CustomerTestimonialListCollectionViewCell
        cell.configure(testimonial: self.gridArray[indexPath.item], indexpath: indexPath.item)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.gridArray.count > 0 {
            cellWidth = self.gridCollectionViewItemWidth
            cellHeight = self.gridCollectionViewItemHeight
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension CustomerTestimonialListViewController: ProtocolCustomerTestimonialListCollectionViewCell {
    func tapButtonPressedCustomerTestimonialListCollectionViewCell(senderTag: Int) {
        if self.gridArray.count > 0 {
            if !(self.gridArray[senderTag].uid.isNilOrEmpty) {
                self.navigateToCustomerTestimonialDetailViewController(slug: self.gridArray[senderTag].uid!.allowSpecialCharacters)
            }
        }
    }
}
extension CustomerTestimonialListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CustomerTestimonialTableViewCell, for: indexPath) as! CustomerTestimonialTableViewCell
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
extension CustomerTestimonialListViewController: ProtocolCustomerTestimonialTableViewCell {
    func tapButtonPressedCustomerTestimonialTableViewCell(senderTag: Int) {
        if self.listArray.count > 0 {
            if !(self.listArray[senderTag].uid.isNilOrEmpty) {
                self.navigateToCustomerTestimonialDetailViewController(slug: self.listArray[senderTag].uid!.allowSpecialCharacters)
            }
        }
    }
}
