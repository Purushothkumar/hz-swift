//
//  FindRightDeviceUploadReportViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 19/07/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import PDFKit
import PhotosUI
import MobileCoreServices

class FindRightDeviceUploadReportViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate, PHPickerViewControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var sixDotCircleView: SixDotCircleView!
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!

    @IBOutlet var tableView: UITableView!

    @IBOutlet var nextView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!
    @IBOutlet var skipButton: FootnoteOutlineButton!

    // MARK: - Lets and Var
    var findRightDeviceUploadReportViewModel = FindRightDeviceUploadReportViewModel()

    var isFrom = ""
    var patientUid = ""
    var sessionID = ""

    var sessionUID = ""
    var isImage = ""
    var sessionKey = ""

    var reportList = [FindRightDeviceReportModelAudiogramTestReport]()

    var pickerController = UIImagePickerController()
    var strImageBase64 = ""
    var imgData: Data?

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
        self.tableView.backgroundColor = UIColor.white
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.tableView.clipsToBounds = true
        self.reloadTableView()
        self.setButtonUserInteraction()
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
        self.sixDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.recordcircleblue, button3image: Asset.circlegrey, button4image: Asset.circlegrey, button5image: Asset.circlegrey, button6image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.FHAStep5Title.capitalized
        let descriptionMessage = AppLocalizationString.FHAStep5Desc.capitalized

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
        self.nextButton.setTitle(AppLocalizationString.next.uppercased(), for: .normal)
        self.skipButton.setTitle(AppLocalizationString.skip.uppercased(), for: .normal)
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
                    self.getFindRightDeviceUploadReportList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.postUploadReport(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getFindRightDeviceUploadReportList(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getFindRightDeviceUploadReportList)\(self.patientUid)/"
        self.findRightDeviceUploadReportViewModel.getFindRightDeviceUploadReportList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    func postUploadReport(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "report=%@&patient_uid=%@&is_image=%@", self.strImageBase64.allowSpecialCharacters, self.patientUid, self.isImage)
        self.findRightDeviceUploadReportViewModel.postUploadReport(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postUploadReport, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.navigateToNext(session_UID: self.sessionUID,session_Key:self.sessionKey)
    }
    @IBAction func skipEarButtonPressed(_ sender: UIButton) {
        self.navigateToNext(session_UID: "",session_Key: "")
    }

    // MARK: - Custom Methods
    func setButtonUserInteraction() {
        if self.sessionUID.isEmpty {
            self.setButtonDisable()
        } else {
            self.setButtonEnable()
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
    func navigateToNext(session_UID: String, session_Key:String){
        self.navigateToFindRightDeviceStyleViewController(isFrom: self.isFrom, patientUid: self.patientUid, sessionID: sessionID, sessionUID: session_UID, sessionKey: session_Key)
    }
    func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
        guard let data = try? Data(contentsOf: url),
              let page = PDFDocument(data: data)?.page(at: 0) else {
            return nil
        }

        let pageSize = page.bounds(for: .mediaBox)
        let pdfScale = width / pageSize.width

        // Apply if you're displaying the thumbnail on screen
        let scale = UIScreen.main.scale * pdfScale
        let screenSize = CGSize(width: pageSize.width * scale,
                                height: pageSize.height * scale)

        return page.thumbnail(of: screenSize, for: .mediaBox)
    }

    func openPicture() {
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: "", message: AppLocalizationString.addReport, preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: AppLocalizationString.takePhoto, style: .default, handler: { (_) in
                self.checkCameraPermission()
            })
            let gallery = UIAlertAction(title: AppLocalizationString.chooseFromGallery, style: .default) { (_) in
                self.checkPhotoPermission()
            }
            let file = UIAlertAction(title: AppLocalizationString.chooseFromDocuments, style: .default) { (_) in
                self.openPDFFiles()
            }
            let cancel = UIAlertAction(title: AppLocalizationString.cancel, style: .cancel) { (_) in
            }
            alertViewController.addAction(camera)
            alertViewController.addAction(gallery)
            alertViewController.addAction(file)
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
                } else {}
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
    func openPDFFiles() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.modalPresentationStyle = .fullScreen
        self.present(documentPicker, animated: true, completion: nil)
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
    func checkQuickCheckReportVerifiedUser(sessionUID:String) {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginFRDViewReportQuickCheck.rawValue, isWishlist: false, productUID: sessionUID)
        } else {
            self.navigateToQuickTestResultViewController(isFrom: IsNavigateFrom.qcFRDReport.rawValue, sessionID: sessionUID)
        }
    }
    func verifiedQuickCheckViewReportUser(isFrom: String, isWishlist: Bool, productUID: String) {
        if isFrom == IsNavigateFrom.loginFRDViewReportQuickCheck.rawValue {
            self.checkQuickCheckReportVerifiedUser(sessionUID:productUID)
        }
    }
    // MARK: - Document Picker Controller Delegate
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let url_string = url.relativePath
        let documentFileURL = Bundle.main.url(forResource: url.absoluteString, withExtension: "pdf")
        if url_string.isEmpty {
            controller.dismiss(animated: true, completion: {
                self.showToastAlert(AppLocalizationString.pleasetryagainuploadreportfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            })
        } else {
            do {
                let fileData = try Data.init(contentsOf: url)
                let fileStream: String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
                let pdfData = Data(base64Encoded: fileStream, options: .ignoreUnknownCharacters)
                controller.dismiss(animated: true, completion: {
                    
                    if pdfData == nil {
                        self.showToastAlert(AppLocalizationString.pleasetryagainuploadreportfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                    } else {
                        if !(url.lastPathComponent.isEmpty) {
                            do {
                                // Convert the Data to Base64 string
                                self.strImageBase64 = pdfData!.base64EncodedString(options: [])
                                if self.strImageBase64.count > 0 && !self.strImageBase64.isEmpty {
                                    self.isImage = "0"
                                    self.commonAPICALL(retryAPIID: 1001)
                                } else {
                                    self.showToastAlert(AppLocalizationString.imageuploadfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                                    return
                                }
                            } catch {
                                self.showToastAlert(AppLocalizationString.pleasetryagainuploadreportfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                                return
                            }
                        }
                    }
                })
            } catch {}
        }
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
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
                        self.isImage = "1"
                        self.commonAPICALL(retryAPIID: 1001)
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
                                    self.commonAPICALL(retryAPIID: 1001)
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
extension FindRightDeviceUploadReportViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension FindRightDeviceUploadReportViewController: ProtocolNetworkRechabilityDelegate {
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
extension FindRightDeviceUploadReportViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if self.reportList.count > 0 {
                return self.reportList.count
            } else {
                return 1
            }
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0  {
            if self.reportList.count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindRightDeviceReportTableViewCell, for: indexPath) as! FindRightDeviceReportTableViewCell
                cell.configure(audiogramTestReport: reportList[indexPath.row], indexPath: indexPath.row, viewCon: self)
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindRightDeviceEmptyReportTableViewCell, for: indexPath) as! FindRightDeviceEmptyReportTableViewCell
                return cell
            }
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindRightDeviceReportBannerTableViewCell, for: indexPath) as! FindRightDeviceReportBannerTableViewCell
            cell.delegate = self
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension FindRightDeviceUploadReportViewController: ProtocolFindRightDeviceReportBannerTableViewCell, ProtocolFindRightDeviceReportTableViewCell {
    func quickTestButtonPressedFindRightDeviceReportBannerTableViewCell(senderTag: Int) {
        self.navigateToQuickTestProfileViewController(isFrom:  IsNavigateFrom.qcFRDUploadReport.rawValue)
    }
    func bookAppointmentPressedFindRightDeviceReportBannerTableViewCell(senderTag: Int) {
        self.navigateToBookAppointmentLocationViewController(isFrom: IsNavigateFrom.baFRDUploadReport.rawValue)
    }
    func tapButtonPressedFindRightDeviceReportTableViewCell(senderTag: Int) {
        if self.reportList.count > 0 {
            if !(self.reportList[senderTag].sessionUid.isNilOrEmpty) {
                if self.sessionUID == self.reportList[senderTag].sessionUid! {
                    self.sessionUID = ""
                    self.sessionKey = ""
                } else {
                    self.sessionUID = self.reportList[senderTag].sessionUid!
                    self.sessionUID = ""
                    self.sessionKey = ""
                    if !(self.reportList[senderTag].sessionUid.isNilOrEmpty) {
                        self.sessionUID = self.reportList[senderTag].sessionUid!
                    }
                    if !(self.reportList[senderTag].sessionKey.isNilOrEmpty) {
                        self.sessionKey = self.reportList[senderTag].sessionKey!
                    }
                }
                self.reloadTableView()
                self.setButtonUserInteraction()
            }
        }
    }
    func viewReportButtonPressedFindRightDeviceReportTableViewCell(senderTag: Int) {
        if self.reportList.count > 0 {
            var reportLink = ""
            var reportRedirectionType = ""
            if !(self.reportList[senderTag].sessionKey.isNilOrEmpty) {
                reportRedirectionType = self.reportList[senderTag].sessionKey!
                if (reportRedirectionType == "quick_test"){
                    if !(self.reportList[senderTag].sessionUid.isNilOrEmpty) {
                        let sessionID = self.reportList[senderTag].sessionUid!
                        if !(sessionID.isEmpty) {
                            self.checkQuickCheckReportVerifiedUser(sessionUID: sessionID)
                        } else {
                            // empty msg
                            self.noLinkAlert()
                        }
                    } else {
                        // empty msg
                        self.noLinkAlert()
                    }
                }
                else if (reportRedirectionType == "audiogram"){
                    if !(self.reportList[senderTag].reportLink.isNilOrEmpty) {
                        reportLink = self.reportList[senderTag].reportLink!
                        if !(reportLink.isEmpty) {
                            guard let appURL = URL(string: reportLink.checkhttpCharacter) else {
                                // url error msg
                                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                                return
                            }
                            if UIApplication.shared.canOpenURL(appURL) {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                                } else {
                                    UIApplication.shared.openURL(appURL)
                                }
                            } else {
                                // error msg
                                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)           }
                        } else {
                            // empty msg
                            self.noLinkAlert()
                        }
                    } else {
                        // empty msg
                        self.noLinkAlert()
                    }
                }
                else{
                    self.showToastAlert(AppLocalizationString.reportInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                }
            }
        }
    }
    func selectButtonPressedFindRightDeviceUploadReportTableViewCell(senderTag: Int) {
        self.openPicture()
    }
    func noLinkAlert(){
        self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
    }
}
