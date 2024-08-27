//
//  OTPSuccessViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 13/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class OTPSuccessViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet var navigationBar: LogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    //    @IBOutlet var mainScrollView: UIScrollView!
    
    @IBOutlet var borderStackView: UIStackView!
    @IBOutlet var mainStackView: UIStackView!
    
    //    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var clearBackgroundView: UIView!
    @IBOutlet var borderBackgroundView: UIView!
    
    @IBOutlet var titleView: UIView!
    @IBOutlet var titleLabel: Title2FontLabel!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var buttonView: UIView!
    @IBOutlet var verifyButton: CalloutBackgroundButton!
    
    // MARK: - Lets and Var
    var otpVerificationViewModel = OTPVerificationViewModel()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var isFrom = ""
    var isWishList = false
    var productUID = ""
    var isLogin = false
    
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
        
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = true
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
        self.titleLabel.text = isLogin == true ? AppLocalizationString.loginConfirmation : AppLocalizationString.signupConfirmation
        self.descriptionLabel.text = isLogin == true ? AppLocalizationString.loginMessage : AppLocalizationString.signupMessage
        self.verifyButton.setTitle(AppLocalizationString.ok.uppercased(), for: .normal)
    }
    // MARK: - IBAction
    @IBAction func verifyButtonPressed(_ sender: UIButton) {
        self.setNavigationControl()
    }
    
    // MARK: - Custom Methods
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
}
extension OTPSuccessViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
    }
    func rightButtonPressed() {
    }
}
