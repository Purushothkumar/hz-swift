//
//  QuickTestResultViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 08/12/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Photos


class QuickTestResultViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var userInfoView: UIView!
    @IBOutlet var userInfoNameLabel: CalloutFontLabel!
    @IBOutlet var userdescriptionLabel: FootnoteFontLabel!

    @IBOutlet var earView: UIView!
    @IBOutlet var leftEarView: UIView!
    @IBOutlet var leftEarStackView: UIStackView!
    @IBOutlet var leftEarTitleLabel: CalloutFontLabel!
    @IBOutlet var leftEarDescriptionLabel: HeadlineFontLabel!
    @IBOutlet var leftEarImageView: UIImageView!
    @IBOutlet var rightEarView: UIView!
    @IBOutlet var rightEarStackView: UIStackView!
    @IBOutlet var rightEarTitleLabel: CalloutFontLabel!
    @IBOutlet var rightEarDescriptionLabel: HeadlineFontLabel!
    @IBOutlet var rightEarImageView: UIImageView!


    @IBOutlet var testButtonView: UIView!
    @IBOutlet var testResultStackView: UIStackView!
    @IBOutlet var retakeButton: CalloutBackgroundButton!
    @IBOutlet var shareReportButton: CalloutBackgroundButton!
    @IBOutlet var DownloadReportButton: CalloutBackgroundButton!
    @IBOutlet var fhaBackButton: CalloutBackgroundButton!

    @IBOutlet var tableviewHeight: NSLayoutConstraint!
    @IBOutlet var tableview: UITableView!

    @IBOutlet var disclaimerView: UIView!
    @IBOutlet var disclaimerLabel: Caption2FontLabel!

    @IBOutlet var bannerView: UIView!
    @IBOutlet var bookAppointmentImageView: UIImageView!
    @IBOutlet var bookAppointmentButton: FootnoteBackgroundButton!

    @IBOutlet var consultAudiologistImageView: UIImageView!
    @IBOutlet var consultAudiologistButton: FootnoteBackgroundButton!


    // MARK: - Lets and Var
    var isFrom = ""

    var isHeadPhoneConnected = false
    var dictJson: NSDictionary = NSDictionary()
    var playCount: CGFloat = 1.0
    var earTestCount = 0
    var selectedEar = ""
    var quickTestResultViewModel = QuickTestResultViewModel()
    var quickTestWarningarray = [QuickTestResultModel]()

    var patientData: PatientList?
    var sessionID = ""
    var testLeftAverage = ""
    var testLeftAverageDisplay = ""
    var testLeftImpression = ""
    var testRightAverage = ""
    var testRightImpression = ""
    var testRightAverageDisplay = ""

    var descriptionmess = ""
    var recommendation = ""
    var reportLink = ""

    var name = ""
    var age = ""
    var gender = ""
    var canHideShimmering = false

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register for app state changes
//                NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
//                NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.setNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.quickTestWarningarray.count > 0 {
            self.tableviewHeight.constant = self.tableview.contentSize.height
        } else {
            self.tableviewHeight.constant = 0
        }
    }
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    @objc func appDidEnterBackground() {
//            print("App did enter background")
//            backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "DownloadReport") {
//                UIApplication.shared.endBackgroundTask(self.backgroundTask)
//                self.backgroundTask = .invalid
//            }
//        }
//
//        @objc func appWillEnterForeground() {
//            print("App will enter foreground")
//            if backgroundTask != .invalid {
//                UIApplication.shared.endBackgroundTask(backgroundTask)
//                backgroundTask = .invalid
//            }
//        }
    // MARK: -  Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_white_FFFFFF,style: StatusBarTheme.darkContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    // MARK: - Set Initial View
    func setInitialView() {
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.quickTestWarningarray = self.quickTestResultViewModel.getWarningDescription()
        self.rightEarStackView.layer.cornerRadius = AppConstantValue.cornerRadius16
        self.leftEarStackView.layer.cornerRadius = AppConstantValue.cornerRadius16

        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        let view0 = self.testResultStackView.arrangedSubviews[0]//retake/share button
        let view1 = self.testResultStackView.arrangedSubviews[1]//download button
        let view2 = self.testResultStackView.arrangedSubviews[2]//fha button

        view0.isHidden = false
        view1.isHidden = false
        view2.isHidden = true

        if self.isFrom == IsNavigateFrom.qcFRDReport.rawValue || self.isFrom == IsNavigateFrom.qcFRDUploadReport.rawValue{
            view2.isHidden = false
        }
        if self.isFrom == IsNavigateFrom.qcFRDReport.rawValue || self.isFrom == IsNavigateFrom.qcFRDUploadReport.rawValue || self.isFrom == IsNavigateFrom.qcMenuReport.rawValue{
            self.navigationBar.isRightViewHidden = false
        }
        self.navigationBar.leftImage = Asset.homedarkblue
        self.navigationBar.rightImage = Asset.xlargeblue
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.hearingHealthReport.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF,titleTextColor: UIColor.colorLiteral.theme_blue_112F70)
    }

    // MARK: - Localization String
    func changeLanguageFormat() {
        self.userdescriptionLabel.text = AppLocalizationString.hearingHealthReport
        self.retakeButton.setTitle(AppLocalizationString.retakeTest.uppercased(), for: .normal)
        self.shareReportButton.setTitle(AppLocalizationString.shareReport.uppercased(), for: .normal)
        self.fhaBackButton.setTitle(AppLocalizationString.gotoFindtherightdevice.uppercased(), for: .normal)
        self.DownloadReportButton.setTitle(AppLocalizationString.downloadReport.uppercased(), for: .normal)


        let disclaimer = AppLocalizationString.disclaimer
        let disclaimerDesc = AppLocalizationString.disclaimerdesc

        let disclaimerFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.semibold.size(13)]
        let disclaimerDescFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let combination = NSMutableAttributedString()
        let disclaimerStr = NSMutableAttributedString(string: String(format: "%@ ", disclaimer), attributes: disclaimerFontAttributes as [NSAttributedString.Key: Any])
        let disclaimerDescStr = NSMutableAttributedString(string: String(format: "%@", disclaimerDesc), attributes: disclaimerDescFontAttributes as [NSAttributedString.Key: Any])

        combination.append(disclaimerStr)
        combination.append(disclaimerDescStr)
        self.disclaimerLabel.attributedText = combination

        self.toLoadData(canHideShimmering: self.canHideShimmering)
    }
    // MARK: - Reload
    func reloadTableview() {
        if self.quickTestWarningarray.count > 0 {
            self.tableview.delegate = self
            self.tableview.dataSource = self
            self.tableview.reloadData()
        }
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getQuickCheckupData(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getQuickCheckupData(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getQuickCheckupData)\(self.sessionID)/"
        self.quickTestResultViewModel.getQuickCheckupData(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    // MARK: - IBAction
    @IBAction func retakeButtonPressed(_ sender: UIButton) {
        if self.isFrom == IsNavigateFrom.qcMenuReport.rawValue {
            self.navigateToQuickTestProfileViewController(isFrom: self.isFrom)
        }
        else if (self.isFrom == IsNavigateFrom.qcFRDReport.rawValue) || (self.isFrom == IsNavigateFrom.qcFRDUploadReport.rawValue) {
            self.navigateToQuickTestProfileViewController(isFrom: self.isFrom)
        }
        else {
            self.navigateBackToQuickTestProfileViewController()
        }
    }
    @IBAction func bookAppointmentPressed(_ sender: UIButton) {
        self.navigateToBookAppointmentLocationViewController(isFrom: IsNavigateFrom.baQuickCheck.rawValue)
    }
    @IBAction func onlineConsultAudiologistButtonPressed(_ sender: UIButton) {
        self.navigateToOnlineConsultationLocationViewController(isFrom: IsNavigateFrom.ocQuickCheck.rawValue)
    }
    @IBAction func fhaBackButtonPressed(_ sender: UIButton) {
        self.fhaRightButtonAction()
    }
    @IBAction func shareReportButtonPressed(_ sender: UIButton) {
        if !(self.reportLink.isEmpty) {
            let objectsToShare = [reportLink.checkhttpCharacter]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
        self.checkPhotoPermissions()
    }

    // MARK: - Custom Method

    func toLoadData(canHideShimmering:Bool) {
        let view0 = self.mainStackView.arrangedSubviews[0]
        let view1 = self.mainStackView.arrangedSubviews[1]

        view0.isHidden = true
        view1.isHidden = true

        self.userInfoNameLabel.text = ""
        self.userdescriptionLabel.text = ""
        self.leftEarDescriptionLabel.text = ""
        self.rightEarDescriptionLabel.text = ""

        self.name = ""
        self.age = ""
        self.gender = ""

        self.userInfoNameLabel.shimmerEffectView(canStop: canHideShimmering)
        self.userdescriptionLabel.shimmerEffectView(canStop: canHideShimmering)
        self.leftEarTitleLabel.shimmerEffectView(canStop: canHideShimmering)
        self.leftEarDescriptionLabel.shimmerEffectView(canStop: canHideShimmering)
        self.leftEarImageView.shimmerEffectView(canStop: canHideShimmering)
        self.rightEarTitleLabel.shimmerEffectView(canStop: canHideShimmering)
        self.rightEarDescriptionLabel.shimmerEffectView(canStop: canHideShimmering)
        self.rightEarImageView.shimmerEffectView(canStop: canHideShimmering)
        self.retakeButton.shimmerEffectView(canStop: canHideShimmering)
        self.shareReportButton.shimmerEffectView(canStop: canHideShimmering)
        self.fhaBackButton.shimmerEffectView(canStop: canHideShimmering)
        self.DownloadReportButton.shimmerEffectView(canStop: canHideShimmering)
        self.bookAppointmentImageView.shimmerEffectView(canStop: canHideShimmering)
        self.consultAudiologistImageView.shimmerEffectView(canStop: canHideShimmering)
        self.disclaimerLabel.shimmerEffectView(canStop: canHideShimmering)

        self.bookAppointmentButton.isHidden = !canHideShimmering
        self.consultAudiologistButton.isHidden = !canHideShimmering

        self.fhaBackButton.isUserInteractionEnabled = canHideShimmering
        self.DownloadReportButton.isUserInteractionEnabled = canHideShimmering
        self.shareReportButton.isUserInteractionEnabled = canHideShimmering
        self.retakeButton.isUserInteractionEnabled = canHideShimmering
        self.bookAppointmentButton.isUserInteractionEnabled = canHideShimmering
        self.consultAudiologistButton.isUserInteractionEnabled = canHideShimmering


        if self.patientData != nil {
            if !(self.patientData!.name.isNilOrEmpty) {
                self.name = self.patientData!.name!
                view0.isHidden = false
                self.userInfoNameLabel.text = name
            }
            if !(self.patientData!.age.isNilOrEmpty) {
                self.age =  self.patientData!.age!
            }
            if !(self.patientData!.gender.isNilOrEmpty) {
                self.gender =  self.patientData!.gender!
            }
            if !(self.age.isEmpty) && !(self.gender.isEmpty) {
                self.userdescriptionLabel.text = String(format: "%@ | %@", self.age, self.gender)
                view0.isHidden = false
            } else if !(self.age.isEmpty) || !(self.gender.isEmpty) {
                if !(self.age.isEmpty) {
                    self.userdescriptionLabel.text = String(format: "%@", self.age)
                    view0.isHidden = false
                } else if !(self.gender.isEmpty) {
                    self.userdescriptionLabel.text = String(format: "%@", self.gender)
                    view0.isHidden = false
                }
            }
        }
        if !(self.testLeftAverage.isEmpty) && !(self.testRightAverage.isEmpty) {
            let averageLeft = Int(self.testLeftAverage)!
            let averageRight = Int(self.testRightAverage)!


            if averageLeft <= 40 {
                self.leftEarImageView.image = UIImage(named: Asset.quicktestresultgood)
                self.leftEarDescriptionLabel.textColor = UIColor.colorLiteral.theme_green_27AE60
                self.testLeftAverageDisplay = "100"
            } else if averageLeft <= 55 {
                self.leftEarImageView.image = UIImage(named: Asset.quicktestresultmild)
                self.leftEarDescriptionLabel.textColor = UIColor.colorLiteral.theme_yellow_FFD426
                self.testLeftAverageDisplay = "75"
            } else if averageLeft <= 70 {
                self.leftEarImageView.image = UIImage(named: Asset.quicktestresultmoderate)
                self.leftEarDescriptionLabel.textColor = UIColor.colorLiteral.theme_orange_F7732F
                self.testLeftAverageDisplay = "50"
            } else if averageLeft > 70 {
                self.leftEarImageView.image = UIImage(named: Asset.quicktestresultacute)
                self.leftEarDescriptionLabel.textColor = UIColor.colorLiteral.theme_red_FF6961
                self.testLeftAverageDisplay = "25"
            }
            if averageRight <= 40 {
                self.rightEarImageView.image = UIImage(named: Asset.quicktestresultgood)
                self.rightEarDescriptionLabel.textColor = UIColor.colorLiteral.theme_green_27AE60
                self.testRightAverageDisplay = "100"
            } else if averageRight <= 55 {
                self.rightEarImageView.image = UIImage(named: Asset.quicktestresultmild)
                self.rightEarDescriptionLabel.textColor = UIColor.colorLiteral.theme_yellow_FFD426
                self.testRightAverageDisplay = "75"
            } else if averageRight <= 70 {
                self.rightEarImageView.image = UIImage(named: Asset.quicktestresultmoderate)
                self.rightEarDescriptionLabel.textColor = UIColor.colorLiteral.theme_orange_F7732F
                self.testRightAverageDisplay = "50"
            } else if averageRight > 70 {
                self.rightEarImageView.image = UIImage(named: Asset.quicktestresultacute)
                self.rightEarDescriptionLabel.textColor = UIColor.colorLiteral.theme_red_FF6961
                self.testRightAverageDisplay = "25"
            }
            if (self.testLeftAverage.isEmpty){
                self.leftEarTitleLabel.text = ""
            }else{
                self.leftEarTitleLabel.text = String(format: "%@%@",AppLocalizationString.myLeftEarScore,testLeftAverageDisplay)
            }
            if (self.testRightAverage.isEmpty){
                self.rightEarTitleLabel.text = ""
            }else{
                self.rightEarTitleLabel.text = String(format: "%@%@",AppLocalizationString.myRightEarScore,testRightAverageDisplay)
            }
            self.leftEarDescriptionLabel.text = testLeftImpression
            self.rightEarDescriptionLabel.text = testRightImpression
            view1.isHidden = false
        }
        self.reloadTableview()
    }
    func fhaRightButtonAction(){
        if (self.isFrom == IsNavigateFrom.qcFRDReport.rawValue) || (self.isFrom == IsNavigateFrom.qcFRDUploadReport.rawValue) {
            self.navigateBackToFindRightDeviceUploadReportViewController()
        }
        else if (self.isFrom == IsNavigateFrom.qcMenuReport.rawValue){
            self.navigateBackToAudiogramReportViewController()
        }
    }

    //check and write permission
    func checkPhotoPermissions() {
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
        case .authorized, .limited:
                self.downloadReportFromURL()
            break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized || newStatus == .limited {
                        self.downloadReportFromURL()
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
    func downloadReportFromURL(){
        if !(self.reportLink.isEmpty) {
            guard let imageUrl = URL(string: self.reportLink) else {
                print("Invalid URL")
                return
            }
            self.downloadAndSaveImage(from: imageUrl) { error in
                if let error = error {
                    DispatchQueue.main.async {
                        print("Failed to download and save image:", error.localizedDescription)
                        self.showToastAlert(AppLocalizationString.downloadReportFailure, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showToastAlert(AppLocalizationString.downloadReportSuccess, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: self)
                    }
                }
            }
        }else{
            self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    func downloadAndSaveImage(from url: URL, completion: @escaping (Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(NSError(domain: "HTTP Error", code: 0, userInfo: nil))
                return
            }
            guard let imageData = data else {
                completion(NSError(domain: "No data", code: 0, userInfo: nil))
                return
            }
            // Convert downloaded data into UIImage
            guard let image = UIImage(data: imageData) else {
                completion(NSError(domain: "Invalid image data", code: 0, userInfo: nil))
                return
            }
            // Save image to photo gallery
            PHPhotoLibrary.shared().performChanges {
                let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
                // Optionally, you can specify an album name here by creating a PHAssetCollection and using `addAssets` method
            } completionHandler: { success, error in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }

        }.resume()
    }
}
extension QuickTestResultViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    func rightButtonPressed() {
        self.fhaRightButtonAction()
    }
}
extension QuickTestResultViewController: ProtocolNetworkRechabilityDelegate {
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
extension QuickTestResultViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quickTestWarningarray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.QuickTestResultDescriptionTableViewCell, for: indexPath) as! QuickTestResultDescriptionTableViewCell
        cell.configure(quickTestResultModel: self.quickTestWarningarray[indexPath.row], indexpath: indexPath.row,canHideShimmering:self.canHideShimmering)
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableviewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
enum DownloadError: Error {
    case invalidResponse
    case other(Error)
}


