//
//  QuickTestUserVerificationViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 13/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift



class QuickTestUserVerificationViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var threeDotCircleView: ThreeDotCircleView!

    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!

    @IBOutlet var borderStackView: UIStackView!
    @IBOutlet var mainStackView: UIStackView!

    @IBOutlet var mainBackgroundView: UIView!
    @IBOutlet var clearBackgroundView: UIView!
    @IBOutlet var borderBackgroundView: UIView!
    @IBOutlet var titleView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var buttonView: UIView!

    @IBOutlet var titleLabel: Title2FontLabel!
    @IBOutlet var mobileNumberLabel: BodyFontLabel!

    @IBOutlet var OTP1TextField: Caption1FontTextfield!
    @IBOutlet var OTP2TextField: Caption1FontTextfield!
    @IBOutlet var OTP3TextField: Caption1FontTextfield!
    @IBOutlet var OTP4TextField: Caption1FontTextfield!

    @IBOutlet var verifyButton: CalloutBackgroundButton!
    @IBOutlet var editButton: FootnoteOutlineButton!

    @IBOutlet var resendOTPView: UIView!
    @IBOutlet var resendOTPButton: FootnoteOutlineButton!
    @IBOutlet var resendOTPLabel: Caption1FontLabel!

    // MARK: - Lets and Var
    var otpText = String()
    var activeField = UITextField()
    var quickTestUserVerificationViewModel = QuickTestUserVerificationViewModel()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var isFrom = ""
    var name = ""
    var mobileNumber = ""
    var phoneToken = ""
    var email = ""
    var dictLeft = [String: String]()
    var dictRight = [String: String]()
    var arrayLeft = [Int]()
    var arrayRight = [Int]()
    var patientData: PatientList?
    var sessionID = ""


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
        self.setThreeDotCircleView()
        self.setButtonDisable()


        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        self.mobileNumberLabel.text = self.mobileNumber.hasPrefix("+91") == true ? self.mobileNumber : "\("+91")\(self.mobileNumber)"
        self.borderBackgroundView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.borderBackgroundView.clipsToBounds = true
        
        self.OTP1TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP1TextField.clipsToBounds = true
        self.OTP1TextField.layer.borderColor = UIColor.colorLiteral.theme_grey_3C3C43_18.cgColor
        self.OTP1TextField.layer.borderWidth = 1.0
        self.OTP2TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP2TextField.clipsToBounds = true
        self.OTP2TextField.layer.borderColor = UIColor.colorLiteral.theme_grey_3C3C43_18.cgColor
        self.OTP2TextField.layer.borderWidth = 1.0
        self.OTP3TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP3TextField.clipsToBounds = true
        self.OTP3TextField.layer.borderColor = UIColor.colorLiteral.theme_grey_3C3C43_18.cgColor
        self.OTP3TextField.layer.borderWidth = 1.0
        self.OTP4TextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.OTP4TextField.clipsToBounds = true
        self.OTP4TextField.layer.borderColor = UIColor.colorLiteral.theme_grey_3C3C43_18.cgColor
        self.OTP4TextField.layer.borderWidth = 1.0

        self.OTP1TextField.delegate = self
        self.OTP2TextField.delegate = self
        self.OTP3TextField.delegate = self
        self.OTP4TextField.delegate = self

        self.OTP1TextField.tintColor = UIColor.colorLiteral.theme_black_333333
        self.OTP2TextField.tintColor = UIColor.colorLiteral.theme_black_333333
        self.OTP3TextField.tintColor = UIColor.colorLiteral.theme_black_333333
        self.OTP4TextField.tintColor = UIColor.colorLiteral.theme_black_333333
        [self.OTP1TextField, self.OTP2TextField, self.OTP3TextField, self.OTP4TextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        self.setUserInteractionButton()
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftdarkblue
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.rapidHearingTest.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF,titleTextColor: UIColor.colorLiteral.theme_blue_112F70)
    }

    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.tellusStepTitle.uppercased()
        let descriptionMessage = AppLocalizationString.tellusStepDesc
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
    // MARK: - Set Three Dot Circle View recordcircleblue
    func setThreeDotCircleView() {
        self.threeDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.checkcircleblue, button3image: Asset.recordcircleblue,circleViewBackgroundColor: UIColor.colorLiteral.theme_blue_E7F4FF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.setCommonTitleView()

        self.titleLabel.text = AppLocalizationString.verifyMobileNumber
        self.verifyButton.setTitle(AppLocalizationString.verify.uppercased(), for: .normal)

        let noOTPstr = AppLocalizationString.didntrecieveOTP
        let resendstr = AppLocalizationString.resend.uppercased()

        let noOTPAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]

        let resendAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.medium.size(13)]

        let noOTP = NSMutableAttributedString(string: String(format: "%@ ", noOTPstr), attributes: noOTPAttributes as [NSAttributedString.Key: Any])
        let resend = NSMutableAttributedString(string: String(format: "%@", resendstr), attributes: resendAttributes as [NSAttributedString.Key: Any])

        let combination = NSMutableAttributedString()
        combination.append(noOTP)
        combination.append(resend)

        self.resendOTPLabel.attributedText = combination
        self.editButton.setTitle(AppLocalizationString.changemobilenumber.capitalized, for: .normal)

    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.postOTPVerification(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.postResendOTP(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func postOTPVerification(retryAPIID: Int, canShowLoader: Bool) {
        if self.OTP1TextField.text.isNilOrEmpty || self.OTP2TextField.text.isNilOrEmpty || self.OTP3TextField.text.isNilOrEmpty || self.OTP4TextField.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseenterotp, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            return
        }
        let strOTP = String(format: "%@%@%@%@", self.OTP1TextField.text!, self.OTP2TextField.text!, self.OTP3TextField.text!, self.OTP4TextField.text!)
        let rightFieldValue = String(format: "%@", dictLeft.count > 0 ? self.stringifyArray(json: dictLeft, prettyPrinted: false) : "{}")
        let leftFieldValue = String(format: "%@", dictRight.count > 0 ? self.stringifyArray(json: dictRight, prettyPrinted: false) : "{}")

//        var uid = ""
        var name = ""
        var dob = ""
//        var genderSlug = ""
        var relationShipSlug = ""
        var relationShip = ""
        var gender = ""

        if patientData != nil {
            if !(patientData!.name.isNilOrEmpty) {
                name = patientData!.name!
            }
//            if !(patientData!.genderSlug.isNilOrEmpty) {
//                genderSlug = patientData!.genderSlug!
//            }
            if !(patientData!.gender.isNilOrEmpty) {
                gender = patientData!.gender!
            }
            if !(patientData!.dob.isNilOrEmpty) {
                dob = patientData!.dob!
            }
            if !(patientData!.relationshipType.isNilOrEmpty) {
                relationShipSlug = patientData!.relationshipType!
            }
            if !(patientData!.relationship.isNilOrEmpty) {
                relationShip = patientData!.relationship!
            }
        }
        if !(strOTP.isEmpty) {
            let param = String(format: "token=%@&otp=%@&left_field_value=%@&right_field_value=%@&profile_name=%@&dob=%@&gender=%@&relationship=%@&relationship_type=%@", phoneToken, strOTP,leftFieldValue,rightFieldValue,name,dob,gender,relationShip,relationShipSlug)
            self.quickTestUserVerificationViewModel.postQuickCheckVerifyOTP(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postQuickCheckVerifyOTP, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }

    func postResendOTP(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.mobileNumber.isEmpty) {
            let param =  String(format: "token=%@", self.phoneToken)
            self.quickTestUserVerificationViewModel.postResendOTP(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postResendOTP, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
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
    func stringifyArray(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        return "{}"
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
extension QuickTestUserVerificationViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension QuickTestUserVerificationViewController: ProtocolNetworkRechabilityDelegate {
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
