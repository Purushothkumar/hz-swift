//
//  SurveySuccessViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 17/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class SurveySuccessViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var surveyStackView: UIStackView!
    @IBOutlet var titleLabel: Title2FontLabel!
    @IBOutlet var messsageLabel: BodyFontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!

    @IBOutlet var bannerheaderLabel: CalloutFontLabel!

    // MARK: - Lets and Var
    var isFrom = ""
    var message = ""

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.setNavigationBar()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        let view3 = self.surveyStackView.arrangedSubviews[3]// message
        if self.message.isEmpty {
            view3.isHidden = true
        } else {
            view3.isHidden = false
        }
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = true
        self.navigationBar.isRightViewHidden = false
        self.navigationBar.leftImage = ""
        self.navigationBar.rightImage = Asset.xlargewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.quickSurvey
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.titleLabel.text = AppLocalizationString.thankYou
        self.messsageLabel.text = message.capitalized
        self.descriptionLabel.text = AppLocalizationString.surveydesc
        self.bannerheaderLabel.text = AppLocalizationString.youmayliketotryourotherservices
    }

    // MARK: - IBAction
    @IBAction func bookAppointmentPressed(_ sender: UIButton) {
        self.navigateToBookAppointmentLocationViewController(isFrom: IsNavigateFrom.baSurveySuccess.rawValue)
    }
    @IBAction func onlineConsultAudiologistButtonPressed(_ sender: UIButton) {
        self.navigateToOnlineConsultationLocationViewController(isFrom: IsNavigateFrom.ocSurveySuccess.rawValue)
    }
    @IBAction func fhaButtonPressed(_ sender: UIButton) {
        self.navigateToFindRightDeviceIntroductionViewController(isFrom: IsNavigateFrom.fhaSurveySuccess.rawValue)
    }
}
extension SurveySuccessViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {}
    func rightButtonPressed() {
       if self.isFrom == IsNavigateFrom.surveyMenu.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        }
    }
}
