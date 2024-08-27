//
//  OnlineConsultationLocationViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 26/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift

class OnlineConsultationLocationViewController: UIViewController,UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var threeDotCircleView: ThreeDotCircleView!

    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var clearBackgroundView: UIView!
    @IBOutlet var borderBackgroundView: UIView!
    @IBOutlet var borderStackView: UIStackView!

    @IBOutlet var languageTitleView: UIView!
    @IBOutlet var languageLabel: FootnoteFontLabel!
    @IBOutlet var languageView: UIView!
    @IBOutlet var languageTextField: Caption1FontTextfield!
    @IBOutlet var languageButton: CalloutOutlineButton!

    @IBOutlet var cityTitleView: UIView!
    @IBOutlet var cityLabel: FootnoteFontLabel!
    @IBOutlet var cityView: UIView!
    @IBOutlet var cityTextField: Caption1FontTextfield!
    @IBOutlet var cityButton: CalloutOutlineButton!

    @IBOutlet var mobileNumberTitleView: UIView!
    @IBOutlet var mobileNumberLabel: FootnoteFontLabel!
    @IBOutlet var mobileNumberView: UIView!
    @IBOutlet var mobileNumberTextField: Caption1FontEditableTextfield!

    @IBOutlet var OTPTitleView: UIView!
    @IBOutlet var OPTLabel: FootnoteFontLabel!
    @IBOutlet var OTPStackView: UIView!
    @IBOutlet var OTP1TextField: Caption1FontEditableTextfield!
    @IBOutlet var OTP2TextField: Caption1FontEditableTextfield!
    @IBOutlet var OTP3TextField: Caption1FontEditableTextfield!
    @IBOutlet var OTP4TextField: Caption1FontEditableTextfield!

    @IBOutlet var nextButtonView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!

    @IBOutlet var sendOTPButtonView: UIView!
    @IBOutlet var sendOTPButton: CalloutBackgroundButton!

    @IBOutlet var verifyOTPButtonView: UIView!
    @IBOutlet var verifyOTPButton: CalloutBackgroundButton!

    @IBOutlet var resendOTPButtonView: UIView!
    @IBOutlet var resendOTPButton: CalloutBackgroundButton!

    // MARK: - Lets and Var
    var onlineConsultationLocationViewModel = OnlineConsultationLocationViewModel()

    var isFrom = ""
    var isLoggedIn = false
    var selectedLanguage = ""
    var selectedCity = ""
    var activeField = UITextField()
    var newUser = false
    var cityList = [String]()
    var cityListID = [Int]()
    var languageList = [String]()
    var languageListCode = [String]()

    var phoneToken = ""
    var concernID = ""
    var customerMobile = ""
    var customerEmail = ""
    var customerName = ""
    var customerUID = ""
    var profilePicture = ""

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
        self.setUserInteractionButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    // MARK: -  Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_white_FFFFFF,style: StatusBarTheme.darkContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    // MARK: - Set Initial View
    func setInitialView() {
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.setThreeDotCircleView()
        self.setVisibility()
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        self.cityTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.cityTextField.clipsToBounds = true
        self.cityTextField.layer.borderColor = UIColor.colorLiteral.theme_grey_999999.cgColor
        self.cityTextField.layer.borderWidth = 1.0
        self.cityTextField.setLeftPaddingPoints(10.0)
        self.cityTextField.setRightPaddingPoints(60.0)
        self.cityTextField.delegate = self
        self.cityTextField.text = ""

        self.languageTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.languageTextField.clipsToBounds = true
        self.languageTextField.layer.borderColor = UIColor.colorLiteral.theme_grey_999999.cgColor
        self.languageTextField.layer.borderWidth = 1.0
        self.languageTextField.setLeftPaddingPoints(10.0)
        self.languageTextField.setRightPaddingPoints(60.0)
        self.languageTextField.delegate = self
        self.languageTextField.text = ""

        self.mobileNumberTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.mobileNumberTextField.clipsToBounds = true
        self.mobileNumberTextField.layer.borderColor = UIColor.colorLiteral.theme_grey_999999.cgColor
        self.mobileNumberTextField.layer.borderWidth = 1.0
        self.mobileNumberTextField.setLeftPaddingPoints(10.0)
        self.mobileNumberTextField.setRightPaddingPoints(60.0)
        self.mobileNumberTextField.delegate = self
        self.mobileNumberTextField.text = ""
        self.mobileNumberTextField.tintColor = UIColor.colorLiteral.theme_black_333333

        self.OTP1TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP1TextField.clipsToBounds = true
        self.OTP1TextField.layer.borderColor = UIColor.colorLiteral.theme_grey_999999.cgColor
        self.OTP1TextField.layer.borderWidth = 1.0
        self.OTP2TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP2TextField.clipsToBounds = true
        self.OTP2TextField.layer.borderColor = UIColor.colorLiteral.theme_grey_999999.cgColor
        self.OTP2TextField.layer.borderWidth = 1.0
        self.OTP3TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP3TextField.clipsToBounds = true
        self.OTP3TextField.layer.borderColor = UIColor.colorLiteral.theme_grey_999999.cgColor
        self.OTP3TextField.layer.borderWidth = 1.0
        self.OTP4TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP4TextField.clipsToBounds = true
        self.OTP4TextField.layer.borderColor = UIColor.colorLiteral.theme_grey_999999.cgColor
        self.OTP4TextField.layer.borderWidth = 1.0

        self.OTP1TextField.delegate = self
        self.OTP2TextField.delegate = self
        self.OTP3TextField.delegate = self
        self.OTP4TextField.delegate = self

        self.OTP1TextField.tintColor = UIColor.colorLiteral.theme_black_333333
        self.OTP2TextField.tintColor = UIColor.colorLiteral.theme_black_333333
        self.OTP3TextField.tintColor = UIColor.colorLiteral.theme_black_333333
        self.OTP4TextField.tintColor = UIColor.colorLiteral.theme_black_333333

        [self.languageTextField, self.mobileNumberTextField,self.OTP1TextField, self.OTP2TextField, self.OTP3TextField, self.OTP4TextField,self.cityTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        self.setUserInteractionButton()
        self.commonAPICALL(retryAPIID: 1000)
    }

    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftdarkblue
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.onlineConsultation.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF,titleTextColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.OnlineConsultationStep1Title.uppercased()
        let descriptionMessage = AppLocalizationString.OnlineConsultationStep1Desc
        self.commonTitleView.setupView(titleMessage: titlemessage, descriptionMessage: descriptionMessage,commonTitlebackgroundViewColor: UIColor.colorLiteral.theme_blue_E7F4FF)
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
    // MARK: - Set Three Dot Circle View
    func setThreeDotCircleView() {
        self.threeDotCircleView.setupView(button1image: Asset.recordcircleblue, button2image: Asset.circlegrey, button3image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_blue_E7F4FF)
    }

    // MARK: - Localization String
    func changeLanguageFormat() {
        self.cityTextField.attributedPlaceholder = NSAttributedString(
            string: AppLocalizationString.selectCity,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_DCDCDD]
        )
        self.cityLabel.setStarAttributtedText(textmessage: AppLocalizationString.selectCitystar.capitalized, color: UIColor.colorLiteral.theme_red_FF6961)
        self.mobileNumberLabel.setStarAttributtedText(textmessage: AppLocalizationString.mobileNumberstar.capitalized, color: UIColor.colorLiteral.theme_red_FF6961)
        self.mobileNumberTextField.attributedPlaceholder = NSAttributedString(
            string: AppLocalizationString.enterYourMobileNumber.capitalized,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_DCDCDD]
        )
        self.OTP1TextField.attributedPlaceholder = NSAttributedString(
            string: "0",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_DCDCDD]
        )
        self.OTP2TextField.attributedPlaceholder = NSAttributedString(
            string: "0",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_DCDCDD]
        )
        self.OTP3TextField.attributedPlaceholder = NSAttributedString(
            string: "0",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_DCDCDD]
        )
        self.OTP4TextField.attributedPlaceholder = NSAttributedString(
            string: "0",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_DCDCDD]
        )

        self.languageTextField.attributedPlaceholder = NSAttributedString(
            string: AppLocalizationString.selectLanguage,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_3C3C43_18]
        )
        self.languageLabel.setStarAttributtedText(textmessage: AppLocalizationString.selectLanguagestar.capitalized, color: UIColor.colorLiteral.theme_red_FF6961)

        self.nextButton.setTitle(AppLocalizationString.next.uppercased(), for: .normal)
        self.nextButton.setTitle(AppLocalizationString.next.uppercased(), for: .normal)
        self.sendOTPButton.setTitle(AppLocalizationString.sendotp.uppercased(), for: .normal)
        self.resendOTPButton.setTitle(AppLocalizationString.resendotp.uppercased(), for: .normal)
        self.verifyOTPButton.setTitle(AppLocalizationString.verifyotp.uppercased(), for: .normal)

        self.setCommonTitleView()
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getOnlineConsultationCityList(retryAPIID: retryAPIID, canShowLoader: true)
                }
                else if retryAPIID == 1001 {
                    self.postOnlineConsultationSaveData(retryAPIID: retryAPIID, canShowLoader: true)
                }
                else if retryAPIID == 1002 {
                    self.postOnlineConsultationSendOTP(retryAPIID: retryAPIID, canShowLoader: true)
                }
                else if retryAPIID == 1003 {
                    self.postOnlineConsultationLoginVerifyOTP(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getOnlineConsultationCityList(retryAPIID: Int, canShowLoader: Bool) {
        self.onlineConsultationLocationViewModel.getOnlineConsultationCityList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getOnlineConsultationCityList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postOnlineConsultationSaveData(retryAPIID: Int, canShowLoader: Bool) {
        let param =  String(format: "city=%@&language=%@&service_type=online", self.selectedCity, self.selectedLanguage)
        self.onlineConsultationLocationViewModel.postOnlineConsultationSaveData(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postOnlineConsultationSaveData, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postOnlineConsultationSendOTP(retryAPIID: Int, canShowLoader: Bool) {
        let param =  String(format: "phone_number=%@%@", "+91".allowSpecialCharacters, self.mobileNumberTextField.text!.allowSpecialCharacters)
        self.onlineConsultationLocationViewModel.postOnlineConsultationSendOTP(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postOnlineConsultationSendOTP, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postOnlineConsultationLoginVerifyOTP(retryAPIID: Int, canShowLoader: Bool) {
        if self.OTP1TextField.text.isNilOrEmpty || self.OTP2TextField.text.isNilOrEmpty || self.OTP3TextField.text.isNilOrEmpty || self.OTP4TextField.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseenterotp, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            return
        }
        let strOTP = String(format: "%@%@%@%@", self.OTP1TextField.text!.allowSpecialCharacters, self.OTP2TextField.text!.allowSpecialCharacters, self.OTP3TextField.text!.allowSpecialCharacters, self.OTP4TextField.text!.allowSpecialCharacters)
        let param =  String(format: "token=%@&otp=%@&city=%@&language=%@&service_type=online", self.phoneToken,strOTP,self.selectedCity,self.selectedLanguage)
        self.onlineConsultationLocationViewModel.postOnlineConsultationLoginVerifyOTP(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postOnlineConsultationLoginVerifyOTP, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1001)
    }
    @IBAction func sendOTPButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1002)
    }
    @IBAction func verifyOTPButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1003)
    }
    @IBAction func resendOTPButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1002)
    }

    @IBAction func languageButtonPressed(_ sender: UIButton) {
        if self.languageList.count > 0 {
            self.view.endEditing(true)
            let dropDown = DropDown()
            // The view to which the drop down will appear on
            dropDown.anchorView = self.languageButton // UIView or UIBarButtonItem

            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = self.languageList
            dropDown.show()

            // Action triggered on selection
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.selectedLanguage = self.languageList[index]
                self.languageTextField.text = item
                self.setUserInteractionButton()
            }
        } else {
            self.showToastAlert(AppLocalizationString.dropDownError, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func cityButtonPressed(_ sender: UIButton) {
        if self.cityList.count > 0 {
            self.view.endEditing(true)
            let dropDown = DropDown()
            // The view to which the drop down will appear on
            dropDown.anchorView = self.cityButton // UIView or UIBarButtonItem

            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = self.cityList
            dropDown.show()

            // Action triggered on selection
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.selectedCity = self.cityList[index]
                self.cityTextField.text = item
                self.setUserInteractionButton()
            }
        } else {
            self.showToastAlert(AppLocalizationString.dropDownError, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    // MARK: - Custom Methods
    func setNextButtonEnable() {
        self.nextButton.isUserInteractionEnabled = true
        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.nextButton.setNeedsDisplay()
        self.nextButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setNextButtonDisable() {
        self.nextButton.isUserInteractionEnabled = false
        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.nextButton.setNeedsDisplay()
        self.nextButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setSendOTPButtonEnable() {
        self.sendOTPButton.isUserInteractionEnabled = true
        self.sendOTPButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.sendOTPButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.sendOTPButton.setNeedsDisplay()
        self.sendOTPButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setSendOTPButtonDisable() {
        self.sendOTPButton.isUserInteractionEnabled = false
        self.sendOTPButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.sendOTPButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.sendOTPButton.setNeedsDisplay()
        self.sendOTPButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setVerifyOTPButtonEnable() {
        self.verifyOTPButton.isUserInteractionEnabled = true
        self.verifyOTPButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.verifyOTPButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.verifyOTPButton.setNeedsDisplay()
        self.verifyOTPButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setVerifyOTPButtonDisable() {
        self.verifyOTPButton.isUserInteractionEnabled = false
        self.verifyOTPButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.verifyOTPButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.verifyOTPButton.setNeedsDisplay()
        self.verifyOTPButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
                if !(self.languageTextField.text.isNilOrEmpty) && !(self.cityTextField.text.isNilOrEmpty) && (self.mobileNumberTextField.text!.count == 10){
                    self.setSendOTPButtonEnable()
                }
                else{
                    self.setSendOTPButtonDisable()
                }
                if !(self.languageTextField.text.isNilOrEmpty) && !(self.cityTextField.text.isNilOrEmpty) && !(self.OTP1TextField.text.isNilOrEmpty) && !(self.OTP2TextField.text.isNilOrEmpty) && !(self.OTP3TextField.text.isNilOrEmpty) && !(self.OTP4TextField.text.isNilOrEmpty) && (self.mobileNumberTextField.text!.count == 10) && !(self.phoneToken.isEmpty){
                    self.setVerifyOTPButtonEnable()
                }
                else{
                    self.setVerifyOTPButtonDisable()
                }
            }
            else if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty) {
                if !(self.languageTextField.text.isNilOrEmpty) && !(self.cityTextField.text.isNilOrEmpty){
                    self.setNextButtonEnable()
                }
                else{
                    self.setNextButtonDisable()
                }
            }
        }
    }
    func setVisibility(){
        let borderStackView0 = self.borderStackView.arrangedSubviews[0]// visit type
        let borderStackView1 = self.borderStackView.arrangedSubviews[1]// city
        let borderStackView2 = self.borderStackView.arrangedSubviews[2]// next
        let borderStackView3 = self.borderStackView.arrangedSubviews[3]// mobile
        let borderStackView4 = self.borderStackView.arrangedSubviews[4]// send otp
        let borderStackView5 = self.borderStackView.arrangedSubviews[5]// otp
        let borderStackView6 = self.borderStackView.arrangedSubviews[6]// verify otp
        let borderStackView7 = self.borderStackView.arrangedSubviews[7]// resend otp
        let borderStackView8 = self.borderStackView.arrangedSubviews[8]// empty

        borderStackView0.isHidden = false
        borderStackView1.isHidden = false
        borderStackView8.isHidden = false
        borderStackView2.isHidden = true
        borderStackView3.isHidden = true
        borderStackView4.isHidden = true
        borderStackView5.isHidden = true
        borderStackView6.isHidden = true
        borderStackView7.isHidden = true

        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            borderStackView3.isHidden = false
            if (self.mobileNumberTextField.text!.count <= 10) && self.isLoggedIn == false {
                borderStackView4.isHidden = false
            }
            else if self.isLoggedIn == true {
                borderStackView4.isHidden = false
                borderStackView5.isHidden = false
                borderStackView6.isHidden = false
            }
        }
        else if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty) {
            borderStackView2.isHidden = false
        }
        self.setUserInteractionButton()
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
        if textField == self.mobileNumberTextField {
            maxLength = 10
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.numericRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        }
        if (textField == OTP1TextField) || (textField == OTP2TextField) || (textField == OTP3TextField) || (textField == OTP4TextField){
            maxLength = 1
            if string.count == 1 {
                if textField == OTP1TextField {
                    OTP2TextField?.becomeFirstResponder()
                }
                if textField == OTP2TextField {
                    OTP3TextField?.becomeFirstResponder()
                }
                if textField == OTP3TextField {
                    OTP4TextField?.becomeFirstResponder()
                }
                if textField == OTP4TextField {
                    OTP4TextField?.resignFirstResponder()
                    textField.text? = string
                    // APICall Verify OTP
                    // Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.VerifyOTPAPI), userInfo: nil, repeats: false)
                }
                textField.text? = string
                self.setUserInteractionButton()
                return false
            } else {
                if textField == OTP1TextField {
                    OTP1TextField?.becomeFirstResponder()
                }
                if textField == OTP2TextField {
                    OTP1TextField?.becomeFirstResponder()
                }
                if textField == OTP3TextField {
                    OTP2TextField?.becomeFirstResponder()
                }
                if textField == OTP4TextField {
                    OTP3TextField?.becomeFirstResponder()
                }
                textField.text? = string
                self.setUserInteractionButton()
                return false
            }
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    @objc func editingChanged(_ textField: UITextField) {
        if (textField == OTP1TextField) || (textField == OTP2TextField) || (textField == OTP3TextField) || (textField == OTP4TextField){
            if textField.textContentType == UITextContentType.oneTimeCode {
                // here split the text to your four text fields
                if let otpCode = textField.text, otpCode.count > 3 {
                    self.OTP1TextField.text = String(otpCode[otpCode.startIndex])
                    self.OTP2TextField.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 1)])
                    self.OTP3TextField.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 2)])
                    self.OTP4TextField.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 3)])
                }
            }
        }
        if (textField == self.mobileNumberTextField){
            if (textField.text!.count < 10){
                self.OTP1TextField.text = ""
                self.OTP2TextField.text = ""
                self.OTP3TextField.text = ""
                self.OTP4TextField.text = ""
                self.phoneToken = ""
                self.isLoggedIn = false
            }
        }
        self.setVisibility()
    }
}
extension OnlineConsultationLocationViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.ocHomeStatic.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.ocHearingCare.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.ocSurveySuccess.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.ocQuickCheck.rawValue {
            self.navigateBackToQuickTestResultViewController()
        } else {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        }
    }
    func rightButtonPressed() {
    }
}
extension OnlineConsultationLocationViewController: ProtocolNetworkRechabilityDelegate {
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
