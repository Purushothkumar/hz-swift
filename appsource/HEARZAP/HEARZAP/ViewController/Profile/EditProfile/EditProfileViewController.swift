//
//  EditProfileViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 15/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Photos
import AVFoundation
import BottomPopup
import PhotosUI

class EditProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var profileView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var editProfileButton: FootnoteOutlineButton!

    @IBOutlet var selectNameView: UIView!
    @IBOutlet var selectNameLabel: Caption2FontLabel!
    @IBOutlet var selectNameTextField: Caption1FontTextfield!

    @IBOutlet var selectGenderView: UIView!
    @IBOutlet var selectGenderLabel: Caption2FontLabel!
    @IBOutlet var genderCollectionView: UICollectionView!
    @IBOutlet var genderCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var selectDOBView: UIView!
    @IBOutlet var selectDOBLabel: Caption2FontLabel!
    @IBOutlet var selectDOBTextField: Caption1FontTextfield!

    @IBOutlet var buttonView: UIView!
    @IBOutlet var cancelButton: FootnoteOutlineButton!
    @IBOutlet var updateButton: FootnoteBackgroundButton!

    // MARK: - Lets and Var
    let editProfileViewModel = EditProfileViewModel()
    var activeField = UITextField()
    var datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    var componentsDay = 0

    var genderArray = [GenderRelationModelGender]()

    var uid = ""
    var name = ""
    var dob = ""
    var genderSlug = ""
    var photo = ""

    var pickerController = UIImagePickerController()
    var strImageBase64 = ""
    var imgData: Data?

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

        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        self.cancelButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.cancelButton.layer.borderWidth = 1.0
        self.cancelButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.cancelButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.cancelButton.clipsToBounds = true

        self.selectNameTextField.setLeftPaddingPoints(5.0)
        self.selectNameTextField.setRightPaddingPoints(5.0)

        self.selectDOBTextField.setLeftPaddingPoints(5.0)
        self.selectDOBTextField.setRightPaddingPoints(30.0)

        self.selectNameTextField.delegate = self
        self.selectDOBTextField.delegate = self

        if !(self.dob.isEmpty) {
            let datefmt = self.dob.toDate(format: AppConstantValue.apiDateFormat)
            if datefmt != nil {
                let formatter = DateFormatter()
                formatter.dateFormat = AppConstantValue.regularDateFormat
                self.dob = formatter.string(from: datefmt!)
            }
        }

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: AppLocalizationString.done, style: .plain, target: self, action: #selector(toClosePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)

        [self.selectNameTextField, self.selectDOBTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        self.setDatePicker()
        self.setUserInteractionButton()
        self.selectNameTextField.text = self.name
        self.selectDOBTextField.text = self.dob
        self.profileImageView.setImage(imageUrl: self.photo, placeHolderImage: profileBlue)
        self.reloadGenderCollectionView()
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.editProfile
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.selectNameTextField.placeholder = AppLocalizationString.pleaseenterthename
        self.selectDOBTextField.placeholder = AppLocalizationString.pleaseSelectDate
        self.selectNameLabel.text = AppLocalizationString.namestar

        self.selectGenderLabel.text = AppLocalizationString.gender
        self.cancelButton.setTitle(AppLocalizationString.cancel.uppercased(), for: .normal)
        self.updateButton.setTitle(AppLocalizationString.update.uppercased(), for: .normal)

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
                    self.postProfileInformation(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 {
                    self.postProfilePhoto(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCustomerRelationAddPerson(retryAPIID: Int, canShowLoader: Bool) {
        self.editProfileViewModel.getCustomerRelationAddPerson(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCustomerRelationAddPerson, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postProfileInformation(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "name=%@&dob=%@&gender=%@", self.selectNameTextField.text!.allowSpecialCharacters, self.selectDOBTextField.text!.allowSpecialCharacters, self.genderSlug)
        self.editProfileViewModel.postProfileInformation(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postProfileInformation, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postProfilePhoto(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "photo=%@", self.strImageBase64.allowSpecialCharacters)
        self.editProfileViewModel.postProfilePhoto(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postProfilePhoto, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.navigateBackToViewController()
    }
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1001)
    }
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        self.openPicture()
    }
    @IBAction func cancelPickerDateAction(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    @IBAction func donePickerDateAction(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    // MARK: - Custom Methods
    @objc func toClosePicker() {
        self.view.endEditing(true)
    }
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if  self.selectNameTextField.text.isNilOrEmpty || self.selectDOBTextField.text.isNilOrEmpty || self.genderSlug.isEmpty {
                self.setButtonDisable()
            } else {
                self.setButtonEnable()
            }
        }
    }
    func setButtonDisable() {
        self.updateButton.isUserInteractionEnabled = false
        self.updateButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.updateButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.updateButton.setNeedsDisplay()
        self.updateButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.updateButton.isUserInteractionEnabled = true
        self.updateButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.updateButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.updateButton.setNeedsDisplay()
        self.updateButton.layoutIfNeeded()
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

    func openPicture() {
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: "", message: AppLocalizationString.addPhoto, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: AppLocalizationString.takePhoto, style: .default, handler: { (_) in
                self.checkCameraPermission()
            })
            let gallery = UIAlertAction(title: AppLocalizationString.chooseFromGallery, style: .default) { (_) in
                self.checkPhotoPermission()
            }
            let cancel = UIAlertAction(title: AppLocalizationString.cancel, style: .cancel) { (_) in
            }
            alertViewController.addAction(camera)
            alertViewController.addAction(gallery)
            alertViewController.addAction(cancel)
            self.present(alertViewController, animated: true, completion: nil)
        }
    }

    func checkCameraPermission() {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        switch cameraAuthorizationStatus {
        case .denied: break
        case .authorized:
            self.openCamera()
            break
        case .restricted: break
        case .notDetermined:
            // Prompting user for the permission to use the camera.
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                if granted {
                    self.openCamera()
                } else {
                }
            }
            break
        @unknown default:
            fatalError()
            break
        }
    }

    func checkPhotoPermission() {
            if #available(iOS 14, *) {
                let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
                self.handleAuthorizationStatus(status)
            } else {
                let status = PHPhotoLibrary.authorizationStatus()
                self.handleAuthorizationStatus(status)
            }
    }
    func handleAuthorizationStatus(_ status: PHAuthorizationStatus) {
        switch status {
        case .authorized:
            self.openGallery()
            break
        case .limited:
            self.openGalleryWithLimitedPermission()
            break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized || newStatus == .limited {
                    self.openGallery()
                } else if newStatus == .limited{
                    self.openGalleryWithLimitedPermission()
                } else {
                    // Handle other cases if needed
                    print("Authorization not granted. Status: \(newStatus)")
                }
            }
            break
        case .restricted:
            self.showAlertForPhotoLibraryRestricted()
            break
        case .denied:
            self.showAlertForPhotoLibraryDenied()
            break
        @unknown default:
            fatalError("Unknown authorization status")
            break
        }
    }
    func openGalleryWithLimitedPermission(){
        var config = PHPickerConfiguration()
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        config.selectionLimit = 1
        config.filter = .images
        config.filter = .any(of: [.images, .livePhotos])
        self.present(picker, animated: true)
    }

    func openCamera() {
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                self.pickerController.delegate = self
                self.pickerController.sourceType = UIImagePickerController.SourceType.camera
                self.pickerController.allowsEditing = true
                self.pickerController.modalPresentationStyle = .fullScreen

                self.present(self.pickerController, animated: true, completion: nil)
            } else {
                self.showToastAlert(AppLocalizationString.donthavecamera, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            }
        }
    }

    func openGallery() {
        DispatchQueue.main.async {
            if #available(iOS 14, *) {
                var configuration = PHPickerConfiguration()
                configuration.filter = .images
                configuration.selectionLimit = 1
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self

                self.present(picker, animated: true, completion: nil)
            } else {
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                    self.pickerController.delegate = self
                    self.pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                    self.pickerController.allowsEditing = true
                    self.pickerController.modalPresentationStyle = .fullScreen
                    self.present(self.pickerController, animated: true, completion: nil)
                } else {
                    let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
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
        if textField == self.selectDOBTextField {
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

    // MARK: - Image Picker Controller Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            picker.dismiss(animated: true) {
                self.showToastAlert(AppLocalizationString.imageuploadfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            }
            return
        }
        if image == nil {
            picker.dismiss(animated: true) {
                self.showToastAlert(AppLocalizationString.imageuploadfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            }
        } else {
            picker.dismiss(animated: true) {
                self.imgData = image.jpegData(compressionQuality: 0.2)
                if self.imgData == nil {
                    self.showToastAlert(AppLocalizationString.imageuploadfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                } else {
                    self.strImageBase64 = image.base64
                    if self.strImageBase64.count > 0 && !self.strImageBase64.isEmpty {
                        self.commonAPICALL(retryAPIID: 1002)
                    } else {
                        self.showToastAlert(AppLocalizationString.imageuploadfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                        return
                    }
                }
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    // https://github.com/marshallino16/ImageCropper
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.dismiss(animated: true) {
            if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self]  image, error in
                    DispatchQueue.main.async {
                        guard let self = self, let image = image as? UIImage else {return}
                        if error == nil {
                            self.imgData = image.jpegData(compressionQuality: 0.2)
                            if self.imgData == nil {
                                self.showToastAlert(AppLocalizationString.imageuploadfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                            } else {
                                self.strImageBase64 = image.compressImage()!.base64
                                if self.strImageBase64.count > 0 && !self.strImageBase64.isEmpty {
                                    self.commonAPICALL(retryAPIID: 1002)
                                } else {
                                    self.showToastAlert(AppLocalizationString.imageuploadfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                                    return
                                }
                            }
                        } else {
                            self.showToastAlert(AppLocalizationString.imageuploadfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                        }
                    }
                }
            }
        }
    }
}

extension EditProfileViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToProfileInformationViewController()
    }
    func rightButtonPressed() {
    }
}
extension EditProfileViewController: ProtocolNetworkRechabilityDelegate {
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
extension EditProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genderArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.EditProfileGenderCollectionViewCell, for: indexPath) as! EditProfileGenderCollectionViewCell
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

extension EditProfileViewController: ProtocolEditProfileGenderCollectionViewCell {
    func tagButtonPressedEditProfileGenderCollectionViewCell(senderTag: Int) {
        if self.genderArray.count > 0 {
            if !(self.genderArray[senderTag].key.isNilOrEmpty) {
                self.genderSlug = self.genderArray[senderTag].key!
                self.reloadGenderCollectionView()
                self.setUserInteractionButton()
            }
        }
    }
}
