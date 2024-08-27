//
//  CheckOutViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 07/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class CheckOutViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var cartCircleView: CartCircleView!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var selectionStackView: UIStackView!
    @IBOutlet var pincodeView: UIView!
    @IBOutlet var pincodeLabel: Caption1FontLabel!
    @IBOutlet var pincodeTextField: Caption1FontTextfield!
    @IBOutlet var checkButton: FootnoteOutlineButton!

    @IBOutlet var selectionView: UIView!
    @IBOutlet var deliveryDetailsLabel: FootnoteFontLabel!
    @IBOutlet var selectionLabel: Caption1FontLabel!
    @IBOutlet var homeButton: FootnoteOutlineButton!
    @IBOutlet var storeButton: FootnoteOutlineButton!

    @IBOutlet var homeStackView: UIStackView!
    @IBOutlet var selectHomeAddressView: UIView!
    @IBOutlet var selectHomeAddressLabel: FootnoteFontLabel!

    @IBOutlet var homeAddressTableView: UITableView!
    @IBOutlet var homeAddressTableViewHeight: NSLayoutConstraint!

    @IBOutlet var addAddressView: UIView!
    @IBOutlet var addAddressButton: FootnoteOutlineButton!

    @IBOutlet var storeStackView: UIStackView!
    @IBOutlet var selectStoreAddressView: UIView!
    @IBOutlet var selectStoreAddressLabel: FootnoteFontLabel!

    @IBOutlet var storeAddressTableView: UITableView!
    @IBOutlet var storeAddressTableViewHeight: NSLayoutConstraint!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var primaryMesageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMesageLabel: Caption1FontLabel!

    @IBOutlet var addedItemsLabel: FootnoteFontLabel!

    @IBOutlet var itemsTableView: UITableView!
    @IBOutlet var itemsTableViewHeight: NSLayoutConstraint!

    @IBOutlet var buttonView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!
    @IBOutlet var buttonViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    var checkOutViewModel = CheckOutViewModel()
    var deliveryType = ""
    var activeField = UITextField()

    var isFrom = ""

    var storeID = ""
    var addressID = ""
    var addressListArray = [AddressDatum]()
    var storeListArray = [StoreDeliveryAddressModelStoreList]()

    var pincode = ""
    var cartListArray = [OrderItem]()

    var orderID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.deliveryType == DeliveryType.home.rawValue {
            if self.addressListArray.count > 0 {
                self.homeAddressTableViewHeight.constant = self.homeAddressTableView.contentSize.height
            } else {
                self.homeAddressTableViewHeight.constant = 0
            }
        } else {
            self.homeAddressTableViewHeight.constant = 0
        }
        if self.storeListArray.count > 0 {
            self.storeAddressTableViewHeight.constant = self.storeAddressTableView.contentSize.height
        } else {
            self.storeAddressTableViewHeight.constant = 0
        }
        if (self.deliveryType == DeliveryType.home.rawValue) && (self.addressListArray.count > 0) && (self.storeListArray.count > 0) {
            self.itemsTableView.isScrollEnabled = false
            self.itemsTableViewHeight.constant = ((8 + 124 + 8) * CGFloat(self.cartListArray.count)) + 8
        } else if (self.deliveryType == DeliveryType.store.rawValue) && (self.storeListArray.count > 0) {
            self.itemsTableView.isScrollEnabled = false
            self.itemsTableViewHeight.constant = ((8 + 124 + 8) * CGFloat(self.cartListArray.count)) + 8
        } else {
            self.itemsTableViewHeight.constant = 0
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
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.nextButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.nextButton.clipsToBounds = true

        self.addAddressButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.addAddressButton.layer.borderWidth = 1.0
        self.addAddressButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.addAddressButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.addAddressButton.clipsToBounds = true

        self.homeAddressTableView.tableFooterView = UIView()
        //        self.homeAddressTableView.separatorColor = UIColor.clear
        self.homeAddressTableView.backgroundColor = UIColor.clear
        self.homeAddressTableView.rowHeight = UITableView.automaticDimension
        self.homeAddressTableView.estimatedRowHeight = UITableView.automaticDimension

        self.storeAddressTableView.tableFooterView = UIView()
        //        self.storeAddressTableView.separatorColor = UIColor.clear
        self.storeAddressTableView.backgroundColor = UIColor.clear
        self.storeAddressTableView.rowHeight = UITableView.automaticDimension
        self.storeAddressTableView.estimatedRowHeight = UITableView.automaticDimension

        self.itemsTableView.tableFooterView = UIView()
        self.itemsTableView.separatorColor = UIColor.colorLiteral.theme_white_F2F2F2
        self.itemsTableView.backgroundColor = UIColor.clear
        self.itemsTableView.rowHeight = UITableView.automaticDimension
        self.itemsTableView.estimatedRowHeight = UITableView.automaticDimension

        let view0 = self.mainStackView.arrangedSubviews[0]// selection
        let view1 = self.mainStackView.arrangedSubviews[1]// home
        let view2 = self.mainStackView.arrangedSubviews[2]// store
        let view3 = self.mainStackView.arrangedSubviews[3]// item
        let view4 = self.mainStackView.arrangedSubviews[4]// empty

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true

        self.pincodeTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.pincodeTextField.clipsToBounds = true
        self.pincodeTextField.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.pincodeTextField.layer.borderWidth = 1.0
        self.pincodeTextField.setLeftPaddingPoints(10.0)
        self.pincodeTextField.setRightPaddingPoints(60.0)
        self.pincodeTextField.delegate = self
        self.pincodeTextField.text = ""

        [self.pincodeTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        self.setUserInteractionButton()
        self.setDefaultButtonSelected(deliveryType: self.deliveryType)
        self.commonAPICALL(retryAPIID: 1000)
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
        self.cartCircleView.setupView(button1image: Asset.recordcircleblue, button2image: Asset.circlegrey, button3image: Asset.circlegrey, label1Color: UIColor.colorLiteral.theme_blue_112F70, label2Color: UIColor.colorLiteral.theme_grey_777777, label3Color: UIColor.colorLiteral.theme_grey_777777,circleViewBackgroundColor: UIColor.colorLiteral.theme_white_FFFFFF)

    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.pincodeTextField.placeholder = AppLocalizationString.enterPincode
        self.pincodeTextField.text = ""
        self.deliveryDetailsLabel.text = AppLocalizationString.deliveryDetails
        self.selectionLabel.text = AppLocalizationString.doyoupreferhomedeliveryorstorepickup
        self.homeButton.setTitle(AppLocalizationString.home.capitalized, for: .normal)
        self.storeButton.setTitle(AppLocalizationString.store.capitalized, for: .normal)
        self.selectHomeAddressLabel.text = AppLocalizationString.selectAddress
        self.addAddressButton.setTitle(AppLocalizationString.addAddress.uppercased(), for: .normal)
        self.selectStoreAddressLabel.text = AppLocalizationString.selectNearbyStore
        self.primaryMesageLabel.text = AppLocalizationString.wearecomingsoon
        self.secondaryMesageLabel.text = AppLocalizationString.ourteamisworkingtobringourservicestoyourdoorstep
        self.nextButton.setTitle(AppLocalizationString.next.uppercased(), for: .normal)
        self.pincodeLabel.text = AppLocalizationString.enteryourareapincode

    }
    // MARK: - Reload
    func reloadHomeAddressTableView() {
        self.homeAddressTableView.delegate = self
        self.homeAddressTableView.dataSource = self
        self.homeAddressTableView.reloadData()
    }
    func reloadstoreAddressTableView() {
        self.storeAddressTableView.delegate = self
        self.storeAddressTableView.dataSource = self
        self.storeAddressTableView.reloadData()
    }
    func reloadItemsTableView() {
        self.itemsTableView.delegate = self
        self.itemsTableView.dataSource = self
        self.itemsTableView.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getOrderedItems(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getZipcodeCustomerAddress(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 || retryAPIID == 1003 {
                    self.postZipcodeServiceRequestsStoreAddress(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.postCheckoutDelivery(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func postCheckoutDelivery(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.postCheckoutDelivery)\(orderID)/"
        var param = ""
        if self.deliveryType == DeliveryType.home.rawValue {
            param = String(format: "visit_type=%@&store_address_id=%@&home_address_id=%@", self.deliveryType.lowercased(), self.storeID, self.addressID)
        } else if self.deliveryType == DeliveryType.store.rawValue {
            param = String(format: "visit_type=%@&store_address_id=%@", self.deliveryType.lowercased(), self.storeID)
        }
        self.checkOutViewModel.postCheckoutDelivery(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getOrderedItems(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getOrderedItems)\(orderID)/"
        self.checkOutViewModel.getOrderedItems(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getZipcodeCustomerAddress(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getZipcodeCustomerAddress)\(self.pincodeTextField.text!.allowSpecialCharacters)/"
        self.checkOutViewModel.getZipcodeCustomerAddress(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postZipcodeServiceRequestsStoreAddress(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "zipcode=%@", self.pincodeTextField.text!.allowSpecialCharacters)
        self.checkOutViewModel.postZipcodeServiceRequestsStoreAddress(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postZipcodeServiceRequestsStoreAddress, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    // MARK: - IBAction
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.storeID = ""
        self.addressID = ""
        self.setUserInteractionButton()
        if !(self.pincodeTextField.text.isNilOrEmpty) {
            if self.pincodeTextField.text!.count == 6 {
                if self.deliveryType == DeliveryType.home.rawValue {
                    self.commonAPICALL(retryAPIID: 1003)
                } else {
                    self.commonAPICALL(retryAPIID: 1002)
                }
            } else {
                self.showToastAlert(AppLocalizationString.pleaseentervalidpincode, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            }
        } else {
            self.showToastAlert(AppLocalizationString.pleaseentervalidpincode, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 2000)
    }
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        self.deliveryType = DeliveryType.home.rawValue
        self.storeID = ""
        self.addressID = ""
        self.reloadItemsTableView()
        self.reloadHomeAddressTableView()
        self.reloadstoreAddressTableView()
        self.showhidePincode(isbuttonPress: false)
    }
    @IBAction func storeButtonPressed(_ sender: UIButton) {
        self.deliveryType = DeliveryType.store.rawValue
        self.storeID = ""
        self.addressID = ""
        self.reloadItemsTableView()
        self.reloadHomeAddressTableView()
        self.reloadstoreAddressTableView()
        self.showhidePincode(isbuttonPress: false)

    }
    @IBAction func addAddressButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.pincode = self.pincodeTextField.text ?? ""
        self.navigateToAddressonMapViewController(isFrom: IsNavigateFrom.addressCheckOut.rawValue, isEdit: false, id: "", customerName: "", mobile: "", addressType: "", address1: "", address2: "", address3: "", landmark: "", city: "", state: "", zipcode: "", lat: "", lng: "", isprimary: false)
    }

    // MARK: - Custom Methods
    func setDefaultButtonSelected(deliveryType: String) {
        DispatchQueue.main.async {
            self.homeButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
            self.homeButton.layer.borderWidth = 1.0
            self.homeButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
            self.homeButton.layer.cornerRadius = AppConstantValue.cornerRadius8
            self.homeButton.clipsToBounds = true

            self.storeButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
            self.storeButton.layer.borderWidth = 1.0
            self.storeButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
            self.storeButton.layer.cornerRadius = AppConstantValue.cornerRadius8
            self.storeButton.clipsToBounds = true

            if self.deliveryType == DeliveryType.home.rawValue {
                self.setHomeButtonSelected()
            } else if self.deliveryType == DeliveryType.store.rawValue {
                self.setstoreButtonSelected()
            }
        }
    }
    func setHomeButtonSelected() {
        DispatchQueue.main.async {
            self.homeButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            self.homeButton.layer.borderWidth = 1.0
            self.homeButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
            self.homeButton.layer.cornerRadius = AppConstantValue.cornerRadius8
            self.homeButton.clipsToBounds = true
        }
    }
    func setstoreButtonSelected() {
        DispatchQueue.main.async {
            self.storeButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            self.storeButton.layer.borderWidth = 1.0
            self.storeButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
            self.storeButton.layer.cornerRadius = AppConstantValue.cornerRadius8
            self.storeButton.clipsToBounds = true
        }
    }
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            let view3 = self.mainStackView.arrangedSubviews[3]// list
            let view4 = self.mainStackView.arrangedSubviews[4]// empty

            if (self.deliveryType == DeliveryType.store.rawValue) && !(self.storeID.isEmpty) {
                self.setButtonEnable()
                view3.isHidden = false
                view4.isHidden = false
            } else if (self.deliveryType == DeliveryType.home.rawValue) && !(self.storeID.isEmpty) && !(self.addressID.isEmpty) {
                self.setButtonEnable()
                view3.isHidden = false
                view4.isHidden = false
            } else {
                self.setButtonDisable()
                view3.isHidden = true
                view4.isHidden = true
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
    func showhidePincode(isbuttonPress: Bool) {
        let view0 = self.mainStackView.arrangedSubviews[0]// selection
        let view1 = self.mainStackView.arrangedSubviews[1]// home
        let view2 = self.mainStackView.arrangedSubviews[2]// store
        let view3 = self.mainStackView.arrangedSubviews[3]// list
        let view4 = self.mainStackView.arrangedSubviews[4]// empty

        view0.isHidden = false
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true

        let selectionview3 = self.selectionStackView.arrangedSubviews[3]// line
        let selectionview4 = self.selectionStackView.arrangedSubviews[4]// text field

        selectionview3.isHidden = isbuttonPress
        selectionview4.isHidden = isbuttonPress

        self.storeID = ""
        self.addressID = ""
        self.setUserInteractionButton()
        self.setDefaultButtonSelected(deliveryType: self.deliveryType)
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
        var maxLength = 6
        if textField == self.pincodeTextField {
            maxLength = 6
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.numericRegEx)
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
        self.showhidePincode(isbuttonPress: false)
    }

}

extension CheckOutViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension CheckOutViewController: ProtocolNetworkRechabilityDelegate {
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

extension CheckOutViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.itemsTableView {
            return self.cartListArray.count
        } else if tableView == self.homeAddressTableView {
            return self.addressListArray.count
        } else {
            return self.storeListArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.itemsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CheckOutItemTableViewCell, for: indexPath) as! CheckOutItemTableViewCell
            cell.configure(data: self.cartListArray[indexPath.row], indexpath: indexPath.row)
            return cell
        } else if tableView == self.homeAddressTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CheckoutHomeAddressTableViewCell, for: indexPath) as! CheckoutHomeAddressTableViewCell
            cell.configure(address: self.addressListArray[indexPath.row], indexpath: indexPath.row, addressID: self.addressID)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CheckoutStoreAddressTableViewCell, for: indexPath) as! CheckoutStoreAddressTableViewCell
            cell.configure(storeDeliveryAddressModelStoreList: self.storeListArray[indexPath.row], indexpath: indexPath.row, storeID: self.storeID)
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == self.itemsTableView && self.cartListArray.count > 0 {
            self.itemsTableViewHeight.constant = tableView.contentSize.height
        } else if tableView == self.homeAddressTableView && self.addressListArray.count > 0 {
            self.homeAddressTableViewHeight.constant = tableView.contentSize.height
        } else if tableView == self.storeAddressTableView && self.storeListArray.count > 0 {
            self.storeAddressTableViewHeight.constant = tableView.contentSize.height
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension CheckOutViewController: ProtocolCheckoutStoreAddressTableViewCell, ProtocolCheckoutHomeAddressTableViewCell {
    func selectButtonPressedCheckoutHomeAddressTableViewCell(senderTag: Int) {
        if self.addressListArray.count > 0 {
            if self.addressListArray[senderTag].id != nil {
                self.addressID = String(format: "%d", self.addressListArray[senderTag].id!)
                self.reloadHomeAddressTableView()
                self.setUserInteractionButton()
            }
        }
    }
    func selectButtonPressedCheckoutStoreAddressTableViewCell(senderTag: Int) {
        if self.storeListArray.count > 0 {
            if self.storeListArray[senderTag].store != nil {
                if self.storeListArray[senderTag].store!.id != nil {
                    self.storeID = String(format: "%d", self.storeListArray[senderTag].store!.id!)
                    self.reloadstoreAddressTableView()
                    self.setUserInteractionButton()
                }
            }
        }
    }
}
