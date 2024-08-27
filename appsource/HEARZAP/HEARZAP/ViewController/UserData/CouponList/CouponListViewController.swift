//
//  CouponListViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CouponListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var tableview: UITableView!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var errorTapButton: CalloutOutlineButton!

    // MARK: - Lets and Var
    var couponListViewModel = CouponListViewModel()
    var listArray = [CustomerCoupon]()

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
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.errorView.isHidden = true

        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTableView()

        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.coupons.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.primaryMessageLabel.text = AppLocalizationString.nodiscountcouponsavailableatthistime
        self.secondaryMessageLabel.text = AppLocalizationString.pleasecheckbacksoonfornewofferscontinue
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
                    self.getCouponList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCouponList(retryAPIID: Int, canShowLoader: Bool) {
        self.couponListViewModel.getCouponList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCouponList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func errorTapButtonPressed(_ sender: UIButton) {

    }
    // MARK: - Custom Method

}
extension CouponListViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}

extension CouponListViewController: ProtocolNetworkRechabilityDelegate {
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
extension CouponListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var faqCount = 0
        if self.listArray[section].couponList != nil {
            faqCount = self.listArray[section].couponList!.count
        }
        return faqCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CouponListTableViewCell, for: indexPath) as! CouponListTableViewCell
        var couponList = CouponList()
        if self.listArray[indexPath.section].couponList != nil {
            couponList = self.listArray[indexPath.section].couponList![indexPath.row]
            cell.configure(couponList: couponList, indexpath: indexPath.row)
            cell.delegate = self
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
        self.view.layer.layoutIfNeeded()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var heading = ""
        var headingHeight: CGFloat = 0

        if !(self.listArray[section].typeName.isNilOrEmpty) {
            heading = self.listArray[section].typeName!
            headingHeight =  self.heightForText(text: heading, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - CGFloat(32))
        }
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Int(AppConstantValue.screenWidthminus32), height: Int(headingHeight) + 32))
        let label = CalloutFontLabel()
        label.frame = CGRect.init(x: 16, y: 16, width: Int(AppConstantValue.screenWidthminus32) - 32, height: Int(headingHeight))
        label.text = heading
        label.textColor = UIColor.colorLiteral.theme_blue_112F70
        label.font = AppFont.semibold.size(16)
        headerView.addSubview(label)
        //        headerView.roundCorners([.topLeft, .topRight], radius: 8.0)
        headerView.layer.masksToBounds = true
        headerView.clipsToBounds = true
        headerView.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var heading = ""
        var headingHeight: CGFloat = 0

        if !(self.listArray[section].typeName.isNilOrEmpty) {
            heading = self.listArray[section].typeName!
            headingHeight =  self.heightForText(text: heading, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - CGFloat(32))
        }
        return headingHeight + CGFloat(32)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Int(AppConstantValue.screenWidthminus32), height: 16))
        headerView.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(8)
    }
}
extension CouponListViewController: ProtocolCouponListTableViewCell {
    func tapButtonPressedCouponListTableViewCell(senderTag: Int) {}
}
