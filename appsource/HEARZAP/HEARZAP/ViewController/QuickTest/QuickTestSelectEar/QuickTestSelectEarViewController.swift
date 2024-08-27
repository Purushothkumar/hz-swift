//
//  QuickTestSelectEarViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 06/12/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FLAnimatedImage
import SwiftGifOrigin
import AVFoundation
import MediaPlayer

class QuickTestSelectEarViewController: UIViewController {
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
    @IBOutlet var userMessageLabel: Caption1FontLabel!
    
    @IBOutlet var selectionView: UIView!
    
    @IBOutlet var rightButton: FootnoteOutlineButton!
    @IBOutlet var leftButton: FootnoteOutlineButton!
    @IBOutlet var leftEarImageView: FLAnimatedImageView!
    @IBOutlet var rightEarImageView: FLAnimatedImageView!
    @IBOutlet var leftEarView: UIView!
    @IBOutlet var rightEarView: UIView!
    
    @IBOutlet var messageView: UIView!
    @IBOutlet var messagelabel: Caption1FontLabel!
    
    @IBOutlet var loaderView: UIView!
    @IBOutlet var imageview0: FLAnimatedImageView!
    @IBOutlet var imageview1: FLAnimatedImageView!
    @IBOutlet var imageview2: FLAnimatedImageView!
    @IBOutlet var imageview3: FLAnimatedImageView!
    @IBOutlet var imageview4: FLAnimatedImageView!
    
    @IBOutlet var headsetAlertlabel: Caption2FontLabel!
    
    // MARK: - Lets and Var
    var isFrom = ""
    var dictLeft = [String: String]()
    var dictRight = [String: String]()
    var arrayLeft = [Int]()
    var arrayRight = [Int]()
    
    var selectedEar = ""
    var count = 5
    var earTestCount = 0
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
        self.leftEarImageView.image = UIImage(named: Asset.earcheckleft)
        self.rightEarImageView.image = UIImage(named: Asset.earcheckright)
        self.rightButton.isHidden = false
        self.leftButton.isHidden = false
        self.rightEarView.layer.cornerRadius = self.rightEarView.frame.height / 2
        self.rightEarView.clipsToBounds = true
        
        self.leftEarView.layer.cornerRadius = self.leftEarView.frame.height / 2
        self.leftEarView.clipsToBounds = true
        
        if self.selectedEar ==  EarType.right.rawValue {
            self.leftEarImageView.image = UIImage(named: Asset.earcheckleftdisable)
            self.leftButton.isHidden = true
//            self.rightEarImageView.image = UIImage.gif(name: Asset.earrightanimation)
            self.rightEarImageView.image = UIImage(named: Asset.earcheckright)
            self.leftEarView.backgroundColor = .clear
            self.rightEarView.backgroundColor = UIColor.colorLiteral.theme_red_FF6961
        } else if self.selectedEar ==  EarType.left.rawValue {
            self.rightEarImageView.image = UIImage(named: Asset.earcheckrightdisable)
            self.rightButton.isHidden = true
//            self.leftEarImageView.image = UIImage.gif(name: Asset.earleftanimation)
            self.leftEarImageView.image = UIImage(named: Asset.earcheckleft)
//            self.leftEarView.backgroundColor = UIColor.init(hexString: "409CFF", alpha: 1.0)
            self.leftEarView.backgroundColor = UIColor.colorLiteral.theme_blue_409CFF
            self.rightEarView.backgroundColor = .clear
        } else {
//            self.rightEarImageView.image = UIImage.gif(name: Asset.earrightanimation)
//            self.leftEarImageView.image = UIImage.gif(name: Asset.earleftanimation)
            self.leftEarImageView.image = UIImage(named: Asset.earcheckleft)
            self.rightEarImageView.image = UIImage(named: Asset.earcheckright)
//            self.leftEarView.backgroundColor = UIColor.init(hexString: "409CFF", alpha: 1.0)
            self.leftEarView.backgroundColor = UIColor.colorLiteral.theme_blue_409CFF
            self.rightEarView.backgroundColor = UIColor.colorLiteral.theme_red_FF6961
        }
        let view3 = self.mainStackView.arrangedSubviews[3]
        let view4 = self.mainStackView.arrangedSubviews[4]
        
        view3.isHidden = true
        view4.isHidden = true
        
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.setThreeDotCircleView()
        self.quickHumanImageViewWidth.constant = CGFloat(screenFrameWidth) * CGFloat(AppConstantValue.screen192slash375)
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
        var strText1 = ""
        //        let strText2 = AppLocalizationString.normallypeopleprefertotesttheirbesthearingsidefirst
        let strText2 = ""
        if self.selectedEar.isEmpty {
            strText1 = AppLocalizationString.whichearyouliketotestfirst
        } else {
            strText1 = AppLocalizationString.nowtesttheotherear
        }
        let boldBlueFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_112F70, NSAttributedString.Key.font: AppFont.bold.size(16)]
        let regulargreyFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let part1 = NSMutableAttributedString(string: String(format: "%@\n\n", strText1), attributes: boldBlueFontAttributes as [NSAttributedString.Key: Any])
        let part2 = NSMutableAttributedString(string: String(format: "%@", strText2), attributes: regulargreyFontAttributes as [NSAttributedString.Key: Any])
        let combination = NSMutableAttributedString()
        combination.append(part1)
        combination.append(part2)
        self.userdescriptionLabel.attributedText = combination
        self.userMessageLabel.text = AppLocalizationString.qcUserMessage
        self.messagelabel.text = AppLocalizationString.pleasewaityourteststartsinamoment
        self.headsetAlertlabel.text = AppLocalizationString.donotremoveyourheadphonetilltestcompletion
        self.setCommonTitleView()
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
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        self.count = 0
        if self.selectedEar ==  EarType.right.rawValue {
            self.leftEarImageView.image = UIImage(named: Asset.earcheckleftdisable)
            self.rightEarImageView.image = UIImage(named: Asset.earcheckright)
        } else if self.selectedEar ==  EarType.left.rawValue {
            self.rightEarImageView.image = UIImage(named: Asset.earcheckrightdisable)
            self.leftEarImageView.image = UIImage(named: Asset.earcheckleft)
        } else {
            self.rightEarImageView.image = UIImage(named: Asset.earcheckright)
            self.leftEarImageView.image = UIImage(named: Asset.earcheckleft)
        }
        self.selectedEar = EarType.right.rawValue
        self.startAnimation(earType: self.selectedEar)
    }
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        self.count = 0
        if self.selectedEar ==  EarType.right.rawValue {
            self.leftEarImageView.image = UIImage(named: Asset.earcheckleftdisable)
            self.rightEarImageView.image = UIImage(named: Asset.earcheckright)
        } else if self.selectedEar ==  EarType.left.rawValue {
            self.rightEarImageView.image = UIImage(named: Asset.earcheckrightdisable)
            self.leftEarImageView.image = UIImage(named: Asset.earcheckleft)
        } else {
            self.rightEarImageView.image = UIImage(named: Asset.earcheckright)
            self.leftEarImageView.image = UIImage(named: Asset.earcheckleft)
        }
        self.selectedEar = EarType.left.rawValue
        self.startAnimation(earType: self.selectedEar)
    }
    // MARK: - Custom Methods
    func startAnimation(earType: String) {
        if self.count < 5 {
            self.view.isUserInteractionEnabled = false
            let view3 = self.mainStackView.arrangedSubviews[3]
            let view4 = self.mainStackView.arrangedSubviews[4]
            view3.isHidden = false
            view4.isHidden = false
            self.perform(#selector(self.drawloader), with: nil, afterDelay: 0.5)
        } else {
            self.view.isUserInteractionEnabled = true
            self.navigateToQuickTestViewController(isFrom: self.isFrom, earTestCount: self.earTestCount, selectedEar: self.selectedEar, patientData: self.patientData!, sessionID: self.sessionID, dictLeft: self.dictLeft, dictRight: self.dictRight, arrayLeft: arrayLeft, arrayRight: arrayRight)
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
        self.startAnimation(earType: self.selectedEar)
    }
}
extension QuickTestSelectEarViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToQuickTestProfileViewController()
    }
    func rightButtonPressed() {
    }
}
extension QuickTestSelectEarViewController: ProtocolNetworkRechabilityDelegate {
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
