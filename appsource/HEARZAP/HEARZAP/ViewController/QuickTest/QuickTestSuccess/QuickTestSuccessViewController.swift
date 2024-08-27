//
//  QuickTestSuccessViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 08/12/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class QuickTestSuccessViewController: UIViewController {
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
    
    @IBOutlet var successView: UIView!
    @IBOutlet var successImageView: UIImageView!
    @IBOutlet var successImageViewWidth: NSLayoutConstraint!
    
    @IBOutlet var buttonView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!
    @IBOutlet var headsetAlertlabel: Caption2FontLabel!
    
    // MARK: - Lets and Var
    var quickTestSuccessViewModel = QuickTestSuccessViewModel()
    var isFrom = ""
    var dictLeft = [String: String]()
    var dictRight = [String: String]()
    var arrayLeft = [Int]()
    var arrayRight = [Int]()
    
    var isHeadPhoneConnected = false
    var dictJson: NSDictionary = NSDictionary()
    var playCount: CGFloat = 1.0
    var earTestCount = 0
    var selectedEar = ""
    
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
        if patientData != nil {
            if !(patientData!.name.isNilOrEmpty) {
                self.patientName = patientData!.name!
            }
        }
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.setThreeDotCircleView()
        self.quickHumanImageViewWidth.constant = CGFloat(screenFrameWidth) * CGFloat(AppConstantValue.screen192slash375)
        self.successImageViewWidth.constant = CGFloat(screenFrameWidth) * CGFloat(AppConstantValue.screen215slash375)
        if self.selectedEar == EarType.left.rawValue {
            self.successImageView.image = UIImage(named: Asset.earsuccessleftthumb)
        } else if self.selectedEar == EarType.right.rawValue {
            self.successImageView.image = UIImage(named: Asset.earsuccessrightthumb)
        }
        
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
        var titlemessage = ""
        var descriptionMessage = ""
        if self.earTestCount == 0 {
            titlemessage = AppLocalizationString.QCStep3Title.capitalized
            descriptionMessage = AppLocalizationString.QCStep3Desc.capitalized
        } else {
            titlemessage = AppLocalizationString.QCStep4Title.capitalized
            descriptionMessage = AppLocalizationString.QCStep4Desc.capitalized
        }
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
        var strText2 = ""
        if self.selectedEar == EarType.left.rawValue {
            strText1 = AppLocalizationString.completedlefteartesting
            strText2 = AppLocalizationString.collectedhearingtestingsamplesofyourleft
        } else if self.selectedEar == EarType.right.rawValue {
            strText1 = AppLocalizationString.completedrighteartesting
            strText2 = AppLocalizationString.collectedhearingtestingsamplesofyourright
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
        
        if self.earTestCount == 0 {
            self.nextButton.setTitle(AppLocalizationString.continueStr.uppercased(), for: .normal)
            self.setCommonTitleView()
        } else {
            self.nextButton.setTitle(AppLocalizationString.next.uppercased(), for: .normal)
            self.setCommonTitleView()
        }
    }
    
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                self.postQuickCheckupdata(retryAPIID: retryAPIID, canShowLoader: true)
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func postQuickCheckupdata(retryAPIID: Int, canShowLoader: Bool) {
        var patientuid = ""
        var rightFieldValue = ""
        var leftFieldValue = ""
        
        if patientData != nil {
            if !(patientData!.uid.isNilOrEmpty) {
                patientuid = patientData!.uid!
            }
        }
        let url = "\(SubAPIUrl.postQuickCheckupdata)\(patientuid)/"
        leftFieldValue = String(format: "%@", dictLeft.count > 0 ? self.stringifyArray(json: dictLeft, prettyPrinted: false) : "{}")
        rightFieldValue = String(format: "%@", dictRight.count > 0 ? self.stringifyArray(json: dictRight, prettyPrinted: false) : "{}")
        
        let param = String(format: "session_id=%@&right_field_value=%@&left_field_value=%@&patientuid=%@", self.sessionID, rightFieldValue, leftFieldValue, patientuid)
        self.quickTestSuccessViewModel.postQuickCheckupdata(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if self.earTestCount == 0 {
            if self.selectedEar == EarType.left.rawValue {
                self.navigateToQuickTestSelectEarViewController(isFrom: self.isFrom, earTestCount: 1, selectedEar: EarType.right.rawValue, patientData: self.patientData!, sessionID: self.sessionID, dictLeft: self.dictLeft, dictRight: self.dictRight, arrayLeft: self.arrayLeft, arrayRight: self.arrayRight)
            } else if self.selectedEar == EarType.right.rawValue {
                self.navigateToQuickTestSelectEarViewController(isFrom: self.isFrom, earTestCount: 1, selectedEar: EarType.left.rawValue, patientData: self.patientData!, sessionID: self.sessionID, dictLeft: self.dictLeft, dictRight: self.dictRight, arrayLeft: self.arrayLeft, arrayRight: self.arrayRight)
            }
        } else {
            if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
                self.navigateToQuickTestUserInfoViewController(isFrom: self.isFrom, patientData: self.patientData!, sessionID: self.sessionID, dictLeft: self.dictLeft, dictRight: self.dictRight, arrayLeft: self.arrayLeft, arrayRight: self.arrayRight)
            }
            else{
                self.commonAPICALL(retryAPIID: 1000)
            }
        }
    }
    // MARK: - Custom Method
    func stringifyArray(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        return "{}"
    }
}
extension QuickTestSuccessViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToQuickTestProfileViewController()
    }
    func rightButtonPressed() {
    }
}
extension QuickTestSuccessViewController: ProtocolNetworkRechabilityDelegate {
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
