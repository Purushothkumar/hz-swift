//
//  ServiceRequestListViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 30/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ServiceRequestListViewController: UIViewController {
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

    var serviceRequestListViewModel = ServiceRequestListViewModel()
    var bookingListArray = [BookingListElement]()
    var isFrom = ""

    var refreshControl = UIRefreshControl()

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
        self.commonAPICALL(retryAPIID: 1000)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTableview()
        self.errorView.isHidden = true

        self.refreshControl.tintColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.refreshControl.attributedTitle = NSAttributedString(string: AppLocalizationString.pulltorefresh)
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tableview.isScrollEnabled = true
        self.tableview.alwaysBounceVertical = true
        self.tableview.addSubview(self.refreshControl)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.myBookings
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }

    // MARK: - Localization String
    func changeLanguageFormat() {
        self.primaryMessageLabel.text = AppLocalizationString.youhavenotmadeanybookingyet
        let errorcombination = NSMutableAttributedString()
        let errorTitleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let errorContentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(13)]

        let errorTitle = NSMutableAttributedString(string: String(format: "%@ ", AppLocalizationString.exploreour), attributes: errorTitleAttributes as [NSAttributedString.Key: Any])
        let errorContent = NSMutableAttributedString(string: String(format: "%@", AppLocalizationString.hearingcareservices), attributes: errorContentFontAttributes as [NSAttributedString.Key: Any])

        errorcombination.append(errorTitle)
        errorcombination.append(errorContent)
        self.secondaryMessageLabel.attributedText = errorcombination
    }

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
                if retryAPIID == 1000 ||  retryAPIID == 2000 {
                    self.getServiceRequestList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }

    func getServiceRequestList(retryAPIID: Int, canShowLoader: Bool) {
        self.serviceRequestListViewModel.getServiceRequestList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getServiceRequestList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    // MARK: - IBAction
    @IBAction func errorTapButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    // MARK: - Custom Methods
    @objc func refresh(sender: AnyObject) {
        // Code to refresh table view
        self.commonAPICALL(retryAPIID: 2000)
    }
}

extension ServiceRequestListViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if isFrom == IsNavigateFrom.srMenu.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {}
}
extension ServiceRequestListViewController: ProtocolNetworkRechabilityDelegate {
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
extension ServiceRequestListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookingListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ServiceRequestListTableViewCell, for: indexPath) as! ServiceRequestListTableViewCell
        cell.configure(bookingList: self.bookingListArray[indexPath.row], indexpath: indexPath.row)
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

extension ServiceRequestListViewController: ProtocolServiceRequestListTableViewCell {
    func tapButtonPressedServiceRequestListTableViewCell(senderTag: Int) {
        // srd
        if self.bookingListArray.count > 0 {
            if !(self.bookingListArray[senderTag].bookingUid.isNilOrEmpty) {
                self.navigateToServiceRequestDetailViewController(isFrom: IsNavigateFrom.srd.rawValue, bookingUid: self.bookingListArray[senderTag].bookingUid!)
            }
        }
    }
}
