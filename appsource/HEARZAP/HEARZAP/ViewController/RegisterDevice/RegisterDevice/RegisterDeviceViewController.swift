//
//  RegisterDeviceViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class RegisterDeviceViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var tableview: UITableView!
    @IBOutlet var tableviewHeight: NSLayoutConstraint!

    @IBOutlet var addDeviceButton: FootnoteOutlineButton!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var errorTapButton: FootnoteOutlineButton!

    @IBOutlet var productTitleLabel: FootnoteFontLabel!

    @IBOutlet var productView: UIView!
    @IBOutlet var productCollectionView: UICollectionView!
    @IBOutlet var productCollectionViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var

    var registerDeviceArray = [AddUserModel]()
    var registerDeviceViewModel = RegisterDeviceViewModel()

    var accessoriesProductListArray = [RegisterDeviceModelAccessories]()
    var deviceListArray = [RegisterDeviceModelDeviceData]()

    var selectedIndex = ""
    var selectedIndexHeight: CGFloat = 0

    let productCollectionViewMargin = CGFloat(0)
    let productCollectionViewItemSpacing = CGFloat(2)
    var productCollectionViewItemHeight = CGFloat(178)
    var productCollectionViewItemWidth = CGFloat(139)
    let productCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var deleteID = ""
    var isFrom = ""

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
        if self.deviceListArray.count > 0 {
            self.tableviewHeight.constant = self.selectedIndexHeight + (CGFloat(self.deviceListArray.count) * CGFloat(106))
        } else {
            self.tableviewHeight.constant = 0
        }
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
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTableview()
        self.reloadProductCollectionView()
        self.addDeviceButton.clipsToBounds = true
        self.addDeviceButton.cornerRadius = AppConstantValue.cornerRadius4
        self.addDeviceButton.borderColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.addDeviceButton.borderWidth = 1.0
        let view0 = self.mainStackView.arrangedSubviews[0]// list
        let view1 = self.mainStackView.arrangedSubviews[1]// add button
        let view2 = self.mainStackView.arrangedSubviews[2]// error
        let view3 = self.mainStackView.arrangedSubviews[3]// title
        let view4 = self.mainStackView.arrangedSubviews[4]// collection

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.registeredDevices.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }

    // MARK: - Localization String
    func changeLanguageFormat() {
        self.productTitleLabel.text = AppLocalizationString.essentialaccessoriesforyourhearingaids
        self.primaryMessageLabel.text = AppLocalizationString.noDeviceFound
        let errorcombination = NSMutableAttributedString()
        let errorTitleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let errorContentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(13)]

        let errorTitle = NSMutableAttributedString(string: String(format: "%@ ", AppLocalizationString.explorehearzap), attributes: errorTitleAttributes as [NSAttributedString.Key: Any])
        let errorContent = NSMutableAttributedString(string: String(format: "%@", AppLocalizationString.onlineShopping), attributes: errorContentFontAttributes as [NSAttributedString.Key: Any])

        errorcombination.append(errorTitle)
        errorcombination.append(errorContent)
        self.secondaryMessageLabel.attributedText = errorcombination
        self.addDeviceButton.setTitle(AppLocalizationString.plusAddaDevice.uppercased(), for: .normal)

    }
    // MARK: - Reload

    func reloadTableview() {
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
    }
    func reloadProductCollectionView() {
        self.productCollectionViewItemWidth = (screenFrameWidth - 2) / 2
        self.productCollectionViewItemHeight = (239.38 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
        self.productCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.productCollectionViewlayout.itemSize = CGSize(width: self.productCollectionViewItemWidth, height: self.productCollectionViewItemHeight)
        self.productCollectionViewlayout.minimumLineSpacing = self.productCollectionViewItemSpacing
        self.productCollectionViewlayout.minimumInteritemSpacing = self.productCollectionViewItemSpacing
        self.productCollectionViewlayout.scrollDirection = .vertical
        self.productCollectionView!.collectionViewLayout = self.productCollectionViewlayout

        self.productCollectionView.dataSource = self
        self.productCollectionView.delegate = self
        self.productCollectionView.reloadData()

        if self.accessoriesProductListArray.count > 0 {
            if self.accessoriesProductListArray.count % 2 == 0 {
                self.productCollectionViewHeight.constant = ((CGFloat(self.accessoriesProductListArray.count) / 2) * productCollectionViewItemHeight) + ((CGFloat(self.accessoriesProductListArray.count) / 2) * 16) + 20
            } else {
                self.productCollectionViewHeight.constant = ((CGFloat(self.accessoriesProductListArray.count) / 2) * productCollectionViewItemHeight) + ((CGFloat(self.accessoriesProductListArray.count) / 2) *  16) + productCollectionViewItemHeight + 16 + 20
            }
        } else {
            self.productCollectionViewHeight.constant = 0
        }
        self.productCollectionView.isScrollEnabled = false
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getCustomerDeviceList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.deleteCustomerDevice(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.getCustomerDeviceList(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCustomerDeviceList(retryAPIID: Int, canShowLoader: Bool) {
        self.registerDeviceViewModel.getCustomerDeviceList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCustomerDeviceList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func deleteCustomerDevice(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.deleteCustomerDevice)\(self.deleteID)/"
        self.registerDeviceViewModel.deleteCustomerDevice(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction

    @IBAction func addDeviceButtonPressed(_ sender: UIButton) {
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

        self.navigateToAddRegisterDeviceViewController(id: id, orderRef: orderRef, deviceUserName: deviceUserName, deviceUserUID: deviceUserUID, deviceName: deviceName, deviceBrand: deviceBrand, deviceBrandUID: deviceBrandUID, deviceModel: deviceModel, deviceSerialNumber: deviceSerialNumber, deviceEarPreference: deviceEarPreference, deviceEarPreferenceValue: deviceEarPreferenceValue, devicePurchasedOn: devicePurchasedOn, devicePurchasedFrom: devicePurchasedFrom, devicePurchasedFromValue: devicePurchasedFromValue, deviceWarrantyExpiresOn: deviceWarrantyExpiresOn, deviceExtendedWarrantyEndOn: deviceExtendedWarrantyEndOn, deviceWarrantyDetails: deviceWarrantyDetails, deviceWarrantyDetailsValue: deviceWarrantyDetailsValue, deviceNextServiceDate: deviceNextServiceDate, deviceLastServiceDate: deviceLastServiceDate, deviceRemark: deviceRemark, isEdit: false, isFrom: IsNavigateFrom.ard.rawValue)
    }
    @IBAction func errorTapButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    // MARK: - Custom Methods

}
extension RegisterDeviceViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if isFrom == IsNavigateFrom.rdMenu.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if isFrom == IsNavigateFrom.rdalert.rawValue {
            self.navigateBackToMyAlertViewController()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {
    }
}
extension RegisterDeviceViewController: ProtocolNetworkRechabilityDelegate {
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
extension RegisterDeviceViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deviceListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.RegisterDeviceTableViewCell, for: indexPath) as! RegisterDeviceTableViewCell
        cell.delegate = self
        cell.configure(device: self.deviceListArray[indexPath.row], indexPath: indexPath.row, selectedIndex: self.selectedIndex, viewCon: self)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.deviceListArray.count > 0 {
            self.tableviewHeight.constant = self.selectedIndexHeight + (CGFloat(self.deviceListArray.count) * CGFloat(106))
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension RegisterDeviceViewController: ProtocolRegisterDeviceTableViewCell {
    func tapButtonPressedRegisterDeviceTableViewCell(senderTag: Int) {
        if self.deviceListArray.count > 0 {
            self.selectedIndexHeight = 0
            if self.deviceListArray[senderTag].id != nil {
                let id = String(format: "%d", self.deviceListArray[senderTag].id!)
                if self.selectedIndex.isEmpty {
                    self.selectedIndex = String(format: "%d", self.deviceListArray[senderTag].id!)
                } else {
                    if self.selectedIndex == id {
                        self.selectedIndex = ""
                    } else {
                        self.selectedIndex = id
                    }
                }
                self.reloadTableview()
            }
        }
    }
    func requestServiceButtonPressedRegisterDeviceTableViewCell(senderTag: Int) {
        self.navigateToBookAppointmentLocationViewController(isFrom: IsNavigateFrom.baSurveyRegisterDevice.rawValue)
    }
    func takeSurveyButtonPressedRegisterDeviceTableViewCell(senderTag: Int) {
        self.navigateToShareExperienceViewController(isFrom: IsNavigateFrom.surveyMenu.rawValue, surveyType: SurveyType.productShoppingHearingAids.rawValue)
    }
    func removeButtonPressedRegisterDeviceTableViewCell(senderTag: Int) {
        if self.deviceListArray.count > 0 {
            self.selectedIndexHeight = 0
            if self.deviceListArray[senderTag].id != nil {
                self.deleteID = String(format: "%d", self.deviceListArray[senderTag].id!)
                self.showDeletePopupScreen(isDelete: true)
            }
        }
    }
    func editButtonPressedRegisterDeviceTableViewCell(senderTag: Int) {
        var id = ""
        var orderRef = ""
        var deviceUserName = ""
        var deviceUserUID = ""
        var deviceName = ""
        var deviceBrand = ""
        var deviceBrandUID = ""
        var deviceModel = ""
        var deviceSerialNumber = ""
        var deviceEarPreference = ""
        var deviceEarPreferenceValue = ""
        var devicePurchasedOn = ""
        var devicePurchasedFrom = ""
        var devicePurchasedFromValue = ""
        var deviceWarrantyExpiresOn = ""
        var deviceExtendedWarrantyEndOn = ""
        var deviceNextServiceDate = ""
        var deviceLastServiceDate = ""
        var deviceWarrantyDetails = ""
        var deviceWarrantyDetailsValue = ""
        var deviceRemark = ""

        if self.deviceListArray.count > 0 {
            if self.deviceListArray[senderTag].id != nil {
                id = String(format: "%d", self.deviceListArray[senderTag].id!)
            }
            if !(self.deviceListArray[senderTag].orderRef.isNilOrEmpty) {
                orderRef = String(format: "%@", self.deviceListArray[senderTag].orderRef!)
            }
            if !(self.deviceListArray[senderTag].deviceName.isNilOrEmpty) {
                deviceName = String(format: "%@", self.deviceListArray[senderTag].deviceName!)
            }
            //            if !(self.deviceListArray[senderTag].deviceUserName.isNilOrEmpty) {
            //                deviceUserName = String(format: "%@", self.deviceListArray[senderTag].deviceUserName!)
            //            }
            if !(self.deviceListArray[senderTag].deviceUserUid.isNilOrEmpty) {
                deviceUserUID = String(format: "%@", self.deviceListArray[senderTag].deviceUserUid!)
            }
            if !(self.deviceListArray[senderTag].deviceBrandUid.isNilOrEmpty) {
                deviceBrandUID = String(format: "%@", self.deviceListArray[senderTag].deviceBrandUid!)
            }
            //            if !(self.deviceListArray[senderTag].deviceBrand.isNilOrEmpty) {
            //                deviceBrand = String(format: "%@", self.deviceListArray[senderTag].deviceBrand!)
            //            }
            if !(self.deviceListArray[senderTag].deviceModel.isNilOrEmpty) {
                deviceModel = String(format: "%@", self.deviceListArray[senderTag].deviceModel!)
            }
            if !(self.deviceListArray[senderTag].deviceSerialNumber.isNilOrEmpty) {
                deviceSerialNumber = String(format: "%@", self.deviceListArray[senderTag].deviceSerialNumber!)
            }
            if !(self.deviceListArray[senderTag].deviceEarPreference.isNilOrEmpty) {
                deviceEarPreference = String(format: "%@", self.deviceListArray[senderTag].deviceEarPreference!)
            }
            //            if !(self.deviceListArray[senderTag].deviceEarPreferenceValue.isNilOrEmpty) {
            //                deviceEarPreferenceValue = String(format: "%@", self.deviceListArray[senderTag].deviceEarPreferenceValue!)
            //            }
            if !(self.deviceListArray[senderTag].devicePurchasedOn.isNilOrEmpty) {
                devicePurchasedOn = String(format: "%@", self.deviceListArray[senderTag].devicePurchasedOn!)
            }
            if !(self.deviceListArray[senderTag].devicePurchasedFrom.isNilOrEmpty) {
                devicePurchasedFrom = String(format: "%@", self.deviceListArray[senderTag].devicePurchasedFrom!)
            }
            //            if !(self.deviceListArray[senderTag].devicePurchasedFromValue.isNilOrEmpty) {
            //                devicePurchasedFromValue = String(format: "%@", self.deviceListArray[senderTag].devicePurchasedFromValue!)
            //            }
            if !(self.deviceListArray[senderTag].deviceWarrantyExpiresOn.isNilOrEmpty) {
                deviceWarrantyExpiresOn = String(format: "%@", self.deviceListArray[senderTag].deviceWarrantyExpiresOn!)
            }
            if !(self.deviceListArray[senderTag].deviceExtendedWarrantyEndOn.isNilOrEmpty) {
                deviceExtendedWarrantyEndOn = String(format: "%@", self.deviceListArray[senderTag].deviceExtendedWarrantyEndOn!)
            }
            if !(self.deviceListArray[senderTag].deviceNextServiceDate.isNilOrEmpty) {
                deviceNextServiceDate = String(format: "%@", self.deviceListArray[senderTag].deviceNextServiceDate!)
            }
            if !(self.deviceListArray[senderTag].deviceLastServiceDate.isNilOrEmpty) {
                deviceLastServiceDate = String(format: "%@", self.deviceListArray[senderTag].deviceLastServiceDate!)
            }
            if !(self.deviceListArray[senderTag].deviceWarrantyDetails.isNilOrEmpty) {
                deviceWarrantyDetails = String(format: "%@", self.deviceListArray[senderTag].deviceWarrantyDetails!)
            }
            //            if !(self.deviceListArray[senderTag].devicePurchasedFromValue.isNilOrEmpty) {
            //                devicePurchasedFromValue = String(format: "%@", self.deviceListArray[senderTag].devicePurchasedFromValue!)
            //            }
            if !(self.deviceListArray[senderTag].remarks.isNilOrEmpty) {
                deviceRemark = String(format: "%@", self.deviceListArray[senderTag].remarks!)
            }

            self.navigateToAddRegisterDeviceViewController(id: id, orderRef: orderRef, deviceUserName: deviceUserName, deviceUserUID: deviceUserUID, deviceName: deviceName, deviceBrand: deviceBrand, deviceBrandUID: deviceBrandUID, deviceModel: deviceModel, deviceSerialNumber: deviceSerialNumber, deviceEarPreference: deviceEarPreference, deviceEarPreferenceValue: deviceEarPreferenceValue, devicePurchasedOn: devicePurchasedOn, devicePurchasedFrom: devicePurchasedFrom, devicePurchasedFromValue: devicePurchasedFromValue, deviceWarrantyExpiresOn: deviceWarrantyExpiresOn, deviceExtendedWarrantyEndOn: deviceExtendedWarrantyEndOn, deviceWarrantyDetails: deviceWarrantyDetails, deviceWarrantyDetailsValue: deviceWarrantyDetailsValue, deviceNextServiceDate: deviceNextServiceDate, deviceLastServiceDate: deviceLastServiceDate, deviceRemark: deviceRemark, isEdit: true, isFrom: IsNavigateFrom.ard.rawValue)
        }
    }
    func buybackButtonPressedRegisterDeviceTableViewCell(senderTag: Int) {
        self.navigateToBuyBackViewController(isFrom: IsNavigateFrom.buybackRegisterDevice.rawValue)
    }
}

extension RegisterDeviceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.accessoriesProductListArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.RegisterDeviceCollectionViewCell, for: indexPath) as! RegisterDeviceCollectionViewCell
        cell.configure(product: self.accessoriesProductListArray[indexPath.item], indexpath: indexPath.item)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.productCollectionView {
            if self.accessoriesProductListArray.count > 0 {
                cellWidth = self.productCollectionViewItemWidth
                cellHeight = self.productCollectionViewItemHeight
            }
        }
        self.view.layoutIfNeeded()
        self.viewWillLayoutSubviews()
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension RegisterDeviceViewController: ProtocolRegisterDeviceCollectionViewCell {
    func tapButtonPressedRegisterDeviceCollectionViewCell(senderTag: Int) {
        if !(self.accessoriesProductListArray[senderTag].slug.isNilOrEmpty) {
            self.navigateToProductDetailViewController(isFrom: IsNavigateFrom.productDetailRegisterDevice.rawValue, productslug: self.accessoriesProductListArray[senderTag].slug!)
        }
    }
    func wishlistButtonPressedRegisterDeviceCollectionViewCell(senderTag: Int) {
    }
}
extension RegisterDeviceViewController: ProtocolBottomSheetCommonDeleteViewControllerDelegate, BottomPopupDelegate {
    // MARK: - DeletePopupScreen
    func showDeletePopupScreen(isDelete: Bool) {
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetCommonDeleteViewController) as? BottomSheetCommonDeleteViewController else { return }
        popupVC.topCornerRadius = CGFloat(25)
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0

        let primaryMsgText = AppLocalizationString.removeDevice
        let secondaryMsgText = AppLocalizationString.areyousureyouwanttoremove
        let deleteText = AppLocalizationString.yesremove
        let cancelText = AppLocalizationString.nocancel

        let popvcheight = 37/*image top*/ + 36/*image height*/ + 25/*image bottom*/ + CGFloat(self.heightForText(text: primaryMsgText, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - 32))/*primary height*/ + 5/*primary bottom*/ + CGFloat(self.heightForText(text: secondaryMsgText, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - 32))/*secondary height*/ + 5/*secondary bottom*/ + 20/*button top*/ + 38 /*button height*/ + 25/*button bottom*/

        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        popupVC.height = popvcheight + bottomPadding + topPadding

        popupVC.popupDelegate = self
        popupVC.protocolBottomSheetCommonDeleteViewControllerDelegate = self
        popupVC.primaryMsgText = primaryMsgText
        popupVC.secondaryMsgText = secondaryMsgText
        popupVC.deleteText = deleteText
        popupVC.cancelText = cancelText
        popupVC.isDelete = isDelete

        self.present(popupVC, animated: true, completion: nil)
    }

    // MARK: - ProtocolBottomSheetCommonDeleteViewControllerDelegate
    func deleteButtonPressedBottomSheetCommonDeleteViewController() {
        self.commonAPICALL(retryAPIID: 1001)
    }
}
