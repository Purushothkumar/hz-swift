//
//  ShareExperienceViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 17/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ShareExperienceViewController: UIViewController {
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

    @IBOutlet var submitView: UIView!
    @IBOutlet var submitButton: CalloutBackgroundButton!
    @IBOutlet var submitButtonHeight: NSLayoutConstraint!

    // MARK: - Lets and Var

    let shareExperienceViewModel = ShareExperienceViewModel()
    var isFrom = ""

    var questionArray = [SurveyModelQuestion]()
    var questionID = ""
    var surveyType = ""
    var selectArray: NSMutableArray = NSMutableArray()
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
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.questionArray.count > 0 {
            self.tableviewHeight.constant = self.tableview.contentSize.height
        } else {
            self.tableviewHeight.constant = 0
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
        self.setUserInteractionButton()
        self.tableview.tableFooterView = UIView()
        self.tableview.separatorColor = UIColor.clear
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.reloadTableView()
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
        self.titlelabel.text = AppLocalizationString.shareyourexperience
        self.descriptionlabel.text = AppLocalizationString.answerfewquestionstoshareyourhearingaidexpereience
    }
    // MARK: - Reload
    func reloadTableView() {
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getSurveyList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.postSurveyList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getSurveyList(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getSurveyList)\(self.surveyType)/"
        self.shareExperienceViewModel.getSurveyList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postSurveyList(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getSurveyList)\(self.surveyType)/"
        var param = ""
        let paramArray = NSMutableArray()
        if self.selectArray.count > 0 {
            for (index, item) in self.selectArray.enumerated() {
                for (key, value) in (item as! NSDictionary) {
                    let valueCode = value as! String
                    let keyCode = key as! String
                    let dictTemp = NSMutableDictionary()
                    dictTemp.setValue(keyCode as String, forKey: "question_id")
                    dictTemp.setValue(valueCode, forKey: "answer_id")
                    paramArray.add(dictTemp)
                }
            }
        }
        param = String(format: "question_answer=%@", paramArray.count > 0 ? self.stringifyArray(json: paramArray, prettyPrinted: false) : "[]")

        self.shareExperienceViewModel.postSurveyList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    // MARK: - IBAction
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1001)
    }
    // MARK: - Custom Methods
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            self.enableButton = false
            if self.selectArray.count > 0 {
                for (index, item) in self.selectArray.enumerated() {
                    for (key, value) in (item as! NSDictionary) {
                        let valueCode = value as! String
                        if !(valueCode.isEmpty) {
                            self.enableButton = true
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
        self.submitButton.isUserInteractionEnabled = false
        self.submitButton.backgroundColor = UIColor.colorLiteral.theme_orange_FFE5D8
        self.submitButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.submitButton.setNeedsDisplay()
        self.submitButton.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.submitButton.isUserInteractionEnabled = true
        self.submitButton.backgroundColor = UIColor.colorLiteral.theme_orange_F7732F
        self.submitButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.submitButton.setNeedsDisplay()
        self.submitButton.layoutIfNeeded()
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

    func scrolltoIndex(selectedRow: Int) {
        DispatchQueue.main.async {
            if self.questionArray.count > 0 {
                if selectedRow < self.questionArray.count - 1 {
                    UIView.animate(withDuration: 0.5) {
                        let indexPath = IndexPath(row: selectedRow + 1, section: 0)
                        let rectOfCellInTableView = self.tableview.rectForRow(at: indexPath)
                        let rectOfCellInSuperview = self.tableview.convert(rectOfCellInTableView, to: self.tableview.superview)
                        self.mainScrollView.setContentOffset(CGPoint(x: 0, y: rectOfCellInSuperview.origin.y), animated: true)
                    }
                }
            }
        }
    }
}
extension ShareExperienceViewController: ProtocolLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension ShareExperienceViewController: ProtocolNetworkRechabilityDelegate {
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
extension ShareExperienceViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ShareExperienceQuestionTableViewCell, for: indexPath) as! ShareExperienceQuestionTableViewCell
        cell.configure(question: self.questionArray[indexPath.row], indexpath: indexPath.row, selectArray: self.selectArray, viewCon: self)
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
        self.tableviewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
