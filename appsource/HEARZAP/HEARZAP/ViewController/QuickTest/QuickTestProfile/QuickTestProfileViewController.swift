//
//  QuickTestProfileViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 02/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class QuickTestProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    //    @IBOutlet var fourDotCircleView: FourDotCircleView!
    
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!
    
    @IBOutlet var mainBackgroundView: UIView!
    @IBOutlet var profileCollectionView: UICollectionView!
    

    // MARK: - Lets and Var
    var quickTestProfileViewModel = QuickTestProfileViewModel()
    var isFrom = ""
    var patientList = [PatientList]()
    var selectedPerson = ""
    var patientData: PatientList?
    var sessionID = ""
    var newGuestpatientList = [PatientList]()

    let profileCollectionViewMargin = CGFloat(0)
    let profileCollectionViewItemSpacing = CGFloat(0)
    var profileCollectionViewItemHeight = CGFloat(178)
    var profileCollectionViewItemWidth = CGFloat(139)
    let profileCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var canHideShimmering = false
    
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
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: - Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_white_FFFFFF,style: StatusBarTheme.darkContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    // MARK: - Set Initial View
    func setInitialView() {
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.patientList.removeAll()
        self.updateDefaultPatientList()
        self.reloadProfileCollectionView()
        self.commonAPICALL(retryAPIID: 1000)
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
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.setCommonTitleView()
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.QCStep1Title.capitalized
        let descriptionMessage = AppLocalizationString.QCStep1Desc.capitalized
        
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
    // MARK: - Reload
    func reloadProfileCollectionView() {
        self.profileCollectionViewItemWidth = (screenFrameWidth - 16 /*left right padding*/) / 3
        self.profileCollectionViewItemHeight = ((screenFrameWidth - 16 /*left right padding*/) / 3) + 60
        self.profileCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.profileCollectionViewlayout.itemSize = CGSize(width: self.profileCollectionViewItemWidth, height: self.profileCollectionViewItemHeight)
        self.profileCollectionViewlayout.minimumLineSpacing = self.profileCollectionViewItemSpacing
        self.profileCollectionViewlayout.minimumInteritemSpacing = self.profileCollectionViewItemSpacing
        self.profileCollectionViewlayout.scrollDirection = .vertical
        self.profileCollectionView!.collectionViewLayout = self.profileCollectionViewlayout
        self.profileCollectionView.dataSource = self
        self.profileCollectionView.delegate = self
        self.profileCollectionView.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
//                if retryAPIID == 1000 {
//                    self.getCustomerRelationPersonList(retryAPIID: retryAPIID, canShowLoader: true)
//                } 
                if (retryAPIID == 1000){
                    if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
                        self.getQuickCheckupGuestUserList(retryAPIID: retryAPIID, canShowLoader: true)
                    } else {
                        self.getCustomerRelationPersonList(retryAPIID: retryAPIID, canShowLoader: true)
                    }
                }
                else if retryAPIID == 1001 {
                    self.postQuickCheckupPersonList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCustomerRelationPersonList(retryAPIID: Int, canShowLoader: Bool) {
        self.quickTestProfileViewModel.getCustomerRelationPersonList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCustomerRelationPersonList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getQuickCheckupGuestUserList(retryAPIID: Int, canShowLoader: Bool) {
        self.quickTestProfileViewModel.getQuickCheckupGuestUserList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getQuickCheckupGuestUserList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postQuickCheckupPersonList(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "patient_uid=%@", self.selectedPerson)
        self.quickTestProfileViewModel.postQuickCheckupPersonList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postQuickCheckupPersonList, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    
    // MARK: - IBAction
    @IBAction func tryNowButtonPressed(_ sender: UIButton) {
        self.checkVerifiedUser()
    }
    // MARK: - Custom Methods
    func checkVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginQuickCheck.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToSelectUserViewControllerToQuickCheck(isFrom: self.isFrom, showFourDotView: true, showFiveDotView: false, showSixDotView: false)
        }
    }
    func verifiedUser(isFrom: String, isWishlist: Bool, productUID: String) {
        if isFrom == IsNavigateFrom.loginQuickCheck.rawValue {
            self.checkVerifiedUser()
        }
    }
    func updateDefaultPatientList(){
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            if (self.newGuestpatientList.count > 0){
                for list in newGuestpatientList {
                    self.patientList.append(list)
                }
            }
        }
        self.patientList.append(PatientList(id: 50000,uid: "",customerUid: "",name: "Invite a Friend",age: "",gender: GenderType.male.rawValue,relationship: "Invite a Friend",relationshipType: StaticRelationType.invitefriend.rawValue))
        self.patientList.append(PatientList(id: 50001,uid: "",customerUid: "",name: "Add New",age: "",gender: GenderType.addnew.rawValue,relationship: "Add New",relationshipType: StaticRelationType.addnew.rawValue))
    }
}
extension QuickTestProfileViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.qcHomeStatic.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.qcHearingCare.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.qcMenuReport.rawValue {
            self.navigateBackToAudiogramReportViewController()
        } else if (self.isFrom == IsNavigateFrom.qcFRDReport.rawValue) || (self.isFrom == IsNavigateFrom.qcFRDUploadReport.rawValue) {
            self.navigateBackToFindRightDeviceUploadReportViewController()
        }
        else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {}
}

extension QuickTestProfileViewController: ProtocolNetworkRechabilityDelegate {
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

extension QuickTestProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.patientList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.QuickTestProfileCollectionViewCell, for: indexPath) as! QuickTestProfileCollectionViewCell
        cell.configure(patientList: self.patientList[indexPath.item], indexpath: indexPath.item,canHideShimmering: self.canHideShimmering)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.patientList.count > 0 {
            cellWidth = self.profileCollectionViewItemWidth
            cellHeight = self.profileCollectionViewItemHeight
        }
        self.view.layoutIfNeeded()
        self.viewWillLayoutSubviews()
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension QuickTestProfileViewController: ProtocolQuickTestProfileCollectionViewCell {
    
    func selectProfileButtonPressedQuickTestProfileCollectionViewCell(senderTag: Int) {
        var relationshiptype = ""
        var uid = ""
        self.selectedPerson = ""
        if (self.patientList.count > 0){
            if !(self.patientList[senderTag].relationshipType.isNilOrEmpty) {
                relationshiptype = self.patientList[senderTag].relationshipType!
                if relationshiptype == StaticRelationType.invitefriend.rawValue{
                    if !(AppLocalizationString.quickcheckinvitefriendlink.isEmpty) {
                        let objectsToShare = [AppLocalizationString.quickcheckinvitefriendlink]
                        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                        activityVC.popoverPresentationController?.sourceView = self.view
                        self.present(activityVC, animated: true, completion: nil)
                    } else {
                        // empty msg
                        self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                    }
                }
                else if relationshiptype == StaticRelationType.addnew.rawValue{
                    if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
                        self.navigateToQuickTestAddUserViewController(isEdit: false, isFrom: IsNavigateFrom.addUserQuickCheck.rawValue, uid: "", name: "", dob: "", genderSlug: "", relationShipSlug: "", relationShip: "", newGuestpatientList: self.newGuestpatientList)
                    } else {
                        self.navigateToQuickTestAddUserViewController(isEdit: false, isFrom: IsNavigateFrom.addUserQuickCheck.rawValue, uid: "", name: "", dob: "", genderSlug: "", relationShipSlug: "", relationShip: "", newGuestpatientList: self.newGuestpatientList)
                    }
                }
                else{
                    if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
                        self.patientData = self.patientList[senderTag]
                        self.navigateToQuickTestHeadsetConnectivityViewController(isFrom: self.isFrom, patientData: self.patientData!, sessionID: self.sessionID)
                    }
                    else {
                        if !(self.patientList[senderTag].uid.isNilOrEmpty) {
                            self.selectedPerson = self.patientList[senderTag].uid!
                        }
                        if !(self.selectedPerson.isEmpty){
                            self.commonAPICALL(retryAPIID: 1001)
                        }
                    }
                }
            }
            
        }
        
    }
}
