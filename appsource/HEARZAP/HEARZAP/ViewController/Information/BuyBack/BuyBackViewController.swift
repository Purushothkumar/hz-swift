//
//  BuyBackViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 21/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BuyBackViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: LogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var bannerImageView: UIImageView!

    @IBOutlet var contentStackView: UIStackView!
    @IBOutlet var titleView: UIView!
    @IBOutlet var titlelabel: Title2FontLabel!
    @IBOutlet var descriptionlabel: FootnoteFontLabel!

    @IBOutlet var contentView: UIView!
    @IBOutlet var tableviewHeight: NSLayoutConstraint!
    @IBOutlet var tableview: UITableView!

    @IBOutlet var buyBackDescriptionView: UIView!
    @IBOutlet var buyBackDescriptionLabel: Caption1FontLabel!
    @IBOutlet var emptyView: UIView!

    @IBOutlet var talkToExpertView: UIView!
    @IBOutlet var talkToExpertButton: CalloutBackgroundButton!
    @IBOutlet var talkToExpertButtonHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    let buyBackViewModel = BuyBackViewModel()
    var buybackArray = [BuybackStep]()

    var serviceType = ""
    var serviceName = ""
    var serviceDesc = ""
    var servicePosterPhoto = ""
    var serviceMarketingVideoLink = ""
    var isFrom = ""

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.buybackArray.count > 0 {
            self.tableviewHeight.constant = self.tableview.contentSize.height
        } else {
            self.tableviewHeight.constant = 0
        }
        self.mainScrollView.sizeToFit()
        self.mainScrollView.contentSize = CGSize(width: self.mainScrollView.frame.size.width, height: self.emptyView.frame.height + self.emptyView.frame.origin.y )

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
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTableview()
        self.buyBackDescriptionView.isHidden = true
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBar.isLogoHidden = false
        self.navigationBar.logoImage = Asset.hzlogo
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        let msg1 = AppLocalizationString.hearzapworkstowardsamissionof
        let msg2 = AppLocalizationString.hearBetterandLiveBetter
        let msg3 = AppLocalizationString.byaddressingHearingLosseventounprivilegedpeople
        let normalFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let semiboldFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.semibold.size(16)] as [NSAttributedString.Key: Any]
        let strmsg1 = NSMutableAttributedString(string: String(format: "%@\n", msg1), attributes: normalFontAttributes as [NSAttributedString.Key: Any])
        let strmsg2 = NSMutableAttributedString(string: String(format: "%@", msg2), attributes: semiboldFontAttributes as [NSAttributedString.Key: Any])
        let strmsg3 = NSMutableAttributedString(string: String(format: "\n%@", msg3), attributes: normalFontAttributes as [NSAttributedString.Key: Any])
        let combination = NSMutableAttributedString()
        combination.append(strmsg1)
        combination.append(strmsg2)
        combination.append(strmsg3)
        self.buyBackDescriptionLabel.attributedText = combination
        self.talkToExpertButton.setTitle(AppLocalizationString.talkToOurExpert.uppercased(), for: .normal)
        self.bannerImageView.setImage(imageUrl: servicePosterPhoto, placeHolderImage: hearzapPlaceholder)
        self.titlelabel.text = serviceName.capitalized
        self.descriptionlabel.text = serviceDesc.capitalized

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
                    self.getBuybackData(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getBuybackData(retryAPIID: Int, canShowLoader: Bool) {
        self.buyBackViewModel.getBuybackData(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getBuybackData, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func talkToExpertButtonPressed(_ sender: UIButton) {
        self.navigateToSupportViewController(isFrom: IsNavigateFrom.supportBuyBack.rawValue)
    }
}
extension BuyBackViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension BuyBackViewController: ProtocolNetworkRechabilityDelegate {
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
extension BuyBackViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.buybackArray.count > 0 {
            return 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.buybackArray.count > 0 {
            if section == 0 {
                return 1
            } else {
                return self.buybackArray.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.buybackArray.count > 0 {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BuyBackTitleTableViewCell, for: indexPath) as! BuyBackTitleTableViewCell
                cell.titleLabel.text = AppLocalizationString.howtogiveyouroldhearingaids
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BuyBackContentTableViewCell, for: indexPath) as! BuyBackContentTableViewCell
                cell.configure(buybackStep: self.buybackArray[indexPath.row], indexPath: indexPath.row)
                if self.buybackArray.count > 0 {
                    if indexPath.row == (self.buybackArray.count - 1) {
                        cell.hideSeparator()
                    }
                } else {
                    cell.hideSeparator()
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BuyBackContentTableViewCell, for: indexPath) as! BuyBackContentTableViewCell
            cell.configure(buybackStep: self.buybackArray[indexPath.row], indexPath: indexPath.row)
            cell.hideSeparator()
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
        self.tableviewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
