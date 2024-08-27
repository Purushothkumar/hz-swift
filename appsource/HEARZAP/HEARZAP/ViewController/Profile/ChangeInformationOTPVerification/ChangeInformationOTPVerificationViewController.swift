//
//  ChangeInformationOTPVerificationViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 14/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChangeInformationOTPVerificationViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: LogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!

    @IBOutlet var borderStackView: UIStackView!
    @IBOutlet var mainStackView: UIStackView!

    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var clearBackgroundView: UIView!
    @IBOutlet var borderBackgroundView: UIView!
    @IBOutlet var titleView: UIView!
    @IBOutlet var descriptionView: UIView!

    @IBOutlet var contentView: UIView!
    @IBOutlet var buttonView: UIView!

    @IBOutlet var titleLabel: Title2FontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!

    @IBOutlet var mobileNumberLabel: BodyFontLabel!
    @IBOutlet var editButton: FootnoteOutlineButton!

    @IBOutlet var OTP1TextField: Caption1FontTextfield!
    @IBOutlet var OTP2TextField: Caption1FontTextfield!
    @IBOutlet var OTP3TextField: Caption1FontTextfield!
    @IBOutlet var OTP4TextField: Caption1FontTextfield!

    @IBOutlet var verifyButton: CalloutBackgroundButton!

    @IBOutlet var resendOTPView: UIView!
    @IBOutlet var resendOTPButton: FootnoteOutlineButton!
    @IBOutlet var resendOTPLabel: Caption2FontLabel!

    // MARK: - Lets and Var
    var otpText = String()
    var activeField = UITextField()

    var changeInformationOTPVerificationViewModel = ChangeInformationOTPVerificationViewModel()

    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var toChangeNumber = false
    var changeData = ""
    var token = ""

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.layoutIfNeeded()
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
        
        self.borderBackgroundView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.borderBackgroundView.clipsToBounds = true
        self.OTP1TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP1TextField.clipsToBounds = true
        self.OTP1TextField.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.OTP1TextField.layer.borderWidth = 1.0
        self.OTP2TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP2TextField.clipsToBounds = true
        self.OTP2TextField.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.OTP2TextField.layer.borderWidth = 1.0
        self.OTP3TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP3TextField.clipsToBounds = true
        self.OTP3TextField.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.OTP3TextField.layer.borderWidth = 1.0
        self.OTP4TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP4TextField.clipsToBounds = true
        self.OTP4TextField.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.OTP4TextField.layer.borderWidth = 1.0
        [self.OTP1TextField, self.OTP2TextField, self.OTP3TextField, self.OTP4TextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })

        self.setUserInteractionButton()
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
        self.mobileNumberLabel.text = self.toChangeNumber == true ? "\(AppLocalizationString.otpSenttoyourmobilenumber) \(self.changeData)": "\(AppLocalizationString.otpSenttoyouremail) \(self.changeData)"
        self.descriptionLabel.text = self.toChangeNumber == true ? AppLocalizationString.mobileOTPSecurity: AppLocalizationString.emailOTPSecurity
        self.titleLabel.text = self.toChangeNumber == true ? AppLocalizationString.verifyMobileNumber : AppLocalizationString.verifyEmail
        self.verifyButton.setTitle(AppLocalizationString.verify.uppercased(), for: .normal)
        self.editButton.setTitle(self.toChangeNumber == true ? AppLocalizationString.changemobilenumber.capitalized : AppLocalizationString.changeemailaddress.capitalized, for: .normal)

        let noOTPstr = AppLocalizationString.didntrecieveOTP
        let resendstr = AppLocalizationString.resend

        let noOTPAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]

        let resendAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.medium.size(13)]

        let noOTP = NSMutableAttributedString(string: String(format: "%@ ", noOTPstr), attributes: noOTPAttributes as [NSAttributedString.Key: Any])
        let resend = NSMutableAttributedString(string: String(format: "%@", resendstr), attributes: resendAttributes as [NSAttributedString.Key: Any])

        let combination = NSMutableAttributedString()
        combination.append(noOTP)
        combination.append(resend)

        self.resendOTPLabel.attributedText = combination
        self.verifyButton.setTitle(AppLocalizationString.verify.uppercased(), for: .normal)

    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    if self.toChangeNumber == true {
                        self.postMobileVerification(retryAPIID: retryAPIID, canShowLoader: true)
                    } else {
                        self.postEmailVerification(retryAPIID: retryAPIID, canShowLoader: true)
                    }
                } else if retryAPIID == 1001 {
                    self.postResendOTP(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func postMobileVerification(retryAPIID: Int, canShowLoader: Bool) {
        if self.OTP1TextField.text.isNilOrEmpty || self.OTP2TextField.text.isNilOrEmpty || self.OTP3TextField.text.isNilOrEmpty || self.OTP4TextField.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseenterotp, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            return
        }
        let str_otp = String(format: "%@%@%@%@", self.OTP1TextField.text!, self.OTP2TextField.text!, self.OTP3TextField.text!, self.OTP4TextField.text!)

        let param = String(format: "token=%@&otp=%@", self.token, str_otp)
        self.changeInformationOTPVerificationViewModel.postMobileVerification(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postMobileVerification, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postEmailVerification(retryAPIID: Int, canShowLoader: Bool) {
        if self.OTP1TextField.text.isNilOrEmpty || self.OTP2TextField.text.isNilOrEmpty || self.OTP3TextField.text.isNilOrEmpty || self.OTP4TextField.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseenterotp, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            return
        }
        let strOTP = String(format: "%@%@%@%@", self.OTP1TextField.text!, self.OTP2TextField.text!, self.OTP3TextField.text!, self.OTP4TextField.text!)

        let param = String(format: "token=%@&otp=%@", self.token, strOTP)
        self.changeInformationOTPVerificationViewModel.postEmailVerification(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postEmailVerification, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postResendOTP(retryAPIID: Int, canShowLoader: Bool) {
        let param =  String(format: "token=%@", self.token)
        self.changeInformationOTPVerificationViewModel.postResendOTP(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postResendOTP, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func resendOTPButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1001)
    }
    @IBAction func verifyButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    @IBAction func editButtonPressed(_ sender: UIButton) {
        self.navigateBackToViewController()
    }
    // MARK: - Custom Methods
    func navigatetoViewController() {
        self.appDelegate?.saveDefaultValues()
        self.appDelegate?.checkInitialViewController()
    }
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if (self.OTP1TextField.text.isNilOrEmpty) || (self.OTP2TextField.text.isNilOrEmpty) || (self.OTP3TextField.text.isNilOrEmpty) || (self.OTP4TextField.text.isNilOrEmpty) {
                self.setButtonDisable()
            } else {
                self.setButtonEnable()
            }
        }
    }
    func setButtonDisable() {
        self.verifyButton.isUserInteractionEnabled = false
        self.verifyButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.verifyButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.verifyButton.setNeedsDisplay()
        self.verifyButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.view.endEditing(true)
        self.verifyButton.isUserInteractionEnabled = true
        self.verifyButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.verifyButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.verifyButton.setNeedsDisplay()
        self.verifyButton.layoutIfNeeded()
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
    @objc func editingChanged(_ textField: UITextField) {
        // here check you text field's input Type
        if textField.textContentType == UITextContentType.oneTimeCode {
            // here split the text to your four text fields
            if let otpCode = textField.text, otpCode.count > 3 {
                self.OTP1TextField.text = String(otpCode[otpCode.startIndex])
                self.OTP2TextField.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 1)])
                self.OTP3TextField.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 2)])
                self.OTP4TextField.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 3)])
            }
        }
        self.setUserInteractionButton()
    }
}
extension ChangeInformationOTPVerificationViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension ChangeInformationOTPVerificationViewController: ProtocolNetworkRechabilityDelegate {
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
