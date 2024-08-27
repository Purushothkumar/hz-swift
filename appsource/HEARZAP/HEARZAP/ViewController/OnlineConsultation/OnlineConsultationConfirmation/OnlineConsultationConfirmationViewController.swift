//
//  OnlineConsultationConfirmationViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 30/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

class OnlineConsultationConfirmationViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var confirmationImageView: UIImageView!

    @IBOutlet var titleLabel: CalloutFontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!

    @IBOutlet var bookingTitleLabel: FootnoteFontLabel!

    @IBOutlet var bookingInfoStackView: UIStackView!

    @IBOutlet var bookingIDTitleLabel: Caption1FontLabel!
    @IBOutlet var bookingIDLabel: Caption1FontLabel!

    @IBOutlet var bookingDateTitleLabel: Caption1FontLabel!
    @IBOutlet var bookingDateLabel: Caption1FontLabel!

    @IBOutlet var serviceDetailsQtyView: UIView!
    @IBOutlet var serviceDetailsQtyTableView: UITableView!
    @IBOutlet var serviceDetailsQtyTableViewHeight: NSLayoutConstraint!

    @IBOutlet var bookingTimeTitleLabel: Caption1FontLabel!
    @IBOutlet var bookingTimeLabel: Caption1FontLabel!

    @IBOutlet var scheduleDateTitleLabel: Caption1FontLabel!
    @IBOutlet var scheduleDateLabel: Caption1FontLabel!

    @IBOutlet var addToCalendarButton: FootnoteOutlineButton!
    @IBOutlet var viewDetailsButton: FootnoteOutlineButton!

    @IBOutlet var onlineConsultationDetailsTitleLabel: FootnoteFontLabel!

    @IBOutlet var onlineConsultationInfoStackView: UIStackView!

    @IBOutlet var onlineConsultationDetailsDescLabel: Caption1FontLabel!
    @IBOutlet var joinNowButton: CalloutBackgroundButton!

    @IBOutlet var linkView: UIView!
    @IBOutlet var linkLabel: Caption1FontLabel!

    @IBOutlet var policyLabel: Caption2FontLabel!
    @IBOutlet var policyButton: FootnoteOutlineButton!

    var serviceRequestsListArray = [ServiceRequestsList]()

    // MARK: - Lets and Var
    var onlineConsultationConfirmationViewModel = OnlineConsultationConfirmationViewModel()

    var isFrom = ""
    var bookingUid = ""

    var meetingLink = ""
    var scheduleDate = ""
    var timeSlot = ""
    var bookedDate = ""
    var serviceDate = ""
    var serviceLocation = ""
    var startTime = ""
    var endTime = ""

    var enableJoinBtn = false
    var canShowJoinBtn = false

    let store = EKEventStore()

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
        if self.serviceRequestsListArray.count > 0 {
            self.serviceDetailsQtyTableViewHeight.constant = self.serviceDetailsQtyTableView.contentSize.height
        } else {
            self.serviceDetailsQtyTableViewHeight.constant = 0
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

        let view0 = self.mainStackView.arrangedSubviews[0]// banner Image
        let view1 = self.mainStackView.arrangedSubviews[1]// Title
        let view2 = self.mainStackView.arrangedSubviews[2]// booking title
        let view3 = self.mainStackView.arrangedSubviews[3]// booking
        let view4 = self.mainStackView.arrangedSubviews[4]// online consultation title
        let view5 = self.mainStackView.arrangedSubviews[5]// online consultation
        let view6 = self.mainStackView.arrangedSubviews[6]// policy title
        let view7 = self.mainStackView.arrangedSubviews[7]// policy button

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        view6.isHidden = true
        view7.isHidden = true

        self.serviceDetailsQtyTableView.tableFooterView = UIView()
        self.serviceDetailsQtyTableView.separatorColor = UIColor.clear
        self.serviceDetailsQtyTableView.backgroundColor = UIColor.clear
        self.serviceDetailsQtyTableView.rowHeight = UITableView.automaticDimension
        self.serviceDetailsQtyTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadServiceDetailsQtyTableView()

        self.addToCalendarButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.addToCalendarButton.layer.borderWidth = 1.0
        self.addToCalendarButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor

        self.linkView.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.linkView.layer.borderWidth = 2.0

        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.homewhite
//        self.navigationBar.rightImage = Asset.xlargewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.consultAudiologistOnline
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }

    // MARK: - Localization String
    func changeLanguageFormat() {
        self.titleLabel.text = AppLocalizationString.yourappointmentisready
        self.bookingTitleLabel.text = AppLocalizationString.bookingDetails
        self.bookingIDTitleLabel.text = AppLocalizationString.bookingID
        self.bookingDateTitleLabel.text = AppLocalizationString.bookingDate
        self.bookingTimeTitleLabel.text = AppLocalizationString.appointmentTime
        self.scheduleDateTitleLabel.text = AppLocalizationString.appointmentDate

        self.onlineConsultationDetailsTitleLabel.text = AppLocalizationString.onlineConsultationDetails
        self.onlineConsultationDetailsDescLabel.text = AppLocalizationString.pleasejoinandspeaktoaudiologist
        self.policyLabel.text = AppLocalizationString.confirmationPolicy
        self.addToCalendarButton.setTitle(AppLocalizationString.addToCalendar.uppercased(), for: .normal)
        self.viewDetailsButton.setTitle(AppLocalizationString.viewDetails.uppercased(), for: .normal)
        self.policyButton.setTitle(AppLocalizationString.viewcancellationpolicy.capitalized, for: .normal)
        self.joinNowButton.setTitle(AppLocalizationString.joinNow.uppercased(), for: .normal)

    }
    // MARK: - Reload
    func reloadServiceDetailsQtyTableView() {
        self.serviceDetailsQtyTableView.delegate = self
        self.serviceDetailsQtyTableView.dataSource = self
        self.serviceDetailsQtyTableView.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getBookingConfirmation(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getBookingConfirmation(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getBookingConfirmation)\(bookingUid)/"
        self.onlineConsultationConfirmationViewModel.getBookingConfirmation(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func addtoCalenderButtonPressed(_ sender: UIButton) {
        self.addToCalendar()
    }
    @IBAction func viewDetailsButtonPressed(_ sender: UIButton) {
        self.navigateToServiceRequestDetailViewController(isFrom: IsNavigateFrom.srdOnlineConsulationSuccess.rawValue, bookingUid: self.bookingUid)
    }
    @IBAction func joinNowButtonPressed(_ sender: UIButton) {
        if !(self.meetingLink.isEmpty) {
            guard let appURL = URL(string: meetingLink.checkhttpCharacter) else {
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
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func copyButtonPressed(_ sender: UIButton) {
        if !(self.meetingLink.isEmpty) {
            UIPasteboard.general.string = self.meetingLink
            self.showToastAlert(AppLocalizationString.linkCopied, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: self)

        } else {
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func policyButtonPressed(_ sender: UIButton) {
        self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseOCConfirmation.rawValue)
    }
    // MARK: - Custom Method
    @objc func addToCalendar() {
        self.checkCalendarPermission()
    }

    func showAlertToAddToCalendar() {
        let alertViewController = UIAlertController(title: AppLocalizationString.addToCalendar, message: AppLocalizationString.calendarPermission, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: AppLocalizationString.yes.capitalized, style: .default, handler: { (_) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        let cancelBtn = UIAlertAction(title: AppLocalizationString.no.capitalized, style: .cancel) { (_) in
        }
        alertViewController.addAction(cancelBtn)
        alertViewController.addAction(okBtn)
        self.present(alertViewController, animated: true, completion: nil)
    }

    func checkCalendarPermission() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            self.insertEvent()
            break
        case .denied:
            self.showAlertToAddToCalendar()
            break
        case .notDetermined:
            // 3
//            self.store.requestAccess(to: .event, completion: {(granted: Bool, _: Error?) -> Void in
//                if granted {
//                    self.insertEvent()
//                } else {
//                    self.showAlertToAddToCalendar()
//                }
//            })
            break
        default:
break        }
    }

    func insertEvent() {
        DispatchQueue.main.async {
            let event = EKEvent(eventStore: self.store)
            event.calendar = self.store.defaultCalendarForNewEvents

            let startDate = "\(self.scheduleDate) \(self.startTime)"
            let endDate = "\(self.scheduleDate) \(self.endTime)"
            event.title = AppLocalizationString.addtocalendarTitle
            event.startDate = self.formattedDateFromString(dateString: startDate)
            event.notes = ""
            event.endDate = self.formattedDateFromString(dateString: endDate)
            event.location = ""
            do {
                try self.store.save(event, span: .thisEvent)
                self.showToastAlert(AppLocalizationString.bookingAddedSuccessfully, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: self)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func formattedDateFromString(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = .current
        let dateFromString = dateFormatter.date(from: dateString)
        return dateFromString
    }
}

extension OnlineConsultationConfirmationViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    func rightButtonPressed() {}
}
extension OnlineConsultationConfirmationViewController: ProtocolNetworkRechabilityDelegate {
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
extension OnlineConsultationConfirmationViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serviceRequestsListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.OnlineConsultationPaymentQuantityTableViewCell, for: indexPath) as! OnlineConsultationPaymentQuantityTableViewCell
        cell.configure(serviceRequestsList: self.serviceRequestsListArray[indexPath.row], indexpath: indexPath.row)
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.serviceDetailsQtyTableViewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
