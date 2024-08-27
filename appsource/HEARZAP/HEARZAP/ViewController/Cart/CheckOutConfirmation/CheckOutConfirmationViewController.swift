//
//  CheckOutConfirmationViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 09/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CheckOutConfirmationViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var orderConfirmationTitleView: UIView!
    @IBOutlet var orderConfirmationTitleLabel: CalloutFontLabel!

    @IBOutlet var orderConfirmationDescriptionView: UIView!
    @IBOutlet var orderConfirmationDescriptionLabel: Caption1FontLabel!

    @IBOutlet var continueShoppingButton: FootnoteOutlineButton!
    @IBOutlet var myOrderButton: FootnoteBackgroundButton!
    @IBOutlet var homeButton: CalloutOutlineButton!

    @IBOutlet var rateusTitleLabel: CalloutFontLabel!
    @IBOutlet var rateusDescriptionLabel: Caption1FontLabel!
    @IBOutlet var rateusButton: FootnoteOutlineButton!

    // MARK: - Lets and Var

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

        self.continueShoppingButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.continueShoppingButton.layer.borderWidth = 1.0
        self.continueShoppingButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.continueShoppingButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.continueShoppingButton.clipsToBounds = true

        self.homeButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.homeButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.homeButton.clipsToBounds = true

        self.myOrderButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.myOrderButton.clipsToBounds = true

        self.rateusButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.rateusButton.layer.borderWidth = 1.0
        self.rateusButton.setTitleColor(UIColor.colorLiteral.theme_black_333333, for: .normal)
        self.rateusButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.rateusButton.clipsToBounds = true

    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = true
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = ""
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.orderConfirmation
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }

    // MARK: - Localization String
    func changeLanguageFormat() {
        self.orderConfirmationTitleLabel.text = AppLocalizationString.orderConfirmed.uppercased()
        self.orderConfirmationDescriptionLabel.text = AppLocalizationString.yourOrderbeenplacedsuccessfully

        self.continueShoppingButton.setTitle(AppLocalizationString.continueshopping.uppercased(), for: .normal)
        self.homeButton.setTitle(AppLocalizationString.backtohome.uppercased(), for: .normal)
        self.myOrderButton.setTitle(AppLocalizationString.myOrders.uppercased(), for: .normal)

        self.rateusTitleLabel.text = AppLocalizationString.lovinghearzap
        self.rateusDescriptionLabel.text = AppLocalizationString.showusyourlovebyratingusontheAppStore
        self.rateusButton.setTitle(AppLocalizationString.rateusonappstore.uppercased(), for: .normal)

    }

    // MARK: - IBAction
    @IBAction func continueShoppingButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()

    }
    @IBAction func myOrderButtonPressed(_ sender: UIButton) {
        self.navigateToOrderListViewController(isFrom: IsNavigateFrom.orderSuccess.rawValue)
    }
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.home, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    @IBAction func rateusButtonPressed(_ sender: UIButton) {
        if !(AppLocalizationString.rateusappstorstr.isEmpty) {
            guard let appURL = URL(string: AppLocalizationString.rateusappstorstr.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
}

extension CheckOutConfirmationViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {}
    func rightButtonPressed() {}
}
