//
//  YoutubePlayerViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 28/12/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import YouTubePlayer

class YoutubePlayerViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var playerView: UIView!
    @IBOutlet var youTubePlayerView: YouTubePlayerView!
    @IBOutlet var playerViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    var servicePosterVideoLink = ""

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.setNavigationBar()
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
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.playerViewHeight.constant = 0
        if !(self.servicePosterVideoLink.isEmpty) {
            let servicePosterVideoLinkid = self.servicePosterVideoLink.extractYoutubeIDFromLink()
            if !(servicePosterVideoLinkid.isNilOrEmpty) {
                self.playerViewHeight.constant = CGFloat(screenFrameWidth) * CGFloat(AppConstantValue.screen206slash375)
                self.youTubePlayerView.loadVideoID("\(servicePosterVideoLinkid!)")
            }
        }
    }

    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = ""
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
}
extension YoutubePlayerViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
