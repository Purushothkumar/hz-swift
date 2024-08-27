//
//  FAQViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 09/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import CoreAudio

class FAQViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: LogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var backgroundView: UIView!
    @IBOutlet var backgroundViewheight: NSLayoutConstraint!
    @IBOutlet var imageViewHeight: NSLayoutConstraint!

    @IBOutlet var faqTitleView: UIView!
    @IBOutlet var faqTitleLabel: Title2FontLabel!
    @IBOutlet var faqDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var faqTitleViewHeight: NSLayoutConstraint!

    @IBOutlet var faqView: UIView!
    @IBOutlet var faqTableView: UITableView!
    @IBOutlet var faqTableViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    let faqViewModel = FAQViewModel()
    var faqArray = [DataFAQ]()
    var isFrom = ""
    var sectionSelected = ""
    var rowSelected = ""

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
        if self.faqArray.count > 0 {
            self.faqTableView.isScrollEnabled = false
            var heightForString: CGFloat = 0
            var sectionstring = ""
            var rowstring = ""
            var indexi = 0
            for item in self.faqArray {
                sectionstring = "\(indexi)"
                var heading = ""
                var headingHeight: CGFloat = 0
                let footerHeight: CGFloat = 16
                if !(item.heading.isNilOrEmpty) {
                    heading = item.heading!
                    headingHeight =  16 + self.heightForText(text: heading, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - CGFloat(32)) + 16
                }
                heightForString = headingHeight + footerHeight + heightForString
                var faq = [FAQCategoryModelFAQ()]
                var faqMessageViewheight: CGFloat = 0
                var indexj = 0
                if self.faqArray[indexi].faq != nil {
                    faq = self.faqArray[indexi].faq!
                    for inneritem in faq {
                        rowstring = "\(indexj)"
                        var question = ""
                        var answer = ""
                        if !(inneritem.question.isNilOrEmpty) {
                            question = inneritem.question!
                        }
                        if !(inneritem.answer.isNilOrEmpty) {
                            answer = inneritem.answer!
                        }
                        if sectionstring == sectionSelected && rowstring == rowSelected {
                            faqMessageViewheight = self.heightForText(text: question, Font: AppFont.medium.size(13), Width: AppConstantValue.screenWidthminus32 - (CGFloat(32) + CGFloat(20) + CGFloat(10))) + CGFloat(20) + self.heightForText(text: answer, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - CGFloat(32)) + CGFloat(20) + CGFloat(10)
                        } else {
                            faqMessageViewheight = self.heightForText(text: question, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - (CGFloat(32) + CGFloat(20) + CGFloat(10))) + CGFloat(20) + CGFloat(10)
                        }
                        heightForString += faqMessageViewheight
                        indexj += 1
                    }
                }
                indexi += 1
            }
            self.faqTableViewHeight.constant = heightForString
        } else {
            self.faqTableViewHeight.constant = 0
        }
        self.backgroundViewheight.constant = self.faqTitleViewHeight.constant + self.faqTableViewHeight.constant
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
        self.imageViewHeight.constant = screenFrameWidth * CGFloat(AppConstantValue.screen211slash375)
        self.faqTableView.tableFooterView = UIView()
        self.faqTableView.separatorColor = UIColor.clear
        self.faqTableView.backgroundColor = UIColor.clear
        self.faqTableView.rowHeight = UITableView.automaticDimension
        self.faqTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadFAQTableView()
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
        //        self.navigationBar.title = ""
        self.navigationBar.delegate = self
        //        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_E7F4FF)
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70)

    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.faqTitleLabel.text = AppLocalizationString.faq
        self.faqDescriptionLabel.text = AppLocalizationString.havingtroubleWeliketohelp
        self.faqTitleViewHeight.constant = self.heightForText(text: AppLocalizationString.faq, Font: AppFont.bold.size(22), Width: screenFrameWidth - 16) + 4 + self.heightForText(text: AppLocalizationString.havingtroubleWeliketohelp, Font: AppFont.medium.size(13), Width: screenFrameWidth - 16) + 30
    }
    // MARK: - Reload
    func reloadFAQTableView() {
        DispatchQueue.main.async {
            self.faqTableView.dataSource = self
            self.faqTableView.delegate = self
            self.faqTableView?.translatesAutoresizingMaskIntoConstraints = false
            self.faqTableView.reloadData()
        }
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getFAQList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getFAQList(retryAPIID: Int, canShowLoader: Bool) {
        self.faqViewModel.getFAQList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getFAQList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
}
extension FAQViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension FAQViewController: ProtocolNetworkRechabilityDelegate {
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
extension FAQViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.faqArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var faqCount = 0
        if self.faqArray[section].faq != nil {
            faqCount = self.faqArray[section].faq!.count
        }
        return faqCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FAQTableViewCell, for: indexPath) as! FAQTableViewCell

        var question = ""
        var answer = ""

        cell.descriptionLabel.text = answer
        cell.titleLabel.text = question
        let viewSubtitle = cell.stackview.arrangedSubviews[1]
        viewSubtitle.isHidden = true
        let sectionstring = "\(indexPath.section)"
        let rowstring = "\(indexPath.row)"

        var faq = FAQCategoryModelFAQ()
        if self.faqArray[indexPath.section].faq != nil {
            faq = self.faqArray[indexPath.section].faq![indexPath.row]
            if !(faq.question.isNilOrEmpty) {
                question = faq.question!
            }
            if !(faq.answer.isNilOrEmpty) {
                answer = faq.answer!
            }
            if sectionstring == sectionSelected && rowstring == rowSelected {
                cell.titleLabel.font = AppFont.medium.size(13)
                cell.descriptionLabel.font = AppFont.regular.size(13)
                cell.titleLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
                cell.titleLabel.isHidden = false
                viewSubtitle.isHidden = false
                cell.arrowImageView.image = UIImage(named: Asset.chevronupblue)
                cell.descriptionLabel.text = answer
                cell.titleLabel.text = question
            } else {
                cell.titleLabel.isHidden = false
                cell.titleLabel.font = AppFont.regular.size(13)
                cell.descriptionLabel.font = AppFont.regular.size(13)
                cell.titleLabel.textColor = UIColor.colorLiteral.theme_grey_777777
                cell.arrowImageView.image = UIImage(named: Asset.chevrondowngrey)
                viewSubtitle.isHidden = true
                cell.titleLabel.text = question
                cell.descriptionLabel.text = ""
            }
            let faqCount = self.faqArray[indexPath.section].faq!.count
            //            if indexPath.row == (faqCount - 1) {
            //                cell.clipsToBounds = true
            //                cell.layer.masksToBounds = true
            //                cell.roundCorners([.bottomLeft, .bottomRight], radius: AppConstantValue.cornerRadius8)
            //                cell.descriptionLabel.clipsToBounds = false
            //            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
        self.view.layer.layoutIfNeeded()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var heading = ""
        var headingHeight: CGFloat = 0

        if !(self.faqArray[section].heading.isNilOrEmpty) {
            heading = self.faqArray[section].heading!
            headingHeight =  self.heightForText(text: heading, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - CGFloat(32))
        }
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Int(AppConstantValue.screenWidthminus32), height: Int(headingHeight) + 32))
        let label = CalloutFontLabel()
        label.frame = CGRect.init(x: 16, y: 16, width: Int(AppConstantValue.screenWidthminus32) - 32, height: Int(headingHeight))
        label.text = heading
        label.textColor = UIColor.colorLiteral.theme_blue_112F70
        label.font = AppFont.semibold.size(16)
        headerView.addSubview(label)
        headerView.roundCorners([.topLeft, .topRight], radius: AppConstantValue.cornerRadius8)
        headerView.layer.masksToBounds = true
        headerView.clipsToBounds = true

        let outlinelabel = CalloutFontLabel()
        outlinelabel.frame = CGRect.init(x: 16, y: Int(headingHeight) + 32 - 1, width: Int(AppConstantValue.screenWidthminus32 - CGFloat(32)), height: 1)
        outlinelabel.backgroundColor = UIColor.colorLiteral.theme_white_F2F2F2
        headerView.addSubview(outlinelabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var heading = ""
        var headingHeight: CGFloat = 0

        if !(self.faqArray[section].heading.isNilOrEmpty) {
            heading = self.faqArray[section].heading!
            headingHeight =  self.heightForText(text: heading, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - CGFloat(32))
        }
        return headingHeight + CGFloat(32)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Int(AppConstantValue.screenWidthminus32), height: 16))
        headerView.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(8)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.faqArray.count > 0 {
            let sectionstring = "\(indexPath.section)"
            let rowstring = "\(indexPath.row)"
            if sectionstring == self.sectionSelected {
                if rowstring == self.rowSelected {
                    self.sectionSelected = ""
                    self.rowSelected = ""
                } else {
                    self.rowSelected = rowstring
                }
            } else {
                self.sectionSelected = sectionstring
                self.rowSelected = rowstring
            }
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            self.reloadFAQTableView()
        }
    }
}
