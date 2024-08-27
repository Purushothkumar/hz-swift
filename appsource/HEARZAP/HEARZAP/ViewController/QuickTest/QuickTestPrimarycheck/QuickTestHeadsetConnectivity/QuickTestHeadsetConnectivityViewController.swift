//
//  QuickTestHeadsetConnectivityViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 04/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FLAnimatedImage
import SwiftGifOrigin
import AVFoundation

class QuickTestHeadsetConnectivityViewController: UIViewController {
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
    
    @IBOutlet var userInfoView: UIView!
    @IBOutlet var userInfoNameLabel: FootnoteFontLabel!
    @IBOutlet var userdescriptionLabel: CalloutFontLabel!
    
    @IBOutlet var deviceConnectionView: UIView!
    @IBOutlet var deviceConnectionImageView: FLAnimatedImageView!
    @IBOutlet var deviceConnectionImageViewWidth: NSLayoutConstraint!
    
    @IBOutlet var quickTestStatusView: QuickTestStatusView!
    
    // MARK: - Lets and Var
    var isFrom = ""
    let audioSession = AVAudioSession.sharedInstance()
    var isHeadPhoneDetected = false
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
        self.setButtonDisable()
        self.getConnectivity()
        NotificationCenter.default.addObserver(self, selector: #selector(self.audioRouteChangeListener(notification:)), name: AVAudioSession.routeChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: AVAudioSession.routeChangeNotification, object: nil)
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
        self.deviceConnectionImageViewWidth.constant = CGFloat(screenFrameWidth) * CGFloat(AppConstantValue.screen163slash375)
        
        self.updateConnectorView(showImage1: false, showImage2: false, showImage3: true, isHeadsetConnected: true, isNoiseDetected: false, isEarchecked: true)
        self.setButtonDisable()
        self.getConnectivity()
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
        self.userdescriptionLabel.text = ""
        self.setCommonTitleView()
    }
    // MARK: - Notification listener
    @objc func audioRouteChangeListener(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let reasonRaw = userInfo[AVAudioSessionRouteChangeReasonKey] as? NSNumber, let reason = AVAudioSession.RouteChangeReason(rawValue: reasonRaw.uintValue)
        else { fatalError("Strange... could not get routeChange") }
        switch reason {
        case .newDeviceAvailable:
            self.getConnectivity()
            break
        case .oldDeviceUnavailable:
            self.setButtonDisable()
            break
        default:
            self.setButtonDisable()
            break
        }
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
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.moveToQuickTestNoiseLevelViewController()
    }
    
    // MARK: - Custom Methods
    func getConnectivity() {
        var currentRoute = AVAudioSession.sharedInstance().currentRoute
        if currentRoute.outputs.count != 0 {
            for description in currentRoute.outputs {
                if (description.portType == AVAudioSession.Port.headphones) || (description.portType == AVAudioSession.Port.bluetoothA2DP) {
                    self.setButtonEnable()
                    self.moveToQuickTestNoiseLevelViewController()
                } else if (description.portType == AVAudioSession.Port.builtInReceiver) || (description.portType == AVAudioSession.Port.builtInSpeaker)  || (description.portType == AVAudioSession.Port.builtInMic) {
                    do {
                        try audioSession.setCategory(.playAndRecord, mode: .default, options: [.allowBluetoothA2DP])
                        try self.audioSession.setActive(true)
                        currentRoute = AVAudioSession.sharedInstance().currentRoute
                        if currentRoute.outputs.count != 0 {
                            for description in currentRoute.outputs {
                                if (description.portType == AVAudioSession.Port.headphones) || (description.portType == AVAudioSession.Port.bluetoothA2DP) {
                                    self.setButtonEnable()
                                    self.moveToQuickTestNoiseLevelViewController()
                                } else {
                                    self.setButtonDisable()
                                }
                            }
                        } else {
                            self.setButtonDisable()
                        }
                    } catch {
                        self.setButtonDisable()
                    }
                } else {
                    self.setButtonDisable()
                }
            }
        } else {
            self.setButtonDisable()
        }
    }
    func setButtonDisable() {
//        self.nextButton.isUserInteractionEnabled = false
//        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
//        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
//        self.nextButton.setNeedsDisplay()
//        self.nextButton.layoutIfNeeded()
        self.deviceConnectionImageView.image = UIImage.gif(name: Asset.quicktestconnectivity)
        self.updateConnectorView(showImage1: false, showImage2: false, showImage3: false, isHeadsetConnected: true, isNoiseDetected: false, isEarchecked: false)
        self.userdescriptionLabel.text = AppLocalizationString.connectyourheadphone
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
//        self.nextButton.isUserInteractionEnabled = true
//        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
//        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
//        self.nextButton.setNeedsDisplay()
//        self.nextButton.layoutIfNeeded()
        self.deviceConnectionImageView.image = UIImage(named: Asset.quicktestconnect)
        self.updateConnectorView(showImage1: true, showImage2: false, showImage3: false, isHeadsetConnected: false, isNoiseDetected: false, isEarchecked: false)
        self.userdescriptionLabel.text = ""
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func updateConnectorView(showImage1: Bool, showImage2: Bool, showImage3: Bool, isHeadsetConnected: Bool, isNoiseDetected: Bool, isEarchecked: Bool) {
        self.quickTestStatusView.setupView(showImage1: showImage1, showImage2: showImage2, showImage3: showImage3, isHeadsetConnected: isHeadsetConnected, isNoiseDetected: isNoiseDetected, isEarchecked: isEarchecked)
    }
    func moveToQuickTestNoiseLevelViewController() {
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .transitionCrossDissolve) {
            if self.isHeadPhoneDetected == false {
                self.isHeadPhoneDetected = true
                self.navigateToQuickTestNoiseLevelViewController(isFrom: self.isFrom, patientData: self.patientData!, sessionID: self.sessionID)
            }
        } completion: {(_) in
            self.isHeadPhoneDetected = false
        }
    }
}
extension QuickTestHeadsetConnectivityViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToQuickTestProfileViewController()
    }
    func rightButtonPressed() {
    }
}
extension QuickTestHeadsetConnectivityViewController: ProtocolNetworkRechabilityDelegate {
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
