//
//  BookAppointmentViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 23/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class BookAppointmentViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var fourDotCircleView: FourDotCircleView!
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!
    @IBOutlet var listView: UIView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var nextButton: CalloutBackgroundButton!
    
    // MARK: - Lets and Var
    var bookAppointmentViewModel = BookAppointmentViewModel()
    
    var isFrom = ""
    var patientUid = ""
    
    var serviceListArray = [ServiceList]()
    var selectedServiceDeviceArray = [String]()
    var selectedServiceArray = [ServiceSelected]()
    var enableButton = false
    
    var deviceListArray = [RegisterDeviceModelDeviceData]()
    var isDeviceNeeded = false
    var id = ""
    
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
        self.setFourDotCircleView()
        self.setCommonTitleView()
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTableView()
        self.setUserInteractionButton()
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.bookAppointment
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Set Four Dot Circle View
    func setFourDotCircleView() {
        self.fourDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.recordcircleblue, button3image: Asset.circlegrey, button4image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.BAStep2Title.capitalized
        let descriptionMessage = AppLocalizationString.BAStep2Desc.capitalized
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
                    self.getBookAppointmentList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getCustomerDeviceList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getBookAppointmentList(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getBookAppointmentList)\(patientUid)/"
        
        self.bookAppointmentViewModel.getBookAppointmentList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getCustomerDeviceList(retryAPIID: Int, canShowLoader: Bool) {
        self.bookAppointmentViewModel.getCustomerDeviceList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCustomerDeviceList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    
    // MARK: - IBAction
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if self.selectedServiceArray.count > 0 {
            var tempServiceArray = [ServiceSelected]()
            for item in selectedServiceArray {
                if item.isSelected == true {
                    tempServiceArray.append(item)
                }
            }
            if tempServiceArray.count > 0 {
                self.navigateToBookAppointmentAddressViewController(isFrom: self.isFrom, selectedServiceArray: tempServiceArray, patientUid: self.patientUid)
            }
        }
    }
    
    // MARK: - Custom Methods
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            self.enableButton = false
            if self.selectedServiceArray.count > 0 {
                for item in self.selectedServiceArray {
                    if item.isSelected == true {
                        self.enableButton = true
                    }
                }
            }
            if self.enableButton == true {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
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
}

extension BookAppointmentViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension BookAppointmentViewController: ProtocolNetworkRechabilityDelegate {
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

extension BookAppointmentViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serviceListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BookAppointmentTableViewCell, for: indexPath) as! BookAppointmentTableViewCell
        cell.configure(service: self.serviceListArray[indexPath.row], indexPath: indexPath.row, viewCon: self)
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
extension BookAppointmentViewController: ProtocolBookAppointmentTableViewCell {
    func selectButtonPressedBookAppointmentTableViewCell(senderTag: Int) {
        isDeviceNeeded = false
        id = ""
        if self.serviceListArray.count > 0 {
            if serviceListArray[senderTag].id != nil {
                id = String(format: "%d", serviceListArray[senderTag].id!)
            }
            if serviceListArray[senderTag].isDeviceNeeded != nil {
                isDeviceNeeded = serviceListArray[senderTag].isDeviceNeeded!
                if isDeviceNeeded == true {
                    if self.selectedServiceArray.count > 0 {
                        for item in selectedServiceArray {
                            if id == item.serviceId {
                                self.selectedServiceDeviceArray = item.listedDevice
                                if item.isSelected == true {
                                    self.updateSelectedServiceList(id: id, deviceArray: [])
                                } else {
                                    self.openDevicePopup()
                                }
                            }
                        }
                        self.setUserInteractionButton()
                        self.reloadTableView()
                    }
                } else {
                    self.updateSelectedServiceList(id: id, deviceArray: [])
                    self.setUserInteractionButton()
                    self.reloadTableView()
                }
            }
        }
    }
    func openDevicePopup() {
        self.commonAPICALL(retryAPIID: 1001)
    }
    
    func updateSelectedServiceList(id: String, deviceArray: [String]) {
        if self.selectedServiceArray.count > 0 {
            var tempServiceArray = [ServiceSelected]()
            tempServiceArray.removeAll()
            tempServiceArray = selectedServiceArray
            selectedServiceArray.removeAll()
            
            for item in tempServiceArray {
                if id == item.serviceId {
                    if item.isSelected == true {
                        selectedServiceArray.append(ServiceSelected(serviceId: id, listedDevice: [], isSelected: false))
                    } else {
                        selectedServiceArray.append(ServiceSelected(serviceId: id, listedDevice: deviceArray, isSelected: true))
                    }
                } else {
                    selectedServiceArray.append(item)
                }
            }
        }
        self.setUserInteractionButton()
        self.reloadTableView()
    }
    func detailButtonPressedBookAppointmentTableViewCell(senderTag: Int) {
        var imageViewName = ""
        var titlemessage = ""
        var descriptionmessage = ""
        var arrlist = [String]()
        if self.serviceListArray.count > 0 {
            if !(self.serviceListArray[senderTag].serviceDescription.isNilOrEmpty) {
                descriptionmessage = self.serviceListArray[senderTag].serviceDescription!.capitalized
            }
            if !(self.serviceListArray[senderTag].serviceName.isNilOrEmpty) {
                titlemessage = self.serviceListArray[senderTag].serviceName!.capitalized
            }
            if self.serviceListArray[senderTag].serviceStepsList != nil {
                if self.serviceListArray[senderTag].serviceStepsList!.count > 0 {
                    for item in self.serviceListArray[senderTag].serviceStepsList! {
                        if !(item.stepName.isNilOrEmpty) {
                            arrlist.append(item.stepName!.capitalized)
                        }
                    }
                }
            }
            if !(self.serviceListArray[senderTag].servicePosterPhoto.isNilOrEmpty) {
                imageViewName = self.serviceListArray[senderTag].servicePosterPhoto!
            }
            
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
            guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetAddDeviceDetailViewController) as? BottomSheetAddDeviceDetailViewController else { return }
            popupVC.topCornerRadius = 0
            popupVC.presentDuration = 1
            popupVC.dismissDuration = 1
            popupVC.shouldDismissInteractivelty = true
            
            var bottomPadding: CGFloat = 0
            var topPadding: CGFloat = 0
            
            let textHeight  = 22 + self.heightForText(text: titlemessage, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32) + 6 + self.heightForText(text: descriptionmessage, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32) + 16
            
            let imageheight = CGFloat(278 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth))
            var tableviewheight: CGFloat = 0
            var tagHeight: CGFloat = 0
            
            tagHeight = 22 + self.heightForText(text: AppLocalizationString.howitworks, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - (16 + 16)) + 20
            
            if arrlist.count > 0 {
                for item in arrlist {
                    tagHeight = tagHeight + 10 + self.heightForText(text: item.description, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - (16 + 22 + 8 + 16)) + 10
                }
            } else {
                tagHeight = 0
            }
            // calculate tableview Height
            tableviewheight = tagHeight + 16
            
            // Calculate View Height
            let defaultheight: CGFloat = screenFrameHeight * (4 / 5)
            let popvcheight = defaultheight
            if #available(iOS 11.0, *) {
                bottomPadding = self.view.safeAreaInsets.bottom
                topPadding = self.view.safeAreaInsets.top
            }
            popupVC.height = popvcheight  + bottomPadding + topPadding
            popupVC.popupDelegate = self as BottomPopupDelegate
            //            popupVC.boardingPopupListViewControllerDelegate = self
            popupVC.titlemessage = titlemessage
            popupVC.descriptionmessage = descriptionmessage
            popupVC.imageViewName = imageViewName
            popupVC.tableviewheightConstant = tableviewheight
            popupVC.arrlist = arrlist
            present(popupVC, animated: true, completion: nil)
        }
    }
}

extension BookAppointmentViewController: BottomPopupDelegate, ProtocolBottomSheetAddDeviceViewController {
    func showAddDevicePopup(id: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetAddDeviceViewController) as? BottomSheetAddDeviceViewController else { return }
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
        popupVC.height = popvcheight  + bottomPadding + topPadding
        popupVC.popupDelegate = self as BottomPopupDelegate
        popupVC.delegate = self
        popupVC.id = id
        popupVC.selectArray = selectedServiceDeviceArray
        popupVC.deviceListArray = self.deviceListArray
        present(popupVC, animated: true, completion: nil)
    }
    func updateDeviceListBottomSheetAddDeviceViewController(id: String, deviceList: [String]) {
        self.updateSelectedServiceList(id: id, deviceArray: deviceList)
    }
    func addNewDeviceListBottomSheetAddDeviceViewController(id: String) {
        let id = ""
        let orderRef = ""
        let deviceUserName = ""
        let deviceUserUID = ""
        let deviceName = ""
        let deviceBrand = ""
        let deviceBrandUID = ""
        let deviceModel = ""
        let deviceSerialNumber = ""
        let deviceEarPreference = ""
        let deviceEarPreferenceValue = ""
        let devicePurchasedOn = ""
        let devicePurchasedFrom = ""
        let devicePurchasedFromValue = ""
        let deviceWarrantyExpiresOn = ""
        let deviceExtendedWarrantyEndOn = ""
        let deviceNextServiceDate = ""
        let deviceLastServiceDate = ""
        let deviceWarrantyDetails = ""
        let deviceWarrantyDetailsValue = ""
        let deviceRemark = ""
        
        self.navigateToAddRegisterDeviceViewController(id: id, orderRef: orderRef, deviceUserName: deviceUserName, deviceUserUID: deviceUserUID, deviceName: deviceName, deviceBrand: deviceBrand, deviceBrandUID: deviceBrandUID, deviceModel: deviceModel, deviceSerialNumber: deviceSerialNumber, deviceEarPreference: deviceEarPreference, deviceEarPreferenceValue: deviceEarPreferenceValue, devicePurchasedOn: devicePurchasedOn, devicePurchasedFrom: devicePurchasedFrom, devicePurchasedFromValue: devicePurchasedFromValue, deviceWarrantyExpiresOn: deviceWarrantyExpiresOn, deviceExtendedWarrantyEndOn: deviceExtendedWarrantyEndOn, deviceWarrantyDetails: deviceWarrantyDetails, deviceWarrantyDetailsValue: deviceWarrantyDetailsValue, deviceNextServiceDate: deviceNextServiceDate, deviceLastServiceDate: deviceLastServiceDate, deviceRemark: deviceRemark, isEdit: false, isFrom: IsNavigateFrom.ardBooking.rawValue)
    }
}
