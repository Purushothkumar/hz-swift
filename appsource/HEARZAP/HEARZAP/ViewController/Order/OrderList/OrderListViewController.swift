//
//  OrderListViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 09/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var orderTableView: UITableView!

    @IBOutlet var orderButton: FootnoteBackgroundButton!
    @IBOutlet var returnOrderButton: FootnoteBackgroundButton!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var errorTapButton: FootnoteOutlineButton!

    // MARK: - Lets and Var
    var orderListViewModel = OrderListViewModel()
    var orderListArray = [OrderList]()
    var returnOrderListArray = [OrderList]()

    var isReturn = false
    var isFrom = ""

    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        if self.isReturn == true {
            self.commonAPICALL(retryAPIID: 1001)
        } else {
            self.commonAPICALL(retryAPIID: 1000)
        }
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
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.orderTableView.tableFooterView = UIView()
        self.orderTableView.separatorColor = UIColor.clear
        self.orderTableView.backgroundColor = UIColor.clear
        self.orderTableView.rowHeight = UITableView.automaticDimension
        self.orderTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadOrderTableView()
        self.errorView.isHidden = true

        self.refreshControl.tintColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.refreshControl.attributedTitle = NSAttributedString(string: AppLocalizationString.pulltorefresh)
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.orderTableView.isScrollEnabled = true
        self.orderTableView.alwaysBounceVertical = true
        self.orderTableView.addSubview(self.refreshControl)

    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.orders
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.primaryMessageLabel.text = AppLocalizationString.youdonthaveanyorders
        self.orderButton.setTitle(AppLocalizationString.orders, for: .normal)
        self.returnOrderButton.setTitle(AppLocalizationString.returnOrders, for: .normal)

        let errorcombination = NSMutableAttributedString()
        let errorTitleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let errorContentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(13)]

        let errorTitle = NSMutableAttributedString(string: String(format: "%@ ", AppLocalizationString.explorehearzap), attributes: errorTitleAttributes as [NSAttributedString.Key: Any])
        let errorContent = NSMutableAttributedString(string: String(format: "%@", AppLocalizationString.onlineShopping), attributes: errorContentFontAttributes as [NSAttributedString.Key: Any])

        errorcombination.append(errorTitle)
        errorcombination.append(errorContent)
        self.secondaryMessageLabel.attributedText = errorcombination
    }
    // MARK: - Reload
    func reloadOrderTableView() {
        self.orderTableView.delegate = self
        self.orderTableView.dataSource = self
        self.orderTableView.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 || retryAPIID == 2000 {
                    self.getOrderList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 || retryAPIID == 2001 {
                    self.getReturnOrderList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }

    func getOrderList(retryAPIID: Int, canShowLoader: Bool) {
        self.orderListViewModel.getOrderList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getOrderList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getReturnOrderList(retryAPIID: Int, canShowLoader: Bool) {
        self.orderListViewModel.getReturnOrderList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getReturnOrderList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    // MARK: - IBAction
    @IBAction func errorTapButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }

    @IBAction func orderButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    @IBAction func returnOrderButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1001)

    }
    // MARK: - Custom Methods
    func setSelectedState() {
        self.orderButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.orderButton.clipsToBounds = true
        self.orderButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.orderButton.cornerRadius = AppConstantValue.cornerRadius4

        self.returnOrderButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.returnOrderButton.clipsToBounds = true
        self.returnOrderButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.returnOrderButton.cornerRadius = AppConstantValue.cornerRadius4

        if self.isReturn == true {
            self.returnOrderButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
            self.returnOrderButton.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
        } else {
            self.orderButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
            self.orderButton.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
        }
    }
    @objc func refresh(sender: AnyObject) {
        // Code to refresh table view
        if self.isReturn == true {
            self.commonAPICALL(retryAPIID: 2001)
        } else {
            self.commonAPICALL(retryAPIID: 2000)
        }
    }
}

extension OrderListViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if isFrom == IsNavigateFrom.orderMenu.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if isFrom == IsNavigateFrom.orderSuccess.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {
    }
}
extension OrderListViewController: ProtocolNetworkRechabilityDelegate {
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

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isReturn == true {
            return returnOrderListArray.count
        } else {
            return self.orderListArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.isReturn == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ReturnOrderListTableViewCell, for: indexPath) as! ReturnOrderListTableViewCell
            cell.configure(order: self.returnOrderListArray[indexPath.row], indexpath: indexPath.row)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.OrderListTableViewCell, for: indexPath) as! OrderListTableViewCell
            cell.configure(order: self.orderListArray[indexPath.row], indexpath: indexPath.row)
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
}
extension OrderListViewController: ProtocolOrderListTableViewCell, ProtocolReturnOrderListTableViewCell {
    func tapButtonPressedOrderListTableViewCell(senderTag: Int) {
        if self.orderListArray.count > 0 {
            if !(self.orderListArray[senderTag].orderNumber.isNilOrEmpty) {
                self.navigateToOrderDetailViewController(isFrom: IsNavigateFrom.od.rawValue, isReturn: false, orderID: self.orderListArray[senderTag].orderNumber!)
            }
        }
    }
    func tapButtonPressedReturnOrderListTableViewCell(senderTag: Int) {
        if self.returnOrderListArray.count > 0 {
            if !(self.returnOrderListArray[senderTag].orderNumber.isNilOrEmpty) {
                self.navigateToOrderDetailViewController(isFrom: IsNavigateFrom.rod.rawValue, isReturn: true, orderID: self.returnOrderListArray[senderTag].orderNumber!)
            }
        }
    }
}
