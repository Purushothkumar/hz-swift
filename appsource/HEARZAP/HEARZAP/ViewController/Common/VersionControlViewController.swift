//
//  VersionControlViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 01/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Firebase

class VersionControlViewController: UIViewController {
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var linkButton: BackgroundButton!
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var footerView: UIView!
    @IBOutlet var headerViewHeight: NSLayoutConstraint!
    @IBOutlet var footerViewHeight: NSLayoutConstraint!

    var canShowPrimaryMsg = false
    var canShowSecondaryMsg = false
    var canShowBtn = false
    var isHavingAction = false
    var iosBtnLink = ""
    var btnText = ""
    var primaryMsgText = ""
    var secondaryMsgText = ""
    var androidBtnLink = ""

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0
        var heightVersionView: CGFloat = 0
        let headerVersionView = self.mainStackView.arrangedSubviews[0]
        let imageVersionView = self.mainStackView.arrangedSubviews[1]
        let primaryTextVersionView = self.mainStackView.arrangedSubviews[2]
        let secondaryTextVersionView = self.mainStackView.arrangedSubviews[3]
        let btnVersionView = self.mainStackView.arrangedSubviews[4]
        let footerVersionView = self.mainStackView.arrangedSubviews[5]
        primaryTextVersionView.isHidden = true
        secondaryTextVersionView.isHidden = true
        btnVersionView.isHidden = true
        headerVersionView.isHidden = false
        imageVersionView.isHidden = false
        footerVersionView.isHidden = false
        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        // logo
        heightVersionView = CGFloat(36)/* logo height */ + CGFloat(50) /* top and bottom */ + bottomPadding + topPadding
        // primary_msg
        if self.canShowPrimaryMsg == true {
            primaryTextVersionView.isHidden = false
            heightVersionView = heightVersionView + self.heightForText(text: primaryMsgText, Font: AppFont.medium.size(13.0), Width: CGFloat(AppConstantValue.screenWidthminus32)) + 5
        }
        // secondary_msg
        if self.canShowSecondaryMsg == true {
            secondaryTextVersionView.isHidden = false
            heightVersionView = heightVersionView + self.heightForText(text: secondaryMsgText, Font: AppFont.regular.size(13.0), Width: CGFloat(AppConstantValue.screenWidthminus32)) + 5
        }
        // button
        if self.canShowBtn == true {
            btnVersionView.isHidden = false
            heightVersionView = heightVersionView + 40 + 38/*button*/ + 25
        }
        if screenFrameHeight > heightVersionView {
            self.headerViewHeight.constant = (screenFrameHeight - heightVersionView) / 2
            self.footerViewHeight.constant = (screenFrameHeight - heightVersionView) / 2
        } else {
            self.footerViewHeight.constant = 0
            self.headerViewHeight.constant = 0
        }
        self.mainScrollView.sizeToFit()
        self.mainScrollView.contentSize = CGSize(width: self.mainScrollView.frame.size.width, height: self.footerViewHeight.constant + self.footerView.frame.origin.y)
    }

    // MARK: - Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_blue_112F70,style: StatusBarTheme.lightContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Set Initial View
    func setInitialView() {
        self.changeStatusBarColor()
        self.linkButton.setTitle(String(format: "  \(btnText.uppercased())  "), for: .normal)
        self.primaryMessageLabel.text = primaryMsgText
        self.secondaryMessageLabel.text = secondaryMsgText
        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0
        var heightVersionView: CGFloat = 0
        let headerVersionView = self.mainStackView.arrangedSubviews[0]
        let imageVersionView = self.mainStackView.arrangedSubviews[1]
        let primaryTextVersionView = self.mainStackView.arrangedSubviews[2]
        let secondaryTextVersionView = self.mainStackView.arrangedSubviews[3]
        let btnVersionView = self.mainStackView.arrangedSubviews[4]
        let footerVersionView = self.mainStackView.arrangedSubviews[5]
        primaryTextVersionView.isHidden = true
        secondaryTextVersionView.isHidden = true
        btnVersionView.isHidden = true
        headerVersionView.isHidden = false
        imageVersionView.isHidden = false
        footerVersionView.isHidden = false
        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        // logo
        heightVersionView =  CGFloat(36) /* logo height */ + CGFloat(50) /* top and bottom */ + bottomPadding + topPadding
        // primary_msg
        if self.canShowPrimaryMsg == true {
            primaryTextVersionView.isHidden = false
            heightVersionView = self.heightForText(text: primaryMsgText, Font: AppFont.medium.size(13.0), Width: CGFloat(AppConstantValue.screenWidthminus32)) + 5
        }
        // secondary_msg
        if self.canShowSecondaryMsg == true {
            secondaryTextVersionView.isHidden = false
            heightVersionView = self.heightForText(text: secondaryMsgText, Font: AppFont.regular.size(13.0), Width: CGFloat(AppConstantValue.screenWidthminus32)) + 5
        }
        // button
        if self.canShowBtn == true {
            btnVersionView.isHidden = false
            heightVersionView = 40 + 38/*BUTTON*/ + 25
        }
        if screenFrameHeight > heightVersionView {
            self.headerViewHeight.constant = (screenFrameHeight - heightVersionView) / 2
            self.footerViewHeight.constant = (screenFrameHeight - heightVersionView) / 2
        } else {
            self.headerViewHeight.constant = 0
            self.footerViewHeight.constant = 0
        }
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_blue_112F70,style: StatusBarTheme.lightContent.rawValue)
        self.view.layer.layoutIfNeeded()
    }
    // MARK: - IBAction
    @IBAction func linkButtonPressed(_ sender: UIButton) {
        if isHavingAction == true {
            if !(self.iosBtnLink.isEmpty) {
                guard let appURL = URL(string: iosBtnLink.checkhttpCharacter) else {
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
                    self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                }
            } else {
                // empty msg
                self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            }
        } else {
            self.navigateBackToViewController()
        }
    }
}
