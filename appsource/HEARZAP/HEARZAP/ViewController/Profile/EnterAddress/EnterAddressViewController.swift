//
//  EnterAddressViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import GoogleMaps
import IQKeyboardManagerSwift

class EnterAddressViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var gmsmapview: GMSMapView!

    @IBOutlet var contactDetailsTitleLabel: Caption1FontLabel!

    @IBOutlet var nameLabel: Caption1FontLabel!
    @IBOutlet var nameTextfield: Caption1FontTextfield!

    @IBOutlet var mobileNumberLabel: Caption1FontLabel!
    @IBOutlet var mobileNumberTextfield: Caption1FontTextfield!

    @IBOutlet var addressTitleLabel: Caption1FontLabel!

    @IBOutlet var pincodeLabel: Caption1FontLabel!
    @IBOutlet var pincodeTextfield: Caption1FontTextfield!

    @IBOutlet var housenoLabel: Caption1FontLabel!
    @IBOutlet var housenoTextfield: Caption1FontTextfield!

    @IBOutlet var addressLabel: Caption1FontLabel!
    @IBOutlet var addressTextfield: Caption1FontTextfield!

    @IBOutlet var landmarkLabel: Caption1FontLabel!
    @IBOutlet var landmarkTextfield: Caption1FontTextfield!

    @IBOutlet var cityLabel: Caption1FontLabel!
    @IBOutlet var cityTextfield: Caption1FontTextfield!

    @IBOutlet var stateLabel: Caption1FontLabel!
    @IBOutlet var stateTextfield: Caption1FontTextfield!

    @IBOutlet var addressTypeLabel: Caption1FontLabel!
    @IBOutlet var homeButton: FootnoteOutlineButton!
    @IBOutlet var officeButton: FootnoteOutlineButton!
    @IBOutlet var otherButton: FootnoteOutlineButton!

    @IBOutlet var defaultAddressLabel: Caption1FontLabel!
    @IBOutlet var defaultButton: UISwitch!

    @IBOutlet var addAddressButton: CalloutBackgroundButton!

    // MARK: - Lets and Var
    var enterAddressViewModel = EnterAddressViewModel()

    var isFrom = ""
    var addressID = ""
    var isEdit = false

    var id = ""
    var customerName = ""
    var mobile = ""
    var addressType = ""
    var address1 = "" // street
    var address2 = "" // area
    var address3 = ""
    var landmark = ""
    var city = "" // city
    var state = "" // state
    var zipcode = "" // pincode
    var lat = ""
    var lng = ""
    var isprimary = false

    var activeField = UITextField()

    let marker = GMSMarker()
    let geocoder = GMSGeocoder()
    var locationManager = CLLocationManager()

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
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        self.nameTextfield.text = ""
        self.mobileNumberTextfield.text = ""
        self.pincodeTextfield.text = ""
        self.housenoTextfield.text = ""
        self.addressTextfield.text = ""
        self.landmarkTextfield.text = ""
        self.cityTextfield.text = ""
        self.stateTextfield.text = ""

        self.nameTextfield.setLeftPaddingPoints(5.0)
        self.nameTextfield.setRightPaddingPoints(5.0)

        self.mobileNumberTextfield.setLeftPaddingPoints(5.0)
        self.mobileNumberTextfield.setRightPaddingPoints(5.0)

        self.housenoTextfield.setLeftPaddingPoints(5.0)
        self.housenoTextfield.setRightPaddingPoints(5.0)

        self.pincodeTextfield.setLeftPaddingPoints(5.0)
        self.pincodeTextfield.setRightPaddingPoints(5.0)

        self.addressTextfield.setLeftPaddingPoints(5.0)
        self.addressTextfield.setRightPaddingPoints(5.0)

        self.landmarkTextfield.setLeftPaddingPoints(5.0)
        self.landmarkTextfield.setRightPaddingPoints(5.0)

        self.cityTextfield.setLeftPaddingPoints(5.0)
        self.cityTextfield.setRightPaddingPoints(5.0)

        self.stateTextfield.setLeftPaddingPoints(5.0)
        self.stateTextfield.setRightPaddingPoints(5.0)

        [self.nameTextfield, self.mobileNumberTextfield, self.housenoTextfield, self.pincodeTextfield, self.addressTextfield, self.landmarkTextfield, self.cityTextfield, self.stateTextfield].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })

        self.nameTextfield.delegate = self
        self.mobileNumberTextfield.delegate = self
        self.housenoTextfield.delegate = self
        self.pincodeTextfield.delegate = self
        self.addressTextfield.delegate = self
        self.landmarkTextfield.delegate = self
        self.cityTextfield.delegate = self
        self.stateTextfield.delegate = self

        self.defaultButton.isOn = self.isprimary
        self.setDefaultButtonColor()
        self.cityTextfield.isUserInteractionEnabled = false
        self.stateTextfield.isUserInteractionEnabled = false

        if !(self.customerName.isEmpty) {
            self.nameTextfield.text = self.customerName
        }
        if !(self.mobile.isEmpty) {
            self.mobileNumberTextfield.text = self.mobile.removePrefix("+91")
        }
        if !(self.zipcode.isEmpty) {
            self.pincodeTextfield.text = self.zipcode
        }
        if !(self.address1.isEmpty) {
            self.housenoTextfield.text = self.address1
        }
        if !(self.address2.isEmpty) {
            self.addressTextfield.text = self.address2
        }
        if !(self.landmark.isEmpty) {
            self.landmarkTextfield.text = self.landmark
        }
        if !(self.city.isEmpty) {
            self.cityTextfield.text = self.city
        }
        if !(self.state.isEmpty) {
            self.stateTextfield.text = self.state
        }
        if self.stateTextfield.text.isNilOrEmpty {
            self.stateTextfield.isUserInteractionEnabled = true
            self.stateTextfield.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        }
        if self.cityTextfield.text.isNilOrEmpty {
            self.cityTextfield.isUserInteractionEnabled = true
            self.cityTextfield.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        }
        if self.pincodeTextfield.text.isNilOrEmpty {
            self.pincodeTextfield.isUserInteractionEnabled = true
            self.pincodeTextfield.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        }

        if !(self.lat.isEmpty) && !(self.lng.isEmpty) {
            let camera = GMSCameraPosition.camera(withLatitude: Double(self.lat)!, longitude: Double(self.lng)!, zoom: 16)
            //            self.gmsmapview.delegate = self
            self.gmsmapview.camera = camera
            self.gmsmapview?.animate(to: camera)

            self.marker.position = camera.target
            self.marker.title = ""
            self.marker.snippet = ""
            self.marker.map = self.gmsmapview
            self.marker.icon = UIImage(named: Asset.locationmarkerred)
        } else {
            self.gmsmapview.isHidden = true
        }
        self.setUserInteractionButton()

    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.enterCompleteAddress
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.contactDetailsTitleLabel.text = AppLocalizationString.contactDetails.uppercased()
        self.nameLabel.setStarAttributtedText(textmessage: AppLocalizationString.namestar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.nameTextfield.placeholder = AppLocalizationString.pleaseenterthename
        self.mobileNumberLabel.setStarAttributtedText(textmessage: AppLocalizationString.mobileNumberstar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.mobileNumberTextfield.placeholder = AppLocalizationString.pleaseEnterYourMobileNumber
        self.addressTitleLabel.text = AppLocalizationString.address.uppercased()
        self.pincodeLabel.setStarAttributtedText(textmessage: AppLocalizationString.pincodestar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.mobileNumberTextfield.placeholder = AppLocalizationString.pleaseEnterYourMobileNumber
        self.pincodeTextfield.placeholder = AppLocalizationString.enterPincode
        self.housenoLabel.setStarAttributtedText(textmessage: AppLocalizationString.housenumberorbuildingnamestar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.housenoTextfield.placeholder = AppLocalizationString.pleaseenterhousenumberorbuildingname
        self.addressLabel.setStarAttributtedText(textmessage: AppLocalizationString.addressTitle, color: UIColor.colorLiteral.theme_red_FF6961)
        self.addressTextfield.placeholder = AppLocalizationString.pleaseenteraddress
        self.landmarkLabel.setStarAttributtedText(textmessage: AppLocalizationString.landmark, color: UIColor.colorLiteral.theme_red_FF6961)
        self.landmarkTextfield.placeholder = AppLocalizationString.pleaseenterlandmark
        self.cityLabel.setStarAttributtedText(textmessage: AppLocalizationString.cityslashdistrictstar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.cityTextfield.placeholder = ""
        self.stateLabel.setStarAttributtedText(textmessage: AppLocalizationString.statestar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.stateTextfield.placeholder = ""
        self.addressTypeLabel.text = AppLocalizationString.saveaddressas
        self.homeButton.setTitle("\(AddressType.home.rawValue)", for: .normal)
        self.officeButton.setTitle("\(AddressType.work.rawValue)", for: .normal)
        self.otherButton.setTitle("\(AddressType.others.rawValue)", for: .normal)

        self.defaultAddressLabel.text = AppLocalizationString.makethismydefaultaddress
        self.addAddressButton.setTitle(AppLocalizationString.saveAddress.uppercased(), for: .normal)
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.saveCustomerAddress(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func saveCustomerAddress(retryAPIID: Int, canShowLoader: Bool) {
        var param = ""
        customerName = self.nameTextfield.text?.allowSpecialCharacters ?? ""
        mobile = self.mobileNumberTextfield.text?.checkPlus91Character.allowSpecialCharacters ?? ""
        address1 = self.housenoTextfield.text?.allowSpecialCharacters ?? ""
        address2 = self.addressTextfield.text?.allowSpecialCharacters ?? ""
        address3 = ""
        landmark = self.landmarkTextfield.text?.allowSpecialCharacters ?? ""
        city = self.cityTextfield.text?.allowSpecialCharacters ?? ""
        state = self.stateTextfield.text?.allowSpecialCharacters ?? ""
        zipcode = self.pincodeTextfield.text?.allowSpecialCharacters ?? ""

        if self.isEdit == false {
            param = String(format: "customer_name=%@&mobile=%@&address_type=%@&is_primary=%@&address_1=%@&address_2=%@&address_3=%@&landmark=%@&city=%@&state=%@&zipcode=%@&lat=%@&lng=%@", customerName, mobile, addressType, isprimary == true ? "true" : "false", address1, address2, address3, landmark, city, state, zipcode, lat, lng)
        } else {
            param = String(format: "id=%@&customer_name=%@&mobile=%@&address_type=%@&is_primary=%@&address_1=%@&address_2=%@&address_3=%@&landmark=%@&city=%@&state=%@&zipcode=%@&lat=%@&lng=%@", id, customerName, mobile, addressType, isprimary == true ? "true" : "false", address1, address2, address3, landmark, city, state, zipcode, lat, lng)
        }
        self.enterAddressViewModel.saveCustomerAddress(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.saveCustomerAddress, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func addAddressButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    @IBAction func addressTypeButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            self.addressType = AddressType.home.rawValue
        } else if sender.tag == 1 {
            self.addressType = AddressType.work.rawValue
        } else if sender.tag == 2 {
            self.addressType = AddressType.others.rawValue
        }
        self.setDefaultButtonColor()
    }
    @IBAction func defaultButtonPressed(_ sender: UISwitch) {
        self.isprimary = !self.isprimary
        sender.isOn = self.isprimary
    }

    // MARK: - Custom Methods
    func setDefaultButtonColor() {
        self.homeButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.homeButton.layer.borderWidth = 1.0
        self.homeButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.homeButton.clipsToBounds = true
        self.homeButton.layer.cornerRadius = AppConstantValue.cornerRadius4

        self.officeButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.officeButton.layer.borderWidth = 1.0
        self.officeButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.officeButton.clipsToBounds = true
        self.officeButton.layer.cornerRadius = AppConstantValue.cornerRadius4

        self.otherButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.otherButton.layer.borderWidth = 1.0
        self.otherButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.otherButton.clipsToBounds = true
        self.otherButton.layer.cornerRadius = AppConstantValue.cornerRadius4

        if self.addressType == AddressType.home.rawValue {
            self.setHomeButtonColor()
        } else if self.addressType == AddressType.work.rawValue {
            self.setOfficeButtonColor()
        } else if self.addressType == AddressType.others.rawValue {
            self.setOthersButtonColor()
        }
    }
    func setHomeButtonColor() {
        self.homeButton.setTitle("   \(AddressType.home.rawValue)   ", for: .normal)
        self.homeButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.homeButton.layer.borderWidth = 1.0
        self.homeButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.homeButton.clipsToBounds = true
        self.homeButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.addressType = AddressType.home.rawValue
        self.setUserInteractionButton()
    }
    func setOfficeButtonColor() {
        self.officeButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.officeButton.layer.borderWidth = 1.0
        self.officeButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.officeButton.clipsToBounds = true
        self.officeButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.addressType = AddressType.work.rawValue
        self.setUserInteractionButton()
    }
    func setOthersButtonColor() {
        self.otherButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.otherButton.layer.borderWidth = 1.0
        self.otherButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.otherButton.clipsToBounds = true
        self.otherButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.addressType = AddressType.others.rawValue
        self.setUserInteractionButton()
    }
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if self.nameTextfield.text.isNilOrEmpty || self.mobileNumberTextfield.text.isNilOrEmpty || self.pincodeTextfield.text.isNilOrEmpty || self.housenoTextfield.text.isNilOrEmpty || self.addressTextfield.text.isNilOrEmpty || self.cityTextfield.text.isNilOrEmpty || self.stateTextfield.text.isNilOrEmpty || self.mobileNumberTextfield.text!.count < 10 || self.addressType.isEmpty || self.pincodeTextfield.text!.count < 6 {
                self.setButtonDisable()
            } else {
                self.setButtonEnable()
            }
        }
    }
    func setButtonDisable() {
        self.addAddressButton.isUserInteractionEnabled = false
        self.addAddressButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.addAddressButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.addAddressButton.setNeedsDisplay()
        self.addAddressButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.addAddressButton.isUserInteractionEnabled = true
        self.addAddressButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.addAddressButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.addAddressButton.setNeedsDisplay()
        self.addAddressButton.layoutIfNeeded()
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
        if textField == self.addressTextfield ||  textField == self.housenoTextfield || textField == self.cityTextfield || textField == self.stateTextfield {
            maxLength = 255
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.alphaNumericSymbolRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        } else if textField == self.landmarkTextfield {
            maxLength = 128
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.alphaNumericSymbolRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        } else if textField == self.mobileNumberTextfield {
            maxLength = 10
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.numericRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        } else if textField == self.nameTextfield {
            maxLength = 50
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.nameRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        } else if textField == self.pincodeTextfield {
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
        self.setUserInteractionButton()
    }
}

extension EnterAddressViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.addresslist.rawValue {
            self.navigateBackToAddressListViewControllerUpdated()
        } else if self.isFrom == IsNavigateFrom.addressCheckOut.rawValue {
            self.navigateBackToCheckOutViewControllerFromAddress()
        } else if self.isFrom == IsNavigateFrom.addressBookAppointment.rawValue {
            self.navigateBackToBookAppointmentAddressViewControllerFromAddress()
        } else {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        }
    }
    func rightButtonPressed() {
    }
}
extension EnterAddressViewController: ProtocolNetworkRechabilityDelegate {
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
