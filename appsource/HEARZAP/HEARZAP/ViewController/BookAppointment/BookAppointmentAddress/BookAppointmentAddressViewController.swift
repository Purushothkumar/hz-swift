//
//  BookAppointmentAddressViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 24/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class BookAppointmentAddressViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var fourDotCircleView: FourDotCircleView!
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var selectionStackView: UIStackView!
    @IBOutlet var pincodeView: UIView!
    @IBOutlet var pincodeLabel: Caption1FontLabel!
    @IBOutlet var pincodeTextField: Caption1FontTextfield!
    @IBOutlet var checkButton: FootnoteOutlineButton!
    @IBOutlet var visitChargeLabel: Caption2FontLabel!
    
    @IBOutlet var selectionView: UIView!
    @IBOutlet var selectionLabel: Caption1FontLabel!
    @IBOutlet var homeButton: FootnoteOutlineButton!
    @IBOutlet var storeButton: FootnoteOutlineButton!
    
    @IBOutlet var homeStackView: UIStackView!
    @IBOutlet var selectHomeAddressView: UIView!
    @IBOutlet var selectHomeAddressLabel: FootnoteFontLabel!
    
    @IBOutlet var homeAddressTableView: UITableView!
    @IBOutlet var homeAddressTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var addAddressView: UIView!
    @IBOutlet var addAddressButton: FootnoteOutlineButton!
    
    @IBOutlet var storeStackView: UIStackView!
    @IBOutlet var selectStoreAddressView: UIView!
    @IBOutlet var selectStoreAddressLabel: FootnoteFontLabel!
    
    @IBOutlet var storeAddressTableView: UITableView!
    @IBOutlet var storeAddressTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var dateStackView: UIStackView!
    @IBOutlet var selectDateTitleView: UIView!
    @IBOutlet var selectDateTitleLabel: FootnoteFontLabel!
    
    @IBOutlet var selectDateView: UIView!
    @IBOutlet var selectDateCollectionView: UICollectionView!
    @IBOutlet var selectDateCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var selectTimeStackView: UIStackView!
    @IBOutlet var selectTimeTitleView: UIView!
    @IBOutlet var selectTimeTitleLabel: FootnoteFontLabel!
    
    @IBOutlet var selectTimeView: UIView!
    @IBOutlet var selectTimeCollectionView: UICollectionView!
    @IBOutlet var selectTimeCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var primaryMesageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMesageLabel: Caption1FontLabel!
    @IBOutlet var tryStoreButton: FootnoteOutlineButton!
    
    @IBOutlet var buttonView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!
    @IBOutlet var buttonViewHeight: NSLayoutConstraint!
    
    // MARK: - Lets and Var
    var bookAppointmentAddressViewModel = BookAppointmentAddressViewModel()
    var deliveryType = ""
    var activeField = UITextField()
    
    let selectDateCollectionViewMargin = 0
    let selectDateCollectionViewItemSpacing = CGFloat(12)
    var selectDateCollectionViewItemHeight = CGFloat(50)
    var selectDateCollectionViewItemWidth = CGFloat(80)
    let selectDateCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let selectTimeCollectionViewMargin = 0
    let selectTimeCollectionViewItemSpacing = CGFloat(12)
    var selectTimeCollectionViewItemHeight = CGFloat(178)
    var selectTimeCollectionViewItemWidth = CGFloat(139)
    let selectTimeCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var isFrom = ""
    var patientUid = ""
    
    var selectedDate = ""
    var selectedTime = ""
    
    //    var storeID = ""
    var addressID = ""
    var addressListArray = [AddressDatum]()
    var storeListArray = [StoreDeliveryAddressModelStoreList]()
    var storeUID = ""
    
    var pincode = ""
    
    var dateListArray = [DateSlot]()
    var timeListArray = [AvailableTimeSlot]()
    var selectedServiceArray = [ServiceSelected]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //        if self.dateListArray.count > 0 {
        //            self.selectDateCollectionViewHeight.constant = CGFloat(85)
        //        } else {
        //            self.selectDateCollectionViewHeight.constant = 0
        //        }
        if self.timeListArray.count > 0 {
            if self.timeListArray.count > 2 {
                self.selectTimeCollectionViewHeight.constant = (CGFloat(self.timeListArray.count) * self.selectTimeCollectionViewItemHeight) + (CGFloat((self.timeListArray.count) - 1) * 12) + CGFloat(20)
            } else {
                self.selectTimeCollectionViewHeight.constant = self.selectTimeCollectionViewItemHeight + CGFloat(20)
            }
        } else {
            self.selectTimeCollectionViewHeight.constant = 0
        }
        self.view.layoutIfNeeded()
        if self.deliveryType == DeliveryType.home.rawValue {
            if self.addressListArray.count > 0 {
                self.homeAddressTableViewHeight.constant = self.homeAddressTableView.contentSize.height
            } else {
                self.homeAddressTableViewHeight.constant = 0
            }
        } else {
            self.homeAddressTableViewHeight.constant = 0
        }
        if self.storeListArray.count > 0 {
            self.storeAddressTableViewHeight.constant = self.storeAddressTableView.contentSize.height
        } else {
            self.storeAddressTableViewHeight.constant = 0
        }
        
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
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.setFourDotCircleView()
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        self.nextButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.nextButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.nextButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.nextButton.clipsToBounds = true
        
        self.addAddressButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.addAddressButton.layer.borderWidth = 1.0
        self.addAddressButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.addAddressButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.addAddressButton.clipsToBounds = true
        
        self.homeAddressTableView.tableFooterView = UIView()
        //        self.homeAddressTableView.separatorColor = UIColor.clear
        self.homeAddressTableView.backgroundColor = UIColor.clear
        self.homeAddressTableView.rowHeight = UITableView.automaticDimension
        self.homeAddressTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.storeAddressTableView.tableFooterView = UIView()
        //        self.storeAddressTableView.separatorColor = UIColor.clear
        self.storeAddressTableView.backgroundColor = UIColor.clear
        self.storeAddressTableView.rowHeight = UITableView.automaticDimension
        self.storeAddressTableView.estimatedRowHeight = UITableView.automaticDimension
        
        let view0 = self.mainStackView.arrangedSubviews[0]// selection
        let view1 = self.mainStackView.arrangedSubviews[1]// home
        let view2 = self.mainStackView.arrangedSubviews[2]// store
        let view3 = self.mainStackView.arrangedSubviews[3]// date
        let view4 = self.mainStackView.arrangedSubviews[4]// time
        let view5 = self.mainStackView.arrangedSubviews[5]// empty
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        
        self.pincodeTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.pincodeTextField.clipsToBounds = true
        self.pincodeTextField.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.pincodeTextField.layer.borderWidth = 1.0
        self.pincodeTextField.setLeftPaddingPoints(10.0)
        self.pincodeTextField.setRightPaddingPoints(60.0)
        self.pincodeTextField.delegate = self
        self.pincodeTextField.text = ""
        
        [self.pincodeTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        self.setUserInteractionButton()
        self.setDefaultButtonSelected(deliveryType: self.deliveryType)
        
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.bookAppointment
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Set Four Dot Circle View
    func setFourDotCircleView() {
        self.fourDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.checkcircleblue, button3image: Asset.recordcircleblue, button4image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.BAStep3Title.capitalized
        let descriptionMessage = AppLocalizationString.BAStep3Desc.capitalized
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
        self.pincodeTextField.placeholder = AppLocalizationString.enterPincode
        self.pincodeTextField.text = ""
        self.selectionLabel.text = AppLocalizationString.doyoupreferhomeorstoreappointment
        self.homeButton.setTitle(AppLocalizationString.home.capitalized, for: .normal)
        self.storeButton.setTitle(AppLocalizationString.store.capitalized, for: .normal)
        self.selectHomeAddressLabel.text = AppLocalizationString.selectAddress
        self.addAddressButton.setTitle(AppLocalizationString.addAddress.uppercased(), for: .normal)
        self.selectStoreAddressLabel.text = AppLocalizationString.selectNearbyStore
        self.primaryMesageLabel.text = AppLocalizationString.wearecomingsoon
        self.secondaryMesageLabel.text = AppLocalizationString.ourteamisworkingtobringourservicestoyourdoorstep
        self.tryStoreButton.setTitle(AppLocalizationString.trystorepickup, for: .normal)
        self.nextButton.setTitle(AppLocalizationString.next.uppercased(), for: .normal)
        self.pincodeLabel.text = AppLocalizationString.enteryourareapincode
        self.selectDateTitleLabel.text = AppLocalizationString.selectDate.capitalized
        self.selectTimeTitleLabel.text = AppLocalizationString.selectTimeSlot.capitalized
        self.visitChargeLabel.text = AppLocalizationString.visitChargeDesc.capitalized
        
        self.setCommonTitleView()
    }
    // MARK: - Reload
    func reloadHomeAddressTableView() {
        DispatchQueue.main.async {
            self.homeAddressTableView.delegate = self
            self.homeAddressTableView.dataSource = self
            self.homeAddressTableView.reloadData()
        }
    }
    func reloadstoreAddressTableView() {
        DispatchQueue.main.async {
            self.storeAddressTableView.delegate = self
            self.storeAddressTableView.dataSource = self
            self.storeAddressTableView.reloadData()
        }
    }
    func reloadSelectTimeCollectionView() {
        DispatchQueue.main.async {
            self.selectTimeCollectionViewItemHeight = CGFloat(38)
            self.selectTimeCollectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32) - CGFloat(32)
            self.selectTimeCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.selectTimeCollectionViewlayout.itemSize = CGSize(width: self.selectTimeCollectionViewItemWidth, height: self.selectTimeCollectionViewItemHeight)
            self.selectTimeCollectionViewlayout.minimumLineSpacing = self.selectTimeCollectionViewItemSpacing
            self.selectTimeCollectionViewlayout.minimumInteritemSpacing = self.selectTimeCollectionViewItemSpacing
            self.selectTimeCollectionViewlayout.scrollDirection = .vertical
            self.selectTimeCollectionView!.collectionViewLayout = self.selectTimeCollectionViewlayout
            self.selectTimeCollectionView.dataSource = self
            self.selectTimeCollectionView.delegate = self
            self.selectTimeCollectionView.reloadData()
            if self.timeListArray.count > 0 {
                if self.timeListArray.count > 2 {
                    self.selectTimeCollectionViewHeight.constant = (CGFloat(self.timeListArray.count) * self.selectTimeCollectionViewItemHeight) + (CGFloat((self.timeListArray.count) - 1) * 12) + CGFloat(20)
                } else {
                    self.selectTimeCollectionViewHeight.constant = self.selectTimeCollectionViewItemHeight + CGFloat(20)
                }
            } else {
                self.selectTimeCollectionViewHeight.constant = 0
            }
            self.view.layoutIfNeeded()
        }
    }
    func reloadSelectDateCollectionView() {
        DispatchQueue.main.async {
            self.selectDateCollectionViewItemHeight = 60
            self.selectDateCollectionViewItemWidth = (CGFloat(AppConstantValue.screenWidthminus32) - (CGFloat(self.selectDateCollectionViewItemSpacing) + 32)) / 2
            self.selectDateCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.selectDateCollectionViewlayout.itemSize = CGSize(width: self.selectDateCollectionViewItemWidth, height: self.selectDateCollectionViewItemHeight)
            self.selectDateCollectionViewlayout.minimumLineSpacing = self.selectDateCollectionViewItemSpacing
            self.selectDateCollectionViewlayout.minimumInteritemSpacing = self.selectDateCollectionViewItemSpacing
            self.selectDateCollectionViewlayout.scrollDirection = .vertical
            self.selectDateCollectionView!.collectionViewLayout = self.selectDateCollectionViewlayout
            self.selectDateCollectionView.dataSource = self
            self.selectDateCollectionView.delegate = self
            self.selectDateCollectionView.reloadData()
            if self.dateListArray.count > 0 {
                if self.dateListArray.count % 2 == 0 {
                    self.selectDateCollectionViewHeight.constant = (CGFloat(self.dateListArray.count / 2) * self.selectDateCollectionViewItemHeight) + ((CGFloat(self.dateListArray.count / 2)) * 12) + 16
                    self.selectDateCollectionView.isScrollEnabled = false
                } else {
                    self.selectDateCollectionViewHeight.constant = (CGFloat(self.dateListArray.count / 2) * self.selectDateCollectionViewItemHeight) + ((CGFloat(self.dateListArray.count / 2)) * 12)  + self.selectDateCollectionViewItemHeight + 12 + 16
                    self.selectDateCollectionView.isScrollEnabled = false
                }
            } else {
                self.selectDateCollectionViewHeight.constant = 0
            }
            self.view.layoutIfNeeded()
        }
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getBookAppointmentDateList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getZipcodeCustomerAddress(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 || retryAPIID == 1003 {
                    self.postZipcodeServiceRequestsStoreAddress(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1004 {
                    self.postBookAppointmentTimeList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.postCreateBooking(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    
    func getZipcodeCustomerAddress(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getZipcodeCustomerAddress)\(self.pincodeTextField.text!.allowSpecialCharacters)/"
        self.bookAppointmentAddressViewModel.getZipcodeCustomerAddress(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postZipcodeServiceRequestsStoreAddress(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "zipcode=%@", self.pincodeTextField.text!.allowSpecialCharacters)
        self.bookAppointmentAddressViewModel.postZipcodeServiceRequestsStoreAddress(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postZipcodeServiceRequestsStoreAddress, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getBookAppointmentDateList(retryAPIID: Int, canShowLoader: Bool) {
        self.bookAppointmentAddressViewModel.getBookAppointmentDateList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getBookAppointmentDateList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postBookAppointmentTimeList(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "booking_date=%@&store=%@", self.selectedDate, self.storeUID)
        self.bookAppointmentAddressViewModel.postBookAppointmentTimeList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postBookAppointmentTimeList, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postCreateBooking(retryAPIID: Int, canShowLoader: Bool) {
        var param = ""
        var paramdict  = [NSDictionary]()
        
        for item in self.selectedServiceArray {
            let newdict = NSMutableDictionary()
            let arrayValueCode: NSMutableArray = NSMutableArray(array: item.listedDevice)
            newdict.setValue(arrayValueCode, forKey: "device_list")
            
            newdict.setValue(item.serviceId, forKey: "service_type")
            paramdict.append(newdict)
        }
        if self.deliveryType == DeliveryType.home.rawValue {
            param = String(format: "service_type_inputs=%@&customer_address=%@&booking_date=%@&booking_time=%@&booking_type=\(2)&store=%@", paramdict.count > 0 ? self.stringifyArray(json: paramdict, prettyPrinted: false) : "[]", addressID, selectedDate, selectedTime, storeUID)
        } else {
            param = String(format: "service_type_inputs=%@&booking_date=%@&booking_time=%@&booking_type=\(3)&store=%@", paramdict.count > 0 ? self.stringifyArray(json: paramdict, prettyPrinted: false) : "[]", selectedDate, selectedTime, storeUID)
        }
        let url = "\(SubAPIUrl.createBookAppointmentList)\(patientUid)/"
        self.bookAppointmentAddressViewModel.postCreateBooking(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    
    // MARK: - IBAction
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.storeUID = ""
        self.addressID = ""
        self.selectedTime = ""
        self.selectedDate = ""
        
        self.setUserInteractionButton()
        if !(self.pincodeTextField.text.isNilOrEmpty) {
            if self.pincodeTextField.text!.count == 6 {
                if self.deliveryType == DeliveryType.home.rawValue {
                    self.commonAPICALL(retryAPIID: 1003)
                } else {
                    self.commonAPICALL(retryAPIID: 1002)
                }
            } else {
                self.showToastAlert(AppLocalizationString.pleaseentervalidpincode, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            }
        } else {
            self.showToastAlert(AppLocalizationString.pleaseentervalidpincode, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 2000)
    }
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        self.deliveryType = DeliveryType.home.rawValue
        self.storeUID = ""
        self.addressID = ""
        self.selectedTime = ""
        self.selectedDate = ""
        self.reloadSelectDateCollectionView()
        self.reloadSelectTimeCollectionView()
        self.reloadHomeAddressTableView()
        self.reloadstoreAddressTableView()
        self.showhidePincode(isbuttonPress: false)
    }
    @IBAction func storeButtonPressed(_ sender: UIButton) {
        self.deliveryType = DeliveryType.store.rawValue
        self.storeUID = ""
        self.addressID = ""
        self.selectedTime = ""
        self.selectedDate = ""
        self.reloadSelectDateCollectionView()
        self.reloadSelectTimeCollectionView()
        self.reloadHomeAddressTableView()
        self.reloadstoreAddressTableView()
        self.showhidePincode(isbuttonPress: false)
        
    }
    @IBAction func addAddressButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.pincode = self.pincodeTextField.text ?? ""
        self.navigateToAddressonMapViewController(isFrom: IsNavigateFrom.addressBookAppointment.rawValue, isEdit: false, id: "", customerName: "", mobile: "", addressType: "", address1: "", address2: "", address3: "", landmark: "", city: "", state: "", zipcode: "", lat: "", lng: "", isprimary: false)
    }
    @IBAction func tryStoreButtonPressed(_ sender: UIButton) {
        self.deliveryType = DeliveryType.store.rawValue
        self.commonAPICALL(retryAPIID: 1002)
    }
    // MARK: - Custom Methods
    func setDefaultButtonSelected(deliveryType: String) {
        DispatchQueue.main.async {
            self.homeButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
            self.homeButton.layer.borderWidth = 1.0
            self.homeButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
            self.homeButton.layer.cornerRadius = AppConstantValue.cornerRadius8
            self.homeButton.clipsToBounds = true
            
            self.storeButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
            self.storeButton.layer.borderWidth = 1.0
            self.storeButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
            self.storeButton.layer.cornerRadius = AppConstantValue.cornerRadius8
            self.storeButton.clipsToBounds = true
            
            if self.deliveryType == DeliveryType.home.rawValue {
                self.setHomeButtonSelected()
            } else if self.deliveryType == DeliveryType.store.rawValue {
                self.setstoreButtonSelected()
            }
        }
    }
    func setHomeButtonSelected() {
        DispatchQueue.main.async {
            self.homeButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            self.homeButton.layer.borderWidth = 1.0
            self.homeButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
            self.homeButton.layer.cornerRadius = AppConstantValue.cornerRadius8
            self.homeButton.clipsToBounds = true
        }
    }
    func setstoreButtonSelected() {
        DispatchQueue.main.async {
            self.storeButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            self.storeButton.layer.borderWidth = 1.0
            self.storeButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
            self.storeButton.layer.cornerRadius = AppConstantValue.cornerRadius8
            self.storeButton.clipsToBounds = true
        }
    }
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if (self.deliveryType == DeliveryType.store.rawValue) && !(self.storeUID.isEmpty) && !(self.selectedDate.isEmpty) && !(self.selectedTime.isEmpty) {
                self.setButtonEnable()
            } else if (self.deliveryType == DeliveryType.home.rawValue) && !(self.storeUID.isEmpty) && !(self.addressID.isEmpty) && !(self.selectedDate.isEmpty) && !(self.selectedTime.isEmpty) {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
            if (self.deliveryType == DeliveryType.store.rawValue) && !(self.storeUID.isEmpty) {
                let view3 = self.mainStackView.arrangedSubviews[3]// date
                view3.isHidden = false
            } else if (self.deliveryType == DeliveryType.home.rawValue) && !(self.storeUID.isEmpty) && !(self.addressID.isEmpty) {
                let view3 = self.mainStackView.arrangedSubviews[3]// date
                view3.isHidden = false
            } else {
                let view3 = self.mainStackView.arrangedSubviews[3]// date
                view3.isHidden = true
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
    
    @objc func scrolltoStore() {
        let view0 = self.mainStackView.arrangedSubviews[0]// selection
        let view1 = self.mainStackView.arrangedSubviews[1]// home
        
        var storeSlotViewY: CGFloat = 0
        
        if DeliveryType.home.rawValue == self.deliveryType {
            storeSlotViewY = view0.frame.height + view1.frame.height
        } else {
            storeSlotViewY = view0.frame.height
        }
        UIView.animate(withDuration: 100) {
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: storeSlotViewY), animated: true)
        }
    }
    
    @objc func scrolltoDateSlot() {
        let view0 = self.mainStackView.arrangedSubviews[0]// selection
        let view1 = self.mainStackView.arrangedSubviews[1]// home
        let view2 = self.mainStackView.arrangedSubviews[2]// store
        var dateSlotViewY: CGFloat = 0
        
        if DeliveryType.home.rawValue == self.deliveryType {
            dateSlotViewY = view0.frame.height + view1.frame.height + view2.frame.height
        } else {
            dateSlotViewY = view0.frame.height + view2.frame.height
        }
        
        UIView.animate(withDuration: 100) {
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: dateSlotViewY), animated: true)
        }
    }
    
    @objc func scrolltoTimeSlot() {
        let view0 = self.mainStackView.arrangedSubviews[0]// selection
        let view1 = self.mainStackView.arrangedSubviews[1]// home
        let view2 = self.mainStackView.arrangedSubviews[2]// store
        let view3 = self.mainStackView.arrangedSubviews[3]// date
        
        var timeSlotViewY: CGFloat = 0
        
        if DeliveryType.home.rawValue == self.deliveryType {
            timeSlotViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height
        } else {
            timeSlotViewY = view0.frame.height + view2.frame.height + view3.frame.height
        }
        
        UIView.animate(withDuration: 100) {
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: timeSlotViewY), animated: true)
        }
    }
    
    func showhidePincode(isbuttonPress: Bool) {
        let view0 = self.mainStackView.arrangedSubviews[0]// selection
        let view1 = self.mainStackView.arrangedSubviews[1]// home
        let view2 = self.mainStackView.arrangedSubviews[2]// store
        let view3 = self.mainStackView.arrangedSubviews[3]// date
        let view4 = self.mainStackView.arrangedSubviews[4]// time
        let view5 = self.mainStackView.arrangedSubviews[5]// empty
        view0.isHidden = false
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        
        let selectionview1 = self.selectionStackView.arrangedSubviews[1]// line
        let selectionview2 = self.selectionStackView.arrangedSubviews[2]// text field
        
        selectionview1.isHidden = isbuttonPress
        selectionview2.isHidden = isbuttonPress
        
        self.storeUID = ""
        self.addressID = ""
        self.selectedTime = ""
        self.selectedDate = ""
        self.setUserInteractionButton()
        self.setDefaultButtonSelected(deliveryType: self.deliveryType)
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
    // MARK: - TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeField.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && (string == " ") {
            return false
        }
        var maxLength = 6
        if textField == self.pincodeTextField {
            maxLength = 6
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.numericRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    @objc func editingChanged(_ textField: UITextField) {
        self.showhidePincode(isbuttonPress: false)
    }
    
}

extension BookAppointmentAddressViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension BookAppointmentAddressViewController: ProtocolNetworkRechabilityDelegate {
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

extension BookAppointmentAddressViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.homeAddressTableView {
            return self.addressListArray.count
        } else {
            return self.storeListArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.homeAddressTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BookAppointmentAddressHomeTableViewCell, for: indexPath) as! BookAppointmentAddressHomeTableViewCell
            cell.configure(address: self.addressListArray[indexPath.row], indexpath: indexPath.row, addressID: self.addressID, viewCon: self)
            cell.delegate = self
            cell.showSeparator()
            if self.addressListArray.count > 0 {
                if indexPath.row == (self.addressListArray.count - 1) {
                    cell.hideSeparator()
                }
            }
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BookAppointmentAddressStoreTableViewCell, for: indexPath) as! BookAppointmentAddressStoreTableViewCell
            cell.configure(storeDeliveryAddressModelStoreList: self.storeListArray[indexPath.row], indexpath: indexPath.row, storeUID: self.storeUID, viewCon: self)
            cell.delegate = self
            cell.showSeparator()
            if self.storeListArray.count > 0 {
                if indexPath.row == (self.storeListArray.count - 1) {
                    cell.hideSeparator()
                }
            }
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
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
        
        if tableView == self.homeAddressTableView && self.addressListArray.count > 0 {
            return self.homeAddressTableViewHeight.constant = tableView.contentSize.height
        } else if tableView == self.storeAddressTableView && self.addressListArray.count > 0 {
            return self.storeAddressTableViewHeight.constant = tableView.contentSize.height
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension BookAppointmentAddressViewController: ProtocolBookAppointmentAddressHomeTableViewCell, ProtocolBookAppointmentAddressStoreTableViewCell {
    func selectButtonPressedBookAppointmentAddressHomeTableViewCell(senderTag: Int) {
        if self.addressListArray.count > 0 {
            if self.addressListArray[senderTag].id != nil {
                self.selectedDate = ""
                self.reloadSelectDateCollectionView()
                self.selectedTime = ""
                self.reloadSelectTimeCollectionView()
                self.addressID = String(format: "%d", self.addressListArray[senderTag].id!)
                self.reloadHomeAddressTableView()
                self.setUserInteractionButton()
            }
        }
    }
    func selectButtonPressedBookAppointmentAddressStoreTableViewCell(senderTag: Int) {
        if self.storeListArray.count > 0 {
            if self.storeListArray[senderTag].store != nil {
                if !(self.storeListArray[senderTag].store!.uid.isNilOrEmpty) {
                    self.selectedDate = ""
                    self.reloadSelectDateCollectionView()
                    self.selectedTime = ""
                    self.reloadSelectTimeCollectionView()
                    
                    self.storeUID = String(format: "%@", self.storeListArray[senderTag].store!.uid!)
                    self.reloadstoreAddressTableView()
                    self.setUserInteractionButton()
                }
            }
        }
    }
}
extension BookAppointmentAddressViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.selectTimeCollectionView {
            return self.timeListArray.count
        } else {
            return self.dateListArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.selectTimeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BookAppointmentTimeCollectionViewCell, for: indexPath) as! BookAppointmentTimeCollectionViewCell
            cell.configure(availableTimeSlot: self.timeListArray[indexPath.item], indexpath: indexPath.item, selectedTime: self.selectedTime)
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BookAppointmentDateCollectionViewCell, for: indexPath) as! BookAppointmentDateCollectionViewCell
            cell.configure(dateSlot: self.dateListArray[indexPath.item], indexpath: indexPath.item, selectedDate: self.selectedDate, viewCon: self)
            cell.delegate = self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.selectTimeCollectionView {
            if self.timeListArray.count > 0 {
                cellWidth = self.selectTimeCollectionViewItemWidth
                cellHeight = self.selectTimeCollectionViewItemHeight
            }
        } else if collectionView == self.selectDateCollectionView {
            if self.dateListArray.count > 0 {
                cellWidth = self.selectDateCollectionViewItemWidth
                cellHeight = self.selectDateCollectionViewItemHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.mainScrollView {
            let view0 = self.mainStackView.arrangedSubviews[0]// selection
            let view1 = self.mainStackView.arrangedSubviews[1]// home
            let view2 = self.mainStackView.arrangedSubviews[2]// store
            let view3 = self.mainStackView.arrangedSubviews[3]// date
            let view4 = self.mainStackView.arrangedSubviews[4]// time
            let view5 = self.mainStackView.arrangedSubviews[5]// empty
            
            let stackviewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height
        }
    }
}

extension BookAppointmentAddressViewController: ProtocolBookAppointmentTimeCollectionViewCell, ProtocolBookAppointmentDateCollectionViewCell {
    func selectButtonPressedBookAppointmentDateCollectionViewCell(senderTag: Int) {
        if self.dateListArray.count > 0 {
            if !(self.dateListArray[senderTag].value.isNilOrEmpty) {
                self.selectedTime = ""
                self.reloadSelectTimeCollectionView()
                self.selectedDate = self.dateListArray[senderTag].value!
                self.reloadSelectDateCollectionView()
                self.commonAPICALL(retryAPIID: 1004)
                self.setUserInteractionButton()
            }
        }
    }
    func selectButtonPressedBookAppointmentTimeCollectionViewCell(senderTag: Int) {
        if self.timeListArray.count > 0 {
            if self.timeListArray[senderTag].id != nil {
                self.selectedTime = String(format: "%d", self.timeListArray[senderTag].id!)
                self.reloadSelectTimeCollectionView()
                self.setUserInteractionButton()
            }
        }
    }
}
