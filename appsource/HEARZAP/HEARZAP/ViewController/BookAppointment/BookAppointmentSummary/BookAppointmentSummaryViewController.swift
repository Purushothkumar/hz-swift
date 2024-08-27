//
//  BookAppointmentSummaryViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 28/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Razorpay

class BookAppointmentSummaryViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var fourDotCircleView: FourDotCircleView!
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var bookingDetailsStackView: UIStackView!
    
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
    
    @IBOutlet var dateView: UIView!
    @IBOutlet var dateTitleLabel: Caption1FontLabel!
    @IBOutlet var dateDescLabel: Caption1FontLabel!
    
    @IBOutlet var timeView: UIView!
    @IBOutlet var timeTitleLabel: Caption1FontLabel!
    @IBOutlet var timeDescLabel: Caption1FontLabel!
    
    @IBOutlet var serviceDetailsStackView: UIStackView!
    @IBOutlet var serviceDetailsView: UIView!
    @IBOutlet var serviceDetailsTitleLabel: FootnoteFontLabel!
    
    @IBOutlet var serviceDetailsQtyView: UIView!
    @IBOutlet var serviceDetailsQtyTableView: UITableView!
    @IBOutlet var serviceDetailsQtyTableViewHeight: NSLayoutConstraint!
    
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
    
    @IBOutlet var privacyLabel: Caption1FontLabel!
    
    @IBOutlet var buttonView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!
    @IBOutlet var buttonViewHeight: NSLayoutConstraint!
    
    // MARK: - Lets and Var
    var bookAppointmentSummaryViewModel = BookAppointmentSummaryViewModel()
    
    var isFrom = ""
    var patientUid = ""
    
    var audiologistDetails: AudiologistDetails?
    
    var razorpay: RazorpayCheckout!
    
    var paymentStatus = ""
    var razorpayPaymentID = ""
    var razorpayOrderID = ""
    var razorpaySignature = ""
    
    var bookingUid = ""
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
    
    var serviceRequestsListArray = [ServiceRequestsList]()
    var priceDetailsArray = [PricingDetail]()
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.serviceRequestsListArray.count > 0 {
            self.serviceDetailsQtyTableViewHeight.constant = self.serviceDetailsQtyTableView.contentSize.height
        } else {
            self.serviceDetailsQtyTableViewHeight.constant = 0
        }
        if self.priceDetailsArray.count > 0 {
            self.priceTableViewHeight.constant = self.priceTableView.contentSize.height
        } else {
            self.priceTableViewHeight.constant = 0
        }
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
        self.setFourDotCircleView()
        self.setCommonTitleView()
        self.buttonView.isHidden = true
        self.setUserInteractionButton()
        self.serviceDetailsQtyTableView.tableFooterView = UIView()
        self.serviceDetailsQtyTableView.separatorColor = UIColor.clear
        self.serviceDetailsQtyTableView.backgroundColor = UIColor.clear
        self.serviceDetailsQtyTableView.rowHeight = UITableView.automaticDimension
        self.serviceDetailsQtyTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadServiceDetailsQtyTableView()
        
        self.priceTableView.tableFooterView = UIView()
        self.priceTableView.separatorColor = UIColor.clear
        self.priceTableView.backgroundColor = UIColor.clear
        self.priceTableView.rowHeight = UITableView.automaticDimension
        self.priceTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadPriceTableView()
        
        self.commonAPICALL(retryAPIID: 1002)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.bookAppointment
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Set Four Dot Circle View
    func setFourDotCircleView() {
        self.fourDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.checkcircleblue, button3image: Asset.checkcircleblue, button4image: Asset.recordcircleblue,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.BAStep4Title.capitalized
        let descriptionMessage = AppLocalizationString.BAStep4Desc.capitalized
        
        self.commonTitleView.setupView(titleMessage: titlemessage, descriptionMessage: descriptionMessage,commonTitlebackgroundViewColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
        if !(titlemessage.isEmpty) && !(descriptionMessage.isEmpty) {
            self.commonTitleViewHeight.constant = 8 + self.heightForText(text: titlemessage, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32) + 2 + self.heightForText(text: descriptionMessage, Font: AppFont.regular.size(11), Width: AppConstantValue.screenWidthminus32) + 8
        } else if !(titlemessage.isEmpty) {
            self.commonTitleViewHeight.constant = 8 + self.heightForText(text: titlemessage, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32) + 10
        } else if !(descriptionMessage.isEmpty) {
            self.commonTitleViewHeight.constant = 10 + self.heightForText(text: descriptionMessage, Font: AppFont.regular.size(11), Width: AppConstantValue.screenWidthminus32) + 8
        } else {
            self.commonTitleViewHeight.constant = 0
        }
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.nextButton.setTitle(AppLocalizationString.paynow.uppercased(), for: .normal)
        self.titleLabel.text = self.visitType.capitalized
        self.dateTitleLabel.text = AppLocalizationString.scheduledDate.capitalized
        self.timeTitleLabel.text = AppLocalizationString.timeSlot.capitalized
        self.paymentTitleLabel.text = AppLocalizationString.priceDetails.capitalized
        self.paymentTotalTitleLabel.text = AppLocalizationString.totalAmount.capitalized
        self.serviceDetailsTitleLabel.text = AppLocalizationString.serviceDetails.capitalized
        
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
        self.privacyLabel.attributedText = combination
        self.privacyLabel.isUserInteractionEnabled = true
        self.privacyLabel.lineBreakMode = .byWordWrapping
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.privacyLabel.addGestureRecognizer(tapgesture)
        
        self.couponTitleLabel.text = coupontitle
        self.couponDescriptionLabel.text = coupondescription
        
        if self.isCouponAdded == false {
            self.couponLabel.text = AppLocalizationString.apply.uppercased()
            self.couponLabel.textColor = UIColor.colorLiteral.theme_red_FF6961
            self.couponBgStackView.backgroundColor = UIColor.colorLiteral.theme_red_FFE6E4
        } else {
            self.couponLabel.text = AppLocalizationString.remove.uppercased()
            self.couponLabel.textColor = UIColor.colorLiteral.theme_red_FF6961
            self.couponBgStackView.backgroundColor = UIColor.colorLiteral.theme_red_FFE6E4
        }
        self.paymentTotalDescLabel.text = self.totalPrice
        self.homeAddressTitleLabel.text = AppLocalizationString.homeAddress
        self.storeAddressTitleLabel.text = AppLocalizationString.serviceStore
        
        self.setCommonTitleView()
    }
    // MARK: - Reload
    func reloadServiceDetailsQtyTableView() {
        self.serviceDetailsQtyTableView.delegate = self
        self.serviceDetailsQtyTableView.dataSource = self
        self.serviceDetailsQtyTableView.reloadData()
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
                    self.postBookingMakePayment(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.postBookingVerifyPayment(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 {
                    self.getBookingSummary(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1003 {
                    self.applyCoupon(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    
    func postBookingMakePayment(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.postBookingMakePayment)\(bookingUid)/"
        self.bookAppointmentSummaryViewModel.postBookingMakePayment(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postBookingVerifyPayment(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.postBookingVerifyPayment)\(bookingUid)/"
        let param = String(format: "payment_status=%@&razorpay_order_id=%@&razorpay_payment_id=%@&razorpay_signature=%@", self.paymentStatus, self.razorpayOrderID, self.razorpayPaymentID, self.razorpaySignature)
        self.bookAppointmentSummaryViewModel.postBookingVerifyPayment(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getBookingSummary(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getBookingSummary)\(bookingUid)/"
        self.bookAppointmentSummaryViewModel.getBookingSummary(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func applyCoupon(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.applyBookingCoupon)\(self.bookingUid)/remove/"
        let param = String(format: "coupon_code=%@", self.couponCode)
        self.bookAppointmentSummaryViewModel.applyCoupon(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    @IBAction func couponButtonPressed(_ sender: UIButton) {
        if self.couponCode.isEmpty {
            self.navigateToServiceCouponListViewController(isFrom: self.isFrom, bookingUid: self.bookingUid, couponOfferedFor: CouponOfferedFor.booking.rawValue)
        } else {
            self.commonAPICALL(retryAPIID: 1003)
        }
    }
    
    // MARK: - Custom Method
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.privacyLabel.text else { return }
        let termsandConditionsRange = (text as NSString).range(of: AppLocalizationString.termsandConditions)
        let texttap = (text as NSString).range(of: text)
        if gesture.didTapAttributedTextInLabel(label: self.privacyLabel, inRange: termsandConditionsRange) {
            self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseBASummary.rawValue)
        } else if gesture.didTapAttributedTextInLabel(label: self.privacyLabel, inRange: texttap) {
            self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseBASummary.rawValue)
        } else {
        }
    }
    
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if !(self.bookingUid.isEmpty) {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
        }
    }
    func setButtonDisable() {
        self.nextButton.isUserInteractionEnabled = false
        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.nextButton.setNeedsDisplay()
        self.nextButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.nextButton.isUserInteractionEnabled = true
        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.nextButton.setNeedsDisplay()
        self.nextButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func appliedCoupon() {
        self.commonAPICALL(retryAPIID: 1002)
    }
}

extension BookAppointmentSummaryViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension BookAppointmentSummaryViewController: ProtocolNetworkRechabilityDelegate {
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

extension BookAppointmentSummaryViewController: RazorpayPaymentCompletionProtocolWithData {
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
extension BookAppointmentSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.serviceDetailsQtyTableView {
            return self.serviceRequestsListArray.count
        } else {
            return self.priceDetailsArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.serviceDetailsQtyTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.OnlineConsultationPaymentQuantityTableViewCell, for: indexPath) as! OnlineConsultationPaymentQuantityTableViewCell
            cell.configure(serviceRequestsList: self.serviceRequestsListArray[indexPath.row], indexpath: indexPath.row)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.OnlineConsultationPaymentPriceTableViewCell, for: indexPath) as! OnlineConsultationPaymentPriceTableViewCell
            cell.configure(pricingDetail: self.priceDetailsArray[indexPath.row], indexpath: indexPath.row)
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
        if tableView == self.serviceDetailsQtyTableView {
            self.serviceDetailsQtyTableViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        } else {
            self.priceTableViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        }
    }
}
