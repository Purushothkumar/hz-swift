//
//  CancelServiceRequestViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 07/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolCancelServiceRequestViewController {
    func postButtonPressedCancelServiceRequestViewController()
}

class CancelServiceRequestViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: LogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var returnReasonTitleView: UIView!
    @IBOutlet var returnReasonTitleLabel: FootnoteFontLabel!

    @IBOutlet var returnReasonTableView: UITableView!
    @IBOutlet var returnReasonTableViewHeight: NSLayoutConstraint!

    @IBOutlet var policyLabel: Caption2FontLabel!
    @IBOutlet var policyButton: FootnoteOutlineButton!

    @IBOutlet var postButton: FootnoteBackgroundButton!
    @IBOutlet var cancelButton: FootnoteOutlineButton!

    // MARK: - Lets and Var

    var cancelServiceRequestViewModel = CancelServiceRequestViewModel()
    var reasonArray = [SRDModelCancelReasonList]()
    var selectedReason = ""
    var bookingUid = ""

    var tableviewHeight: CGFloat = 0

    var delegate: ProtocolCancelServiceRequestViewController!

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

        if self.reasonArray.count > 0 {
            self.returnReasonTableViewHeight.constant = tableviewHeight
            self.returnReasonTableView.isScrollEnabled = false
        } else {
            self.returnReasonTableViewHeight.constant = 0
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

        self.cancelButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.cancelButton.layer.borderWidth = 1.0
        self.cancelButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.cancelButton.clipsToBounds = true
        self.cancelButton.layer.cornerRadius = AppConstantValue.cornerRadius4

        self.returnReasonTableView.tableFooterView = UIView()
        self.returnReasonTableView.separatorColor = UIColor.clear
        self.returnReasonTableView.backgroundColor = UIColor.clear
        self.returnReasonTableView.rowHeight = UITableView.automaticDimension
        self.returnReasonTableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableviewHeight = 0
        if self.reasonArray.count > 0 {
            for item in self.reasonArray {
                if !(item.value.isNilOrEmpty) {
                    let height = self.heightForText(text: item.value!, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - CGFloat(32)) + 16
                    tableviewHeight = tableviewHeight + height + 16
                }
            }
        }
        self.reloadReturnReasonTableView()
        self.setUserInteractionButton()
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = true
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = ""
        self.navigationBar.rightImage = ""
        self.navigationBar.isLogoHidden = false
        self.navigationBar.logoImage = Asset.hzlogo
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.returnReasonTitleLabel.text = AppLocalizationString.whyareyoucancellingthisbooking
        self.cancelButton.setTitle(AppLocalizationString.nodontcancel.uppercased(), for: .normal)
        self.postButton.setTitle(AppLocalizationString.yescancel.uppercased(), for: .normal)
        self.policyLabel.text = AppLocalizationString.bookingCancellationPolicy
        self.policyButton.setTitle(AppLocalizationString.viewcancellationpolicy.capitalized, for: .normal)

    }
    // MARK: - Reload
    func reloadReturnReasonTableView() {
        self.returnReasonTableView.delegate = self
        self.returnReasonTableView.dataSource = self
        self.returnReasonTableView.reloadData()
        //        if self.reasonArray.count > 0 {
        //            for item in self.reasonArray {
        //                if !(item.value.isNilOrEmpty) {
        //                    let height = self.heightForText(text: item.value!, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - CGFloat(32)) + 16
        //                    tableviewHeight = tableviewHeight + height + 16
        //                }
        //            }
        //        }
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.postCancelReason(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func postCancelReason(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.postCancelBooking)\(self.bookingUid)/"
        let param = String(format: "reason_id=%@", selectedReason)
        self.cancelServiceRequestViewModel.postCancelBooking(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    // MARK: - IBAction
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.navigateBackToViewController()
    }
    @IBAction func postButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    @IBAction func policyButtonPressed(_ sender: UIButton) {
        self.navigateToTermsConditionsViewController(isFrom: IsNavigateFrom.termsofUseCancelRequest.rawValue)
    }
    // MARK: - Custom Methods
    func postSuccess() {
        self.delegate.postButtonPressedCancelServiceRequestViewController()
        self.navigateBackToViewController()
    }

    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if !(self.selectedReason.isEmpty) {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
        }
    }
    func setButtonDisable() {
        self.postButton.isUserInteractionEnabled = false
        self.postButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.postButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.postButton.setNeedsDisplay()
        self.postButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

    func setButtonEnable() {
        self.postButton.isUserInteractionEnabled = true
        self.postButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.postButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.postButton.setNeedsDisplay()
        self.postButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

}
extension CancelServiceRequestViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
    }
    func rightButtonPressed() {
    }
}
extension CancelServiceRequestViewController: ProtocolNetworkRechabilityDelegate {
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

extension CancelServiceRequestViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reasonArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CancelServiceRequestTableViewCell, for: indexPath) as! CancelServiceRequestTableViewCell
        cell.configure(reason: self.reasonArray[indexPath.row], indexpath: indexPath.row, selectID: self.selectedReason)
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if tableView == self.returnReasonTableView && self.reasonArray.count > 0 {
            return self.returnReasonTableViewHeight.constant = tableView.contentSize.height
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension CancelServiceRequestViewController: ProtocolCancelServiceRequestTableViewCell {
    func reasonButtonPressedCancelServiceRequestTableViewCell(senderTag: Int) {
        if self.reasonArray.count > 0 {
            selectedReason = ""
            if self.reasonArray[senderTag].id != nil {
                selectedReason = String(format: "%d", self.reasonArray[senderTag].id!)
            }
            self.setUserInteractionButton()
            self.reloadReturnReasonTableView()
        }
    }
}
