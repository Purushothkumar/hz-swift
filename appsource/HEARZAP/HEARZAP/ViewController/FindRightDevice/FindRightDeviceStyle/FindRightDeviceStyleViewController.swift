//
//  FindRightDeviceStyleViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 14/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class FindRightDeviceStyleViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var sixDotCircleView: SixDotCircleView!
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!
    @IBOutlet var listView: UIView!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Lets and Var
    var lifestyleArray = [FindRightDeviceStyleModelLifestyle]()
    var findRightDeviceStyleViewModel = FindRightDeviceStyleViewModel()
    
    var isFrom = ""
    var patientUid = ""
    var lifestyleID: Int?
    var lifestyleName = ""
    var sessionID = ""
    
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
        self.sixDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.checkcircleblue, button3image: Asset.recordcircleblue, button4image: Asset.circlegrey, button5image: Asset.circlegrey, button6image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.FHAStep2Title.capitalized
        let descriptionMessage = AppLocalizationString.FHAStep2Desc.capitalized
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
        self.setCommonTitleView()
    }
    
    // MARK: - Reload
    func reloadTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getFindRightDeviceLifestyleList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getFindRightDeviceLifestyleList(retryAPIID: Int, canShowLoader: Bool) {
        self.findRightDeviceStyleViewModel.getFindRightDeviceLifestyleList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getFindRightDeviceLifestyleList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    
    // MARK: - Custom Methods
    
}

extension FindRightDeviceStyleViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension FindRightDeviceStyleViewController: ProtocolNetworkRechabilityDelegate {
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

extension FindRightDeviceStyleViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lifestyleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindRightDeviceStyleTableViewCell, for: indexPath) as! FindRightDeviceStyleTableViewCell
        cell.configure(findRightDeviceStyleModelLifestyle: self.lifestyleArray[indexPath.row], indexPath: indexPath.row)
        cell.delegate = self
        cell.hideSeparator()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension FindRightDeviceStyleViewController: ProtocolFindRightDeviceStyleTableViewCell, BottomPopupDelegate {
    func selectButtonFindRightDeviceStyleTableViewCell(senderTag: Int) {
        if !(self.lifestyleArray[senderTag].name.isNilOrEmpty) {
            self.lifestyleName = self.lifestyleArray[senderTag].name!
        }
        if self.lifestyleArray[senderTag].id != nil {
            self.lifestyleID = (self.lifestyleArray[senderTag].id)!
        }
        self.reloadTableView()
        self.navigateToFindRightDeviceFeatureViewController(isFrom: self.isFrom, patientUid: self.patientUid, lifestyleID: self.lifestyleID!, lifestyleName: self.lifestyleName, sessionID: self.sessionID,sessionUID: self.sessionUID,sessionKey: self.sessionKey)
    }
    func detailButtonFindRightDeviceStyleTableViewCell(senderTag: Int) {
        var imageViewName = ""
        var titlemessage = ""
        var descriptionmessage = ""
        var arrlist = [String]()
        
        if !(self.lifestyleArray[senderTag].lifestyleDescription.isNilOrEmpty) {
            descriptionmessage = self.lifestyleArray[senderTag].lifestyleDescription!.capitalized
        }
        if !(self.lifestyleArray[senderTag].name.isNilOrEmpty) {
            titlemessage = self.lifestyleArray[senderTag].name!.capitalized
        }
        if self.lifestyleArray[senderTag].situation != nil {
            if self.lifestyleArray[senderTag].situation!.count > 0 {
                for item in self.lifestyleArray[senderTag].situation! {
                    if !(item.isEmpty) {
                        arrlist.append(item.capitalized)
                    }
                }
            }
        }
        if self.lifestyleArray[senderTag].image != nil {
            if !(self.lifestyleArray[senderTag].image!.isEmpty) {
                imageViewName = (self.lifestyleArray[senderTag].image)!
            }
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetLifeStyleViewController) as? BottomSheetLifeStyleViewController else { return }
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        
        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0
        
        let textHeight  = CGFloat(22) + self.heightForText(text: titlemessage, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32) + CGFloat(6) + self.heightForText(text: descriptionmessage, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32) + 16
        
        let imageheight = CGFloat(278 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth))
        var tableviewheight: CGFloat = 0
        var tagHeight: CGFloat = 0
        
        if arrlist.count > 0 {
            for item in arrlist {
                tagHeight = tagHeight + CGFloat(10) + self.heightForText(text: item.description, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - (CGFloat(18) + CGFloat(10))) + CGFloat(10)
            }
        } else {
            tagHeight = 0
        }
        // calculate tableview Height
        tableviewheight = tagHeight
        
        // Calculate View Height
        let defaultheight: CGFloat = screenFrameHeight * (4 / 5)
        let popvcheight = defaultheight
        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        popupVC.height = popvcheight  + bottomPadding + topPadding
        popupVC.popupDelegate = self as BottomPopupDelegate
        //            popupViewCon.boardingPopupListViewControllerDelegate = self
        popupVC.titlemessage = titlemessage
        popupVC.descriptionmessage = descriptionmessage
        popupVC.imageViewName = imageViewName
        popupVC.tableviewheightConstant = tableviewheight
        popupVC.arrlist = arrlist
        present(popupVC, animated: true, completion: nil)
    }
}
