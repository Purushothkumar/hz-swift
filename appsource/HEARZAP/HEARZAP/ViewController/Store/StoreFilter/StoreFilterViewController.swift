//
//  StoreFilterViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 27/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class StoreFilterViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var filterTitleView: UIView!
    @IBOutlet var filterTitleBackgroundView: UIView!
    @IBOutlet var findNearbyTextfield: Caption1FontTextfield!
    @IBOutlet var findNearbyButton: CalloutBackgroundButton!
    
    @IBOutlet var filterTextStackView: UIStackView!
    @IBOutlet var filterTextView: UIView!
    @IBOutlet var filterStateLabel: FootnoteFontLabel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var errorView: UIView!
    
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    
    // MARK: - Lets and Var
    
    let storeFilterViewModel = StoreFilterViewModel()
    var filterStoreArray = [StoreFilterModelStoreList]()
    var queryString = ""
    var isState = false
    var isCity = false
    var isZipCode = false
    var activeField = UITextField()
    var hasnext = false
    var pageNumber = 1
    var totalPages = 1
    
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
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.findNearbyTextfield.setLeftPaddingPoints(CGFloat(10))
        self.findNearbyTextfield.setRightPaddingPoints(CGFloat(10))
        self.errorView.isHidden =  true
        self.findNearbyTextfield.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.filterTextView.isHidden = true
        if self.isState == true {
            self.commonAPICALL(retryAPIID: 1000)
        } else if self.isCity == true {
            self.commonAPICALL(retryAPIID: 1001)
        } else if self.isZipCode == true {
            self.commonAPICALL(retryAPIID: 1002)
        } else {
            self.findNearbyTextfield.becomeFirstResponder()
        }
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        //        self.navigationBar.rightImage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.tabStores
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.findNearbyTextfield.placeholder = AppLocalizationString.enteryourcityorpincode
        self.primaryMessageLabel.text = AppLocalizationString.wearecomingsoon
        self.secondaryMessageLabel.text = AppLocalizationString.ourteamisworkingtobringourservicestoyourdoorstep
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
                    self.getStoreFilterStateList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getStoreFilterCityList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 {
                    self.getStoreFilterZipcodeList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getStoreFilterStateList(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.queryString.isEmpty) {
            let suburl = "\(SubAPIUrl.getStoreFilterStateList)\(queryString.allowSpecialCharacters)/"
            self.storeFilterViewModel.getStoreFilterStateList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: suburl, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(self.pageNumber)", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    func getStoreFilterCityList(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.queryString.isEmpty) {
            let suburl = "\(SubAPIUrl.getStoreFilterCityList)\(queryString.allowSpecialCharacters)/"
            self.storeFilterViewModel.getStoreFilterCityList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: suburl, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(self.pageNumber)", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    func getStoreFilterZipcodeList(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.queryString.isEmpty) {
            let suburl = "\(SubAPIUrl.getStoreFilterZipcodeList)\(queryString.allowSpecialCharacters)/"
            self.storeFilterViewModel.getStoreFilterZipcodeList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: suburl, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(self.pageNumber)", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    
    // MARK: - IBAction
    @IBAction func findNearbyButtonPressed(_ sender: UIButton) {
        if self.findNearbyTextfield.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseenteryourcityorpincode, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        } else {
            self.pageNumber = 1
            self.hasnext = false
            self.queryString = self.findNearbyTextfield.text ?? ""
            if self.queryString.isNumber == true {
                self.commonAPICALL(retryAPIID: 1002)
            } else {
                self.commonAPICALL(retryAPIID: 1001)
            }
        }
    }
    
    // MARK: - Custom Methods
    
    // MARK: - TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeField.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && (string == " ") {
            return false
        }
        let maxLength = 255
        if string == "" {return true}
        let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.alphaNumericRegEx)
        let predicateBool = predicate.evaluate(with: string)
        if predicateBool == false {
            self.showToastAlert(AppLocalizationString.pleaseenteranameusingonlyalphabeticletters, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
            return predicateBool
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
extension StoreFilterViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension StoreFilterViewController: ProtocolNetworkRechabilityDelegate {
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

extension StoreFilterViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterStoreArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FilterStoreTableViewCell, for: indexPath) as! FilterStoreTableViewCell
        cell.configure(storeList: self.filterStoreArray[indexPath.row], indexpath: indexPath.row)
        cell.delegate = self
        if indexPath.row == (self.filterStoreArray.count - 1) {
            cell.hideSeparator()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - Scrollview Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 && self.pageNumber > 1 && self.hasnext == true {
            self.hasnext = false
            if self.isState == true {
                self.commonAPICALL(retryAPIID: 1000)
            } else if self.isCity == true {
                self.commonAPICALL(retryAPIID: 1001)
            } else if self.isZipCode == true {
                self.commonAPICALL(retryAPIID: 1002)
            } else {
            }
        }
    }
}
extension StoreFilterViewController: ProtocolFilterStoreTableViewCell {
    func viewStoreButtonFilterStoreTableViewCell(senderTag: Int) {
        if  self.filterStoreArray.count > 0 {
            if  self.filterStoreArray.count > 0 {
                if !(self.filterStoreArray[senderTag].slug.isNilOrEmpty) {
                    let slug = "\(self.filterStoreArray[senderTag].slug!)"
                    self.navigateToStoreDetailViewController(slug: slug)
                }
            }
        }
    }
}
