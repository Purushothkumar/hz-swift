//
//  ServiceCouponListViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 30/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ServiceCouponListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: LogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var imageCardView: UIView!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var couponOfferView: UIView!

    @IBOutlet var couponOfferStackView: UIStackView!
    @IBOutlet var couponTitleLabel: Title2FontLabel!
    @IBOutlet var couponDescriptionLabel: FootnoteFontLabel!

    @IBOutlet var couponStackView: UIStackView!

    @IBOutlet var couponTextField: Caption1FontTextfield!
    @IBOutlet var applyButton: FootnoteBackgroundButton!

    @IBOutlet var orLabel: Caption1FontLabel!

    @IBOutlet var selectCouponLabel: Caption1FontLabel!

    @IBOutlet var couponView: UIView!
    @IBOutlet var couponTableviewHeight: NSLayoutConstraint!
    @IBOutlet var couponTableview: UITableView!

    @IBOutlet var listView: UIView!
    @IBOutlet var tableviewHeight: NSLayoutConstraint!
    @IBOutlet var tableview: UITableView!

    // MARK: - Lets and Var
    let serviceCouponListViewModel = ServiceCouponListViewModel()
    var isFrom = ""
    var bookingUid = ""
    var activeField = UITextField()

    var couponOfferedFor = ""
    var couponStepArray = [ServiceStep]()
    var listArray = [ServiceCouponListModelCustomerCoupon]()

    var serviceType = ""
    var serviceName = ""
    var serviceDesc = ""
    var servicePosterPhoto = ""
    var serviceMarketingVideoLink = ""

    var couponCode = ""

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
        if self.couponStepArray.count > 0 {
            self.tableviewHeight.constant = self.tableview.contentSize.height
        } else {
            self.tableviewHeight.constant = 0
        }
        if self.listArray.count > 0 {
            self.couponTableviewHeight.constant = self.couponTableview.contentSize.height
        } else {
            self.couponTableviewHeight.constant = 0
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
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor =  UIColor.colorLiteral.theme_white_FFFFFF
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension

        self.couponTableview.tableFooterView = UIView()
        self.couponTableview.separatorColor = UIColor.clear
        self.couponTableview.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.couponTableview.rowHeight = UITableView.automaticDimension
        self.couponTableview.estimatedRowHeight = UITableView.automaticDimension

        self.couponTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.couponTextField.clipsToBounds = true
        self.couponTextField.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.couponTextField.layer.borderWidth = 1.0
        self.couponTextField.setLeftPaddingPoints(10.0)
        self.couponTextField.setRightPaddingPoints(10.0)
        [self.couponTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        self.setUserInteractionButton()
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBar.isLogoHidden = false
        self.navigationBar.logoImage = Asset.hzlogo
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.couponTitleLabel.text = serviceName.capitalized
        self.couponDescriptionLabel.text = serviceDesc.capitalized
        self.bannerImageView.setImage(imageUrl: servicePosterPhoto, placeHolderImage: hearzapPlaceholder)
        self.orLabel.text = AppLocalizationString.or
        self.couponTextField.placeholder = AppLocalizationString.enterCouponCode
        self.selectCouponLabel.text = AppLocalizationString.selectthecoupons
        self.applyButton.setTitle(AppLocalizationString.apply.uppercased(), for: .normal)
    }
    // MARK: - Reload
    func reloadTableview() {
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
    }
    func reloadCouponTableview() {
        self.couponTableview.delegate = self
        self.couponTableview.dataSource = self
        self.couponTableview.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getCouponList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.applyCoupon(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCouponList(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getCouponList)\(self.couponOfferedFor)/"
        self.serviceCouponListViewModel.getCouponList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func applyCoupon(retryAPIID: Int, canShowLoader: Bool) {
        var url = ""
        var param = ""

        if self.couponOfferedFor == CouponOfferedFor.booking.rawValue {
            url = "\(SubAPIUrl.applyBookingCoupon)\(self.bookingUid)/apply/"
            param = String(format: "coupon_code=%@", self.couponCode)
        } else {
            //            url = "\(SubAPIUrl.applyShoppingCoupon)\(self.bookingUid)/apply/"
            //            param = String(format: "coupon_code=%@", self.couponCode)
            url = "\(SubAPIUrl.applyShoppingCoupon)"
            param = String(format: "order_id=%@&coupon_code=%@&mode=apply", self.bookingUid, self.couponCode)
        }
        self.serviceCouponListViewModel.applyCoupon(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    // MARK: - IBAction
    @IBAction func applyButtonPressed(_ sender: UIButton) {
        self.couponCode = self.couponTextField.text!.allowSpecialCharacters
        if !(self.couponCode.isEmpty) {
            self.commonAPICALL(retryAPIID: 1001)
        }
    }

    // MARK: - Custom Methods
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if self.couponTextField.text.isNilOrEmpty {
                self.setButtonDisable()
            } else {
                self.setButtonEnable()
            }
        }
    }
    func setButtonDisable() {
        self.applyButton.isUserInteractionEnabled = false
        self.applyButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.applyButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.applyButton.setNeedsDisplay()
        self.applyButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.applyButton.isUserInteractionEnabled = true
        self.applyButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.applyButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.applyButton.setNeedsDisplay()
        self.applyButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    // MARK: - TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeField.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && (string == " ") {
            return false
        }
        var maxLength = 255
        if textField == self.couponTextField {
            maxLength = 10
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.alphaNumericRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    @objc func editingChanged(_ textField: UITextField) {
        self.setUserInteractionButton()
    }
}

extension ServiceCouponListViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension ServiceCouponListViewController: ProtocolNetworkRechabilityDelegate {
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
extension ServiceCouponListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableview {
            if self.couponStepArray.count > 0 {
                return 2
            }
        } else {
            if self.listArray.count > 0 {
                return 1
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableview {
            if self.couponStepArray.count > 0 {
                if section == 0 {
                    return 1
                } else {
                    return self.couponStepArray.count
                }
            }
        } else {
            return self.listArray.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableview {
            if self.couponStepArray.count > 0 {
                if indexPath.section == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ServiceCouponListTitleTableViewCell, for: indexPath) as! ServiceCouponListTitleTableViewCell
                    cell.titleLabel.text = AppLocalizationString.howtouse
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ServiceCouponListContentTableViewCell, for: indexPath) as! ServiceCouponListContentTableViewCell
                    cell.configure(serviceStep: self.couponStepArray[indexPath.row], indexpath: indexPath.row)
                    return cell
                }
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ServiceCouponListTableViewCell, for: indexPath) as! ServiceCouponListTableViewCell
            cell.configure(customerCoupon: listArray[indexPath.row], indexpath: indexPath.row)
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ServiceCouponListTableViewCell, for: indexPath) as! ServiceCouponListTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == self.tableview {
            self.tableviewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        } else {
            self.couponTableviewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        }
    }
}
extension ServiceCouponListViewController: ProtocolServiceCouponListTableViewCell {
    func tapButtonPressedServiceCouponListTableViewCell(senderTag: Int) {
        if self.listArray.count > 0 {
            if !(self.listArray[senderTag].couponCode.isNilOrEmpty) {
                self.couponCode = ""
                self.couponCode = self.listArray[senderTag].couponCode!
                self.commonAPICALL(retryAPIID: 1001)
            }
        }
    }
}
