//
//  AddressListViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class AddressListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var tableview: UITableView!
    @IBOutlet var addAddressButton: CalloutOutlineButton!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!

    // MARK: - Lets and Var
    var addressListViewModel = AddressListViewModel()
    var listArray = [AddressDatum]()

    var isFrom = ""
    var deleteID = ""

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        self.primaryMessageLabel.text = ""
        self.secondaryMessageLabel.text = ""
        self.errorView.isHidden = true
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.addAddressButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.addAddressButton.layer.borderWidth = 1.0
        self.addAddressButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.addAddressButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.addAddressButton.clipsToBounds = true

        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTableView()
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.savedAddress
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.primaryMessageLabel.text = AppLocalizationString.noAddressTitle
        self.secondaryMessageLabel.text = AppLocalizationString.noAddressDesc
        self.addAddressButton.setTitle(AppLocalizationString.addAddress, for: .normal)

    }

    // MARK: - Reload
    func reloadTableView() {
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getCustomerAddressList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.deleteCustomerAddress(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.getCustomerAddressList(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCustomerAddressList(retryAPIID: Int, canShowLoader: Bool) {
        self.addressListViewModel.getCustomerAddressList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCustomerAddressList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func deleteCustomerAddress(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.deleteCustomerAddress)\(self.deleteID)/"
        self.addressListViewModel.deleteCustomerAddress(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func addAddressButtonPressed(_ sender: UIButton) {
        self.navigateToAddressonMapViewController(isFrom: IsNavigateFrom.addresslist.rawValue, isEdit: false, id: "", customerName: "", mobile: "", addressType: "", address1: "", address2: "", address3: "", landmark: "", city: "", state: "", zipcode: "", lat: "", lng: "", isprimary: false)
    }
    // MARK: - Custom Method

}
extension AddressListViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.addresslist.rawValue {
            self.navigateBackToAddressListViewControllerUpdated()
        } else if self.isFrom == IsNavigateFrom.addressCheckOut.rawValue {
            self.navigateBackToCheckOutViewControllerFromAddress()
        } else if self.isFrom == IsNavigateFrom.addressBookAppointment.rawValue {
            self.navigateBackToBookAppointmentAddressViewControllerFromAddress()
        } else {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        }
    }
    func rightButtonPressed() {
    }
}

extension AddressListViewController: ProtocolNetworkRechabilityDelegate {
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
extension AddressListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.AddressListTableViewCell, for: indexPath) as! AddressListTableViewCell
        cell.configure(address: self.listArray[indexPath.row], indexpath: indexPath.row)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
extension AddressListViewController: ProtocolAddressListTableViewCell {
    func editButtonPressedAddressListTableViewCell(senderTag: Int) {
        if self.listArray.count > 0 {
            var id = ""
            var customerName = ""
            var mobile = ""
            var addressType = ""
            var address1 = "" // street
            var address2 = "" // area
            var address3 = ""
            var landmark = ""
            var city = "" // city
            var state = "" // state
            var zipcode = "" // pincode
            var lat = ""
            var lng = ""
            var isprimary = false

            if self.listArray[senderTag].id != nil {
                id = String(format: "%d", self.listArray[senderTag].id!)
            }
            if self.listArray[senderTag].lat != nil {
                lat = String(format: "%f", self.listArray[senderTag].lat!)
            }
            if self.listArray[senderTag].lng != nil {
                lng = String(format: "%f", self.listArray[senderTag].lng!)
            }
            if self.listArray[senderTag].zipcode != nil {
                zipcode = String(format: "%d", self.listArray[senderTag].zipcode!)
            }
            if self.listArray[senderTag].isPrimary != nil {
                isprimary = self.listArray[senderTag].isPrimary!
            }
            if !(self.listArray[senderTag].customerName.isNilOrEmpty) {
                customerName = self.listArray[senderTag].customerName!
            }
            if !(self.listArray[senderTag].mobile.isNilOrEmpty) {
                mobile = self.listArray[senderTag].mobile!
            }
            if !(self.listArray[senderTag].address1.isNilOrEmpty) {
                address1 = self.listArray[senderTag].address1!
            }
            if !(self.listArray[senderTag].address2.isNilOrEmpty) {
                address2 = self.listArray[senderTag].address2!
            }
            if !(self.listArray[senderTag].address3.isNilOrEmpty) {
                address3 = self.listArray[senderTag].address3!
            }
            if !(self.listArray[senderTag].landmark.isNilOrEmpty) {
                landmark = self.listArray[senderTag].landmark!
            }
            if !(self.listArray[senderTag].city.isNilOrEmpty) {
                city = self.listArray[senderTag].city!
            }
            if !(self.listArray[senderTag].state.isNilOrEmpty) {
                state = self.listArray[senderTag].state!
            }
            if !(self.listArray[senderTag].addressType.isNilOrEmpty) {
                addressType = self.listArray[senderTag].addressType!
            }
            self.navigateToAddressonMapViewController(isFrom: IsNavigateFrom.addresslist.rawValue, isEdit: true, id: id, customerName: customerName, mobile: mobile, addressType: addressType, address1: address1, address2: address2, address3: address3, landmark: landmark, city: city, state: state, zipcode: zipcode, lat: lat, lng: lng, isprimary: isprimary)
        }
    }
    func deleteButtonPressedAddressListTableViewCell(senderTag: Int) {
        if self.listArray.count > 0 {
            if self.listArray[senderTag].id != nil {
                self.deleteID = String(format: "%d", self.listArray[senderTag].id!)
                self.showDeletePopupScreen(isDelete: true)
            }
        }
    }
}
extension AddressListViewController: ProtocolBottomSheetCommonDeleteViewControllerDelegate, BottomPopupDelegate {
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

        let primaryMsgText = AppLocalizationString.deleteAddress
        let secondaryMsgText = AppLocalizationString.areyousureyouwanttodelete
        let deleteText = AppLocalizationString.yesdelete
        let cancelText = AppLocalizationString.nocancel

        let popvcheight = 37/*image top*/ + 36/*image height*/ + 25/*image bottom*/ + CGFloat(self.heightForText(text: primaryMsgText, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - 32))/*primary height*/ + 5/*primary bottom*/ + CGFloat(self.heightForText(text: secondaryMsgText, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - 32))/*secondary height*/ + 5/*secondary bottom*/ + 20/*button top*/ + 38/*button height*/ + 25/*button bottom*/

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
