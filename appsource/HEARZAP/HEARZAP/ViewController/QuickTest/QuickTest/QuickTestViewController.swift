//
//  QuickTestViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 07/12/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FLAnimatedImage
import SwiftGifOrigin
import AVFoundation
import MediaPlayer
import PKCCheck

class QuickTestViewController: UIViewController {
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

    @IBOutlet var progessView: UIView!
    @IBOutlet var progressLevelLabel: FootnoteFontLabel!
    @IBOutlet var progessView1: UIProgressView!
    @IBOutlet var progessView2: UIProgressView!
    @IBOutlet var progessView3: UIProgressView!
    @IBOutlet var progessView4: UIProgressView!

    @IBOutlet var playView: UIView!
    @IBOutlet var playImageView: FLAnimatedImageView!
    @IBOutlet var playButton: FootnoteOutlineButton!

    @IBOutlet var headsetAlertlabel: Caption2FontLabel!

    // MARK: - Lets and Var
    var isFrom = ""
    var engine: AVAudioEngine!
    var tone: AVTonePlayerUnit!
    var floatAmplitude: CGFloat = 30.0
    var floatFrequency: CGFloat = 500.0
    var indexValue = 1
    var arrayProgress: NSMutableArray = NSMutableArray()

    var isSoundAudible = false
    var selectedEar = ""
    var isHeadPhoneConnected = false
    var dictJson: NSDictionary = NSDictionary()
    var playCount: CGFloat = 1.0
    var dictLeft = [String: String]()
    var dictRight = [String: String]()
    var arrayLeft = [Int]()
    var arrayRight = [Int]()

    var earTestCount = 0
    var volumeView = MPVolumeView(frame: .zero)
    let audioSession = AVAudioSession.sharedInstance()
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
        self.setNavigationBar()
        self.setButtonDisable()
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
        self.playImageView.image = UIImage(named: Asset.presshereblue)
        UIApplication.shared.isIdleTimerDisabled = true
        self.volumeView = MPVolumeView(frame: .zero)
        self.view.addSubview(volumeView)
        MPVolumeView.setVolume(0.15)
        self.quickHumanImageViewWidth.constant = CGFloat(screenFrameWidth) * CGFloat(AppConstantValue.screen192slash375)
        self.setButtonDisable()
        self.leftwaveImageView.image = UIImage.gif(name: Asset.wave)
        self.rightwaveImageView.image = UIImage.gif(name: Asset.wave)
        self.leftwaveImageView.isHidden = true
        self.rightwaveImageView.isHidden = true
        self.leftwaveImageView.image = UIImage.gif(name: Asset.wave)
        self.rightwaveImageView.image = UIImage.gif(name: Asset.wave)
        self.toGenerateTone()

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
        let titlemessage = AppLocalizationString.QCStep3Title.capitalized
        let descriptionMessage = AppLocalizationString.QCStep3Desc.capitalized

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
        self.threeDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.recordcircleblue, button3image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_blue_E7F4FF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        if self.patientName.isEmpty {
            self.userInfoNameLabel.text = String(format: "%@", AppLocalizationString.hello)
        } else {
            self.userInfoNameLabel.text = String(format: "%@ %@", AppLocalizationString.hello, self.patientName)
        }
        var strText1 = AppLocalizationString.testingyourrightearR
        var strText2 = AppLocalizationString.playing4levelsofsoundswithdifferentdecibelsinright

        if self.selectedEar == EarType.left.rawValue {
            strText1 = AppLocalizationString.testingyourleftearL
            strText2 = AppLocalizationString.playing4levelsofsoundswithdifferentdecibelsinleft
        } else if self.selectedEar == EarType.right.rawValue {
            strText1 = AppLocalizationString.testingyourrightearR
            strText2 = AppLocalizationString.playing4levelsofsoundswithdifferentdecibelsinright
        }
        let boldBlueFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_112F70, NSAttributedString.Key.font: AppFont.bold.size(16)]
        let regulargreyFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let part1 = NSMutableAttributedString(string: String(format: "%@\n\n", strText1), attributes: boldBlueFontAttributes as [NSAttributedString.Key: Any])
        let part2 = NSMutableAttributedString(string: String(format: "%@", strText2), attributes: regulargreyFontAttributes as [NSAttributedString.Key: Any])
        let combination = NSMutableAttributedString()
        combination.append(part1)
        combination.append(part2)
        self.userdescriptionLabel.attributedText = combination
        self.headsetAlertlabel.text = AppLocalizationString.donotremoveyourheadphonetilltestcompletion
        self.setCommonTitleView()
    }
    // MARK: - Notification listener
    @objc func audioRouteChangeListener(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let reasonRaw = userInfo[AVAudioSessionRouteChangeReasonKey] as? NSNumber, let reason = AVAudioSession.RouteChangeReason(rawValue: reasonRaw.uintValue)
        else { fatalError("Strange... could not get routeChange") }
        switch reason {
        case .newDeviceAvailable:
            self.isHeadPhoneConnected = true
            self.setButtonEnable()
            break
        case .oldDeviceUnavailable:
            self.toStopEngine()
            self.isHeadPhoneConnected = false
            self.setButtonDisable()
            break
        default:
            self.toStopEngine()
            self.isHeadPhoneConnected = false
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
        self.navigateToQuickTestSelectEarViewController(isFrom: self.isFrom, earTestCount: self.earTestCount, selectedEar: self.selectedEar, patientData: self.patientData!, sessionID: self.sessionID, dictLeft: self.dictLeft, dictRight: self.dictRight, arrayLeft: arrayLeft, arrayRight: arrayRight)
    }
    @IBAction func playButtonPressed(_ sender: UIButton) {
        self.playButton.isUserInteractionEnabled = false
        self.isSoundAudible = true
        self.toStopEngine()
        self.leftwaveImageView.isHidden = true
        self.rightwaveImageView.isHidden = true
        self.playImageView.image = UIImage(named: Asset.pressheregreen)
        if self.isHeadPhoneConnected == false {
            self.showToastAlert(AppLocalizationString.headphonesisdisconnected, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        } else {
            var progress = UIProgressView()
            progress = self.arrayProgress.object(at: self.indexValue - 1) as! UIProgressView
            progress.progress = 1.0
            self.perform(#selector(self.toAddDetails), with: nil, afterDelay: 0.7)
        }
    }

    // MARK: - Custom Methods
    @objc func toStopEngine() {
        if self.engine != nil {
            self.tone.pause()
            self.tone.reset()
            self.engine.mainMixerNode.volume = 0.0
            self.engine.reset()
        }
    }
    func setButtonEnable() {
        DispatchQueue.main.async {
            self.changeLanguageFormat()
            self.isHeadPhoneConnected = true
            self.perform(#selector(self.toPlayTone), with: nil, afterDelay: 0.6)
        }
    }
    func setButtonDisable() {
        DispatchQueue.main.async {
            self.toStopEngine()
            self.leftwaveImageView.isHidden = true
            self.rightwaveImageView.isHidden = true
        }
        self.isHeadPhoneConnected = false
    }
    func toGenerateTone() {
        self.playImageView.image = UIImage(named: Asset.presshereblue)
        MPVolumeView.setVolume(0.15)
        self.arrayProgress.add(self.progessView1)
        self.arrayProgress.add(self.progessView2)
        self.arrayProgress.add(self.progessView3)
        self.arrayProgress.add(self.progessView4)

        if self.selectedEar == EarType.right.rawValue {
            self.leftwaveImageView.isHidden = true
            //            self.rightwaveImageView.isHidden = false/* hide for 826 task*/
            self.rightwaveImageView.isHidden = true
        } else {
            //            self.leftwaveImageView.isHidden = false /* hide for 826 task*/
            self.leftwaveImageView.isHidden = true
            self.rightwaveImageView.isHidden = true
        }

        self.tone = AVTonePlayerUnit()
        self.tone.amplitude = Double(self.floatAmplitude)
        let format = AVAudioFormat(standardFormatWithSampleRate: self.tone.sampleRate, channels: 1)
        self.engine = AVAudioEngine()
        self.engine.attach(self.tone)
        let mixer = self.engine.mainMixerNode
        self.engine.connect(self.tone, to: mixer, format: format)
        do {
            try self.engine.start()
        } catch let error as NSError {
            print(error)
        }
        var currentRoute = AVAudioSession.sharedInstance().currentRoute
        if currentRoute.outputs.count != 0 {
            for description in currentRoute.outputs {
                if (description.portType == AVAudioSession.Port.headphones) || (description.portType == AVAudioSession.Port.bluetoothA2DP) {
                    self.isHeadPhoneConnected = true
                    self.setButtonEnable()
                } else if (description.portType == AVAudioSession.Port.builtInReceiver) || (description.portType == AVAudioSession.Port.builtInSpeaker)  || (description.portType == AVAudioSession.Port.builtInMic) {
                    do {
                        try audioSession.setCategory(AVAudioSession.Category.playAndRecord, options: [.allowBluetoothA2DP])
                        try self.audioSession.setActive(true)
                        currentRoute = AVAudioSession.sharedInstance().currentRoute
                        if currentRoute.outputs.count != 0 {
                            for description in currentRoute.outputs {
                                if (description.portType == AVAudioSession.Port.headphones) || (description.portType == AVAudioSession.Port.bluetoothA2DP) {
                                    self.isHeadPhoneConnected = true
                                    self.setButtonEnable()
                                } else {
                                    self.isHeadPhoneConnected = false
                                    self.setButtonDisable()
                                }
                            }
                        } else {
                            self.isHeadPhoneConnected = false
                            self.setButtonDisable()
                        }
                    } catch {
                        self.isHeadPhoneConnected = false
                        self.setButtonDisable()
                    }
                } else {
                    self.isHeadPhoneConnected = false
                    self.setButtonDisable()
                }
            }
        } else {
            self.isHeadPhoneConnected = false
            self.setButtonDisable()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(audioRouteChangeListener(notification:)), name: AVAudioSession.routeChangeNotification, object: nil)
    }

    @objc func toSetFrequency() {
        if self.indexValue == 1 {
            self.floatAmplitude = 30.0
            MPVolumeView.setVolume(0.15)
            self.floatFrequency = 500
        } else if self.indexValue == 2 {
            if self.floatAmplitude >= 50 {
                self.floatAmplitude = self.floatAmplitude - 20
            } else {
                self.floatAmplitude = 30.0
            }
            MPVolumeView.setVolume(0.15)
            self.floatFrequency = 1000
        } else if self.indexValue == 3 {
            if self.floatAmplitude >= 50 {
                self.floatAmplitude = self.floatAmplitude - 20
            } else {
                self.floatAmplitude = 30.0
            }
            MPVolumeView.setVolume(0.15)
            self.floatFrequency = 2000
        } else if self.indexValue == 4 {
            if self.floatAmplitude >= 50 {
                self.floatAmplitude = self.floatAmplitude - 20
            } else {
                self.floatAmplitude = 30.0
            }
            MPVolumeView.setVolume(0.15)
            self.floatFrequency = 4000
        }
        self.isSoundAudible = false
        self.playCount = 1.0
        //        self.progress_bar.progress = 0.0
        self.perform(#selector(self.toPlayTone), with: nil, afterDelay: 0.6)
    }

    @objc func toPlayTone() {
        DispatchQueue.main.async {
            self.playImageView.image = UIImage(named: Asset.presshereblue)
            if self.isSoundAudible == false {
                self.playButton.isUserInteractionEnabled = true
                self.progressLevelLabel.text = String(format: "\(AppLocalizationString.playingsoundLevel4)", self.indexValue)
                self.tone.frequency = Double(self.floatFrequency)
                self.tone.amplitude = Double(self.floatAmplitude)
                if self.engine != nil {
                    if self.selectedEar == EarType.right.rawValue {
                        if self.engine.isRunning {
                            self.tone.pan = 1.0
                            self.tone.preparePlaying()
                            self.tone.play()
                            self.engine.mainMixerNode.volume = 1.0
                            self.perform(#selector(self.toStopTone), with: nil, afterDelay: 1.5)
                            //            self.rightwaveImageView.isHidden = false/* hide for 826 task*/
                            self.rightwaveImageView.isHidden = true
                            self.leftwaveImageView.isHidden = true
                            return
                        } else {
                            self.tone = AVTonePlayerUnit()
                            self.tone.amplitude = Double(self.floatAmplitude)
                            let format = AVAudioFormat(standardFormatWithSampleRate: self.tone.sampleRate, channels: 1)
                            self.engine = AVAudioEngine()
                            self.engine.attach(self.tone)
                            let mixer = self.engine.mainMixerNode
                            self.engine.connect(self.tone, to: mixer, format: format)
                            do {
                                try self.engine.start()
                                self.tone.pan = 1.0
                                self.tone.preparePlaying()
                                self.tone.play()
                                self.perform(#selector(self.toStopTone), with: nil, afterDelay: 1.5)
                                //            self.rightwaveImageView.isHidden = false/* hide for 826 task*/
                                self.rightwaveImageView.isHidden = true
                                self.leftwaveImageView.isHidden = true
                                return
                            } catch {
                                assertionFailure(String(describing: error))
                            }
                        }
                    } else {
                        if self.engine.isRunning {
                            self.tone.pan = -1.0
                            self.tone.preparePlaying()
                            self.tone.play()
                            self.engine.mainMixerNode.volume = 1.0
                            //            self.leftwaveImageView.isHidden = false /* hide for 826 task*/
                            self.leftwaveImageView.isHidden = true
                            self.rightwaveImageView.isHidden = true
                            self.perform(#selector(self.toStopTone), with: nil, afterDelay: 1.5)
                            return
                        } else {
                            self.tone = AVTonePlayerUnit()
                            self.tone.amplitude = Double(self.floatAmplitude)
                            let format = AVAudioFormat(standardFormatWithSampleRate: self.tone.sampleRate, channels: 1)
                            self.engine = AVAudioEngine()
                            self.engine.attach(self.tone)
                            let mixer = self.engine.mainMixerNode
                            self.engine.connect(self.tone, to: mixer, format: format)
                            do {
                                try self.engine.start()
                                self.tone.pan = -1.0
                                self.tone.preparePlaying()
                                self.tone.play()
                                //            self.leftwaveImageView.isHidden = false/* hide for 826 task*/
                                self.leftwaveImageView.isHidden = true
                                self.rightwaveImageView.isHidden = true
                                self.perform(#selector(self.toStopTone), with: nil, afterDelay: 1.5)
                                return
                            } catch {
                                assertionFailure(String(describing: error))
                            }
                        }
                    }
                }
            }
        }
    }

    @objc func toStopTone() {
        self.toStopEngine()
        self.leftwaveImageView.isHidden = true
        self.rightwaveImageView.isHidden = true
        var progress = UIProgressView()
        progress = self.arrayProgress.object(at: self.indexValue - 1) as! UIProgressView

        if self.isSoundAudible == false {
            if self.floatAmplitude == 80 {
                progress.progress = 1.0
                self.toAddDetails()
            } else {
                self.floatAmplitude = self.floatAmplitude + 10
                self.playCount = 1.0

                if self.floatAmplitude == 30.0 {
                    MPVolumeView.setVolume(0.15)
                } else if self.floatAmplitude == 40.0 {
                    MPVolumeView.setVolume(0.25)
                } else if self.floatAmplitude == 50.0 {
                    MPVolumeView.setVolume(0.33)
                } else if self.floatAmplitude == 60.0 {
                    MPVolumeView.setVolume(0.43)
                } else if self.floatAmplitude == 70.0 {
                    MPVolumeView.setVolume(0.55)
                } else if self.floatAmplitude == 80.0 {
                    MPVolumeView.setVolume(0.8)
                }
                self.perform(#selector(self.toPlayTone), with: nil, afterDelay: 0.6)
            }
        }
    }
    func toSuccessPage() {
        self.navigateToQuickTestSuccessViewController(isFrom: self.isFrom, earTestCount: self.earTestCount, selectedEar: self.selectedEar, patientData: self.patientData!, sessionID: self.sessionID, dictLeft: self.dictLeft, dictRight: self.dictRight, arrayLeft: self.arrayLeft, arrayRight: self.arrayRight)
    }

    @objc func toAddDetails() {
        if self.selectedEar == EarType.right.rawValue {
            self.dictRight.updateValue(String(format: "%.0f", self.floatAmplitude as CVarArg), forKey: String(format: "%.0f", self.floatFrequency as CVarArg))
            self.arrayRight.insert(Int(self.floatAmplitude), at: 0)
        } else {
            self.dictLeft.updateValue(String(format: "%.0f", self.floatAmplitude as CVarArg), forKey: String(format: "%.0f", self.floatFrequency as CVarArg))
            self.arrayLeft.insert(Int(self.floatAmplitude), at: 0)
        }
        let progress = self.arrayProgress.object(at: self.indexValue - 1) as! UIProgressView
        progress.progress = 1.0
        if self.indexValue != 4 {
            self.indexValue = self.indexValue + 1
            self.perform(#selector(self.toSetFrequency), with: nil, afterDelay: 0.5)
        } else {
            self.toSuccessPage()
        }
    }
}
extension QuickTestViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
            self.floatAmplitude = 30.0
            MPVolumeView.setVolume(0.15)
            self.volumeView.removeFromSuperview()
            self.view.willRemoveSubview(self.volumeView)
            if self.engine != nil {
                self.tone.pause()
                self.tone.reset()
                self.engine.mainMixerNode.volume = 0.0
                self.engine.pause()
                self.engine.reset()
                self.engine = nil
            }
            self.leftwaveImageView.isHidden = true
            self.rightwaveImageView.isHidden = true
            self.navigateBackToQuickTestProfileViewController()
    }
    func rightButtonPressed() {
    }
}
extension QuickTestViewController: ProtocolNetworkRechabilityDelegate {
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
