//
//  AddRegisterDeviceViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 23/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift

class AddRegisterDeviceViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!

    @IBOutlet var deviceDetailsStackView: UIStackView!
    @IBOutlet var deviceDetailsLabel: Caption1FontLabel!

    @IBOutlet var userNameLabel: Caption1FontLabel!
    @IBOutlet var userNameTextField: Caption1FontTextfield!
    @IBOutlet var userNameButton: CalloutOutlineButton!

    @IBOutlet var deviceNameLabel: Caption1FontLabel!
    @IBOutlet var deviceNameTextField: Caption1FontTextfield!
    @IBOutlet var deviceNameLabelHint: Caption2FontLabel!

    @IBOutlet var brandLabel: Caption1FontLabel!
    @IBOutlet var brandTextField: Caption1FontTextfield!
    @IBOutlet var brandLabelhint: Caption2FontLabel!
    @IBOutlet var brandButton: CalloutOutlineButton!

    @IBOutlet var modelLabel: Caption1FontLabel!
    @IBOutlet var modelTextField: Caption1FontTextfield!
    @IBOutlet var modelLabelhint: Caption2FontLabel!

    @IBOutlet var serialNumberLabel: Caption1FontLabel!
    @IBOutlet var serialNumberTextField: Caption1FontTextfield!
    @IBOutlet var serialNumberLabelhint: Caption2FontLabel!

    @IBOutlet var earPreferenceLabel: Caption1FontLabel!
    @IBOutlet var earPreferenceTextField: Caption1FontTextfield!
    @IBOutlet var earPreferenceLabelhint: Caption2FontLabel!
    @IBOutlet var earPreferenceButton: CalloutOutlineButton!

    @IBOutlet var otherDetailsStackView: UIStackView!
    @IBOutlet var otherDetailsOwnerLabel: Caption1FontLabel!

    @IBOutlet var purchasedFromLabel: Caption1FontLabel!
    @IBOutlet var purchasedFromTextField: Caption1FontTextfield!
    @IBOutlet var purchasedFromButton: CalloutOutlineButton!

    @IBOutlet var purchasedOnLabel: Caption1FontLabel!
    @IBOutlet var purchasedOnTextField: Caption1FontTextfield!

    @IBOutlet var warrentyExpiresLabel: Caption1FontLabel!
    @IBOutlet var warrentyExpiresTextField: Caption1FontTextfield!
    @IBOutlet var warrentyExpiresLabelhint: Caption2FontLabel!

    @IBOutlet var extendedWarrentyExpiresLabel: Caption1FontLabel!
    @IBOutlet var extendedWarrentyExpiresTextField: Caption1FontTextfield!
    @IBOutlet var extendedWarrentyExpiresLabelhint: Caption2FontLabel!

    @IBOutlet var warrentyDetailsLabel: Caption1FontLabel!
    @IBOutlet var warrentyDetailsTextField: Caption1FontTextfield!
    @IBOutlet var warrentyDetailsButton: CalloutOutlineButton!

    @IBOutlet var nextServiceDateLabel: Caption1FontLabel!
    @IBOutlet var nextServiceDateTextField: Caption1FontTextfield!

    @IBOutlet var lastServiceDateLabel: Caption1FontLabel!
    @IBOutlet var lastServiceDateTextField: Caption1FontTextfield!

    @IBOutlet var remarkLabel: Caption1FontLabel!
    @IBOutlet var remarkTextField: Caption1FontTextfield!

    @IBOutlet var saveButton: FootnoteBackgroundButton!

    // MARK: - Lets and Var
    var addRegisterDeviceViewModel = AddRegisterDeviceViewModel()
    var activeField = UITextField()

    var isEdit = false
    var isFrom = ""

    var id = ""
    var orderRef = ""
    var deviceUserName = ""
    var deviceUserUID = ""
    var deviceName = ""
    var deviceBrand = ""
    var deviceBrandUID = ""
    var deviceModel = ""
    var deviceSerialNumber = ""
    var deviceEarPreference = ""
    var deviceEarPreferenceValue = ""
    var devicePurchasedOn = ""
    var devicePurchasedFrom = ""
    var devicePurchasedFromValue = ""
    var deviceWarrantyExpiresOn = ""
    var deviceExtendedWarrantyEndOn = ""
    var deviceNextServiceDate = ""
    var deviceLastServiceDate = ""
    var deviceWarrantyDetails = ""
    var deviceWarrantyDetailsValue = ""
    var deviceRemark = ""

    let devicePurchasedOnDatePicker = UIDatePicker()
    let devicePurchasedOnDateFormatter = DateFormatter()

    let deviceWarrantyExpiresOnDatePicker = UIDatePicker()
    let deviceWarrantyExpiresOnDateFormatter = DateFormatter()

    let deviceExtendedeWarrantyExpiresOnDatePicker = UIDatePicker()
    let deviceExtendedWarrantyExpiresOnDateFormatter = DateFormatter()

    let deviceNextServiceDatePicker = UIDatePicker()
    let deviceNextServiceDateDateFormatter = DateFormatter()

    let deviceLastServiceDateDatePicker = UIDatePicker()
    let deviceLastServiceDateDateFormatter = DateFormatter()

    var patientList = [String]()
    var brandList = [String]()
    var warrantyList = [String]()
    var earPreferenceList = [String]()
    var purchasedFromList = [String]()

    var patientSlugList = [String]()
    var brandSlugList = [String]()
    var warrantySlugList = [String]()
    var earPreferenceSlugList = [String]()
    var purchasedFromSlugList = [String]()

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
        
        self.userNameTextField.setLeftPaddingPoints(5)
        self.userNameTextField.setRightPaddingPoints(30)

        self.deviceNameTextField.setLeftPaddingPoints(5)
        self.deviceNameTextField.setRightPaddingPoints(5)

        self.brandTextField.setLeftPaddingPoints(5)
        self.brandTextField.setRightPaddingPoints(30)

        self.modelTextField.setLeftPaddingPoints(5)
        self.modelTextField.setRightPaddingPoints(5)

        self.serialNumberTextField.setLeftPaddingPoints(5)
        self.serialNumberTextField.setRightPaddingPoints(5)

        self.earPreferenceTextField.setLeftPaddingPoints(5)
        self.earPreferenceTextField.setRightPaddingPoints(30)

        self.purchasedOnTextField.setLeftPaddingPoints(5)
        self.purchasedOnTextField.setRightPaddingPoints(30)

        self.purchasedFromTextField.setLeftPaddingPoints(5)
        self.purchasedFromTextField.setRightPaddingPoints(30)

        self.warrentyExpiresTextField.setLeftPaddingPoints(5)
        self.warrentyExpiresTextField.setRightPaddingPoints(30)

        self.extendedWarrentyExpiresTextField.setLeftPaddingPoints(5)
        self.extendedWarrentyExpiresTextField.setRightPaddingPoints(30)

        self.warrentyDetailsTextField.setLeftPaddingPoints(5)
        self.warrentyDetailsTextField.setRightPaddingPoints(30)

        self.lastServiceDateTextField.setLeftPaddingPoints(5)
        self.lastServiceDateTextField.setRightPaddingPoints(30)

        self.nextServiceDateTextField.setLeftPaddingPoints(5)
        self.nextServiceDateTextField.setRightPaddingPoints(30)

        var components = DateComponents()
        components.year = -100
        devicePurchasedOnDatePicker.datePickerMode = .date
        devicePurchasedOnDatePicker.maximumDate = Date()
        devicePurchasedOnDatePicker.minimumDate = Calendar.current.date(byAdding: components, to: Date())
        purchasedOnTextField.inputView = devicePurchasedOnDatePicker
        devicePurchasedOnDatePicker.addTarget(self, action: #selector(fnGoToDoneDatePicker), for: .valueChanged)

        deviceWarrantyExpiresOnDatePicker.datePickerMode = .date
        //        deviceWarrantyExpiresOnDatePicker.minimumDate = Date()
        warrentyExpiresTextField.inputView = deviceWarrantyExpiresOnDatePicker
        deviceWarrantyExpiresOnDatePicker.addTarget(self, action: #selector(fnGoToDoneWarantyDatePicker), for: .valueChanged)

        deviceExtendedeWarrantyExpiresOnDatePicker.datePickerMode = .date
        //        deviceWarrantyExpiresOnDatePicker.minimumDate = Date()
        extendedWarrentyExpiresTextField.inputView = deviceExtendedeWarrantyExpiresOnDatePicker
        deviceExtendedeWarrantyExpiresOnDatePicker.addTarget(self, action: #selector(fnGoToDoneExtendedWarantyDatePicker), for: .valueChanged)

        deviceNextServiceDatePicker.datePickerMode = .date
        //        deviceNextServiceDatePicker.minimumDate = Date()
        nextServiceDateTextField.inputView = deviceNextServiceDatePicker
        deviceNextServiceDatePicker.addTarget(self, action: #selector(fnGoToDoneNextServiceDatePicker), for: .valueChanged)

        deviceLastServiceDateDatePicker.datePickerMode = .date
        //        deviceLastServiceDateDatePicker.maximumDate = Date()
        lastServiceDateTextField.inputView = deviceLastServiceDateDatePicker
        deviceLastServiceDateDatePicker.addTarget(self, action: #selector(fnGoToDoneLastServiceDatePicker), for: .valueChanged)
        self.updateUI()
        self.commonAPICALL(retryAPIID: 1001)

    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = self.isEdit == false ? AppLocalizationString.addadevice.capitalized : AppLocalizationString.saveDevice.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.saveButton.setTitle(self.isEdit == false ? AppLocalizationString.addDevice.uppercased() : AppLocalizationString.saveDevice.uppercased(), for: .normal)
        self.deviceDetailsLabel.text = AppLocalizationString.deviceDetails.uppercased()
        self.deviceNameLabel.setStarAttributtedText(textmessage: AppLocalizationString.deviceNameStar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.userNameLabel.setStarAttributtedText(textmessage: AppLocalizationString.deviceUserstar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.deviceNameLabelHint.text = AppLocalizationString.deviceNameHint
        self.brandLabel.setStarAttributtedText(textmessage: AppLocalizationString.deviceBrandstar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.brandLabelhint.text = AppLocalizationString.deviceBrandHint
        self.modelLabel.setStarAttributtedText(textmessage: AppLocalizationString.deviceModelstar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.modelLabelhint.text = AppLocalizationString.deviceModelHint
        //        self.serialNumberLabel.setStarAttributtedText(textmessage: AppLocalizationString.serialNumberStar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.serialNumberLabel.text = AppLocalizationString.serialNumber
        self.serialNumberLabelhint.text = AppLocalizationString.serialNumberhint
        self.earPreferenceLabel.setStarAttributtedText(textmessage: AppLocalizationString.earPreferncesstar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.earPreferenceLabelhint.text = AppLocalizationString.earPreferncesHint
        self.otherDetailsOwnerLabel.text = AppLocalizationString.otherDetails.uppercased()
        self.purchasedOnLabel.text = AppLocalizationString.purchasedOn
        self.purchasedFromLabel.setStarAttributtedText(textmessage: AppLocalizationString.purchasedFromStar, color: UIColor.colorLiteral.theme_red_FF6961)
        //        self.purchasedFromLabel.text = AppLocalizationString.purchasedFrom
        self.warrentyExpiresLabel.text = AppLocalizationString.warrantyExpireson
        self.extendedWarrentyExpiresLabel.text = AppLocalizationString.exWarrantyExpireson
        self.warrentyDetailsLabel.text = AppLocalizationString.warrantyDetails
        self.nextServiceDateLabel.text = AppLocalizationString.nextServiceDate
        self.lastServiceDateLabel.text = AppLocalizationString.lastServiceDate
        self.warrentyExpiresLabelhint.text = AppLocalizationString.warrantyExpiresonHint
        self.extendedWarrentyExpiresLabelhint.text = AppLocalizationString.exWarrantyExpiresHint
        self.remarkLabel.text = AppLocalizationString.remarks
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.postCustomerDeviceList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getCustomerDeviceDropdownList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCustomerDeviceDropdownList(retryAPIID: Int, canShowLoader: Bool) {
        self.addRegisterDeviceViewModel.getCustomerDeviceDropdownList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCustomerDeviceDropdownList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postCustomerDeviceList(retryAPIID: Int, canShowLoader: Bool) {
        var param = ""
        if isEdit == true {
            param = String(format: "id=%@&order_ref=%@&device_user=%@&device_name=%@&device_brand=%@&device_model=%@&device_serial_number=%@&device_ear_preference=%@&device_purchased_on=%@&device_purchased_from=%@&device_warranty_details=%@&device_next_service_date=%@&device_last_service_date=%@&device_warranty_expires_on=%@&device_extended_warranty_end_on=%@&remarks=%@", self.id, self.orderRef, self.deviceUserUID, self.deviceNameTextField.text!.allowSpecialCharacters, self.deviceBrandUID, self.modelTextField.text!.allowSpecialCharacters, self.serialNumberTextField.text!.allowSpecialCharacters, self.deviceEarPreference, self.purchasedOnTextField.text!.allowSpecialCharacters, self.devicePurchasedFrom, self.deviceWarrantyDetails, self.nextServiceDateTextField.text!.allowSpecialCharacters, self.lastServiceDateTextField.text!.allowSpecialCharacters, self.warrentyExpiresTextField.text!.allowSpecialCharacters, self.extendedWarrentyExpiresTextField.text!.allowSpecialCharacters, self.remarkTextField.text!.allowSpecialCharacters)
        } else {
            param = String(format: "device_user=%@&device_name=%@&device_brand=%@&device_model=%@&device_serial_number=%@&device_ear_preference=%@&device_purchased_on=%@&device_purchased_from=%@&device_warranty_details=%@&device_next_service_date=%@&device_last_service_date=%@&device_warranty_expires_on=%@&device_extended_warranty_end_on=%@&remarks=%@", self.deviceUserUID, self.deviceNameTextField.text!.allowSpecialCharacters, self.deviceBrandUID, self.modelTextField.text!.allowSpecialCharacters, self.serialNumberTextField.text!.allowSpecialCharacters, self.deviceEarPreference, self.purchasedOnTextField.text!.allowSpecialCharacters, self.devicePurchasedFrom, self.deviceWarrantyDetails, self.nextServiceDateTextField.text!.allowSpecialCharacters, self.lastServiceDateTextField.text!.allowSpecialCharacters, self.warrentyExpiresTextField.text!.allowSpecialCharacters, self.extendedWarrentyExpiresTextField.text!.allowSpecialCharacters, self.remarkTextField.text!.allowSpecialCharacters)
        }
        self.addRegisterDeviceViewModel.postCustomerDeviceList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postCustomerDeviceList, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    @IBAction func userNameButtonPressed(_ sender: UIButton) {
        if self.patientList.count > 0 {
            self.view.endEditing(true)
            let dropDown = DropDown()
            // The view to which the drop down will appear on
            dropDown.anchorView = self.userNameButton // UIView or UIBarButtonItem
            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = self.patientList
            dropDown.show()
            // Action triggered on selection
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.deviceUserUID = self.patientSlugList[index]
                self.deviceUserName = self.patientList[index]
                self.userNameTextField.text = item
                self.setUserInteractionButton()
            }
        } else {
            self.showToastAlert(AppLocalizationString.dropDownError, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func brandButtonPressed(_ sender: UIButton) {
        if self.brandList.count > 0 {
            self.view.endEditing(true)
            let dropDown = DropDown()
            // The view to which the drop down will appear on
            dropDown.anchorView = self.brandButton // UIView or UIBarButtonItem
            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = self.brandList
            dropDown.show()
            // Action triggered on selection
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.deviceBrandUID = self.brandSlugList[index]
                self.deviceBrand = self.brandList[index]
                self.brandTextField.text = item
                self.setUserInteractionButton()
            }
        } else {
            self.showToastAlert(AppLocalizationString.dropDownError, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func earPreferenceButtonPressed(_ sender: UIButton) {
        if self.earPreferenceList.count > 0 {
            self.view.endEditing(true)
            let dropDown = DropDown()
            // The view to which the drop down will appear on
            dropDown.anchorView = self.earPreferenceButton // UIView or UIBarButtonItem
            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = self.earPreferenceList
            dropDown.show()
            // Action triggered on selection
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.deviceEarPreference = self.earPreferenceSlugList[index]
                self.deviceEarPreferenceValue = self.earPreferenceList[index]
                self.earPreferenceTextField.text = item
                self.setUserInteractionButton()
            }
        } else {
            self.showToastAlert(AppLocalizationString.dropDownError, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func purchasedFromButtonPressed(_ sender: UIButton) {
        if self.purchasedFromList.count > 0 {
            self.view.endEditing(true)
            let dropDown = DropDown()
            // The view to which the drop down will appear on
            dropDown.anchorView = self.earPreferenceButton // UIView or UIBarButtonItem
            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = self.purchasedFromList
            dropDown.show()
            // Action triggered on selection
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.devicePurchasedFrom = self.purchasedFromSlugList[index]
                self.devicePurchasedFromValue = self.purchasedFromList[index]
                self.purchasedFromTextField.text = item
                self.setUserInteractionButton()
            }
        } else {
            self.showToastAlert(AppLocalizationString.dropDownError, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func warrentyDetailsButtonPressed(_ sender: UIButton) {
        if self.warrantyList.count > 0 {
            self.view.endEditing(true)
            let dropDown = DropDown()
            // The view to which the drop down will appear on
            dropDown.anchorView = self.warrentyDetailsButton // UIView or UIBarButtonItem

            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = self.warrantyList
            dropDown.show()

            // Action triggered on selection
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.deviceWarrantyDetails = self.warrantySlugList[index]
                self.deviceWarrantyDetailsValue = self.warrantyList[index]
                self.warrentyDetailsTextField.text = item
                self.setUserInteractionButton()
            }
        } else {
            self.showToastAlert(AppLocalizationString.dropDownError, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }

    // MARK: - Custom Methods

    func updateUI() {
        self.userNameTextField.text = self.deviceUserName
        self.deviceNameTextField.text = self.deviceName
        self.brandTextField.text = self.deviceBrand
        self.modelTextField.text = self.deviceModel
        self.serialNumberTextField.text = self.deviceSerialNumber
        self.earPreferenceTextField.text = self.deviceEarPreferenceValue
        self.purchasedFromTextField.text = self.devicePurchasedFromValue
        self.purchasedOnTextField.text = self.devicePurchasedOn
        self.warrentyDetailsTextField.text = self.deviceWarrantyDetailsValue
        self.warrentyExpiresTextField.text = self.deviceWarrantyExpiresOn
        self.extendedWarrentyExpiresTextField.text = self.deviceExtendedWarrantyEndOn
        self.nextServiceDateTextField.text = self.deviceNextServiceDate
        self.lastServiceDateTextField.text = self.deviceLastServiceDate
        self.remarkTextField.text = self.deviceRemark
        if self.isEdit == true {
            if !(self.devicePurchasedOn.isEmpty) {
                let datefmt = self.devicePurchasedOn.toDate(format: AppConstantValue.apiDateFormat)
                if datefmt != nil {
                    let formatter = DateFormatter()
                    formatter.dateFormat = AppConstantValue.regularDateFormat
                    self.purchasedOnTextField.text = formatter.string(from: datefmt!)
                    var components = DateComponents()
                    components.year = 100
                    self.deviceWarrantyExpiresOnDatePicker.datePickerMode = .date
                    self.deviceWarrantyExpiresOnDatePicker.minimumDate = datefmt!
                    self.deviceWarrantyExpiresOnDatePicker.maximumDate = Calendar.current.date(byAdding: components, to: Date())
                    self.warrentyExpiresTextField.text = ""

                    self.deviceExtendedeWarrantyExpiresOnDatePicker.datePickerMode = .date
                    self.deviceExtendedeWarrantyExpiresOnDatePicker.minimumDate = datefmt!
                    self.deviceExtendedeWarrantyExpiresOnDatePicker.maximumDate = Calendar.current.date(byAdding: components, to: Date())
                    self.extendedWarrentyExpiresTextField.text = ""

                    self.deviceNextServiceDatePicker.datePickerMode = .date
                    self.deviceNextServiceDatePicker.minimumDate = datefmt!
                    self.deviceNextServiceDatePicker.maximumDate = Calendar.current.date(byAdding: components, to: Date())
                    self.nextServiceDateTextField.text = ""

                    self.deviceLastServiceDateDatePicker.datePickerMode = .date
                    self.deviceLastServiceDateDatePicker.minimumDate = datefmt!
                    self.deviceLastServiceDateDatePicker.maximumDate = Calendar.current.date(byAdding: components, to: Date())
                    self.lastServiceDateTextField.text = ""
                }
            }
            if !(self.deviceWarrantyExpiresOn.isEmpty) {
                let datefmt = self.deviceWarrantyExpiresOn.toDate(format: AppConstantValue.apiDateFormat)
                if datefmt != nil {
                    let formatter = DateFormatter()
                    formatter.dateFormat = AppConstantValue.regularDateFormat
                    self.warrentyExpiresTextField.text = formatter.string(from: datefmt!)
                    var components = DateComponents()
                    components.year = 100
                    self.deviceExtendedeWarrantyExpiresOnDatePicker.datePickerMode = .date
                    self.deviceExtendedeWarrantyExpiresOnDatePicker.minimumDate = datefmt
                    self.deviceExtendedeWarrantyExpiresOnDatePicker.maximumDate = Calendar.current.date(byAdding: components, to: Date())
                    self.extendedWarrentyExpiresTextField.text = ""
                }
            }
            if !(self.deviceExtendedWarrantyEndOn.isEmpty) {
                let datefmt = self.deviceNextServiceDate.toDate(format: AppConstantValue.apiDateFormat)
                if datefmt != nil {
                    let formatter = DateFormatter()
                    formatter.dateFormat = AppConstantValue.regularDateFormat
                    self.extendedWarrentyExpiresTextField.text = formatter.string(from: datefmt!)
                }
            }
            if !(self.deviceLastServiceDate.isEmpty) {
                let datefmt = self.deviceLastServiceDate.toDate(format: AppConstantValue.apiDateFormat)
                if datefmt != nil {
                    let formatter = DateFormatter()
                    formatter.dateFormat = AppConstantValue.regularDateFormat
                    self.lastServiceDateTextField.text = formatter.string(from: datefmt!)
                    var components = DateComponents()
                    components.year = 100
                    self.deviceNextServiceDatePicker.datePickerMode = .date
                    self.deviceNextServiceDatePicker.minimumDate = datefmt
                    self.deviceNextServiceDatePicker.maximumDate = Calendar.current.date(byAdding: components, to: Date())
                    self.nextServiceDateTextField.text = ""
                }
            }
            if !(self.deviceNextServiceDate.isEmpty) {
                let datefmt = self.deviceNextServiceDate.toDate(format: AppConstantValue.apiDateFormat)
                if datefmt != nil {
                    let formatter = DateFormatter()
                    formatter.dateFormat = AppConstantValue.regularDateFormat
                    self.nextServiceDateTextField.text = formatter.string(from: datefmt!)
                }
            }
        }
        if #available(iOS 13.4, *) {
            self.devicePurchasedOnDatePicker.preferredDatePickerStyle = .wheels
            self.deviceWarrantyExpiresOnDatePicker.preferredDatePickerStyle = .wheels
            self.deviceExtendedeWarrantyExpiresOnDatePicker.preferredDatePickerStyle = .wheels
            self.deviceNextServiceDatePicker.preferredDatePickerStyle = .wheels
            self.deviceLastServiceDateDatePicker.preferredDatePickerStyle = .wheels
        }

        self.userNameTextField.delegate = self
        self.deviceNameTextField.delegate = self
        self.brandTextField.delegate = self
        self.modelTextField.delegate = self
        self.serialNumberTextField.delegate = self
        self.earPreferenceTextField.delegate = self
        self.purchasedOnTextField.delegate = self
        self.purchasedFromTextField.delegate = self
        self.warrentyExpiresTextField.delegate = self
        self.extendedWarrentyExpiresTextField.delegate = self
        self.warrentyDetailsTextField.delegate = self
        self.lastServiceDateTextField.delegate = self
        self.nextServiceDateTextField.delegate = self
        self.remarkTextField.delegate = self

        [self.userNameTextField, self.deviceNameTextField, self.brandTextField, self.modelTextField, self.serialNumberTextField, self.earPreferenceTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)})

        [self.purchasedOnTextField, self.purchasedFromTextField, self.warrentyExpiresTextField, self.extendedWarrentyExpiresTextField, self.warrentyDetailsTextField, self.lastServiceDateTextField, self.nextServiceDateTextField, self.remarkTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)})

        self.setUserInteractionButton()
    }

    @objc func editingChanged(_ textField: UITextField) {
        self.setUserInteractionButton()
    }
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if self.userNameLabel.text.isNilOrEmpty || self.deviceNameTextField.text.isNilOrEmpty || self.brandTextField.text.isNilOrEmpty || self.modelTextField.text.isNilOrEmpty || self.earPreferenceTextField.text.isNilOrEmpty || self.purchasedFromTextField.text.isNilOrEmpty {
                self.setButtonDisable()
            } else {
                self.setButtonEnable()
            }
        }
    }
    func setButtonDisable() {
        self.saveButton.isUserInteractionEnabled = false
        self.saveButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.saveButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.saveButton.setNeedsDisplay()
        self.saveButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.saveButton.isUserInteractionEnabled = true
        self.saveButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.saveButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.saveButton.setNeedsDisplay()
        self.saveButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

    @objc func fnGoToDoneDatePicker() {

        self.devicePurchasedOnDateFormatter.dateFormat = AppConstantValue.regularDateFormat
        self.purchasedOnTextField.text = self.devicePurchasedOnDateFormatter.string(from: self.devicePurchasedOnDatePicker.date)

        var components = DateComponents()
        components.year = 100

        self.deviceWarrantyExpiresOnDatePicker.datePickerMode = .date
        self.deviceWarrantyExpiresOnDatePicker.minimumDate = self.devicePurchasedOnDatePicker.date
        self.deviceWarrantyExpiresOnDatePicker.maximumDate = Calendar.current.date(byAdding: components, to: Date())
        self.warrentyExpiresTextField.text = ""

        self.deviceExtendedeWarrantyExpiresOnDatePicker.datePickerMode = .date
        self.deviceExtendedeWarrantyExpiresOnDatePicker.minimumDate = self.devicePurchasedOnDatePicker.date
        self.deviceExtendedeWarrantyExpiresOnDatePicker.maximumDate = Calendar.current.date(byAdding: components, to: Date())
        self.extendedWarrentyExpiresTextField.text = ""

        self.deviceNextServiceDatePicker.datePickerMode = .date
        self.deviceNextServiceDatePicker.minimumDate = self.devicePurchasedOnDatePicker.date
        self.deviceNextServiceDatePicker.maximumDate = Calendar.current.date(byAdding: components, to: Date())
        self.nextServiceDateTextField.text = ""

        self.deviceLastServiceDateDatePicker.datePickerMode = .date
        self.deviceLastServiceDateDatePicker.minimumDate = self.devicePurchasedOnDatePicker.date
        self.deviceLastServiceDateDatePicker.maximumDate = Calendar.current.date(byAdding: components, to: Date())
        self.lastServiceDateTextField.text = ""
    }

    @objc func fnGoToDoneWarantyDatePicker() {
        self.deviceWarrantyExpiresOnDateFormatter.dateFormat = AppConstantValue.regularDateFormat
        self.warrentyExpiresTextField.text = deviceWarrantyExpiresOnDateFormatter.string(from: self.deviceWarrantyExpiresOnDatePicker.date)

        var components = DateComponents()
        components.year = 100

        self.deviceExtendedeWarrantyExpiresOnDatePicker.datePickerMode = .date
        self.deviceExtendedeWarrantyExpiresOnDatePicker.minimumDate = self.deviceWarrantyExpiresOnDatePicker.date
        self.deviceExtendedeWarrantyExpiresOnDatePicker.maximumDate = Calendar.current.date(byAdding: components, to: Date())
        self.extendedWarrentyExpiresTextField.text = ""
    }
    @objc func fnGoToDoneExtendedWarantyDatePicker() {
        self.deviceExtendedWarrantyExpiresOnDateFormatter.dateFormat = AppConstantValue.regularDateFormat
        self.extendedWarrentyExpiresTextField.text = deviceExtendedWarrantyExpiresOnDateFormatter.string(from: self.deviceExtendedeWarrantyExpiresOnDatePicker.date)
    }
    @objc func fnGoToDoneLastServiceDatePicker() {
        self.deviceLastServiceDateDateFormatter.dateFormat = AppConstantValue.regularDateFormat
        self.lastServiceDateTextField.text = self.deviceLastServiceDateDateFormatter.string(from: self.deviceLastServiceDateDatePicker.date)
    }

    @objc func fnGoToDoneNextServiceDatePicker() {
        self.deviceNextServiceDateDateFormatter.dateFormat = AppConstantValue.regularDateFormat
        self.nextServiceDateTextField.text = deviceNextServiceDateDateFormatter.string(from: deviceNextServiceDatePicker.date)

        var components = DateComponents()
        components.year = 100

        //        self.deviceLastServiceDateDatePicker.datePickerMode = .date
        //        self.deviceLastServiceDateDatePicker.minimumDate = self.devicePurchasedOnDatePicker.date
        //        self.deviceLastServiceDateDatePicker.maximumDate = self.deviceNextServiceDatePicker.date
        //        self.lastServiceDateTextField.text = ""
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
        if textField == self.deviceNameTextField {
            maxLength = 50
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.nameRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        } else if textField == self.remarkTextField {
            maxLength = 255
        } else {
            maxLength = 255
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if purchasedOnTextField.isFirstResponder {
            DispatchQueue.main.async(execute: {
                if #available(iOS 13.0, *) {
                    (sender as? UIMenuController)?.hideMenu()
                } else {
                    (sender as? UIMenuController)?.setMenuVisible(false, animated: false)
                }
            })
            return false
        }
        if warrentyExpiresTextField.isFirstResponder {
            DispatchQueue.main.async(execute: {
                if #available(iOS 13.0, *) {
                    (sender as? UIMenuController)?.hideMenu()
                } else {
                    (sender as? UIMenuController)?.setMenuVisible(false, animated: false)
                }
            })
            return false
        }
        if extendedWarrentyExpiresTextField.isFirstResponder {
            DispatchQueue.main.async(execute: {
                if #available(iOS 13.0, *) {
                    (sender as? UIMenuController)?.hideMenu()
                } else {
                    (sender as? UIMenuController)?.setMenuVisible(false, animated: false)
                }
            })
            return false
        }
        if lastServiceDateTextField.isFirstResponder {
            DispatchQueue.main.async(execute: {
                if #available(iOS 13.0, *) {
                    (sender as? UIMenuController)?.hideMenu()
                } else {
                    (sender as? UIMenuController)?.setMenuVisible(false, animated: false)
                }
            })
            return false
        }
        if nextServiceDateTextField.isFirstResponder {
            DispatchQueue.main.async(execute: {
                if #available(iOS 13.0, *) {
                    (sender as? UIMenuController)?.hideMenu()
                } else {
                    (sender as? UIMenuController)?.setMenuVisible(false, animated: false)
                }
            })
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

extension AddRegisterDeviceViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if isFrom == IsNavigateFrom.ardBooking.rawValue {
            self.navigateBackToBookAppointmentViewController()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {
    }
}
extension AddRegisterDeviceViewController: ProtocolNetworkRechabilityDelegate {
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
