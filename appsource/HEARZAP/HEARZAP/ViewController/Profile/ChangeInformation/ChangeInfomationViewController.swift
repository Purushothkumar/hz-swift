//
//  ChangeInformationViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 14/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChangeInformationViewController: UIViewController, UITextFieldDelegate {
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
    @IBOutlet var contentView: UIView!
    @IBOutlet var buttonView: UIView!

    @IBOutlet var titleLabel: Title2FontLabel!

    @IBOutlet var changeInformationHintLabel: Caption1FontLabel!
    @IBOutlet var changeInformationLabel: Caption2FontLabel!

    @IBOutlet var changeInformationTextfield: Caption1FontTextfield!

    @IBOutlet var updateButton: CalloutBackgroundButton!

    // MARK: - Lets and Var
    var activeField = UITextField()
    var changeInformationViewModel = ChangeInformationViewModel()

    var toChangeNumber = false
    var changeData = ""

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
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        self.borderBackgroundView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.borderBackgroundView.clipsToBounds = true
        self.changeInformationTextfield.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.changeInformationTextfield.clipsToBounds = true
        self.changeInformationTextfield.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.changeInformationTextfield.layer.borderWidth = 1.0
        self.changeInformationTextfield.setLeftPaddingPoints(10.0)
        self.changeInformationTextfield.setRightPaddingPoints(10.0)
        [self.changeInformationTextfield].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        self.setUserInteractionupdateButton()
        self.changeInformationTextfield.keyboardType = self.toChangeNumber == true ? .numberPad : .emailAddress
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
        self.changeInformationHintLabel.text = self.toChangeNumber == true ? AppLocalizationString.pleaseEnterYourMobileNumber : AppLocalizationString.pleaseEnterYourEmailAddress
        self.titleLabel.text = self.toChangeNumber == true ? AppLocalizationString.enterMobileNumber : AppLocalizationString.emailAddress
        self.changeInformationLabel.text = self.toChangeNumber == true ? AppLocalizationString.enterYourMobileNumber: AppLocalizationString.enterEmailAddress
        self.changeInformationHintLabel.text = AppLocalizationString.wesendyouanOTPforverification
        self.changeInformationTextfield.placeholder = self.toChangeNumber == true ? AppLocalizationString.pleaseEnterYourMobileNumber : AppLocalizationString.pleaseEnterYourEmailAddress
        self.updateButton.setTitle(AppLocalizationString.update.uppercased(), for: .normal)
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    if self.toChangeNumber == true {
                        self.postChangePhone(retryAPIID: retryAPIID, canShowLoader: true)
                    } else {
                        self.postChangeEmail(retryAPIID: retryAPIID, canShowLoader: true)
                    }
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func postChangePhone(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.changeInformationTextfield.text.isNilOrEmpty) {
            let param =  String(format: "phone_number=%@%@", "+91".allowSpecialCharacters, self.changeInformationTextfield.text!)
            self.changeInformationViewModel.postChangePhone(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postChangePhone, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    func postChangeEmail(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.changeInformationTextfield.text.isNilOrEmpty) {
            let param =  String(format: "email_address=%@", self.changeInformationTextfield.text!.allowSpecialCharacters)
            self.changeInformationViewModel.postChangeEmail(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postChangeEmail, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    // MARK: - IBAction
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }

    // MARK: - Custom Methods
    func setUserInteractionupdateButton() {
        DispatchQueue.main.async {
            if self.changeInformationTextfield.text.isNilOrEmpty {
                self.setButtonDisable()
            } else {
                if self.toChangeNumber == true {
                    if self.changeInformationTextfield.text!.count < 10 {
                        self.setButtonDisable()
                    } else {
                        self.setButtonEnable()
                    }
                } else {
                    if self.changeInformationTextfield.text.isNilOrEmpty {
                        self.setButtonDisable()
                    } else if self.changeInformationTextfield.text!.count <= 500 && self.changeInformationTextfield.text!.isEmailValid {
                        self.setButtonEnable()
                    } else {
                        self.setButtonDisable()
                    }
                }
            }
        }
    }
    func setButtonDisable() {
        self.updateButton.isUserInteractionEnabled = false
        self.updateButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.updateButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.updateButton.setNeedsDisplay()
        self.updateButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.updateButton.isUserInteractionEnabled = true
        self.updateButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.updateButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.updateButton.setNeedsDisplay()
        self.updateButton.layoutIfNeeded()
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
        var regEx = ""

        if textField == self.changeInformationTextfield && self.toChangeNumber == true {
            maxLength = 10
            regEx = AppConstantValue.numericRegEx
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        } else {
            maxLength = 500
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    @objc func editingChanged(_ textField: UITextField) {
        self.setUserInteractionupdateButton()
    }
}
extension ChangeInformationViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension ChangeInformationViewController: ProtocolNetworkRechabilityDelegate {
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
