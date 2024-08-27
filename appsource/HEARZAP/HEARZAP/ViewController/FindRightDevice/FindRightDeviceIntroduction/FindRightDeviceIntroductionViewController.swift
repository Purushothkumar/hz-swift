//
//  FindRightDeviceIntroductionViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 07/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class FindRightDeviceIntroductionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: LogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var stepStackView: UIStackView!
    @IBOutlet var listStackView: UIStackView!
    @IBOutlet var resultStackView: UIStackView!
    
    @IBOutlet var bannerView: UIView!
    @IBOutlet var bannerImageView: UIImageView!
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var demoTitleView: UIView!
    @IBOutlet var demoTitleLabel: Title2FontLabel!
    @IBOutlet var demoDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var tableviewHeight: NSLayoutConstraint!
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet var playView: UIView!
    @IBOutlet var playViewTitleLabel: Caption1FontLabel!
    @IBOutlet var playButton: FootnoteRoundedOutlineButton!
    
    @IBOutlet var recomendedLabel: FootnoteFontLabel!
    
    @IBOutlet var previousViewHeight: NSLayoutConstraint!
    @IBOutlet var previoustableviewHeight: NSLayoutConstraint!
    @IBOutlet var previoustableview: UITableView!
    
    @IBOutlet var tryNowView: UIView!
    @IBOutlet var tryNowButton: CalloutBackgroundButton!
    
    @IBOutlet var emptyView: UIView!
    
    // MARK: - Lets and Var
    var isFrom = ""
    let findRightDeviceIntroductionViewModel = FindRightDeviceIntroductionViewModel()
    var stepArray = [Step]()
    var previousResultArray = [PreviousResult]()
    
    var demovideoLink = ""
    
    var servicePosterImage = ""
    var servicePosterVideoLink = ""
    
    var lifestyleID: Int?
    var technologyID: Int?
    var model = [Int]()
    var earpreferenceID: Int?
    var UID: String?
    var patientUid = ""
    var sessionUID = ""
    
    var isNewUser = false
    
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
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.stepArray.count > 0 {
            self.tableviewHeight.constant = self.tableview.contentSize.height
        } else {
            self.tableviewHeight.constant = 0
        }
        if self.previousResultArray.count > 0 {
            self.previoustableviewHeight.constant = self.previoustableview.contentSize.height
            self.previousViewHeight.constant = self.previoustableview.contentSize.height + CGFloat(20)
        } else {
            self.previoustableviewHeight.constant = 0
            self.previousViewHeight.constant = 0
            
        }
        self.mainScrollView.sizeToFit()
        self.mainScrollView.contentSize = CGSize(width: self.mainStackView.frame.size.width, height: self.emptyView.frame.height + self.emptyView.frame.origin.y)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.backgroundView.roundCorners([.topLeft, .topRight], radius: 8.0)
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
        self.playButton.setTitle(AppLocalizationString.playVideo.uppercased(), for: .normal)
        self.playButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.playButton.layer.borderWidth = 1.0
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        
        self.previoustableview.tableFooterView = UIView()
        self.previoustableview.separatorColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.previoustableview.backgroundColor = UIColor.clear
        self.previoustableview.rowHeight = UITableView.automaticDimension
        self.previoustableview.estimatedRowHeight = UITableView.automaticDimension
        self.backgroundView.roundCorners([.topLeft, .topRight], radius: 20.0)
        self.tryNowView.isHidden = true
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBar.isLogoHidden = false
        self.navigationBar.logoImage = Asset.hzlogo
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.demoTitleLabel.text = AppLocalizationString.hearingAidFinder
        self.demoDescriptionLabel.text = AppLocalizationString.chooseTheRightHearingAidBasedOnYourLifestyle
        self.playViewTitleLabel.text = AppLocalizationString.needHelpCheckourdemovideo
        self.recomendedLabel.text = AppLocalizationString.recentRecommendations
        self.playButton.setTitle(AppLocalizationString.playVideo.uppercased(), for: .normal)
        self.tryNowButton.setTitle(AppLocalizationString.findnow.uppercased(), for: .normal)
    }
    // MARK: - Reload
    func reloadTableview() {
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
    }
    func reloadPreviousTableview() {
        self.previoustableview.delegate = self
        self.previoustableview.dataSource = self
        self.previoustableview.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getFindRightDeviceDemoList(retryAPIID: retryAPIID, canShowLoader: true)
                }
                if retryAPIID == 1001 {
                    self.getFindRightDeviceDemoList(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getFindRightDeviceDemoList(retryAPIID: Int, canShowLoader: Bool) {
        self.findRightDeviceIntroductionViewModel.getFindRightDeviceDemoList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getFindRightDeviceDemoList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    
    // MARK: - IBAction
    @IBAction func tryNowButtonPressed(_ sender: UIButton) {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.checkVerifiedUser()
        } else {
            self.navigateToSelectUserViewControllerToFHA(isFrom: self.isFrom, showFourDotView: false, showFiveDotView: false, showSixDotView: true)
        }
    }
    @IBAction func playButtonPressed(_ sender: UIButton) {
        if !(servicePosterVideoLink.isEmpty) {
            self.navigateToYoutubePlayerViewController(servicePosterVideoLink: self.servicePosterVideoLink)
        }
    }
    // MARK: - Custom Methods
    func checkVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginFHA.rawValue, isWishlist: false, productUID: "")
        } else {
            self.commonAPICALL(retryAPIID: 1001)
        }
    }
    func verifiedUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkVerifiedUser()
    }
}
extension FindRightDeviceIntroductionViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.fhaHomeStatic.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.fhaHearingCare.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else  if self.isFrom == IsNavigateFrom.fhaShop.rawValue {
            self.navigateBackToShopCategoryViewController()
        } else if self.isFrom == IsNavigateFrom.fhaSurveySuccess.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        }
    }
    func rightButtonPressed() {}
}

extension FindRightDeviceIntroductionViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableview {
            if self.stepArray.count > 0 {
                return 2
            }
        } else {
            if self.previousResultArray.count > 0 {
                return 1
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableview {
            if self.stepArray.count > 0 {
                if section == 0 {
                    return 1
                } else {
                    return self.stepArray.count
                }
            }
        } else {
            return self.previousResultArray.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableview {
            if self.stepArray.count > 0 {
                if indexPath.section == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindRightDeviceIntroductionTitleTableViewCell, for: indexPath) as! FindRightDeviceIntroductionTitleTableViewCell
                    cell.titleLabel.text = AppLocalizationString.howitworks
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindRightDeviceIntroductionTableViewCell, for: indexPath) as! FindRightDeviceIntroductionTableViewCell
                    cell.configure(step: self.stepArray[indexPath.row], indexPath: indexPath.row)
                    if self.stepArray.count > 0 {
                        if indexPath.row == (self.stepArray.count - 1) {
                            cell.hideSeparator()
                        }
                    }
                    return cell
                }
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindRightDeviceIntroductionResultTableViewCell, for: indexPath) as! FindRightDeviceIntroductionResultTableViewCell
            cell.configure(previousResult: self.previousResultArray[indexPath.row], indexPath: indexPath.row)
            if self.previousResultArray.count > 0 {
                if indexPath.row == (self.previousResultArray.count - 1) {
                    cell.hideSeparator()
                }
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindRightDeviceIntroductionTitleTableViewCell, for: indexPath) as! FindRightDeviceIntroductionTitleTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == self.previoustableview {
            self.previoustableviewHeight.constant = tableView.contentSize.height
            self.previousViewHeight.constant = tableView.contentSize.height + CGFloat(20)
            
        } else {
            self.tableviewHeight.constant = tableView.contentSize.height
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.previousResultArray.count > 0 && tableView == self.previoustableview {
            if !(self.previousResultArray[indexPath.row].uid.isNilOrEmpty) {
                UID = (self.previousResultArray[indexPath.row].uid!)
            }
            if self.previousResultArray[indexPath.row].input != nil {
                if self.previousResultArray[indexPath.row].input!.technologyID != nil {
                    technologyID = self.previousResultArray[indexPath.row].input!.technologyID!
                }
                if self.previousResultArray[indexPath.row].input!.earInfoID != nil {
                    earpreferenceID = self.previousResultArray[indexPath.row].input!.earInfoID!
                }
                if self.previousResultArray[indexPath.row].input!.modelIDList != nil {
                    model = self.previousResultArray[indexPath.row].input!.modelIDList!
                }
                if self.previousResultArray[indexPath.row].input!.lifestyleID != nil {
                    lifestyleID = self.previousResultArray[indexPath.row].input!.lifestyleID!
                }
            }
            
            self.patientUid = ""
            self.navigateToFindRightDeviceRecommendViewController(isFrom: self.isFrom, patientUid: self.patientUid, lifestyleID: self.lifestyleID, model: self.model, technologyID: technologyID, earpreferenceID: earpreferenceID, UID: UID, sessionUID: self.sessionUID, sessionKey: "", isNewUser: false,sessionID: "")
        }
    }
}
extension FindRightDeviceIntroductionViewController: ProtocolNetworkRechabilityDelegate {
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
