//
//  FindRightDeviceEarPreferenceViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 21/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FLAnimatedImage
import BottomPopup

class FindRightDeviceEarPreferenceViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var sixDotCircleView: SixDotCircleView!
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    
    @IBOutlet var hearderLabel: CalloutFontLabel!
    
    @IBOutlet var leftEarButton: FootnoteOutlineButton!
    @IBOutlet var rightEarButton: FootnoteOutlineButton!
    @IBOutlet var bothEarButton: FootnoteOutlineButton!
    
    @IBOutlet var bannerImageView: FLAnimatedImageView!
    
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: Caption2FontLabel!
    @IBOutlet var contentLabel: Caption2FontLabel!
    
    @IBOutlet var nextView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!
    
    @IBOutlet var emptyView: UIView!
    
    // MARK: - Lets and Var
    var findRightDeviceEarPreferenceViewModel = FindRightDeviceEarPreferenceViewModel()
    
    var isFrom = ""
    var patientUid = ""
    var sessionID = ""
    
    var lifestyleID: Int?
    var technologyID: Int?
    var model = [Int]()
    var earpreference = FRDEarPreference.earpreference.rawValue
    var earpreferenceID: Int?
    
    var titlemessage = ""
    var descriptionmessage = ""
    var contentmessage = ""
    
    var leftEarpreferenceID: Int?
    var bothEarpreferenceID: Int?
    var rightEarpreferenceID: Int?
    
    var leftTitleMessage = ""
    var bothTitleMessage = ""
    var rightTitleMessage = ""
    
    var leftDecriptionMessage = ""
    var bothDecriptionMessage = ""
    var rightDecriptionMessage = ""
    
    var leftImage = ""
    var bothImage = ""
    var rightImage = ""
    
    var sessionUID = ""
    var sessionKey = ""
    
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
        self.mainScrollView.sizeToFit()
        self.mainScrollView.contentSize = CGSize(width: self.mainStackView.frame.size.width, height: self.emptyView.frame.height + self.emptyView.frame.origin.y)
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
        self.setSixDotCircleView()
        self.setCommonTitleView()
        self.setButtonUserInteraction()
        self.setDefaultButtonColor()
        self.bannerImageView.clipsToBounds = true
        self.bannerImageView.layer.borderColor = UIColor.colorLiteral.theme_blue_E7F4FF.cgColor
        self.bannerImageView.layer.borderWidth = 2.0
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.hearingAidFinder
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Set Six Dot Circle View
    func setSixDotCircleView() {
        self.sixDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.checkcircleblue, button3image: Asset.checkcircleblue, button4image: Asset.checkcircleblue, button5image: Asset.recordcircleblue, button6image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.FHAStep4Title.capitalized
        let descriptionMessage = AppLocalizationString.FHAStep4Desc.capitalized
        
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
    
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.hearderLabel.text = AppLocalizationString.chooseEar
        self.titleLabel.text = ""
        self.descriptionLabel.text = descriptionmessage
        self.contentLabel.text = contentmessage
        self.setCommonTitleView()
        self.nextButton.setTitle(AppLocalizationString.next.uppercased(), for: .normal)
        self.leftEarButton.setTitle(AppLocalizationString.leftEar.uppercased(), for: .normal)
        self.rightEarButton.setTitle(AppLocalizationString.rightEar.uppercased(), for: .normal)
        self.bothEarButton.setTitle(AppLocalizationString.bothEars.uppercased(), for: .normal)
        
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getFindRightDeviceEarPreference(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getFindRightDeviceEarPreference(retryAPIID: Int, canShowLoader: Bool) {
        self.findRightDeviceEarPreferenceViewModel.getFindRightDeviceEarPreference(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getFindRightDeviceEarPreference, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.navigateToFindRightDeviceRecommendViewController(isFrom: self.isFrom, patientUid: self.patientUid, lifestyleID: lifestyleID, model: model, technologyID: technologyID, earpreferenceID: earpreferenceID, UID: "", sessionUID: self.sessionUID,sessionKey: self.sessionKey, isNewUser: true,sessionID: self.sessionID)
    }
    @IBAction func leftEarButtonPressed(_ sender: UIButton) {
        self.leftEarTapped()
    }
    @IBAction func rightEarButtonPressed(_ sender: UIButton) {
        self.rightEarTapped()
    }
    @IBAction func bothEarButtonPressed(_ sender: UIButton) {
        self.bothEarTapped()
    }
    // MARK: - Custom Methods
    func setButtonUserInteraction() {
        if self.earpreference == FRDEarPreference.earpreference.rawValue {
            self.setButtonDisable()
        } else {
            self.setButtonEnable()
        }
    }
    func setButtonDisable() {
        self.nextButton.isUserInteractionEnabled = false
        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.nextButton.setNeedsDisplay()
        self.nextButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.nextButton.isUserInteractionEnabled = true
        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.nextButton.setNeedsDisplay()
        self.nextButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func setDefaultButtonColor() {
        self.leftEarButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.leftEarButton.layer.borderWidth = 1.0
        self.leftEarButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        
        self.rightEarButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.rightEarButton.layer.borderWidth = 1.0
        self.rightEarButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        
        self.bothEarButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.bothEarButton.layer.borderWidth = 1.0
        self.bothEarButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        
        if self.earpreference == FRDEarPreference.left.rawValue {
            self.setLeftEarButtonColor()
        } else if self.earpreference == FRDEarPreference.right.rawValue {
            self.setRightEarButtonColor()
        } else if self.earpreference == FRDEarPreference.both.rawValue {
            self.setBothEarButtonColor()
        }
    }
    func setLeftEarButtonColor() {
        self.leftEarButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.leftEarButton.layer.borderWidth = 1.0
        self.leftEarButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
    }
    func setRightEarButtonColor() {
        self.rightEarButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.rightEarButton.layer.borderWidth = 1.0
        self.rightEarButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
    }
    func setBothEarButtonColor() {
        self.bothEarButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.bothEarButton.layer.borderWidth = 1.0
        self.bothEarButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
    }
    func leftEarTapped() {
        if self.leftEarpreferenceID != nil {
            self.earpreferenceID = self.leftEarpreferenceID
            //            self.bannerImageView.image = UIImage.gif(name: Asset.monaural_left)
            self.bannerImageView.setImage(imageUrl: leftImage, placeHolderImage: hearzapPlaceholder)
            self.earpreference = FRDEarPreference.left.rawValue
            self.setButtonUserInteraction()
            self.setDefaultButtonColor()
            var contentmessage = ""
            self.contentLabel.setHTMLFromString(htmlText: contentmessage, fontFamily: AppConstantValue.poppinsregular, fontSize: 13.0, fontColor: AppConstantValue.fontGrey777777)
            self.descriptionLabel.setHTMLFromString(htmlText: leftDecriptionMessage, fontFamily: AppConstantValue.poppinsregular, fontSize: 13.0, fontColor: AppConstantValue.fontGrey777777)
            
            //            setHTMLFromString(htmlText: contentmessage.capitalized, fontFamily: AppConstantValue.poppinsregular, fontSize: 13.0, fontColor: AppConstantValue.fontGrey777777)
        }
    }
    func rightEarTapped() {
        if self.rightEarpreferenceID != nil {
            self.earpreferenceID = self.rightEarpreferenceID
            //            self.bannerImageView.image = UIImage.gif(name: Asset.monaural_right)
            self.bannerImageView.setImage(imageUrl: rightImage, placeHolderImage: hearzapPlaceholder)
            self.earpreference = FRDEarPreference.right.rawValue
            self.setButtonUserInteraction()
            self.setDefaultButtonColor()
            var contentmessage = ""
            self.contentLabel.setHTMLFromString(htmlText: contentmessage, fontFamily: AppConstantValue.poppinsregular, fontSize: 13.0, fontColor: AppConstantValue.fontGrey777777)
            self.descriptionLabel.setHTMLFromString(htmlText: rightDecriptionMessage, fontFamily: AppConstantValue.poppinsregular, fontSize: 13.0, fontColor: AppConstantValue.fontGrey777777)
        }
    }
    func bothEarTapped() {
        if self.bothEarpreferenceID != nil {
            self.earpreferenceID = self.bothEarpreferenceID
            //            self.bannerImageView.image = UIImage.gif(name: Asset.binaural)
            self.bannerImageView.setImage(imageUrl: bothImage, placeHolderImage: hearzapPlaceholder)
            self.earpreference = FRDEarPreference.both.rawValue
            self.setButtonUserInteraction()
            self.setDefaultButtonColor()
            var contentmessage = ""
            self.contentLabel.setHTMLFromString(htmlText: contentmessage, fontFamily: AppConstantValue.poppinsregular, fontSize: 13.0, fontColor: AppConstantValue.fontGrey777777)
            self.descriptionLabel.setHTMLFromString(htmlText: bothDecriptionMessage, fontFamily: AppConstantValue.poppinsregular, fontSize: 13.0, fontColor: AppConstantValue.fontGrey777777)
        }
    }
}
extension FindRightDeviceEarPreferenceViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension FindRightDeviceEarPreferenceViewController: ProtocolNetworkRechabilityDelegate {
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
