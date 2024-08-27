//
//  QuickTestEarCheckViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 04/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FLAnimatedImage
import SwiftGifOrigin
import AVFoundation
import MediaPlayer

class QuickTestEarCheckViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var threeDotCircleView: ThreeDotCircleView!
    
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var quickHumanView: UIView!
    @IBOutlet var quickHumanImageView: UIImageView!
    @IBOutlet var quickHumanImageViewWidth: NSLayoutConstraint!
    @IBOutlet var leftwaveImageView: FLAnimatedImageView!
    @IBOutlet var rightwaveImageView: FLAnimatedImageView!
    
    @IBOutlet var userInfoView: UIView!
    @IBOutlet var userInfoNameLabel: FootnoteFontLabel!
    @IBOutlet var userdescriptionLabel: CalloutFontLabel!
    
    @IBOutlet var successView: UIView!
    @IBOutlet var bannerImageView: FLAnimatedImageView!
    
    @IBOutlet var quickTestStatusView: QuickTestStatusView!
    
    @IBOutlet var loaderView: UIView!
    @IBOutlet var imageview0: FLAnimatedImageView!
    @IBOutlet var imageview1: FLAnimatedImageView!
    @IBOutlet var imageview2: FLAnimatedImageView!
    @IBOutlet var imageview3: FLAnimatedImageView!
    @IBOutlet var imageview4: FLAnimatedImageView!
    
    // MARK: - Lets and Var
    var isFrom = ""
    var dictLeft = [String: String]()
    var dictRight = [String: String]()
    var arrayLeft = [Int]()
    var arrayRight = [Int]()
    
    var count = 0
    var patientData: PatientList?
    var sessionID = ""
    var patientName = ""
    
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
        if self.patientData != nil {
            if !(self.patientData!.name.isNilOrEmpty) {
                self.patientName = self.patientData!.name!
            }
        }
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.setThreeDotCircleView()
        
        self.quickHumanImageViewWidth.constant = CGFloat(screenFrameWidth) * CGFloat(AppConstantValue.screen192slash375)
        self.updateConnectorView(showImage1: true, showImage2: true, showImage3: false, isHeadsetConnected: true, isNoiseDetected: true, isEarchecked: false)
        self.leftwaveImageView.image = UIImage.gif(name: Asset.wave)
        self.rightwaveImageView.image = UIImage.gif(name: Asset.wave)
        
        self.leftwaveImageView.isHidden = true
        self.rightwaveImageView.isHidden = true
        self.bannerImageView.image = UIImage(named: Asset.earchecksuccess)
        self.startAnimation()
        
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftdarkblue
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.rapidHearingTest.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF,titleTextColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.QCStep2Title.capitalized
        let descriptionMessage = AppLocalizationString.QCStep2Desc.capitalized
        
        self.commonTitleView.setupView(titleMessage: titlemessage, descriptionMessage: descriptionMessage,commonTitlebackgroundViewColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
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
    // MARK: - Set Three Dot Circle View
    func setThreeDotCircleView() {
        self.threeDotCircleView.setupView(button1image: Asset.recordcircleblue, button2image: Asset.circlegrey, button3image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_blue_E7F4FF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        if self.patientName.isEmpty {
            self.userInfoNameLabel.text = String(format: "%@", AppLocalizationString.hello)
        } else {
            self.userInfoNameLabel.text = String(format: "%@ %@", AppLocalizationString.hello, self.patientName)
        }
        self.userdescriptionLabel.text = AppLocalizationString.youregoodtogo
        self.setCommonTitleView()
    }
    // MARK: - Notification listener
    
    
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
    
    // MARK: - Custom Methods
    func startAnimation() {
        if self.count < 5 {
            self.view.isUserInteractionEnabled = false
            self.perform(#selector(self.drawloader), with: nil, afterDelay: 0.5)
        } else {
            self.view.isUserInteractionEnabled = true
            self.navigateToQuickTestSelectEarViewController(isFrom: self.isFrom, earTestCount: 0, selectedEar: "", patientData: self.patientData!, sessionID: self.sessionID, dictLeft: self.dictLeft, dictRight: self.dictRight, arrayLeft: arrayLeft, arrayRight: arrayRight)
        }
    }
    @objc func drawloader() {
        self.imageview0.image = UIImage(named: Asset.squaregreyfill)
        self.imageview1.image = UIImage(named: Asset.squaregreyfill)
        self.imageview2.image = UIImage(named: Asset.squaregreyfill)
        self.imageview3.image = UIImage(named: Asset.squaregreyfill)
        self.imageview4.image = UIImage(named: Asset.squaregreyfill)
        if self.count == 4 {
            self.imageview0.image = UIImage(named: Asset.squarelightbluefill)
            self.imageview1.image = UIImage(named: Asset.squarelightbluefill)
            self.imageview2.image = UIImage(named: Asset.squarelightbluefill)
            self.imageview3.image = UIImage(named: Asset.squarelightbluefill)
            self.imageview4.image = UIImage(named: Asset.squarelightbluefill)
        } else if self.count == 3 {
            self.imageview0.image = UIImage(named: Asset.squarelightbluefill)
            self.imageview1.image = UIImage(named: Asset.squarelightbluefill)
            self.imageview2.image = UIImage(named: Asset.squarelightbluefill)
            self.imageview3.image = UIImage(named: Asset.squarelightbluefill)
        } else if self.count == 2 {
            self.imageview0.image = UIImage(named: Asset.squarelightbluefill)
            self.imageview1.image = UIImage(named: Asset.squarelightbluefill)
            self.imageview2.image = UIImage(named: Asset.squarelightbluefill)
        } else if self.count == 1 {
            self.imageview0.image = UIImage(named: Asset.squarelightbluefill)
            self.imageview1.image = UIImage(named: Asset.squarelightbluefill)
        } else {
            self.imageview0.image = UIImage(named: Asset.squarelightbluefill)
        }
        
        self.count += 1
        self.startAnimation()
    }
    
    func updateConnectorView(showImage1: Bool, showImage2: Bool, showImage3: Bool, isHeadsetConnected: Bool, isNoiseDetected: Bool, isEarchecked: Bool) {
        self.quickTestStatusView.setupView(showImage1: showImage1, showImage2: showImage2, showImage3: showImage3, isHeadsetConnected: isHeadsetConnected, isNoiseDetected: isNoiseDetected, isEarchecked: isEarchecked)
    }
}
extension QuickTestEarCheckViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToQuickTestProfileViewController()
    }
    func rightButtonPressed() {
    }
}
extension QuickTestEarCheckViewController: ProtocolNetworkRechabilityDelegate {
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
