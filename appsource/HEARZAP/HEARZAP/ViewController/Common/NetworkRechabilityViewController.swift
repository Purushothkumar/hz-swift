//
//  NetworkRechabilityViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 05/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolNetworkRechabilityDelegate: AnyObject {
    func tryAgainWithID(retryAPIID: Int)
}
class NetworkRechabilityViewController: UIViewController {

    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var tryAgainButton: FootnoteBackgroundButton!
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var footerView: UIView!
    @IBOutlet var headerViewHeight: NSLayoutConstraint!
    @IBOutlet var footerViewHeight: NSLayoutConstraint!

    var retryAPIID = 0
    var primaryMsgText = AppLocalizationString.noInternetConnectionHeader
    var secondaryMsgText = AppLocalizationString.noInternetConnectionDesc
    var btnText = AppLocalizationString.tryAgain

    var protocolNetworkRechabilityDelegate: ProtocolNetworkRechabilityDelegate!

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0
        var viewHeight: CGFloat = 0

        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        // logo
        viewHeight = 36/* logo height */ + 50/* top and bottom */ + bottomPadding + topPadding
        // primary_msg
        viewHeight = viewHeight + self.heightForText(text: primaryMsgText, Font: AppFont.medium.size(13.0), Width: CGFloat(AppConstantValue.screenWidthminus32)) + 5
        // secondary_msg
        viewHeight = viewHeight + self.heightForText(text: secondaryMsgText, Font: AppFont.regular.size(13.0), Width: CGFloat(AppConstantValue.screenWidthminus32)) + 5
        // button
        viewHeight = viewHeight + 40 + 38/*button*/ + 25

        if screenFrameHeight > viewHeight {
            self.headerViewHeight.constant = (screenFrameHeight - viewHeight) / 2
            self.footerViewHeight.constant = (screenFrameHeight - viewHeight) / 2
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

        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0
        var viewHeight: CGFloat = 0

        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        // logo
        viewHeight = 36/* logo height */ + 50/* top and bottom */ + bottomPadding + topPadding
        // primary_msg
        viewHeight = self.heightForText(text: primaryMsgText, Font: AppFont.medium.size(13.0), Width: CGFloat(AppConstantValue.screenWidthminus32)) + 5
        // secondary_msg
        viewHeight = self.heightForText(text: secondaryMsgText, Font: AppFont.regular.size(13.0), Width: CGFloat(AppConstantValue.screenWidthminus32)) + 5
        // button
        viewHeight = 4 + 38/*button*/ + 25
        if screenFrameHeight > viewHeight {
            self.headerViewHeight.constant = (screenFrameHeight - viewHeight) / 2
            self.footerViewHeight.constant = (screenFrameHeight - viewHeight) / 2
        } else {
            self.headerViewHeight.constant = 0
            self.footerViewHeight.constant = 0
        }
        self.view.layer.layoutIfNeeded()
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.tryAgainButton.setTitle(String(format: "  \(btnText.uppercased())  "), for: .normal)
        self.primaryMessageLabel.text = primaryMsgText
        self.secondaryMessageLabel.text = secondaryMsgText
    }
    // MARK: - IBAction
    @IBAction func tryAgainPressed(_ sender: UIButton) {
        if retryAPIID != 0 {
            if Reachability.isConnectedToNetwork() {
                self.dismiss(animated: true) {
                    self.protocolNetworkRechabilityDelegate.tryAgainWithID(retryAPIID: self.retryAPIID)
                }
            }
        }
    }
}
