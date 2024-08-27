//
//  FindRightDeviceRecommendViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FLAnimatedImage
import BottomPopup
import SwiftUI

class FindRightDeviceRecommendViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var sixDotCircleView: SixDotCircleView!
    
    @IBOutlet var retryButton: FootnoteBackgroundButton!
    @IBOutlet var retryButtonWidth: NSLayoutConstraint!
    @IBOutlet var recommendationHeaderLabel: CalloutFontLabel!
    @IBOutlet var recommendationDescriptionLabel: Caption2FontLabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var selectItemLabel: Caption2FontLabel!
    
    @IBOutlet var addwishlistButton: FootnoteBackgroundButton!
    @IBOutlet var compareButton: FootnoteBackgroundButton!
    @IBOutlet var bookTrialButton: FootnoteBackgroundButton!
    
    @IBOutlet var errorView: UIView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var errorRetrybutton: CalloutOutlineButton!
    
    let collectionViewMargin = 0
    let collectionViewItemSpacing = CGFloat(8)
    var collectionViewItemHeight = CGFloat(129)
    var collectionViewItemWidth = CGFloat(307)
    let collectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    // MARK: - Lets and Var
    var findRightDeviceRecommendViewModel = FindRightDeviceRecommendViewModel()
    
    var isFrom = ""
    var patientUid = ""
    
    var lifestyleID: Int?
    var technologyID: Int?
    var model = [Int]()
    var earpreferenceID: Int?
    var UID: String?
    var sessionUID = ""
    var sessionKey = ""
    var sessionID = ""
    
    var isNewUser = false
    var recommendedArray = [FindRightDeviceRecommendModelOutput]()
    var selectedrecommendedArray = [String]()
    var selectedWishListArray = [String]()
    
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
        self.errorView.isHidden = true
        self.addwishlistButton.titleLabel?.textAlignment = .center
        self.compareButton.titleLabel?.textAlignment = .center
        self.bookTrialButton.titleLabel?.textAlignment = .center
        if self.isNewUser == false {
            self.commonAPICALL(retryAPIID: 1001)
        } else {
            self.commonAPICALL(retryAPIID: 1000)
        }
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = true
        self.navigationBar.isRightViewHidden = false
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = Asset.xlargewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.hearingAidFinder
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Set Six Dot Circle View
    func setSixDotCircleView() {
        self.sixDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.checkcircleblue, button3image: Asset.checkcircleblue, button4image: Asset.checkcircleblue, button5image: Asset.checkcircleblue, button6image: Asset.recordcircleblue,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        //        let titlemessage = AppLocalizationString.FHAStep5Title.capitalized
        //        let descriptionMessage = AppLocalizationString.FHAStep5Desc.capitalized
        
        self.recommendationHeaderLabel.text = AppLocalizationString.FHAStep6Title.capitalized
        self.recommendationDescriptionLabel.text = AppLocalizationString.FHAStep6Desc.capitalized
    }
    
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.setCommonTitleView()
        self.primaryMessageLabel.text = AppLocalizationString.noProductsFound
        self.secondaryMessageLabel.text = AppLocalizationString.noProductsDesc
        self.errorRetrybutton.setTitle(AppLocalizationString.tryAgain.uppercased(), for: .normal)
        self.selectItemLabel.text = String(format: "%d %@", self.selectedrecommendedArray.count, self.selectedrecommendedArray.count > 1 ? AppLocalizationString.itemspicked : AppLocalizationString.itempicked)
        self.addwishlistButton.setTitle(AppLocalizationString.pluswishlist.uppercased(), for: .normal)
        self.compareButton.setTitle(AppLocalizationString.compare.uppercased(), for: .normal)
        self.bookTrialButton.setTitle(AppLocalizationString.freeTrial.uppercased(), for: .normal)
        self.retryButton.setTitle(AppLocalizationString.retry.uppercased(), for: .normal)
        
        if (self.recommendedArray.count == 0) {
            self.retryButtonWidth.constant = 0
        }
        else if (self.recommendedArray.count > 0){
            self.retryButtonWidth.constant = 70
        }
    }
    // MARK: - Reload
    func reloadCollectionView() {
        self.collectionViewItemWidth = (screenFrameWidth - 8) / 2
        self.collectionViewItemHeight = (239.38 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
        
        self.collectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionViewlayout.itemSize = CGSize(width: self.collectionViewItemWidth, height: self.collectionViewItemHeight)
        self.collectionViewlayout.minimumLineSpacing = self.collectionViewItemSpacing
        self.collectionViewlayout.minimumInteritemSpacing = self.collectionViewItemSpacing
        self.collectionViewlayout.scrollDirection = .vertical
        self.collectionView!.collectionViewLayout = self.collectionViewlayout
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
    }
    
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.postFindRightDeviceRecommendList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getFindRightDeviceRecommendList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.postWishlist(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    
    func postFindRightDeviceRecommendList(retryAPIID: Int, canShowLoader: Bool) {
        let str_model: String = self.model.count > 0 ?  self.stringifyArray(json: self.model, prettyPrinted: false) : "[]"
        var param = ""
        if !(self.sessionUID.isEmpty) && !(self.sessionKey.isEmpty){
            param =  String(format: "lifestyle=%d&model=%@&technology=%d&ear_info=%d&patient_uid=%@&session_uid=%@&session_key=%@&session_id=%@", self.lifestyleID!, str_model, self.technologyID!, self.earpreferenceID!, self.patientUid, self.sessionUID, self.sessionKey,self.sessionID)
        } else {
            param =  String(format: "lifestyle=%d&model=%@&technology=%d&ear_info=%d&patient_uid=%@&session_id=%@", self.lifestyleID!, str_model, self.technologyID!, self.earpreferenceID!, self.patientUid,self.sessionID)
        }
        self.findRightDeviceRecommendViewModel.postFindRightDeviceRecommendList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postFindRightDeviceRecomendedList, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    
    func getFindRightDeviceRecommendList(retryAPIID: Int, canShowLoader: Bool) {
        let subAPIUrl = String(format: "%@%@/", SubAPIUrl.getFindRightDeviceRecomendedList, UID!)
        self.findRightDeviceRecommendViewModel.getFindRightDeviceRecomendedList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: subAPIUrl, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postWishlist(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "product_id=%@&mode=add", self.selectedWishListArray.count > 0 ? self.stringifyArray(json: self.selectedWishListArray, prettyPrinted: false) : "[]")
        self.findRightDeviceRecommendViewModel.postWishlist(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postWishlist, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func bookTrialButtonPressed(_ sender: UIButton) {
        self.navigateToBookAppointmentLocationViewController(isFrom: IsNavigateFrom.baFHA.rawValue)
    }
    @IBAction func compareButtonPressed(_ sender: UIButton) {
        var product1 = ""
        var product2 = ""
        if self.selectedrecommendedArray.count > 0 {
            if self.selectedrecommendedArray.count > 0 {
                product1 = self.selectedrecommendedArray[0]
            }
            if self.selectedrecommendedArray.count > 1 {
                product2 = self.selectedrecommendedArray[1]
            }
            self.navigateToCompareProductViewController(isFrom: IsNavigateFrom.compareFHA.rawValue, product1: product1, product2: product2)
        }
    }
    @IBAction func addwishlistButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 2000)
    }
    @IBAction func retryButtonPressed(_ sender: UIButton) {
        self.navigateBackToFindRightDeviceIntroductionViewController()
    }
    // MARK: - Custom Methods
    func setButtonUserInteraction() {
        if self.selectedWishListArray.count > 0 {
            self.setAddwishlistButtonEnable()
        } else {
            self.setAddwishlistButtonDisable()
        }
        if self.selectedrecommendedArray.count > 0 && self.selectedrecommendedArray.count <= 2 {
            self.setCompareButtonButtonEnable()
        } else {
            self.setCompareButtonButtonDisable()
        }
        self.changeLanguageFormat()
    }
    func setAddwishlistButtonDisable() {
        self.addwishlistButton.isUserInteractionEnabled = false
        self.addwishlistButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.addwishlistButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.addwishlistButton.setNeedsDisplay()
        self.addwishlistButton.layoutIfNeeded()
    }
    func setAddwishlistButtonEnable() {
        self.addwishlistButton.isUserInteractionEnabled = true
        self.addwishlistButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.addwishlistButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.addwishlistButton.setNeedsDisplay()
        self.addwishlistButton.layoutIfNeeded()
    }
    func setCompareButtonButtonDisable() {
        self.compareButton.isUserInteractionEnabled = false
        self.compareButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.compareButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.compareButton.setNeedsDisplay()
        self.compareButton.layoutIfNeeded()
    }
    func setCompareButtonButtonEnable() {
        self.compareButton.isUserInteractionEnabled = true
        self.compareButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.compareButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.compareButton.setNeedsDisplay()
        self.compareButton.layoutIfNeeded()
    }
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
        return "[]"
    }
}
extension FindRightDeviceRecommendViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {}
    func rightButtonPressed() {
        if self.isFrom == IsNavigateFrom.fhaHomeStatic.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.fhaHearingCare.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if self.isFrom == IsNavigateFrom.fhaShop.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
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
}
extension FindRightDeviceRecommendViewController: ProtocolNetworkRechabilityDelegate {
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
extension FindRightDeviceRecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendedArray.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.FindRightDeviceRecommendCollectionViewCell, for: indexPath) as! FindRightDeviceRecommendCollectionViewCell
        cell.configure(output: self.recommendedArray[indexPath.item], indexPath: indexPath.item, selectedrecommendedArray: self.selectedrecommendedArray, selectedWishListArray: self.selectedWishListArray)
        cell.delegate = self
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if recommendedArray.count > 0 {
            cellWidth = self.collectionViewItemWidth
            cellHeight = self.collectionViewItemHeight
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension FindRightDeviceRecommendViewController: ProtocolFindRightDeviceRecommendCollectionViewCell {
    func productDetailButtonFindRightDeviceRecommendCollectionViewCell(senderTag: Int) {
        if self.recommendedArray[senderTag].product != nil {
            if !(self.recommendedArray[senderTag].product!.slug.isNilOrEmpty) {
                self.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productDetailFHA.rawValue, productslug: self.recommendedArray[senderTag].product!.slug!)
            }
        }
    }
    func selectButtonPressedFindRightDeviceRecommendCollectionViewCell(senderTag: Int) {
        if self.recommendedArray[senderTag].product != nil {
            if self.recommendedArray[senderTag].product!.uid != nil {
                let uid = self.recommendedArray[senderTag].product!.uid!
                if self.selectedrecommendedArray.count > 0 {
                    if self.selectedrecommendedArray.contains(uid) {
                        self.selectedrecommendedArray.removeAll { $0 == uid }
                    } else {
                        self.selectedrecommendedArray.append(uid)
                    }
                } else {
                    self.selectedrecommendedArray.append(uid)
                }
            }
            if self.recommendedArray[senderTag].product!.id != nil {
                let id = String(format: "%d", self.recommendedArray[senderTag].product!.id!)
                if self.selectedWishListArray.count > 0 {
                    if self.selectedWishListArray.contains(id) {
                        self.selectedWishListArray.removeAll { $0 == id }
                    } else {
                        self.selectedWishListArray.append(id)
                    }
                } else {
                    self.selectedWishListArray.append(id)
                }
            }
        }
        self.reloadCollectionView()
        self.setButtonUserInteraction()
    }
}
