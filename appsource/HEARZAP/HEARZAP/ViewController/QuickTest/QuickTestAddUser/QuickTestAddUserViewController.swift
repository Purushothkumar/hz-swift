//
//  QuickTestAddUserViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 13/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


class QuickTestAddUserViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var selectNameView: UIView!
    @IBOutlet var selectNameLabel: Caption1FontLabel!
    @IBOutlet var selectNameTextField: Caption1FontTextfield!

    @IBOutlet var selectDOBView: UIView!
    @IBOutlet var selectDOBLabel: Caption1FontLabel!
    @IBOutlet var selectDOBTextField: Caption1FontTextfield!
    @IBOutlet var selectDOBImageView: UIImageView!

    @IBOutlet var selectGenderView: UIView!
    @IBOutlet var selectGenderLabel: Caption1FontLabel!
    @IBOutlet var genderCollectionView: UICollectionView!
    @IBOutlet var genderCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var selectRelationshipTypeView: UIView!
    @IBOutlet var selectRelationshipTypeLabel: Caption1FontLabel!
    @IBOutlet var selectRelationshipTypeTextField: Caption1FontTextfield!
    @IBOutlet var selectRelationshipTypeImageView: UIImageView!

    @IBOutlet var selectRelationshipView: UIView!
    @IBOutlet var selectRelationshipLabel: Caption1FontLabel!
    @IBOutlet var selectRelationshipTextField: Caption1FontTextfield!

    @IBOutlet var addButton: CalloutBackgroundButton!

    // MARK: - Lets and Var
    let quickTestAddUserViewModel = QuickTestAddUserViewModel()
    var isFrom = ""
    var relationPicker: UIPickerView = UIPickerView()
    var activeField = UITextField()
    var isEdit = false
    var datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    var componentsDay = 0

    var genderArray = [GenderRelationModelGender]()
    var relationShipArray = [GenderRelationModelRelationType]()
    var newGuestpatientList = [PatientList]()

    var uid = ""
    var name = ""
    var dob = ""
    var genderSlug = ""
    var relationShipSlug = ""
    var relationShip = ""
//    var gender = ""

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
        if isFrom == IsNavigateFrom.addUserQuickCheck.rawValue{
            self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_white_FFFFFF,style: StatusBarTheme.darkContent.rawValue)
        }else{
            self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_blue_112F70,style: StatusBarTheme.lightContent.rawValue)
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isFrom == IsNavigateFrom.addUserQuickCheck.rawValue{
            return .darkContent
        }
        else{
            return .lightContent
        }
    }
    // MARK: - Set Initial View
    func setInitialView() {
        let view0 = self.mainStackView.arrangedSubviews[0]
        view0.isHidden = true
        self.changeStatusBarColor()
        self.changeLanguageFormat()

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        self.selectRelationshipTextField.text = ""
        self.selectNameTextField.text = ""
        self.selectRelationshipTypeTextField.text = ""
        self.selectDOBTextField.text = ""

        self.selectRelationshipTextField.tintColor = UIColor.colorLiteral.theme_black_333333
        self.selectNameTextField.tintColor = UIColor.colorLiteral.theme_black_333333
        self.selectRelationshipTypeTextField.tintColor = UIColor.colorLiteral.theme_black_333333
        self.selectDOBTextField.tintColor = UIColor.colorLiteral.theme_black_333333

        if self.isEdit == true {
            self.selectNameTextField.text = self.name
            self.selectDOBTextField.text = self.dob
            self.selectRelationshipTypeTextField.text = self.relationShipSlug
            self.selectRelationshipTextField.text = self.relationShip
            self.reloadGenderCollectionView()
            if self.relationShipSlug.lowercased() == "self".lowercased() {
                self.selectRelationshipTypeTextField.isUserInteractionEnabled = false
                self.selectRelationshipTypeTextField.backgroundColor = UIColor.colorLiteral.theme_grey_777777.withAlphaComponent(0.3)
            }
            self.commonAPICALL(retryAPIID: 1002)
        }
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.selectNameTextField.setLeftPaddingPoints(5.0)
        self.selectNameTextField.setRightPaddingPoints(5.0)

        self.selectDOBTextField.setLeftPaddingPoints(5.0)
        self.selectDOBTextField.setRightPaddingPoints(30.0)

        self.selectRelationshipTypeTextField.setLeftPaddingPoints(5.0)
        self.selectRelationshipTypeTextField.setRightPaddingPoints(30.0)

        self.selectRelationshipTextField.setLeftPaddingPoints(5.0)
        self.selectRelationshipTextField.setRightPaddingPoints(5.0)

        self.selectNameTextField.delegate = self
        self.selectRelationshipTextField.delegate = self
        self.selectDOBTextField.delegate = self
        self.selectRelationshipTypeTextField.delegate = self

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: AppLocalizationString.done, style: .plain, target: self, action: #selector(toClosePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)

        self.selectRelationshipTypeTextField.inputView = relationPicker
        self.relationPicker.delegate = self
        self.relationPicker.dataSource = self
        [self.selectNameTextField, self.selectDOBTextField, self.selectRelationshipTextField,self.selectRelationshipTypeTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        self.setDatePicker()

        self.commonAPICALL(retryAPIID: 1000)

    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        if isFrom == IsNavigateFrom.addUserQuickCheck.rawValue{
            self.navigationBar.leftImage = Asset.arrowleftdarkblue
        }
        else{
            self.navigationBar.leftImage = Asset.arrowleftwhite
        }
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = self.isEdit == true ? AppLocalizationString.editProfile : AppLocalizationString.addperson
        self.navigationBar.delegate = self
        if isFrom == IsNavigateFrom.addUserQuickCheck.rawValue{
            self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF,titleTextColor: UIColor.colorLiteral.theme_blue_112F70)
        }
        else{
            self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
        }
    }

    // MARK: - Set Add User Title View
    func setCommonTitleView() {
        if isFrom == IsNavigateFrom.addUserQuickCheck.rawValue{
            self.commonTitleView.setupView(titleMessage: AppLocalizationString.addperson, descriptionMessage: AppLocalizationString.hiconfirmthepersonsdetails,commonTitlebackgroundViewColor: UIColor.colorLiteral.theme_blue_E7F4FF)
        }
        else{
            self.commonTitleView.setupView(titleMessage: AppLocalizationString.addperson, descriptionMessage: AppLocalizationString.hiconfirmthepersonsdetails,commonTitlebackgroundViewColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
        }
        self.commonTitleViewHeight.constant = 8 + self.heightForText(text: AppLocalizationString.addperson, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32) + 2 + self.heightForText(text: AppLocalizationString.hiconfirmthepersonsdetails, Font: AppFont.regular.size(11), Width: AppConstantValue.screenWidthminus32) + 8
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.setCommonTitleView()
        self.addButton.setTitle(AppLocalizationString.add.uppercased(), for: .normal)

        self.selectNameLabel.setStarAttributtedText(textmessage: AppLocalizationString.namestar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.selectNameTextField.placeholder = AppLocalizationString.pleaseenterthename

        self.selectGenderLabel.setStarAttributtedText(textmessage: AppLocalizationString.genderstar, color: UIColor.colorLiteral.theme_red_FF6961)

        self.selectRelationshipTypeLabel.setStarAttributtedText(textmessage: AppLocalizationString.relationshiptypestar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.selectRelationshipTypeTextField.placeholder = AppLocalizationString.pleaseSelectRelationshiptype

        self.selectRelationshipLabel.setStarAttributtedText(textmessage: AppLocalizationString.relationshipstar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.selectRelationshipTextField.placeholder = AppLocalizationString.pleaseAddRelationship

        self.selectDOBLabel.setStarAttributtedText(textmessage: AppLocalizationString.dateOfBirthstar, color: UIColor.colorLiteral.theme_red_FF6961)
        self.selectDOBTextField.placeholder = AppLocalizationString.pleaseSelectDate

    }
    // MARK: - Reload
    func reloadGenderCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .horizontal
        self.genderCollectionView.delegate = self
        self.genderCollectionView.dataSource = self
        self.genderCollectionView.collectionViewLayout = layout
        self.genderCollectionView.reloadData()
        self.genderCollectionView.collectionViewLayout.invalidateLayout()
        self.genderCollectionView!.layoutSubviews()
        self.genderCollectionViewHeight.constant = tagHeight
        if self.genderArray.count > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.genderCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getCustomerRelationAddPerson(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.postCustomerRelationAddPerson(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 {
                    self.postCustomerRelationGetPerson(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCustomerRelationAddPerson(retryAPIID: Int, canShowLoader: Bool) {
        self.quickTestAddUserViewModel.getCustomerRelationAddPerson(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCustomerRelationAddPerson, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postCustomerRelationAddPerson(retryAPIID: Int, canShowLoader: Bool) {
        var param = ""
        if self.isEdit == true {
            param = String(format: "uid=%@&name=%@&dob=%@&gender=%@&relationship_type=%@&relationship=%@", uid, self.selectNameTextField.text!.allowSpecialCharacters, self.selectDOBTextField.text!.allowSpecialCharacters, self.genderSlug, self.relationShipSlug, self.selectRelationshipTextField.text!.allowSpecialCharacters)
        } else {
            param = String(format: "name=%@&dob=%@&gender=%@&relationship_type=%@&relationship=%@", self.selectNameTextField.text!.allowSpecialCharacters, self.selectDOBTextField.text!.allowSpecialCharacters, self.genderSlug, self.relationShipSlug, self.selectRelationshipTextField.text!.allowSpecialCharacters)
        }
        self.quickTestAddUserViewModel.postCustomerRelationAddPerson(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postCustomerRelationAddPerson, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postCustomerRelationGetPerson(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.postCustomerRelationGetPerson)\(uid)/"
        self.quickTestAddUserViewModel.postCustomerRelationGetPerson(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction

    @IBAction func addButtonPressed(_ sender: UIButton) {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.newGuestpatientList.append(PatientList(
                id: nil,
                uid: nil,
                customerUid: nil,
                name: self.selectNameTextField.text ?? "",
                age: nil,
                dob: self.selectDOBTextField.text ?? "",
                gender: self.genderSlug,
                relationship: self.selectRelationshipTextField.text ?? "",
                relationshipType: self.relationShipSlug))
            self.navigateBackToGuestQuickTestProfileViewController(newGuestpatientList:self.newGuestpatientList)
        } else {
            self.commonAPICALL(retryAPIID: 1001)
        }
    }
    @IBAction func cancelPickerDateAction(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    @IBAction func donePickerDateAction(_ sender: UIButton) {
        self.view.endEditing(true)
    }

    // MARK: - Custom Methods
    @objc func selectDOBMethod(_ sender: AnyObject) {
        self.selectDOBTextField.becomeFirstResponder()
    }
    @objc func selectRelationshipTypeMethod(_ sender: AnyObject) {
        self.selectRelationshipTextField.becomeFirstResponder()
    }
    @objc func toClosePicker() {
        self.view.endEditing(true)
    }
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if self.selectRelationshipTypeTextField.text.isNilOrEmpty || self.selectRelationshipTextField.text.isNilOrEmpty || self.selectNameTextField.text.isNilOrEmpty || self.selectDOBTextField.text.isNilOrEmpty || self.genderSlug.isEmpty || self.relationShipSlug.isEmpty {
                self.setButtonDisable()
            } else {
                self.setButtonEnable()
            }
        }
    }
    func setButtonDisable() {
        self.addButton.isUserInteractionEnabled = false
        self.addButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.addButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.addButton.setNeedsDisplay()
        self.addButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.addButton.isUserInteractionEnabled = true
        self.addButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.addButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.addButton.setNeedsDisplay()
        self.addButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setDatePicker() {
        self.datePicker.datePickerMode = .date
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        components.day = self.componentsDay
        let minimumDate: Date = calendar.date(byAdding: components, to: currentDate)!
        self.datePicker.maximumDate = minimumDate
        self.datePicker.addTarget(self, action: #selector(self.toolDoneDatePicker), for: .valueChanged)
        if #available(iOS 14.0, *) {
            self.datePicker.preferredDatePickerStyle = .inline
            self.datePicker.sizeToFit()
        }
        let rect = CGRect(x: 0, y: 0, width: Int(screenFrameWidth), height: 450)
        let pickerWrapperView = UIView(frame: rect)
        pickerWrapperView.addSubview(self.datePicker)
        // Adding constraints
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.datePicker.leadingAnchor.constraint(equalTo: pickerWrapperView.leadingAnchor).isActive = true
        self.datePicker.trailingAnchor.constraint(equalTo: pickerWrapperView.trailingAnchor).isActive = true
        self.datePicker.topAnchor.constraint(equalTo: pickerWrapperView.topAnchor).isActive = true
        self.datePicker.bottomAnchor.constraint(equalTo: pickerWrapperView.bottomAnchor).isActive = true
        self.selectDOBTextField.inputView = pickerWrapperView
        // ToolBar
        let toolBarDate = UIToolbar(frame: CGRect(x: 0, y: 0, width: Int(screenFrameWidth), height: 44))
        toolBarDate.barStyle = .default
        toolBarDate.isTranslucent = true
        toolBarDate.sizeToFit()
        // Adding Button ToolBar
        let lblDate = UILabel()
        lblDate.text = AppLocalizationString.selectDate
        lblDate.sizeToFit()
        lblDate.backgroundColor = .clear
        lblDate.textColor = UIColor.colorLiteral.theme_blue_112F70
        lblDate.textAlignment = .center
        let lblDateTitle = UIBarButtonItem.init(customView: lblDate)
        let btnCancelDate = UIBarButtonItem(title: AppLocalizationString.cancel, style: .plain, target: self, action: #selector(self.cancelPickerDateAction(_:)))
        let btnDoneDate = UIBarButtonItem(title: AppLocalizationString.done, style: .plain, target: self, action: #selector(self.donePickerDateAction(_:)))
        let btnSpaceDate = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBarDate.setItems([btnCancelDate, btnSpaceDate, lblDateTitle, btnSpaceDate, btnDoneDate], animated: false)
        toolBarDate.isUserInteractionEnabled = true
        self.selectDOBTextField.inputAccessoryView = toolBarDate
    }

    @objc func toolDoneDatePicker() {
        self.dateFormatter.dateFormat = AppConstantValue.regularDateFormat
        self.selectDOBTextField.text = self.dateFormatter.string(from: self.datePicker.date)
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
        var maxLength = 255
        if textField == self.selectDOBTextField ||  textField == self.selectRelationshipTextField || textField == self.selectRelationshipTypeTextField {
            maxLength = 255
        } else if textField == self.selectNameTextField {
            maxLength = 50
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.nameRegEx)
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
        self.setUserInteractionButton()
    }

}

extension QuickTestAddUserViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension QuickTestAddUserViewController: ProtocolNetworkRechabilityDelegate {
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
extension QuickTestAddUserViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - UIPickerView Delegate Methods
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  self.relationShipArray.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var relationShipValue = ""
        if !(self.relationShipArray[row].value.isNilOrEmpty) {
            relationShipValue = self.relationShipArray[row].value!
        }
        return relationShipValue
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if  self.relationShipArray.count > 0 {
            if !(self.relationShipArray[row].key.isNilOrEmpty) {
                self.relationShipSlug = self.relationShipArray[row].key!
            }
            if !(self.relationShipArray[row].value.isNilOrEmpty) {
                self.selectRelationshipTypeTextField.text = self.relationShipArray[row].value!
            }
        }
    }
}
extension QuickTestAddUserViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genderArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.AddUserGenderCollectionViewCell, for: indexPath) as! AddUserGenderCollectionViewCell
        cell.configure(gender: self.genderArray[indexPath.item], selectedGenderSlug: self.genderSlug, indexpath: indexPath.item)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.genderArray.count > 0 {
            var tag = ""
            if !(self.genderArray[indexPath.item].value.isNilOrEmpty) {
                tag = self.genderArray[indexPath.item].value!
            }
            let font = AppFont.medium.size(13)
            let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
            cellWidth = 12 + size.width + 12
            cellHeight = tagHeight
        }
        self.view.layoutIfNeeded()
        self.viewWillLayoutSubviews()
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension QuickTestAddUserViewController: ProtocolAddUserGenderCollectionViewCell {
    func tagButtonPressedAddUserGenderCollectionViewCell(senderTag: Int) {
        if self.genderArray.count > 0 {
            if !(self.genderArray[senderTag].key.isNilOrEmpty) {
                self.genderSlug = self.genderArray[senderTag].key!
                self.reloadGenderCollectionView()
                self.setUserInteractionButton()
            }
        }
    }
}
