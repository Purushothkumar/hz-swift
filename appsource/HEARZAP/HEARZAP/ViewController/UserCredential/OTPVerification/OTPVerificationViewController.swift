//
//  OTPVerificationViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 21/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class OTPVerificationViewController: UIViewController, UITextFieldDelegate {
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
    var otpVerificationViewModel = OTPVerificationViewModel()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var isFrom = ""
    var isWishList = false
    var productUID = ""
    var isLogin = false
    var name = ""
    var mobileNumber = ""
    var phoneToken = ""
    
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

        self.mobileNumberLabel.text = self.mobileNumber.hasPrefix("+91") == true ? self.mobileNumber : "\("+91")\(self.mobileNumber)"
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
        
        var url = ""
        if self.isLogin == false {
            url = SubAPIUrl.postSignupVerification
        } else {
            url = SubAPIUrl.postLoginVerification
        }
        if !(strOTP.isEmpty) {
            let param = String(format: "token=%@&otp=%@", phoneToken, strOTP)
            self.otpVerificationViewModel.postOTPVerification(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    
    func postResendOTP(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.mobileNumber.isEmpty) {
            let param =  String(format: "token=%@", self.phoneToken)
            self.otpVerificationViewModel.postResendOTP(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postResendOTP, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
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
    func checkNavigationControl() {
        if self.isLogin == false {
            self.navigateToOTPSuccessViewController(isFrom: self.isFrom, isLogin: self.isLogin, isWishlist: self.isWishList, productUID: self.productUID)
        } else {
            self.setNavigationControl()
        }
    }
    func setNavigationControl() {
        if self.isFrom == IsNavigateFrom.loginMenu.rawValue {
            self.navigateBackToMenuViewControllerFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginOnlineConsultation.rawValue {
            self.navigateBackToOnlineConsultationDemoViewControllerFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginFHA.rawValue {
            self.navigateBackToFindRightDeviceIntroductionViewControllerFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginStoreDetail.rawValue {
            self.navigateBackToStoreDetailViewControllerFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginSurveyMenu.rawValue {
            self.navigateBackToMenuViewControllerSurveyFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginReferFriendMenu.rawValue {
            self.navigateBackToMenuViewControllerReferFriendFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginRegisterDeviceMenu.rawValue {
            self.navigateBackToMenuViewControllerRegisterDeviceFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCouponMenu.rawValue {
            self.navigateBackToMenuViewControllerCouponFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginProfileMenu.rawValue {
            self.navigateBackToMenuViewControllerProfileFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginRewardsMenu.rawValue {
            self.navigateBackToMenuViewControllerRewardsFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginAddressMenu.rawValue {
            self.navigateBackToMenuViewControllerAddressFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginBuyBackMenu.rawValue {
            self.navigateBackToMenuViewControllerBuyBackFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCartHAProductDetail.rawValue {
            self.navigateBackToHAProductDetailViewControllerToCart(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCartProductDetail.rawValue {
            self.navigateBackToProductDetailViewControllerToCart(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginWishlistHAProductDetail.rawValue {
            self.navigateBackToHAProductDetailViewControllerToWishlist(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginWishlistProductDetail.rawValue {
            self.navigateBackToProductDetailViewControllerToWishlist(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCartHAProductDetailLogo.rawValue {
            self.navigateBackToHAProductDetailViewControllerToCartLogo(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCartProductDetailLogo.rawValue {
            self.navigateBackToProductDetailViewControllerToCartLogo(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCartAccessoriesSubcategroryColor.rawValue {
            self.navigateBackToAccessoriesSubCategoryColorViewControllerToCart(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCartViewAll.rawValue {
            self.navigateBackToViewAllProductViewControllerToCart(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCartHearingCare.rawValue {
            self.navigateBackToHearingCareViewControllerToCart(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCartStore.rawValue {
            self.navigateBackToStoreFinderViewControllerToCart(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCartShop.rawValue {
            self.navigateBackToShopCategoryViewControllerToCart(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCartMenu.rawValue {
            self.navigateBackToMenuViewControllerToCart(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginServiceRequestMenu.rawValue {
            self.navigateBackToMenuViewControllerToServiceRequest(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginOrderListMenu.rawValue {
            self.navigateBackToMenuViewControllerToOrderList(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginWishlistMenu.rawValue {
            self.navigateBackToMenuViewControllerToWishlist(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginAudiogramReportMenu.rawValue {
            self.navigateBackToMenuViewControllerToAudiogramReport(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginCartCompare1.rawValue {
            self.navigateBackToCompareProductViewControllerForProduct(isFrom: self.isFrom)
        } else if self.isFrom == IsNavigateFrom.loginCartCompare2.rawValue {
            self.navigateBackToCompareProductViewControllerForProduct(isFrom: self.isFrom)
        } else if self.isFrom == IsNavigateFrom.loginBookAppointment.rawValue {
            self.navigateBackToBookAppointmentDemoViewControllerFromOTP(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginMyAlertHearingCare.rawValue {
            self.navigateBackToHearingCareViewControllerToMyAlert(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginMyAlertStore.rawValue {
            self.navigateBackToStoreFinderViewControllerToMyAlert(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginMyAlertShop.rawValue {
            self.navigateBackToShopCategoryViewControllerToMyAlert(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginMyAlertMenu.rawValue {
            self.navigateBackToMenuViewControllerToMyAlert(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginFRDViewReportQuickCheck.rawValue {
            self.navigateBackToFindRightDeviceUploadReportViewControllerToQuickCheck(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        } else if self.isFrom == IsNavigateFrom.loginViewReportQuickCheck.rawValue {
            self.navigateBackToAudiogramReportViewControllerToQuickCheckView(isFrom: self.isFrom, isWishlist: self.isWishList, productUID: self.productUID)
        }
    }
    // navigateBackToProductDetailViewControllerToWishlist
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
extension OTPVerificationViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension OTPVerificationViewController: ProtocolNetworkRechabilityDelegate {
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
