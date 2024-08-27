//
//  MyAlertViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AVFoundation

class MyAlertViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var tableview: UITableView!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var errorTapButton: FootnoteOutlineButton!

    // MARK: - Lets and Var
    var myAlertViewModel = MyAlertViewModel()
    var listArray = [MyAlertModelDatum]()
    var isFrom = ""

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
        self.navigationBar.title = AppLocalizationString.myAlerts
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.primaryMessageLabel.text = AppLocalizationString.noAlerts
        self.secondaryMessageLabel.text = AppLocalizationString.noAlertsDesc
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
                    self.getmyalert(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getmyalert(retryAPIID: Int, canShowLoader: Bool) {
        self.myAlertViewModel.getmyalert(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getmyalert, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func errorTapButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    // MARK: - Custom Methods

}

extension MyAlertViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if isFrom == IsNavigateFrom.myalertHearingCare.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if isFrom == IsNavigateFrom.myalertStore.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabStores, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if isFrom == IsNavigateFrom.myalertShop.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if isFrom == IsNavigateFrom.myalertMenu.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {
    }
}
extension MyAlertViewController: ProtocolNetworkRechabilityDelegate {
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
extension MyAlertViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.MyAlertTableViewCell, for: indexPath) as! MyAlertTableViewCell
        cell.configure(alert: self.listArray[indexPath.row], indexPath: indexPath.row)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension MyAlertViewController: ProtocolMyAlertTableViewCell {
    func tapButtonPressedMyAlertTableViewCell(senderTag: Int) {
        if self.listArray.count > 0 {
            var objID = ""
            var objType = ""
            if !(self.listArray[senderTag].objID.isNilOrEmpty) {
                objID = self.listArray[senderTag].objID!
            }
            if !(self.listArray[senderTag].objType.isNilOrEmpty) {
                objType = self.listArray[senderTag].objType!
            }
            if objType == MyAlertFor.order.rawValue {
                if !(objID.isEmpty) {
                    self.navigateToOrderDetailViewController(isFrom: IsNavigateFrom.odAlert.rawValue, isReturn: false, orderID: objID)
                }
            } else if objType == MyAlertFor.orderreturn.rawValue {
                if !(objID.isEmpty) {
                    self.navigateToOrderDetailViewController(isFrom: IsNavigateFrom.rodAlert.rawValue, isReturn: true, orderID: objID)
                }
            } else if objType == MyAlertFor.registereddevice.rawValue {
                self.navigateToRegisterDeviceViewController(isFrom: IsNavigateFrom.rdalert.rawValue)
            } else if objType == MyAlertFor.booking.rawValue {
                if !(objID.isEmpty) {
                    self.navigateToServiceRequestDetailViewController(isFrom: IsNavigateFrom.srdAlert.rawValue, bookingUid: objID)
                }
            }
        }
    }
}
