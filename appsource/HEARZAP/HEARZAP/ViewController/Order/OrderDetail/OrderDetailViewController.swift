//
//  OrderDetailViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 10/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class OrderDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var titleLabel: CalloutFontLabel!

    @IBOutlet var addressInfoStackView: UIStackView!
    @IBOutlet var orderTitleLabel: CalloutFontLabel!
    @IBOutlet var orderDateStatusLabel: Caption1FontLabel!

    @IBOutlet var deliveryLocationTitleLabel: Caption1FontLabel!
    @IBOutlet var deliveryLocationLabel: Caption1FontLabel!

    @IBOutlet var infoStackView: UIStackView!

    @IBOutlet var bookingStackView: UIStackView!
    @IBOutlet var infoTitleLabel: Caption1FontLabel!

    @IBOutlet var orderIDTitleLabel: Caption1FontLabel!
    @IBOutlet var orderIDLabel: Caption1FontLabel!

    @IBOutlet var orderDateTitleLabel: Caption1FontLabel!
    @IBOutlet var orderDateLabel: Caption1FontLabel!

    @IBOutlet var orderAmountTitleLabel: Caption1FontLabel!
    @IBOutlet var orderAmountLabel: Caption1FontLabel!

    @IBOutlet var orderStatusTitleLabel: Caption1FontLabel!
    @IBOutlet var orderStatusLabel: Caption1FontLabel!

    @IBOutlet var orderReasonTitleLabel: Caption1FontLabel!
    @IBOutlet var orderReasonLabel: Caption1FontLabel!

    @IBOutlet var refundStatusTitleLabel: Caption1FontLabel!
    @IBOutlet var refundStatusLabel: Caption1FontLabel!

    @IBOutlet var refundAmountTitleLabel: Caption1FontLabel!
    @IBOutlet var refundAmountLabel: Caption1FontLabel!

    @IBOutlet var buttonStackView: UIStackView!
    @IBOutlet var needhelpButton: FootnoteOutlineButton!
    @IBOutlet var cancelButton: FootnoteOutlineButton!
    @IBOutlet var returnButton: FootnoteOutlineButton!

    @IBOutlet var orderitemsLabel: CalloutFontLabel!
    @IBOutlet var itemStackView: UIStackView!
    @IBOutlet var itemTableview: UITableView!
    @IBOutlet var itemTableviewHeight: NSLayoutConstraint!

    @IBOutlet var trackingStackView: UIStackView!

    @IBOutlet var trackingTitleLAbel: CalloutFontLabel!
    @IBOutlet var trackingIdTitleLabel: Caption1FontLabel!
    @IBOutlet var trackingIdLabel: Caption1FontLabel!
    @IBOutlet var trackingIdButton: FootnoteOutlineButton!

    @IBOutlet var trackingTableView: UITableView!
    @IBOutlet var trackingTableViewHeight: NSLayoutConstraint!

    @IBOutlet var paymentDetailTitleLabel: CalloutFontLabel!

    @IBOutlet var paymentStackView: UIStackView!

    @IBOutlet var paymentAmountTitleLabel: Caption1FontLabel!
    @IBOutlet var paymentAmountLabel: Caption1FontLabel!

    @IBOutlet var paymentModeTitleLabel: Caption1FontLabel!
    @IBOutlet var paymentModeLabel: Caption1FontLabel!

    @IBOutlet var paymentIDTitleLabel: Caption1FontLabel!
    @IBOutlet var paymentIDLabel: Caption1FontLabel!

    @IBOutlet var paymentDateTitleLabel: Caption1FontLabel!
    @IBOutlet var paymentDateLabel: Caption1FontLabel!

    @IBOutlet var downloadButtonStackView: UIStackView!
    @IBOutlet var downloadReceiptButton: FootnoteOutlineButton!
    @IBOutlet var downloadInvoiceButton: FootnoteOutlineButton!

    // MARK: - Lets and Var
    var orderDetailViewModel = OrderDetailViewModel()
    var isFrom = ""
    var isReturn = false
    var orderID = ""

    var productListArray = [OrderItemList]()
    var trackingStatusArray = [StatusList]()

    var returnReasonList = [ReturnReasonList]()
    var cancelReasonList = [CancelReasonList]()
    var selectArray = [String]()

    var canShowOrderItem = false
    var canShowTrackingDetails = false
    var canShowDeliveryAddress = false
    var canShowOrderDetail = false
    var canShowCancelOrder = false
    var canShowReturnOrderItem = false
    var canShowPaymentDetails = false
    var canShowTrackingInfo = false

    var invoiceDocument = ""
    var paymentReceipt = ""
    var trackingCode = ""
    var trackingURL = ""

    var refreshControl = UIRefreshControl()

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
        if self.productListArray.count > 0 && self.canShowOrderItem == true {
            self.itemTableviewHeight.constant = itemTableview.contentSize.height
        } else {
            self.itemTableviewHeight.constant = 0
        }
        if self.trackingStatusArray.count > 0 && self.canShowTrackingDetails == true {
            self.trackingTableViewHeight.constant = trackingTableView.contentSize.height
        } else {
            self.trackingTableViewHeight.constant = 0
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

        self.itemTableview.tableFooterView = UIView()
        self.itemTableview.separatorColor = UIColor.clear
        self.itemTableview.backgroundColor = UIColor.clear
        self.itemTableview.rowHeight = UITableView.automaticDimension
        self.itemTableview.estimatedRowHeight = UITableView.automaticDimension
        self.reloadItemTableview()

        self.trackingTableView.tableFooterView = UIView()
        self.trackingTableView.separatorColor = UIColor.clear
        self.trackingTableView.backgroundColor = UIColor.clear
        self.trackingTableView.rowHeight = UITableView.automaticDimension
        self.trackingTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTrackingTableView()

        self.returnButton.clipsToBounds = true
        self.returnButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.returnButton.layer.borderWidth = 1.0
        self.returnButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor

        self.refreshControl.tintColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.refreshControl.attributedTitle = NSAttributedString(string: AppLocalizationString.pulltorefresh)
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.mainScrollView.isScrollEnabled = true
        self.mainScrollView.alwaysBounceVertical = true
        self.mainScrollView.addSubview(self.refreshControl)

        if self.isReturn == false {
            self.commonAPICALL(retryAPIID: 1000)
        } else {
            self.commonAPICALL(retryAPIID: 1001)
        }

    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = isReturn == false ? AppLocalizationString.order : AppLocalizationString.returnOrder
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }

    // MARK: - Localization String
    func changeLanguageFormat() {
        self.titleLabel.text = isReturn == false ? AppLocalizationString.orderDetails : AppLocalizationString.returnOrderDetails
        self.deliveryLocationTitleLabel.text = isReturn == false ? AppLocalizationString.deliveryLocation : AppLocalizationString.returnPickupLocation
        self.orderIDTitleLabel.text = AppLocalizationString.orderID
        self.orderDateTitleLabel.text = isReturn == false ? AppLocalizationString.orderDate : AppLocalizationString.returndate
        self.orderAmountTitleLabel.text = isReturn == false ? AppLocalizationString.orderAmount : AppLocalizationString.itemAmount
        self.orderStatusTitleLabel.text = AppLocalizationString.orderStatus
        self.orderReasonTitleLabel.text = isReturn == false ? AppLocalizationString.cancellationReason : AppLocalizationString.returnReason
        self.refundStatusTitleLabel.text = AppLocalizationString.refundStatus
        self.refundAmountTitleLabel.text = AppLocalizationString.refundAmount

        self.orderitemsLabel.text = AppLocalizationString.orderedItems.capitalized

        self.needhelpButton.setTitle(AppLocalizationString.needHelp.capitalized, for: .normal)
        self.cancelButton.setTitle(AppLocalizationString.cancelOrder.capitalized, for: .normal)
        self.returnButton.setTitle(AppLocalizationString.return_str.uppercased(), for: .normal)

        self.trackingTitleLAbel.text = AppLocalizationString.trackingDetails
        self.trackingIdTitleLabel.text = AppLocalizationString.trackingID
        self.paymentDetailTitleLabel.text = AppLocalizationString.paymentDetails

        self.paymentAmountTitleLabel.text = AppLocalizationString.paymentAmount
        self.paymentModeTitleLabel.text = AppLocalizationString.paymentMode
        self.paymentIDTitleLabel.text = AppLocalizationString.paymentTXNID
        self.paymentDateTitleLabel.text = AppLocalizationString.paymentDate

        self.downloadReceiptButton.setTitle(AppLocalizationString.downloadReceipt.capitalized, for: .normal)
        self.downloadInvoiceButton.setTitle(AppLocalizationString.downloadInvoice.capitalized, for: .normal)
    }
    // MARK: - Reload

    func reloadItemTableview() {
        self.itemTableview.delegate = self
        self.itemTableview.dataSource = self
        self.itemTableview.reloadData()

    }
    func reloadTrackingTableView() {
        self.trackingTableView.delegate = self
        self.trackingTableView.dataSource = self
        self.trackingTableView.reloadData()

    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 || retryAPIID == 2000 {
                    self.getOrderDetail(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 || retryAPIID == 2001 {
                    self.getReturnOrderDetail(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }

    func getOrderDetail(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.orderID.isEmpty) {
            let url = "\(SubAPIUrl.getOrderDetail)\(self.orderID)/"
            self.orderDetailViewModel.getOrderDetail(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    func getReturnOrderDetail(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.orderID.isEmpty) {
            let url = "\(SubAPIUrl.getReturnOrderDetail)\(self.orderID)/"
            self.orderDetailViewModel.getOrderDetail(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    // MARK: - IBAction
    @IBAction func cancelOrderButtonPressed(_ sender: UIButton) {
        self.navigateToCancelOrderViewController(orderID: self.orderID, reasonArray: self.cancelReasonList)
    }
    @IBAction func needhelpButtonPressed(_ sender: UIButton) {
        self.navigateToSupportViewController(isFrom: IsNavigateFrom.supportOrder.rawValue)
    }
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        self.showPopup()
    }
    @IBAction func downloadReceiptButtonPressed(_ sender: UIButton) {
        if !(self.paymentReceipt.isEmpty) {
            guard let appURL = URL(string: self.paymentReceipt.checkhttpCharacter) else {
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
    @IBAction func downloadInvoiceButtonPressed(_ sender: UIButton) {
        if !(self.invoiceDocument.isEmpty) {
            guard let appURL = URL(string: self.invoiceDocument.checkhttpCharacter) else {
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

    @IBAction func trackIdButtonPressed(_ sender: UIButton) {
        if !(self.trackingURL.isEmpty) {
            guard let appURL = URL(string: self.trackingURL.checkhttpCharacter) else {
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
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    // MARK: - Custom Methods

    @objc func refresh(sender: AnyObject) {
        // Code to refresh table view
        if self.isReturn == false {
            self.commonAPICALL(retryAPIID: 2000)
        } else {
            self.commonAPICALL(retryAPIID: 2001)
        }
    }
}

extension OrderDetailViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if isFrom == IsNavigateFrom.od.rawValue {
            self.navigateBackToViewController()
        } else if isFrom == IsNavigateFrom.odSuccess.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if isFrom == IsNavigateFrom.odAlert.rawValue {
            self.navigateBackToMyAlertViewController()
        } else if isFrom == IsNavigateFrom.rod.rawValue {
            self.navigateBackToViewController()
        } else if isFrom == IsNavigateFrom.rodAlert.rawValue {
            self.navigateBackToMyAlertViewController()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {
    }
}
extension OrderDetailViewController: ProtocolNetworkRechabilityDelegate {
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

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.itemTableview {
            return self.productListArray.count
        } else {
            return self.trackingStatusArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.itemTableview {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.OrderDetailItemTableViewCell, for: indexPath) as! OrderDetailItemTableViewCell
            cell.configure(item: productListArray[indexPath.row], indexpath: indexPath.row)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.OrderDetailTrackingTableViewCell, for: indexPath) as! OrderDetailTrackingTableViewCell
            cell.configure(statusList: self.trackingStatusArray[indexPath.row], indexpath: indexPath.row, totalArrayCount: self.trackingStatusArray.count)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
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
        if tableView == self.itemTableview && self.productListArray.count > 0 && self.canShowOrderItem == true {
            return self.itemTableviewHeight.constant = tableView.contentSize.height
        } else if tableView == self.trackingTableView && self.trackingStatusArray.count > 0 && self.canShowTrackingDetails == true {
            return self.trackingTableViewHeight.constant = tableView.contentSize.height
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension OrderDetailViewController: BottomPopupDelegate, ProtocolBottomSheetReturnProductViewController {
    // MARK: - Select Device PopupScreen
    func showPopup() {
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetReturnProductViewController) as? BottomSheetReturnProductViewController else { return }
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0

        let defaultheight: CGFloat = screenFrameHeight * (4 / 5)
        let popvcheight = defaultheight
        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        popupVC.height = popvcheight  + bottomPadding + topPadding
        popupVC.popupDelegate = self as BottomPopupDelegate
        popupVC.delegate = self
        popupVC.selectArray = self.selectArray
        popupVC.deviceListArray = self.productListArray
        present(popupVC, animated: true, completion: nil)
    }
    func updateDeviceListBottomSheetReturnProductViewController(deviceList: [String]) {
        self.selectArray = deviceList
        var selecteditem = [OrderItemList]()
        if self.selectArray.count > 0 {
            for item in self.productListArray {
                var itemID = ""
                if item.itemID != nil {
                    itemID = String(format: "%d", item.itemID!)
                    if self.selectArray.contains(itemID) {
                        selecteditem.append(item)
                    }
                }
            }
        }
        if (selecteditem.count > 0) && (self.returnReasonList.count > 0) {
            self.navigateToReturnReasonViewController(orderID: self.orderID, reasonArray: self.returnReasonList, selectArray: self.selectArray, productListArray: selecteditem)
        }
    }
}
