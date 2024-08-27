//
//  QuickTestNoiseLevelViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 04/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FLAnimatedImage
import AVFoundation
import PKCCheck

class QuickTestNoiseLevelViewController: UIViewController {
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
    
    @IBOutlet var noiseInfoView: UIView!
    @IBOutlet var noiseInfoTitleLabel: FootnoteFontLabel!
    @IBOutlet var noiseInfodescriptionLabel: CalloutFontLabel!
    
    @IBOutlet var deviceConnectionView: UIView!
    @IBOutlet var FDBarGaugeView: FDBarGauge!
    //    @IBOutlet var deviceConnectionImageView: FLAnimatedImageView!
    //    @IBOutlet var deviceConnectionImageViewWidth: NSLayoutConstraint!
    
    @IBOutlet var quickTestStatusView: QuickTestStatusView!

    
    // MARK: - Lets and Var
    var isFrom = ""
    let audioSession = AVAudioSession.sharedInstance()
    let pkcCheck = PKCCheck()
    var isHeadPhoneConnected = false
    var isNoiseDetected = false
    var isMoved = false
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
        self.toCheckMicrophonePermission()
        NotificationCenter.default.addObserver(self, selector: #selector(self.audioRouteChangeListener(notification:)), name: AVAudioSession.routeChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: AVAudioSession.routeChangeNotification, object: nil)
        self.setButtonDisable()
        self.pkcCheck.decibelStop()
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
        
        self.updateConnectorView(showImage1: true, showImage2: false, showImage3: false, isHeadsetConnected: true, isNoiseDetected: false, isEarchecked: false)
        self.setButtonDisable()
        self.pkcCheck.delegate = self
        self.isHeadPhoneConnected = true
        // noise bar
        self.FDBarGaugeView.numBars = 100
        self.FDBarGaugeView.value =  Double(0.0)
        self.FDBarGaugeView.minLimit = 0.0
        self.FDBarGaugeView.maxLimit = 100.0
        self.FDBarGaugeView.warnThreshold = 30.0
        self.FDBarGaugeView.dangerThreshold = 60.0
        self.FDBarGaugeView.normalColor = UIColor.colorLiteral.theme_red_FF6961
        self.FDBarGaugeView.warningColor = UIColor.colorLiteral.theme_red_FF6961
        self.FDBarGaugeView.dangerColor = UIColor.colorLiteral.theme_red_FF6961
        self.FDBarGaugeView.outerBorderColor = UIColor.clear
        self.FDBarGaugeView.backgroundColor = UIColor.clear
        
        self.pkcCheck.decibelStart()
        self.toCheckMicrophonePermission()
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
        self.setCommonTitleView()
    }
    // MARK: - Notification listener
    @objc func audioRouteChangeListener(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let reasonRaw = userInfo[AVAudioSessionRouteChangeReasonKey] as? NSNumber, let reason = AVAudioSession.RouteChangeReason(rawValue: reasonRaw.uintValue)
        else { fatalError("Strange... could not get routeChange") }
        switch reason {
        case .newDeviceAvailable:
            self.toCheckMicrophonePermission()
            break
        case .oldDeviceUnavailable:
            self.stopNoiseDetection()
            break
        default:
            self.stopNoiseDetection()
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
        self.moveToQuickTestEarCheckViewController()
    }
    
    // MARK: - Custom Methods
    func stopNoiseDetection() {
        self.isHeadPhoneConnected = false
        self.pkcCheck.decibelStop()
        self.setButtonDisable()
        self.updateConnectorView(showImage1: false, showImage2: false, showImage3: false, isHeadsetConnected: false, isNoiseDetected: false, isEarchecked: false)
    }
    func setButtonDisable() {
//        self.nextButton.isUserInteractionEnabled = false
//        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
//        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
//        self.nextButton.setNeedsDisplay()
//        self.nextButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
//        self.nextButton.isUserInteractionEnabled = true
//        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
//        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
//        self.nextButton.setNeedsDisplay()
//        self.nextButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func updateConnectorView(showImage1: Bool, showImage2: Bool, showImage3: Bool, isHeadsetConnected: Bool, isNoiseDetected: Bool, isEarchecked: Bool) {
        self.quickTestStatusView.setupView(showImage1: showImage1, showImage2: showImage2, showImage3: showImage3, isHeadsetConnected: isHeadsetConnected, isNoiseDetected: isNoiseDetected, isEarchecked: isEarchecked)
    }
    
    func setNoiseLevelNavigate() {
        if self.isHeadPhoneConnected == true {
            self.setButtonEnable()
            self.updateConnectorView(showImage1: true, showImage2: true, showImage3: false, isHeadsetConnected: false, isNoiseDetected: false, isEarchecked: false)
        } else {
            self.stopNoiseDetection()
        }
    }
    func moveToQuickTestEarCheckViewController() {
        self.pkcCheck.decibelStop()
        self.navigateToQuickTestEarCheckViewController(isFrom: self.isFrom, patientData: self.patientData!, sessionID: self.sessionID)
    }
    // MARK: - Microphone Permission
    func toCheckMicrophonePermission() {
        var currentRoute = AVAudioSession.sharedInstance().currentRoute
        if currentRoute.outputs.count != 0 {
            for description in currentRoute.outputs {
                if (description.portType == AVAudioSession.Port.headphones) || (description.portType == AVAudioSession.Port.bluetoothA2DP) {
                    self.toCheckStartPermission()
                } else if (description.portType == AVAudioSession.Port.builtInReceiver) || (description.portType == AVAudioSession.Port.builtInSpeaker)  || (description.portType == AVAudioSession.Port.builtInMic) {
                    do { try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: [.allowBluetoothA2DP])
                        try self.audioSession.setActive(true)
                        currentRoute = AVAudioSession.sharedInstance().currentRoute
                        if currentRoute.outputs.count != 0 {
                            for description in currentRoute.outputs {
                                if (description.portType == AVAudioSession.Port.headphones) || (description.portType == AVAudioSession.Port.bluetoothA2DP) {
                                    self.toCheckStartPermission()
                                } else {
                                    DispatchQueue.main.async {
                                        self.stopNoiseDetection()
                                        return
                                    }
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.stopNoiseDetection()
                                return
                            }
                        }
                    } catch let e {
                        DispatchQueue.main.async {
                            self.stopNoiseDetection()
                            return
                        }                    }
                } else {
                    DispatchQueue.main.async {
                        self.stopNoiseDetection()
                        return
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.stopNoiseDetection()
                return
            }
        }
    }
    func startRecordingNoiseLevel() {
        var currentRoute = AVAudioSession.sharedInstance().currentRoute
        if currentRoute.outputs.count != 0 {
            for description in currentRoute.outputs {
                if (description.portType == AVAudioSession.Port.headphones) || (description.portType == AVAudioSession.Port.bluetoothA2DP) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isHeadPhoneConnected = true
                        self.pkcCheck.decibelStart()
                    }
                } else if (description.portType == AVAudioSession.Port.builtInReceiver) || (description.portType == AVAudioSession.Port.builtInSpeaker)  || (description.portType == AVAudioSession.Port.builtInMic) {
                    do { try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: [.allowBluetoothA2DP])
                        try self.audioSession.setActive(true)
                        currentRoute = AVAudioSession.sharedInstance().currentRoute
                        if currentRoute.outputs.count != 0 {
                            for description in currentRoute.outputs {
                                if (description.portType == AVAudioSession.Port.headphones) || (description.portType == AVAudioSession.Port.bluetoothA2DP) {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.isHeadPhoneConnected = true
                                        self.pkcCheck.decibelStart()
                                    }
                                } else {
                                    self.stopNoiseDetection()
                                }
                            }
                        } else {
                            self.stopNoiseDetection()
                        }
                    } catch {
                        self.stopNoiseDetection()
                    }
                } else {
                    self.stopNoiseDetection()
                }
            }
        } else {
            self.stopNoiseDetection()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(audioRouteChangeListener(notification:)), name: AVAudioSession.routeChangeNotification, object: nil)
    }
    
    func toCheckStartPermission() {
        DispatchQueue.main.async {
            switch AVAudioSession.sharedInstance().recordPermission {
            case AVAudioSession.RecordPermission.granted:
                self.startRecordingNoiseLevel()
                break
            case AVAudioSession.RecordPermission.denied:
                self.showToastAlert(AppLocalizationString.microphonepermission, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                break
            case AVAudioSession.RecordPermission.undetermined:
                AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                    // Handle granted
                    if granted {
                        self.startRecordingNoiseLevel()
                    } else {
                        self.showToastAlert(AppLocalizationString.microphonepermission, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                    }
                })
                break
            @unknown default:
                break
            }
        }
    }
    
}
extension QuickTestNoiseLevelViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToQuickTestProfileViewController()
    }
    func rightButtonPressed() {
    }
}
extension QuickTestNoiseLevelViewController: ProtocolNetworkRechabilityDelegate {
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
// MARK: - PKCCheckDelegate Methods
extension QuickTestNoiseLevelViewController: PKCCheckDelegate {
    func pkcCheckDecibel(_ level: CGFloat, average: CGFloat, degree: CGFloat, radian: CGFloat) {
        if self.patientName.isEmpty {
            self.noiseInfoTitleLabel.text = String(format: "%@", AppLocalizationString.hello)
        } else {
            self.noiseInfoTitleLabel.text = String(format: "%@ %@", AppLocalizationString.hello, self.patientName)
        }
        if average <= 30 {
//            if average <= 100 {
            DispatchQueue.main.async {
                self.noiseInfodescriptionLabel.text = AppLocalizationString.lownoise
                self.noiseInfodescriptionLabel.textColor = UIColor.colorLiteral.theme_green_27AE60
                if self.isHeadPhoneConnected == true {
                    self.setButtonEnable()
                    self.updateConnectorView(showImage1: true, showImage2: true, showImage3: false, isHeadsetConnected: true, isNoiseDetected: false, isEarchecked: false)
                    self.pkcCheck.decibelStop()
                    if self.isMoved == false {
                        self.isMoved = true
                        self.moveToQuickTestEarCheckViewController()
                    }
                } else {
                    self.stopNoiseDetection()
                }
            }
        } else if average <= 60 {
            DispatchQueue.main.async {
                self.noiseInfodescriptionLabel.text = AppLocalizationString.averagenoise
                self.noiseInfodescriptionLabel.textColor = UIColor.colorLiteral.theme_orange_F7732F
                if self.isHeadPhoneConnected == true {
                    self.setButtonEnable()
                    self.updateConnectorView(showImage1: true, showImage2: true, showImage3: false, isHeadsetConnected: true, isNoiseDetected: false, isEarchecked: false)
                    self.pkcCheck.decibelStop()
                    if self.isMoved == false {
                        self.isMoved = true
                        self.moveToQuickTestEarCheckViewController()
                    }
                } else {
                    self.stopNoiseDetection()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.updateConnectorView(showImage1: true, showImage2: false, showImage3: false, isHeadsetConnected: false, isNoiseDetected: false, isEarchecked: false)
                self.noiseInfodescriptionLabel.text = AppLocalizationString.highnoise
                self.noiseInfodescriptionLabel.textColor = UIColor.colorLiteral.theme_red_FF6961
                if self.isHeadPhoneConnected == true {
                    self.setButtonDisable()
                    self.updateConnectorView(showImage1: true, showImage2: false, showImage3: false, isHeadsetConnected: true, isNoiseDetected: false, isEarchecked: false)
                } else {
                    self.stopNoiseDetection()
                }
            }
        }
        self.FDBarGaugeView.value = Double(average)
    }
}
