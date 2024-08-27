//
//  BlogContainerViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 28/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BlogContainerViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainBackgroundView: UIView!
    @IBOutlet var blogView: UIView!
    @IBOutlet var blogTitleLabel: Title2FontLabel!
    @IBOutlet var blogDescriptionLabel: FootnoteFontLabel!

    @IBOutlet var blogSelectionView: UIView!
    @IBOutlet var blogSelectionStackView: UIStackView!

    @IBOutlet var tipsSelectionView: UIView!
    @IBOutlet var tipsSelectionButton: FootnoteOutlineButton!
    @IBOutlet var tipsSelectionViewWidth: NSLayoutConstraint!

    @IBOutlet var careMaintenanceSelectionView: UIView!
    @IBOutlet var careMaintenanceSelectionButton: FootnoteOutlineButton!
    @IBOutlet var careMaintenanceSelectionViewWidth: NSLayoutConstraint!

    @IBOutlet var articlesContainerView: UIView!
    @IBOutlet var tipsContainerView: UIView!
    @IBOutlet var careMaintenanceSelectionContainerView: UIView!

    // MARK: - Lets and Var

    var selectedIndex = 0

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
        self.tipsSelectionViewWidth.constant = CGFloat(screenFrameWidth) * CGFloat(75/375.0)
        self.careMaintenanceSelectionViewWidth.constant = CGFloat(screenFrameWidth) * CGFloat(200/375.0)

       if self.selectedIndex == 0 {
            self.setDefaultTipsSelection()
        } else if self.selectedIndex == 1 {
            self.setDefaultCareMaintenanceSelection()
        }
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.tips
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.blogTitleLabel.text = AppLocalizationString.hearingTipsblogs
        self.blogDescriptionLabel.text = AppLocalizationString.gettoknowmoreaboutHearingCareandHearingRelatedIssues
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {

            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }

    // MARK: - IBAction


    @IBAction func tipsSelectionButtonPressed(_ sender: UIButton) {
        self.setDefaultTipsSelection()
    }
    @IBAction func careMaintenanceSelectionButtonPressed(_ sender: UIButton) {
        self.setDefaultCareMaintenanceSelection()
    }

    // MARK: - Custom Methods
    func setDefaultBlogSelection() {
        self.tipsSelectionView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.tipsSelectionButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.careMaintenanceSelectionView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.careMaintenanceSelectionButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.articlesContainerView.isHidden = true
        self.tipsContainerView.isHidden = true
        self.careMaintenanceSelectionContainerView.isHidden = true
    }

    func setDefaultTipsSelection() {
        self.selectedIndex = 0
        self.setDefaultBlogSelection()
        self.tipsSelectionView.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
        self.tipsSelectionButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.tipsContainerView.isHidden = false
    }
    func setDefaultCareMaintenanceSelection() {
        self.selectedIndex = 1
        self.setDefaultBlogSelection()
        self.careMaintenanceSelectionView.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
        self.careMaintenanceSelectionButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.careMaintenanceSelectionContainerView.isHidden = false
    }
}
extension BlogContainerViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension BlogContainerViewController: ProtocolNetworkRechabilityDelegate {
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
