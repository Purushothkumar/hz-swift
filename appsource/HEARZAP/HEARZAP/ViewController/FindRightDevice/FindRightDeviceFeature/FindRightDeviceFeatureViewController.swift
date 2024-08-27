//
//  FindRightDeviceFeatureViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 14/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class FindRightDeviceFeatureViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var sixDotCircleView: SixDotCircleView!
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    
    @IBOutlet var modelView: UIView!
    @IBOutlet var selectStylelabel: CalloutFontLabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var technologyView: UIView!
    @IBOutlet var priceRangelabel: CalloutFontLabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var featureView: UIView!
    @IBOutlet var featurelabel: CalloutFontLabel!
    @IBOutlet var featureTableView: UITableView!
    @IBOutlet var featureTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var nextView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!
    
    @IBOutlet var emptyView: UIView!
    
    // MARK: - Lets and Var
    var findRightDeviceFeatureViewModel = FindRightDeviceFeatureViewModel()
    var modelArray = [FindRightDeviceFeatureModelModel]()
    var technologyArray = [FindRightDeviceFeatureModelTechnology]()
    var featureArray = [FindRightDeviceFeatureModelFeature]()
    var jsonfeatureArray = [FindRightDeviceFeatureModelFeature]()
    
    let collectionViewMargin = 0
    let collectionViewItemSpacing = CGFloat(10)
    var collectionViewItemHeight = CGFloat(129)
    var collectionViewItemWidth = CGFloat(307)
    let collectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var isFrom = ""
    var patientUid = ""
    var sessionID = ""
    
    var lifestyleID: Int?
    var technologyID: Int?
    var modelSelectedArray = [Int]()
    var lifestyleName = ""
    
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
        if self.technologyArray.count > 0 {
            self.tableViewHeight.constant = self.tableView.contentSize.height
        } else {
            self.tableViewHeight.constant = 0
        }
        if self.featureArray.count > 0 {
            self.featureTableViewHeight.constant = self.featureTableView.contentSize.height
        } else {
            self.featureTableViewHeight.constant = 0
        }
        
        if self.modelArray.count > 0 {
            if self.modelArray.count % 2 == 0 {
                if self.modelArray.count > 4 {
                    self.collectionViewHeight.constant = ((CGFloat(self.modelArray.count) / 2) * collectionViewItemHeight) + (((CGFloat(self.modelArray.count) / 2) - 1) * 16)
                } else {
                    self.collectionViewHeight.constant = ((CGFloat(self.modelArray.count) / 2) * collectionViewItemHeight) + 16
                }
            } else {
                if self.modelArray.count > 4 {
                    self.collectionViewHeight.constant = ((CGFloat(self.modelArray.count) / 2) * collectionViewItemHeight) + (((CGFloat(self.modelArray.count) / 2) - 1) * 16) + collectionViewItemHeight + 16
                } else {
                    self.collectionViewHeight.constant = ((CGFloat(self.modelArray.count) / 2) * collectionViewItemHeight) + collectionViewItemHeight + 16
                }
            }
        } else {
            self.collectionViewHeight.constant = 0
        }
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
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.setButtonUserInteraction()
        let view0 = self.mainStackView.arrangedSubviews[0]// empty
        let view1 = self.mainStackView.arrangedSubviews[1]// model
        let view2 = self.mainStackView.arrangedSubviews[2]// empty
        let view3 = self.mainStackView.arrangedSubviews[3]// technology
        let view4 = self.mainStackView.arrangedSubviews[4]// empty
        let view5 = self.mainStackView.arrangedSubviews[5]// feature
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
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
        self.sixDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.checkcircleblue, button3image: Asset.checkcircleblue, button4image: Asset.recordcircleblue, button5image: Asset.circlegrey, button6image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
        
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.FHAStep3Title.capitalized
        var descriptionMessage = ""
        if self.lifestyleName.lowercased() == FRDLifeStyle.relaxed.rawValue.lowercased() {
            descriptionMessage = AppLocalizationString.FHAStep3DescRelaxed.capitalized
        } else if self.lifestyleName.lowercased() == FRDLifeStyle.quiet.rawValue.lowercased() {
            descriptionMessage = AppLocalizationString.FHAStep3DescQuiet.capitalized
        } else if self.lifestyleName.lowercased() == FRDLifeStyle.functional.rawValue.lowercased() {
            descriptionMessage = AppLocalizationString.FHAStep3DescFunctional.capitalized
        } else if self.lifestyleName.lowercased() == FRDLifeStyle.active.rawValue.lowercased() {
            descriptionMessage = AppLocalizationString.FHAStep3DescActive.capitalized
        } else if self.lifestyleName.lowercased() == FRDLifeStyle.busy.rawValue.lowercased() {
            descriptionMessage = AppLocalizationString.FHAStep3DescBusy.capitalized
        }
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
        self.featurelabel.text = AppLocalizationString.availablefeatures
        self.priceRangelabel.text = AppLocalizationString.yourtechnologypreferences
        self.selectStylelabel.text = AppLocalizationString.selectyourhearingaidstyle
        self.setCommonTitleView()
        self.nextButton.setTitle(AppLocalizationString.next.uppercased(), for: .normal)
    }
    
    // MARK: - Reload
    func reloadTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    func reloadFeatureTableView() {
        self.featureTableView.delegate = self
        self.featureTableView.dataSource = self
        self.featureTableView.reloadData()
    }
    func reloadFeatureDataTableView() {
        let view4 = self.mainStackView.arrangedSubviews[4]// empty
        let view5 = self.mainStackView.arrangedSubviews[5]// feature
        view4.isHidden = true
        view5.isHidden = true
        self.featureArray.removeAll()
        self.reloadFeatureTableView()
        var i = 0
        if self.technologyID != nil {
            for item in self.jsonfeatureArray {
                if item.technologyID != nil {
                    let itemid = item.technologyID!
                    if itemid == self.technologyID! {
                        self.featureArray.append(item)
                    }
                    i += 1
                    if i >= self.jsonfeatureArray.count {
                        if self.featureArray.count > 0 {
                            view4.isHidden = false
                            view5.isHidden = false
                            self.reloadFeatureTableView()
                        }
                    }
                }
            }
        }
    }
    func reloadCollectionView() {
        self.collectionViewItemWidth = (CGFloat(AppConstantValue.screenWidthminus32) - 10) / 2
        self.collectionViewItemHeight = (self.collectionViewItemWidth * CGFloat(100/133.79)) + 44
        self.collectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionViewlayout.itemSize = CGSize(width: self.collectionViewItemWidth, height: self.collectionViewItemHeight)
        self.collectionViewlayout.minimumLineSpacing = self.collectionViewItemSpacing
        self.collectionViewlayout.minimumInteritemSpacing = self.collectionViewItemSpacing
        self.collectionViewlayout.scrollDirection = .vertical
        self.collectionView!.collectionViewLayout = self.collectionViewlayout
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
        
        if self.modelArray.count > 0 {
            if self.modelArray.count % 2 == 0 {
                if self.modelArray.count > 4 {
                    self.collectionViewHeight.constant = ((CGFloat(self.modelArray.count) / 2) * collectionViewItemHeight) + (((CGFloat(self.modelArray.count) / 2) - 1) * 16)
                } else {
                    self.collectionViewHeight.constant = ((CGFloat(self.modelArray.count) / 2) * collectionViewItemHeight) + 16
                }
            } else {
                if self.modelArray.count > 4 {
                    self.collectionViewHeight.constant = ((CGFloat(self.modelArray.count) / 2) * collectionViewItemHeight) + (((CGFloat(self.modelArray.count) / 2) - 1) * 16) + collectionViewItemHeight + 16
                } else {
                    self.collectionViewHeight.constant = ((CGFloat(self.modelArray.count) / 2) * collectionViewItemHeight) + collectionViewItemHeight + 16
                }
            }
        } else {
            self.collectionViewHeight.constant = 0
        }
        self.collectionView.isScrollEnabled = false
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getFindRightDeviceModelList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getFindRightDeviceModelList(retryAPIID: Int, canShowLoader: Bool) {
        var strQuery = ""
        if !(self.sessionUID.isEmpty) && !(self.sessionKey.isEmpty) {
            strQuery = String(format: "&session_uid=%@&session_key=%@", self.sessionUID, self.sessionKey)
        }
        self.findRightDeviceFeatureViewModel.getFindRightDeviceModelList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getFindRightDeviceModelList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: strQuery)
    }
    // MARK: - IBAction
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.navigateToFindRightDeviceEarPreferenceViewController(isFrom: self.isFrom, patientUid: self.patientUid, lifestyleID: self.lifestyleID!, model: self.modelSelectedArray, technologyID: self.technologyID!,sessionID: self.sessionID, sessionUID: self.sessionUID, sessionKey: self.sessionKey)
    }
    // MARK: - Custom Methods
    func setButtonUserInteraction() {
        if (self.technologyID != nil) && (self.modelSelectedArray.count > 0) {
            self.setButtonEnable()
        } else {
            self.setButtonDisable()
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
    
    @objc func scrolltoAditionalFeatures() {
        let view0 = self.mainStackView.arrangedSubviews[0]// empty
        let view1 = self.mainStackView.arrangedSubviews[1]// model
        let view2 = self.mainStackView.arrangedSubviews[2]// empty
        let view3 = self.mainStackView.arrangedSubviews[3]// technology
        let view4 = self.mainStackView.arrangedSubviews[4]// empty
        let view5 = self.mainStackView.arrangedSubviews[5]// feature
        
        var featuresViewY: CGFloat = 0
        var technologyIDSelected = ""
        if self.technologyID != nil {
            technologyIDSelected = String(format: "%d", self.technologyID!)
        }
        if !(technologyIDSelected.isEmpty) && self.modelArray.count > 0 {
            featuresViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height
        }
        UIView.animate(withDuration: 100) {
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: featuresViewY), animated: true)
        }
    }
}

extension FindRightDeviceFeatureViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension FindRightDeviceFeatureViewController: ProtocolNetworkRechabilityDelegate {
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

extension FindRightDeviceFeatureViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == featureTableView {
            return self.featureArray.count
        } else {
            return self.technologyArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == featureTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindRightDeviceFeatureTableViewCell, for: indexPath) as! FindRightDeviceFeatureTableViewCell
            cell.configure(feature: self.featureArray[indexPath.row], indexPath: indexPath.row)
            //            cell.delegate = self
            cell.hideSeparator()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindRightDevicePriceTableViewCell, for: indexPath) as! FindRightDevicePriceTableViewCell
            var technologyIDSelected = ""
            if self.technologyID != nil {
                technologyIDSelected = String(format: "%d", self.technologyID!)
            }
            cell.configure(technology: self.technologyArray[indexPath.row], indexPath: indexPath.row, technologyID: technologyIDSelected, viewCon: self)
            cell.delegate = self
            cell.hideSeparator()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == featureTableView {
            self.featureTableViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        } else {
            self.tableViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        }
    }
}
extension FindRightDeviceFeatureViewController: ProtocolFindRightDevicePriceTableViewCell {
    func selectButtonPressedFindRightDevicePriceTableViewCell(senderTag: Int) {
        if self.technologyArray[senderTag].id != nil {
            self.technologyID = self.technologyArray[senderTag].id!
            self.reloadlistView()
        }
        self.setButtonUserInteraction()
    }
    
    func reloadlistView() {
        self.reloadTableView()
        self.reloadFeatureDataTableView()
        self.setButtonUserInteraction()
    }
}

extension FindRightDeviceFeatureViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.FindRightDeviceStyleCollectionViewCell, for: indexPath) as! FindRightDeviceStyleCollectionViewCell
        cell.configure(findRightDeviceFeatureModelModel: self.modelArray[indexPath.row], indexPath: indexPath.row, modelSelectedArray: self.modelSelectedArray)
        cell.delegate = self
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if modelArray.count > 0 {
            cellWidth = self.collectionViewItemWidth
            cellHeight = self.collectionViewItemHeight
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension FindRightDeviceFeatureViewController: ProtocolFindRightDeviceStyleCollectionViewCell, BottomPopupDelegate {
    func selectButtonPressedFindRightDeviceStyleCollectionViewCell(senderTag: Int) {
        if self.modelArray[senderTag].id != nil {
            let id = self.modelArray[senderTag].id!
            if self.modelSelectedArray.count > 0 {
                if self.modelSelectedArray.contains(id) {
                    for i in 0..<self.modelSelectedArray.count {
                        if self.modelSelectedArray[i] == id {
                            self.modelSelectedArray.remove(at: i)
                            self.reloadCollectionView()
                            self.setButtonUserInteraction()
                            return
                        }
                    }
                } else {
                    self.modelSelectedArray.append(id)
                    self.reloadCollectionView()
                    self.setButtonUserInteraction()
                }
            } else {
                self.modelSelectedArray.append(id)
                self.reloadCollectionView()
                self.setButtonUserInteraction()
            }
        }
        self.setButtonUserInteraction()
    }
    func infoButtonPressedFindRightDeviceStyleCollectionViewCell(senderTag: Int) {
        var imageViewName = ""
        var titlemessage = ""
        var descriptionmessage = ""
        var proArrayList = [String]()
        var consArrayList = [String]()
        var deviceArrayList = [String]()
        var humanArrayList = [String]()
        if !(self.modelArray[senderTag].modelDescription.isNilOrEmpty) {
            descriptionmessage = "\(String(describing: self.modelArray[senderTag].modelDescription!))"
        }
        if !(self.modelArray[senderTag].name.isNilOrEmpty) {
            titlemessage = "\(String(describing: self.modelArray[senderTag].name!))"
        }
        if self.modelArray[senderTag].pros != nil {
            if self.modelArray[senderTag].pros!.count > 0 {
                for item in self.modelArray[senderTag].pros! {
                    if !(item.isEmpty) {
                        proArrayList.append(item)
                    }
                }
            }
        }
        if self.modelArray[senderTag].cons != nil {
            if self.modelArray[senderTag].cons!.count > 0 {
                for item in self.modelArray[senderTag].cons! {
                    if !(item.isEmpty) {
                        consArrayList.append(item)
                    }
                }
            }
        }
        if self.modelArray[senderTag].deviceView != nil {
            if self.modelArray[senderTag].deviceView!.count > 0 {
                for item in self.modelArray[senderTag].deviceView! {
                    if !(item.isEmpty) {
                        deviceArrayList.append(item)
                    }
                }
            }
        }
        if self.modelArray[senderTag].humanEarView != nil {
            if self.modelArray[senderTag].humanEarView!.count > 0 {
                for item in self.modelArray[senderTag].humanEarView! {
                    if !(item.isEmpty) {
                        humanArrayList.append(item)
                    }
                }
            }
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetFeatureViewController) as? BottomSheetFeatureViewController else { return }
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        
        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0
        let defaultheight: CGFloat = screenFrameHeight * (4 / 5)
        
        let popvcheight = defaultheight
        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        popupVC.height = popvcheight + bottomPadding + topPadding
        popupVC.popupDelegate = self as BottomPopupDelegate
        popupVC.titlemessage = titlemessage
        popupVC.descriptionmessage = descriptionmessage
        popupVC.proArrayList = proArrayList
        popupVC.consArrayList = consArrayList
        popupVC.deviceArrayList = deviceArrayList
        popupVC.humanArrayList = humanArrayList
        present(popupVC, animated: true, completion: nil)
    }
}
