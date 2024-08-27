//
//  CheckOutSummaryViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 08/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Razorpay

class CheckOutSummaryViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var cartCircleView: CartCircleView!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var titleLabel: FootnoteFontLabel!

    @IBOutlet var addressStackView: UIStackView!

    @IBOutlet var homeAddressView: UIView!
    @IBOutlet var homeAddressStackView: UIStackView!

    @IBOutlet var homeAddressTitleLabel: Caption1FontLabel!
    @IBOutlet var homeAddressNameLabel: FootnoteFontLabel!
    @IBOutlet var homeAddressTypeView: UIView!
    @IBOutlet var homeAddressTypeLabel: Caption1FontLabel!
    @IBOutlet var homeAddressLabel: Caption1FontLabel!
    @IBOutlet var homeAddressContactLabel: Caption1FontLabel!

    @IBOutlet var storeAddressView: UIView!
    @IBOutlet var storeAddressStackView: UIStackView!

    @IBOutlet var storeAddressTitleLabel: Caption1FontLabel!
    @IBOutlet var storeAddressNameLabel: FootnoteFontLabel!
    @IBOutlet var storeAddressLabel: Caption1FontLabel!
    @IBOutlet var storeAddressContactLabel: Caption1FontLabel!

    @IBOutlet var addedItemsLabel: FootnoteFontLabel!

    @IBOutlet var itemsTableView: UITableView!
    @IBOutlet var itemsTableViewHeight: NSLayoutConstraint!

    @IBOutlet var couponStackView: UIStackView!
    @IBOutlet var couponBgStackView: UIStackView!
    @IBOutlet var couponTitleLabel: FootnoteFontLabel!
    @IBOutlet var couponDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var couponLabel: FootnoteFontLabel!
    @IBOutlet var couponButton: FootnoteOutlineButton!

    @IBOutlet var paymentStackView: UIStackView!
    @IBOutlet var paymentTitleLabel: FootnoteFontLabel!

    @IBOutlet var priceTableView: UITableView!
    @IBOutlet var priceTableViewHeight: NSLayoutConstraint!

    @IBOutlet var paymentTotalTitleLabel: FootnoteFontLabel!
    @IBOutlet var paymentTotalDescLabel: Caption1FontLabel!

    @IBOutlet var audiologistView: UIView!
    @IBOutlet var audiologistLabel: Caption1FontLabel!
    @IBOutlet var audiologistButton: FootnoteOutlineButton!
    
    @IBOutlet var productInfoStackView: UIStackView!

    @IBOutlet var productGenuineView: UIView!
    @IBOutlet var productGenuineLabel: Caption2FontLabel!

    @IBOutlet var productShippingView: UIView!
    @IBOutlet var productShippingLabel: Caption2FontLabel!

    @IBOutlet var productPaymentView: UIView!
    @IBOutlet var productPaymentLabel: Caption2FontLabel!

    @IBOutlet var termsView: UIView!
    @IBOutlet var termsLabel: Caption2FontLabel!

    @IBOutlet var buttonView: UIView!
    @IBOutlet var paynowButton: FootnoteBackgroundButton!
    @IBOutlet var buttonViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    var checkOutSummaryViewModel = CheckOutSummaryViewModel()
    var cartListArray = [OrderItem]()
    var priceDetailsArray = [PricingDetail]()

    var orderID = ""

    var razorpay: RazorpayCheckout!

    var paymentStatus = ""
    var razorpayPaymentID = ""
    var razorpayOrderID = ""
    var razorpaySignature = ""

    var visitType = ""
    var canShowAudiologistStaff = false
    var canShowHomeAddress = false
    var canShowStoreAddress = false
    var scheduleDate = ""
    var timeSlot = ""
    var canShowApplyCoupon = false
    var canShowPricingDetails = false
    var totalPrice = ""
    var couponCode = ""
    var couponAmount = ""

    var coupontitle = ""
    var coupondescription = ""
    var isCouponAdded = false
    var canShowFreeShipping = false
    
    var addressHeading = ""

    var isAudiologistPrescribed = true

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
        if self.cartListArray.count > 0 {

            self.itemsTableView.isScrollEnabled = false
            self.itemsTableViewHeight.constant = CGFloat((140 * self.cartListArray.count) + 8)

        } else {
            self.itemsTableViewHeight.constant = 0
        }

        if self.priceDetailsArray.count > 0 {
            self.priceTableViewHeight.constant = self.priceTableView.contentSize.height + 8
        } else {
            self.priceTableViewHeight.constant = 0
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
        self.setCartCircleView()

        self.paynowButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.paynowButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.paynowButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.paynowButton.clipsToBounds = true

        self.priceTableView.tableFooterView = UIView()
        self.priceTableView.separatorColor = UIColor.clear
        self.priceTableView.backgroundColor = UIColor.clear
        self.priceTableView.rowHeight = UITableView.automaticDimension
        self.priceTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadPriceTableView()

        self.itemsTableView.tableFooterView = UIView()
        self.itemsTableView.separatorColor = UIColor.colorLiteral.theme_white_F2F2F2
        self.itemsTableView.backgroundColor = UIColor.clear
        self.itemsTableView.rowHeight = UITableView.automaticDimension
        self.itemsTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadItemsTableView()

        self.commonAPICALL(retryAPIID: 1002)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.checkout
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Set Cart Circle View
    func setCartCircleView() {
        self.cartCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.recordcircleblue, button3image: Asset.circlegrey, label1Color: UIColor.colorLiteral.theme_blue_112F70, label2Color: UIColor.colorLiteral.theme_blue_112F70, label3Color: UIColor.colorLiteral.theme_grey_777777,circleViewBackgroundColor: UIColor.colorLiteral.theme_white_FFFFFF)

    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        //        self.addItemsTitleLabel.text = AppLocalizationString.addedItems
        //
        self.paymentTitleLabel.text = AppLocalizationString.priceDetails.capitalized
        self.paymentTotalTitleLabel.text = AppLocalizationString.totalAmount.capitalized
        //        self.serviceDetailsTitleLabel.text = AppLocalizationString.serviceDetails.capitalized
        //
        let strText1 = AppLocalizationString.youareagreeingtothe
        let strText2 = AppLocalizationString.termsandConditions
        let strText3 = AppLocalizationString.ofHEARZAPbycheckingout
        let regularFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(11)]
        let regularUndelineFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(11), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.colorLiteral.theme_blue_2AACEF] as [NSAttributedString.Key: Any]

        let part1 = NSMutableAttributedString(string: String(format: "%@ ", strText1), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
        let part2 = NSMutableAttributedString(string: String(format: "%@", strText2), attributes: regularUndelineFontAttributes as [NSAttributedString.Key: Any])
        let part3 = NSMutableAttributedString(string: String(format: " %@", strText3), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
        let combination = NSMutableAttributedString()
        combination.append(part1)
        combination.append(part2)
        combination.append(part3)
        self.termsLabel.attributedText = combination
        self.termsLabel.isUserInteractionEnabled = true
        self.termsLabel.lineBreakMode = .byWordWrapping
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.termsLabel.addGestureRecognizer(tapgesture)

        self.couponTitleLabel.text = coupontitle
        self.couponDescriptionLabel.text = coupondescription

        self.audiologistLabel.text = AppLocalizationString.audiologistDesc
        self.productGenuineLabel.text = AppLocalizationString.qualityAssurance
        self.productShippingLabel.text = AppLocalizationString.freeShippingPanIndia
        self.productPaymentLabel.text = AppLocalizationString.secureandSafePayments
        self.paynowButton.setTitle(AppLocalizationString.paynow.uppercased(), for: .normal)

        if self.isCouponAdded == false {
            self.couponLabel.text = AppLocalizationString.apply.capitalized
            self.couponLabel.textColor = UIColor.colorLiteral.theme_red_FF6961
            self.couponBgStackView.backgroundColor = UIColor.colorLiteral.theme_red_FFE6E4
        } else {
            self.couponLabel.text = AppLocalizationString.remove.capitalized
            self.couponLabel.textColor = UIColor.colorLiteral.theme_red_FF6961
            self.couponBgStackView.backgroundColor = UIColor.colorLiteral.theme_red_FFE6E4
        }
        self.paymentTotalDescLabel.text = self.totalPrice
        self.homeAddressTitleLabel.text = AppLocalizationString.homeAddress
        self.storeAddressTitleLabel.text = AppLocalizationString.serviceStore

    }
    // MARK: - Reload
    func reloadItemsTableView() {
        self.itemsTableView.delegate = self
        self.itemsTableView.dataSource = self
        self.itemsTableView.reloadData()
    }
    func reloadPriceTableView() {
        self.priceTableView.delegate = self
        self.priceTableView.dataSource = self
        self.priceTableView.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.postCheckoutMakePayment(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.postCheckoutVerifyPayment(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 {
                    self.getCheckoutSummary(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1003 {
                    self.applyCoupon(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }

    func postCheckoutMakePayment(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.postCheckoutMakePayment)\(orderID)/"
        let param = String(format: "is_audiologist_prescribed=%@&order_id=%@", isAudiologistPrescribed == false ? "off" : "on", self.orderID)

        self.checkOutSummaryViewModel.postCheckoutMakePayment(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postCheckoutVerifyPayment(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.postCheckoutVerifyPayment)\(orderID)/"
        let param = String(format: "payment_status=%@&razorpay_order_id=%@&razorpay_payment_id=%@&razorpay_signature=%@", self.paymentStatus, self.razorpayOrderID, self.razorpayPaymentID, self.razorpaySignature)
        self.checkOutSummaryViewModel.postCheckoutVerifyPayment(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getCheckoutSummary(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getCheckoutSummary)\(orderID)/"
        self.checkOutSummaryViewModel.getCheckoutSummary(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func applyCoupon(retryAPIID: Int, canShowLoader: Bool) {
        //        let param = String(format: "coupon_code=%@", self.couponCode)
        let param = String(format: "order_id=%@&coupon_code=%@&mode=remove", self.orderID, self.couponCode)
        self.checkOutSummaryViewModel.applyCoupon(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.applyShoppingCoupon, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction

    @IBAction func paynowButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    @IBAction func couponButtonPressed(_ sender: UIButton) {
        if self.couponCode.isEmpty {
            self.navigateToServiceCouponListViewController(isFrom: IsNavigateFrom.cartCoupon.rawValue, bookingUid: self.orderID, couponOfferedFor: CouponOfferedFor.shopping.rawValue)
        } else {
            self.commonAPICALL(retryAPIID: 1003)
        }
    }
    @IBAction func audiologistButtonPressed(_ sender: UIButton) {
        isAudiologistPrescribed == false ? (isAudiologistPrescribed = true) : (isAudiologistPrescribed = false)
        self.audiologistButton.setImage(self.isAudiologistPrescribed == false ? UIImage(named: Asset.checksquarewhite) : UIImage(named: Asset.checksquareblueFill), for: .normal)

    }
    // MARK: - Custom Method
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.termsLabel.text else { return }
        let termsandConditionsRange = (text as NSString).range(of: AppLocalizationString.termsandConditions)
        let texttap = (text as NSString).range(of: text)
        //        if gesture.didTapAttributedTextInLabel(label: self.policylabel, inRange: termsandConditionsRange) {
        //            self.navigateToTermsConditionsViewController(isFrom: isFrom)
        //        }
        if gesture.didTapAttributedTextInLabel(label: self.termsLabel, inRange: termsandConditionsRange) {
            self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseCheckoutSummary.rawValue)
        } else if gesture.didTapAttributedTextInLabel(label: self.termsLabel, inRange: texttap) {
            self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseCheckoutSummary.rawValue)
        } else {
            
        }
    }

    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if !(self.orderID.isEmpty) {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
        }
    }
    func setButtonDisable() {
        self.paynowButton.isUserInteractionEnabled = false
        self.paynowButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.paynowButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.paynowButton.setNeedsDisplay()
        self.paynowButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.paynowButton.isUserInteractionEnabled = true
        self.paynowButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.paynowButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.paynowButton.setNeedsDisplay()
        self.paynowButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func appliedCoupon() {
        self.commonAPICALL(retryAPIID: 1002)
    }

}

extension CheckOutSummaryViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension CheckOutSummaryViewController: ProtocolNetworkRechabilityDelegate {
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
extension CheckOutSummaryViewController: RazorpayPaymentCompletionProtocolWithData {
    func toShowPaymentForm(strRazorOrderId: String, razorTotalAmount: String, currency: String) {
        self.paymentStatus = ""
        self.razorpayPaymentID = ""
        self.razorpayOrderID = strRazorOrderId
        self.razorpaySignature = ""
        var mobileNumber = ""
        var emailAddress = ""

        if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.customerEmail).isNilOrEmpty) {
            emailAddress = UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.customerEmail)!
        }
        if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.customerMobile).isNilOrEmpty) {
            mobileNumber = UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.customerMobile)!
        }
        guard let razorPayID: String = Bundle.main.infoDictionary?["RAZOR_PAY_ID"] as? String else { return }
        razorpay = RazorpayCheckout.initWithKey(razorPayID, andDelegateWithData: self)

        let options: [AnyHashable: Any] = [
            "amount": razorTotalAmount, // This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": currency, // We support more that 92 international currencies.
            "description": "purchase description",
            "order_id": strRazorOrderId, // Razorpay Order ID generated from local DB
            "image": "",
            "name": "Hearzap Customer Mobile",
            // "payment_capture": "1",
            "prefill": [
                "contact": mobileNumber,
                "email": emailAddress
            ],
            "theme": [
                "color": "#112F70"
            ]
        ]
        if let rzp = self.razorpay {
            rzp.open(options, displayController: self)
        } else {}
    }
    // MARK: - RazorPay Delegate
    // RazorpayPaymentCompletionProtocolWithData - This will returns you the data in both error and success case. On payment failure you will get a code and description. In payment success you will get the payment id.
    @objc func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable: Any]?) {
        // ([AnyHashable("email"): "purushoth.kumar@seaant.com", AnyHashable("name"): "", AnyHashable("contact"): "+919840730024"])//cancel
        //        self.presentAlert(withTitle: "Alert", message: str)
        self.paymentStatus = "PAYMENT_FAILURE"
        self.razorpaySignature = ""
        //        self.razorpayOrderID = razorpay_order_id
        //        self.fnGoToUpdateInDB()
        self.showToastAlert(str, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
    }

    @objc func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable: Any]?) {
        //        WithData Success: pay_FDWmE6Wbnqm7VM Optional([AnyHashable("razorpay_signature"): 1cbb0aab97b464815edba6dab95ca66c8f3ce8a2648de1b996a713cad6bbc371, AnyHashable("razorpay_payment_id"): pay_FDWmE6Wbnqm7VM, AnyHashable("razorpay_order_id"): order_FDWm3e3INudk9c])
        /*Sample
         onPaymentSuccess: payment_id pay_I6myr0mjBbx65u response Optional([AnyHashable("razorpay_order_id"): order_I6mya1cGroLTz5, AnyHashable("custom_branding"): 0, AnyHashable("org_logo"): , AnyHashable("razorpay_payment_id"): pay_I6myr0mjBbx65u, AnyHashable("checkout_logo"): https://cdn.razorpay.com/logo.png, AnyHashable("org_name"): Razorpay Software Private Ltd, AnyHashable("razorpay_signature"):
         */

        self.paymentStatus = "PAYMENT_SUCCESS"
        if let razorpaySignatureString = response!["razorpay_signature"] as? String {
            self.razorpaySignature = razorpaySignatureString
        }
        if let razorpayOrderIDString = response!["razorpay_order_id"] as? String {
            self.razorpayOrderID = razorpayOrderIDString
        }
        if let razorpayPaymentIDString = response!["razorpay_payment_id"] as? String {
            self.razorpayPaymentID = razorpayPaymentIDString
        }
        self.commonAPICALL(retryAPIID: 1001)
    }
}

extension CheckOutSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.priceTableView {
            return self.priceDetailsArray.count
        } else if tableView == self.itemsTableView {
            return self.cartListArray.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.priceTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CheckOutSummaryPriceTableViewCell, for: indexPath) as! CheckOutSummaryPriceTableViewCell
            cell.configure(pricingDetail: self.priceDetailsArray[indexPath.row], indexpath: indexPath.row)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CheckOutSummaryProductTableViewCell, for: indexPath) as! CheckOutSummaryProductTableViewCell
            cell.configure(data: self.cartListArray[indexPath.row], indexpath: indexPath.row)
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
        if (tableView == self.priceTableView) && (self.priceDetailsArray.count > 0) {
            return self.priceTableViewHeight.constant = tableView.contentSize.height
        } else if tableView == self.itemsTableView && self.cartListArray.count > 0 {
            return self.itemsTableViewHeight.constant = tableView.contentSize.height
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
