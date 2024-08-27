//
//  BookAppointmentUserInfoViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class BookAppointmentUserInfoViewController: UIViewController,UITextFieldDelegate {
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

    @IBOutlet var nameTitleView: UIView!
    @IBOutlet var nameLabel: FootnoteFontLabel!
    @IBOutlet var nameView: UIView!
    @IBOutlet var nameTextField: Caption1FontEditableTextfield!

    @IBOutlet var emailTitleView: UIView!
    @IBOutlet var emailLabel: FootnoteFontLabel!
    @IBOutlet var emailView: UIView!
    @IBOutlet var emailTextField: Caption1FontEditableTextfield!

    @IBOutlet var nextButtonView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!


    // MARK: - Lets and Var
    var isFrom = ""
    var activeField = UITextField()
    var concernID = ""
    var bookAppointmentUserInfoViewModel = BookAppointmentUserInfoViewModel()

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
        self.setButtonDisable()
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        self.nameTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.nameTextField.clipsToBounds = true
        self.nameTextField.layer.borderColor = UIColor.colorLiteral.theme_grey_999999.cgColor
        self.nameTextField.layer.borderWidth = 1.0
        self.nameTextField.setLeftPaddingPoints(10.0)
        self.nameTextField.setRightPaddingPoints(10.0)
        self.nameTextField.delegate = self
        self.nameTextField.text = ""
        self.nameTextField.tintColor = UIColor.colorLiteral.theme_black_333333

        self.emailTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.emailTextField.clipsToBounds = true
        self.emailTextField.layer.borderColor = UIColor.colorLiteral.theme_grey_999999.cgColor
        self.emailTextField.layer.borderWidth = 1.0
        self.emailTextField.setLeftPaddingPoints(10.0)
        self.emailTextField.setRightPaddingPoints(10.0)
        self.emailTextField.delegate = self
        self.emailTextField.text = ""
        self.emailTextField.tintColor = UIColor.colorLiteral.theme_black_333333

        [self.emailTextField,self.nameTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        self.setUserInteractionButton()

    }

    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftdarkblue
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.bookAppointment.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF,titleTextColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.BookAppointmentStep3Title.uppercased()
        let descriptionMessage = AppLocalizationString.BookAppointmentStep3Desc
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
        self.nameTextField.attributedPlaceholder = NSAttributedString(
            string: AppLocalizationString.enteryourname,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_DCDCDD]
        )
        self.emailTextField.attributedPlaceholder = NSAttributedString(
            string: AppLocalizationString.enteryouremailid,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_DCDCDD]
        )
        self.nameLabel.setStarAttributtedText(textmessage: AppLocalizationString.namestar.capitalized, color: UIColor.colorLiteral.theme_red_FF6961)
        self.emailLabel.text = AppLocalizationString.emailid
        self.nextButton.setTitle(AppLocalizationString.submit.uppercased(), for: .normal)
        self.setCommonTitleView()
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.postBookAppointmentCustomerDetail(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func postBookAppointmentCustomerDetail(retryAPIID: Int, canShowLoader: Bool) {
        var param = String(format: "name=%@&email=%@", self.nameTextField.text!.allowSpecialCharacters, self.emailTextField.text!.allowSpecialCharacters)
        let strurl = String(format: "%@%@/", SubAPIUrl.postBookAppointmentCustomerDetail,self.concernID)

        self.bookAppointmentUserInfoViewModel.postBookAppointmentCustomerDetail(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: strurl, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    // MARK: - IBAction
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Custom Methods
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
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if !(self.nameTextField.text.isNilOrEmpty){
                if (self.nameTextField.text!.count <= 50){
                    if !(self.emailTextField.text.isNilOrEmpty){
                        if self.emailTextField.text!.count <= 500 && self.emailTextField.text!.isEmailValid == true {
                            self.setButtonEnable()
                        }
                        else{
                           self.setButtonDisable()
                        }
                    }
                    else{
                        self.setButtonEnable()
                    }
                }
                else{
                    self.setButtonDisable()
                }
            }
        }
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
        if textField == self.nameTextField {
            maxLength = 50
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.nameRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        }
        else{
            maxLength = 500
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
extension BookAppointmentUserInfoViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension BookAppointmentUserInfoViewController: ProtocolNetworkRechabilityDelegate {
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
