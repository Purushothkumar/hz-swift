//
//  OnlineConsultationAudiologistViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class OnlineConsultationAudiologistViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var fiveDotCircleView: FiveDotCircleView!
    @IBOutlet var commonTitleView: CommonTitleView!
    @IBOutlet var commonTitleViewHeight: NSLayoutConstraint!

    @IBOutlet var tableview: UITableView!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var errorViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    var isFrom = ""
    var patientUid = ""
    var concernArraySelected: NSMutableArray = NSMutableArray()
    var onlineConsultationAudiologistViewModel = OnlineConsultationAudiologistViewModel()

    var audiologistProfileList = [AudiologistProfileList]()
    var audiologistProfile: AudiologistProfile?

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
        self.reloadTableview()
        self.errorView.isHidden = true
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
        self.fiveDotCircleView.setupView(button1image: Asset.checkcircleblue, button2image: Asset.checkcircleblue, button3image: Asset.recordcircleblue, button4image: Asset.circlegrey, button5image: Asset.circlegrey,circleViewBackgroundColor: UIColor.colorLiteral.theme_yellow_FFFCEC)
    }
    // MARK: - Set Common Title View
    func setCommonTitleView() {
        let titlemessage = AppLocalizationString.OCStep3Title.capitalized
        let descriptionMessage = AppLocalizationString.OCStep3Desc.capitalized

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
        self.primaryMessageLabel.text = AppLocalizationString.noAudiologistsFound
        self.secondaryMessageLabel.text = ""
        self.setCommonTitleView()
        self.errorViewHeight.constant = 5/*primary top*/ + CGFloat(self.heightForText(text: AppLocalizationString.noAudiologistsFound, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - 32))/*primary height*/ + 5/*primary bottom*/ + CGFloat(self.heightForText(text: "", Font: AppFont.regular.size(11), Width: AppConstantValue.screenWidthminus32 - 32))/*secondary height*/ + 5/*secondary bottom*/ + 16/*button top*/ + 44/*button height*/ + 16/*button bottom*/
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
                    self.getOnlineConsultationaudiologistsList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getOnlineConsultationaudiologistsList(retryAPIID: Int, canShowLoader: Bool) {
        self.onlineConsultationAudiologistViewModel.getOnlineConsultationaudiologistsList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getOnlineConsultationaudiologistsList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
}

extension OnlineConsultationAudiologistViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension OnlineConsultationAudiologistViewController: ProtocolNetworkRechabilityDelegate {
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
extension OnlineConsultationAudiologistViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.audiologistProfileList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.OnlineConsultationAudiologistTableViewCell, for: indexPath) as! OnlineConsultationAudiologistTableViewCell
        cell.configure(audiologistProfileList: self.audiologistProfileList[indexPath.row], indexpath: indexPath.row)
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
extension OnlineConsultationAudiologistViewController: ProtocolOnlineConsultationAudiologistTableViewCell {
    func consultButtonPressedOnlineConsultationAudiologistTableViewCell(senderTag: Int) {
        if self.audiologistProfileList[senderTag].audiologistProfile != nil {
            if self.audiologistProfileList[senderTag].audiologistProfile != nil {
                self.audiologistProfile = self.audiologistProfileList[senderTag].audiologistProfile!
                if self.audiologistProfile != nil {
                    self.navigateToOnlineConsultationAppointmentViewController(isFrom: self.isFrom, patientUid: self.patientUid, concernArraySelected: self.concernArraySelected, audiologistProfile: self.audiologistProfile!)
                }
            }
        }
    }
    func moreButtonPressedOnlineConsultationAudiologistTableViewCell(senderTag: Int) {}

}
