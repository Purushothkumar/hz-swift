//
//  LoginViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 28/06/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: LogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var mainScrollView: UIScrollView!
    
    @IBOutlet var mainStackView: UIStackView!
    
    @IBOutlet var mainBackgroundView: UIView!
    @IBOutlet var clearBackgroundView: UIView!
    @IBOutlet var borderBackgroundView: UIView!
    @IBOutlet var borderStackView: UIStackView!
    @IBOutlet var titleView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var buttonView: UIView!
    
    @IBOutlet var titleLabel: Title2FontLabel!
    
    @IBOutlet var mobileNumberLabel: Caption1FontLabel!
    @IBOutlet var mobileNumberTextField: Caption1FontTextfield!
    @IBOutlet var mobileNumberHintLabel: Caption2FontLabel!
    
    @IBOutlet var usermessageLabel: Caption1FontLabel!
    @IBOutlet var signupButton: FootnoteOutlineButton!
    
    @IBOutlet var loginButton: CalloutBackgroundButton!
    
    // MARK: - Lets and Var
    var loginViewModel = LoginViewModel()
    var isFrom = ""
    var isWishList = false
    var productUID = ""
    var activeField = UITextField()
    
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
        self.borderBackgroundView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.borderBackgroundView.clipsToBounds = true
        self.mobileNumberTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.mobileNumberTextField.clipsToBounds = true
        self.mobileNumberTextField.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.mobileNumberTextField.layer.borderWidth = 1.0
        self.mobileNumberTextField.setLeftPaddingPoints(10.0)
        self.mobileNumberTextField.setRightPaddingPoints(10.0)
        [self.mobileNumberTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        self.setUserInteractionButton()
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.logoImage = Asset.hzlogo
        self.navigationBar.isLogoHidden = false
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.mobileNumberHintLabel.text = AppLocalizationString.pleaseEnterYourMobileNumber
        self.titleLabel.text = AppLocalizationString.login
        self.mobileNumberLabel.text = AppLocalizationString.enterYourMobileNumber
        self.mobileNumberHintLabel.text = AppLocalizationString.wesendyouanOTPforverification
        self.mobileNumberTextField.placeholder = AppLocalizationString.pleaseEnterYourMobileNumber
        self.loginButton.setTitle(AppLocalizationString.getotp.uppercased(), for: .normal)
        self.signupButton.setTitle(AppLocalizationString.signUp.capitalized, for: .normal)
        self.usermessageLabel.text = AppLocalizationString.donthaveanaccount
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.postLogin(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func postLogin(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.mobileNumberTextField.text.isNilOrEmpty) {
            let param =  String(format: "phone_number=%@%@", "+91".allowSpecialCharacters, self.mobileNumberTextField.text!)
            self.loginViewModel.postLogin(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postLogin, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    
    // MARK: - IBAction
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        self.navigateToSignupViewController(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
    }
    // MARK: - Custom Methods
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if self.mobileNumberTextField.text.isNilOrEmpty {
                self.setButtonDisable()
            } else {
                if self.mobileNumberTextField.text!.count < 10 {
                    self.setButtonDisable()
                } else {
                    self.setButtonEnable()
                }
            }
        }
    }
    func setButtonDisable() {
        self.loginButton.isUserInteractionEnabled = false
        self.loginButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.loginButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.loginButton.setNeedsDisplay()
        self.loginButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.loginButton.isUserInteractionEnabled = true
        self.loginButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.loginButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.loginButton.setNeedsDisplay()
        self.loginButton.layoutIfNeeded()
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
        var maxLength = 10
        if textField == self.mobileNumberTextField {
            maxLength = 10
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
extension LoginViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
        //        self.dismiss(animated: true) {}
    }
    func rightButtonPressed() {}
}
extension LoginViewController: ProtocolNetworkRechabilityDelegate {
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
