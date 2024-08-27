//
//  CancelOrderViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 03/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CancelOrderViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var returnReasonTitleView: UIView!
    @IBOutlet var returnReasonTitleLabel: FootnoteFontLabel!

    @IBOutlet var returnReasonView: UIView!
    @IBOutlet var returnReasonTableView: UITableView!
    @IBOutlet var returnReasonTableViewHeight: NSLayoutConstraint!

    @IBOutlet var cancelButton: FootnoteOutlineButton!
    @IBOutlet var continueButton: FootnoteBackgroundButton!

    // MARK: - Lets and Var

    var cancelReasonViewModel = CancelReasonViewModel()
    var reasonArray = [CancelReasonList]()
    var selectedReason = ""
    var orderID = ""

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
            self.returnReasonTableViewHeight.constant = self.returnReasonTableView.contentSize.height
        } else {
            self.returnReasonTableViewHeight.constant = 0
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

        self.reloadReturnReasonTableView()
        self.setUserInteractionButton()

    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = true
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = ""
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.cancelOrder
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {

        self.returnReasonTitleLabel.text = AppLocalizationString.whyareyoucancellingthisbooking
        self.cancelButton.setTitle(AppLocalizationString.nodontcancel.uppercased(), for: .normal)
        self.continueButton.setTitle(AppLocalizationString.yescancel.uppercased(), for: .normal)
    }
    // MARK: - Reload
    func reloadReturnReasonTableView() {
        self.returnReasonTableView.delegate = self
        self.returnReasonTableView.dataSource = self
        self.returnReasonTableView.reloadData()
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
         let url = "\(SubAPIUrl.postCancelReason)\(orderID)/"
         let param = String(format: "status_code=CANCELLED&reason_id=%@", selectedReason)
         self.cancelReasonViewModel.postCancelReason(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
     }

    // MARK: - IBAction
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.navigateBackToViewController()
    }
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }

    // MARK: - Custom Methods
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
        self.continueButton.isUserInteractionEnabled = false
        self.continueButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.continueButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.continueButton.setNeedsDisplay()
        self.continueButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

    func setButtonEnable() {
        self.continueButton.isUserInteractionEnabled = true
        self.continueButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.continueButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.continueButton.setNeedsDisplay()
        self.continueButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
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
}

extension CancelOrderViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    func rightButtonPressed() {
    }
}
extension CancelOrderViewController: ProtocolNetworkRechabilityDelegate {
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

extension CancelOrderViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reasonArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CancelOrderTableViewCell, for: indexPath) as! CancelOrderTableViewCell
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
extension CancelOrderViewController: ProtocolCancelOrderTableViewCell {
    func reasonButtonPressedCancelOrderTableViewCell(senderTag: Int) {
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
