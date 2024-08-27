//
//  OnlineConsultationConcernViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class OnlineConsultationConcernViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var fiveDotCircleView: FiveDotCircleView!
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!

    @IBOutlet var tableview: UITableView!

    @IBOutlet var nextButtonView: UIView!
    @IBOutlet var nextButton: CalloutBackgroundButton!

    // MARK: - Lets and Var

    var isFrom = ""
    var onlineConsultationConcernViewModel = OnlineConsultationConcernViewModel()
    var patientUid = ""

    var concernArray = [CustomerConcernQuestion]()
    var concernArraySelected: NSMutableArray = NSMutableArray()
    var enableButton = false
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
        self.setFiveDotCircleView()
        self.setCommonTitleView()
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.setUserInteractionButton()
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.consultAudiologistOnline
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Set Four Dot Circle View
    func setFiveDotCircleView() {
        self.fiveDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.recordcircleblue, button3image: Asset.circlegrey, button4image: Asset.circlegrey, button5image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.OCStep2Title.capitalized
        let descriptionMessage = AppLocalizationString.OCStep2Desc.capitalized
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
        self.nextButton.setTitle(AppLocalizationString.next.uppercased(), for: .normal)
        self.setCommonTitleView()
    }

    // MARK: - Reload
    func reloadTableview() {
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getOnlineConsultationConcernList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getOnlineConsultationConcernList(retryAPIID: Int, canShowLoader: Bool) {
        self.onlineConsultationConcernViewModel.getOnlineConsultationConcernList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getOnlineConsultationConcernList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    // MARK: - IBAction
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.navigateToOnlineConsultationAudiologistViewController(isFrom: self.isFrom, patientUid: self.patientUid, concernArraySelected: self.concernArraySelected)
    }
    // MARK: - Custom Methods
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            self.enableButton = true
            if self.concernArraySelected.count > 0 {
                for (index, item) in self.concernArraySelected.enumerated() {
                    for (key, value) in (item as! NSDictionary) {
                        let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                        if arrayValueCode.count > 0 {
                        } else {
                            self.enableButton = false
                        }
                    }
                }
            }
            if self.enableButton == true {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
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
}

extension OnlineConsultationConcernViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension OnlineConsultationConcernViewController: ProtocolNetworkRechabilityDelegate {
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

extension OnlineConsultationConcernViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.concernArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.OnlineConsultationConcernTableViewCell, for: indexPath) as! OnlineConsultationConcernTableViewCell
        cell.configure(customerConcernQuestion: self.concernArray[indexPath.row], indexpath: indexPath.row, viewCon: self)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
