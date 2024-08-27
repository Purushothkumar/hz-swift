//
//  HearingAidFilterViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 26/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolHearingAidFilterViewController {
    func doneButtonPressedHearingAidFilterViewController(styleArraySelected: [String], brandArraySelected: [String], featureArraySelected: NSMutableArray, specificationArraySelected: NSMutableArray)
}

class HearingAidFilterViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationView: UIView!
    @IBOutlet var titleLabel: CalloutFontLabel!
    @IBOutlet var closeButton: FootnoteOutlineButton!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var styleTitleLabel: FootnoteFontLabel!
    @IBOutlet var styleArrowImage: UIImageView!
    @IBOutlet var styleTitleButton: FootnoteOutlineButton!
    
    @IBOutlet var styleTableView: UITableView!
    @IBOutlet var styleTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var brandTitleLabel: FootnoteFontLabel!
    @IBOutlet var brandArrowImage: UIImageView!
    @IBOutlet var brandTitleButton: FootnoteOutlineButton!
    
    @IBOutlet var brandTableView: UITableView!
    @IBOutlet var brandTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var featureTitleLabel: FootnoteFontLabel!
    @IBOutlet var featureArrowImage: UIImageView!
    @IBOutlet var featureTitleButton: FootnoteOutlineButton!
    
    @IBOutlet var featureTableView: UITableView!
    @IBOutlet var featureTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var specificationTitleLabel: FootnoteFontLabel!
    @IBOutlet var specificationArrowImage: UIImageView!
    @IBOutlet var specificationTitleButton: FootnoteOutlineButton!
    
    @IBOutlet var specificationTableView: UITableView!
    @IBOutlet var specificationTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var clearAllButton: FootnoteOutlineButton!
    @IBOutlet var doneButton: FootnoteBackgroundButton!
    
    // MARK: - Lets and Var
    var hearingAidFilterViewModel = HearingAidFilterViewModel()
    var isFilterClear = false
    
    var isStyle = false
    var isBrand = false
    var isFeature = false
    var isSpecification = false
    var enableButton = false
    var styleArray = [FilterModelStyle]()
    var brandArray = [FilterModelBrand]()
    var featureArray = [FilterModelFeature]()
    var specificationArray = [FilterModelSpecification]()
    
    var styleArraySelected = [String]()
    var brandArraySelected = [String]()
    var featureArraySelected: NSMutableArray = NSMutableArray()
    var specificationArraySelected: NSMutableArray = NSMutableArray()
    
    var styleTableHeight = 0
    var brandTableHeight = 0
    var featureTableHeight = 0
    var specificationTableHeight = 0
    
    var delegate: ProtocolHearingAidFilterViewController?
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let view1 = self.mainStackView.arrangedSubviews[1]// style list View
        let view4 = self.mainStackView.arrangedSubviews[4]// brandlist View
        let view7 = self.mainStackView.arrangedSubviews[7]// feature list View
        let view10 = self.mainStackView.arrangedSubviews[10]// specification list View
        
        view10.isHidden = true
        if (self.isStyle == true) && (self.styleArray.count > 0) {
            self.styleTableViewHeight.constant = CGFloat(self.styleTableHeight)
            view1.isHidden = false
        } else {
            self.styleTableViewHeight.constant = 0
            view1.isHidden = true
        }
        
        if (self.isBrand == true) && (self.brandArray.count > 0) {
            self.brandTableViewHeight.constant = CGFloat(self.brandTableHeight)
            view4.isHidden = false
        } else {
            self.brandTableViewHeight.constant = 0
            view4.isHidden = true
        }
        if (self.isFeature == true) && (self.featureArray.count > 0) {
            self.featureTableViewHeight.constant = CGFloat(self.featureTableHeight)
            view7.isHidden = false
        } else {
            self.featureTableViewHeight.constant = 0
            view7.isHidden = true
        }
        if (self.isSpecification == true) && (self.specificationArray.count > 0) {
            self.specificationTableViewHeight.constant = CGFloat(self.specificationTableHeight)
            view10.isHidden = false
        } else {
            self.specificationTableViewHeight.constant = 0
            view10.isHidden = true
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
        self.changeLanguageFormat()
        self.clearAllButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.clearAllButton.layer.borderWidth = 1.0
        self.doneButton.isHidden = true
        self.clearAllButton.isHidden = true
        
        self.styleTableView.tableFooterView = UIView()
        self.styleTableView.separatorColor = UIColor.clear
        self.styleTableView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.styleTableView.rowHeight = UITableView.automaticDimension
        self.styleTableView.estimatedRowHeight = UITableView.automaticDimension
        self.styleTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.styleTableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        
        self.brandTableView.tableFooterView = UIView()
        self.brandTableView.separatorColor = UIColor.clear
        self.brandTableView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.brandTableView.rowHeight = UITableView.automaticDimension
        self.brandTableView.estimatedRowHeight = UITableView.automaticDimension
        self.brandTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.brandTableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        
        self.featureTableView.tableFooterView = UIView()
        self.featureTableView.separatorColor = UIColor.clear
        self.featureTableView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.featureTableView.rowHeight = UITableView.automaticDimension
        self.featureTableView.estimatedRowHeight = UITableView.automaticDimension
        self.featureTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.featureTableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        
        self.specificationTableView.tableFooterView = UIView()
        self.specificationTableView.separatorColor = UIColor.clear
        self.specificationTableView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.specificationTableView.rowHeight = UITableView.automaticDimension
        self.specificationTableView.estimatedRowHeight = UITableView.automaticDimension
        self.specificationTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.specificationTableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        
        self.setBrandUI()
        self.setStyleUI()
        self.setFeatureUI()
        self.setSpecificationUI()
        self.reloadBrandTableView()
        self.reloadStyleTableView()
        self.reloadFeatureTableView()
        self.reloadSpecificationTableView()
        
        let view0 = self.mainStackView.arrangedSubviews[0]// style title View
        let view1 = self.mainStackView.arrangedSubviews[1]// style list View
        let view2 = self.mainStackView.arrangedSubviews[2]// empty
        let view3 = self.mainStackView.arrangedSubviews[3]// brand title View
        let view4 = self.mainStackView.arrangedSubviews[4]// brandlist View
        let view5 = self.mainStackView.arrangedSubviews[5]// empty
        let view6 = self.mainStackView.arrangedSubviews[6]// feature title View
        let view7 = self.mainStackView.arrangedSubviews[7]// feature list View
        let view8 = self.mainStackView.arrangedSubviews[8]// empty
        let view9 = self.mainStackView.arrangedSubviews[9]// specification title View
        let view10 = self.mainStackView.arrangedSubviews[10]// specification list View
        let view11 = self.mainStackView.arrangedSubviews[11]// empty
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        view6.isHidden = true
        view7.isHidden = true
        view8.isHidden = true
        view9.isHidden = true
        view10.isHidden = true
        view11.isHidden = true
        self.setUserInteractionButton()
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.titleLabel.text = AppLocalizationString.filterRefine.capitalized
        self.doneButton.setTitle(AppLocalizationString.done.uppercased(), for: .normal)
        self.clearAllButton.setTitle(AppLocalizationString.clearAll.uppercased(), for: .normal)
        self.styleTitleLabel.text = AppLocalizationString.style.capitalized
        self.brandTitleLabel.text = AppLocalizationString.brand.capitalized
        self.featureTitleLabel.text = AppLocalizationString.features.capitalized
        self.specificationTitleLabel.text = AppLocalizationString.specification.capitalized
        
    }
    // MARK: - Reload
    func reloadStyleTableView() {
        self.styleTableView.dataSource = self
        self.styleTableView.delegate = self
        self.styleTableView.reloadData()
        self.styleTableView.isScrollEnabled = false
        self.viewWillLayoutSubviews()
    }
    func reloadBrandTableView() {
        self.brandTableView.dataSource = self
        self.brandTableView.delegate = self
        self.brandTableView.reloadData()
        self.brandTableView.isScrollEnabled = false
        self.viewWillLayoutSubviews()
    }
    func reloadFeatureTableView() {
        self.featureTableView.dataSource = self
        self.featureTableView.delegate = self
        self.featureTableView.reloadData()
        self.featureTableView.isScrollEnabled = false
        self.viewWillLayoutSubviews()
    }
    func reloadSpecificationTableView() {
        self.specificationTableView.dataSource = self
        self.specificationTableView.delegate = self
        self.specificationTableView.reloadData()
        self.specificationTableView.isScrollEnabled = false
        self.viewWillLayoutSubviews()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getHearingAidFilterList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getHearingAidFilterList(retryAPIID: Int, canShowLoader: Bool) {
        self.hearingAidFilterViewModel.getHearingAidFilterList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getHearingAidFilterList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func styleTitleButtonPressed(_ sender: UIButton) {
        self.isStyle = !self.isStyle
        self.setStyleUI()
        self.reloadStyleTableView()
    }
    @IBAction func brandTitleButtonPressed(_ sender: UIButton) {
        self.isBrand = !self.isBrand
        self.setBrandUI()
        self.reloadBrandTableView()
    }
    @IBAction func featureTitleButtonPressed(_ sender: UIButton) {
        self.isFeature = !self.isFeature
        self.setFeatureUI()
        self.reloadFeatureTableView()
    }
    @IBAction func specificationTitleButtonPressed(_ sender: UIButton) {
        self.isSpecification = !self.isSpecification
        self.setSpecificationUI()
        self.reloadSpecificationTableView()
    }
    @IBAction func styleButtonPressed(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.styleTableView)
        let indexPath: IndexPath = self.styleTableView.indexPathForRow(at: buttonPosition)!
        var strValueCode = ""
        self.isFilterClear = false
        
        if self.styleArray.count > 0 {
            if !(self.styleArray[indexPath.row].id.isNilOrEmpty) {
                strValueCode = self.styleArray[indexPath.row].id!
            }
        }
        if !(strValueCode.isEmpty) {
            if self.styleArraySelected.count > 0 {
                if self.styleArraySelected.contains(strValueCode) {
                    self.styleArraySelected = self.styleArraySelected.filter { $0 != strValueCode }
                } else {
                    self.styleArraySelected.append(strValueCode)
                }
            } else {
                self.styleArraySelected.append(strValueCode)
            }
        }
        self.reloadStyleTableView()
        self.setUserInteractionButton()
    }
    @IBAction func brandButtonPressed(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.brandTableView)
        let indexPath: IndexPath = self.brandTableView.indexPathForRow(at: buttonPosition)!
        var strValueCode = ""
        self.isFilterClear = false
        
        if self.brandArray.count > 0 {
            if !(self.brandArray[indexPath.row].id.isNilOrEmpty) {
                strValueCode = self.brandArray[indexPath.row].id!
            }
        }
        if !(strValueCode.isEmpty) {
            if self.brandArraySelected.count > 0 {
                if self.brandArraySelected.contains(strValueCode) {
                    self.brandArraySelected = self.brandArraySelected.filter { $0 != strValueCode }
                } else {
                    self.brandArraySelected.append(strValueCode)
                }
            } else {
                self.brandArraySelected.append(strValueCode)
            }
        }
        self.reloadBrandTableView()
        self.setUserInteractionButton()
    }
    @IBAction func featureButtonPressed(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.featureTableView)
        let indexPath: IndexPath = self.featureTableView.indexPathForRow(at: buttonPosition)!
        var strKeyCode = ""
        var strValueCode = ""
        self.isFilterClear = false
        if !(self.featureArray[indexPath.section].id.isNilOrEmpty) {
            strKeyCode = self.featureArray[indexPath.section].id!
            if self.featureArray[indexPath.section].value != nil {
                if self.featureArray[indexPath.section].value!.count > 0 {
                    if !(self.featureArray[indexPath.section].value![indexPath.row].isEmpty) {
                        strValueCode = self.featureArray[indexPath.section].value![indexPath.row]
                    }
                }
            }
        }
        
        let featureArraySelectedCheck = self.featureArraySelected
        for (index, item) in featureArraySelectedCheck.enumerated() {
            for (key, value) in (item as! NSDictionary) {
                if (key as! String) == strKeyCode {
                    let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                    if arrayValueCode.count > 0 {
                        if arrayValueCode.contains(strValueCode) {
                            arrayValueCode.remove(strValueCode)
                        } else {
                            arrayValueCode.add(strValueCode)
                        }
                    } else {
                        arrayValueCode.add(strValueCode)
                    }
                    self.featureArraySelected.removeObject(at: index)
                    let dictTemp = NSMutableDictionary()
                    dictTemp.setValue(arrayValueCode, forKey: strKeyCode)
                    self.featureArraySelected.insert(dictTemp, at: index)
                    self.reloadFeatureTableView()
                    self.setUserInteractionButton()
                    return
                }
            }
        }
    }
    @IBAction func specificationButtonPressed(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.specificationTableView)
        let indexPath: IndexPath = self.specificationTableView.indexPathForRow(at: buttonPosition)!
        var strKeyCode = ""
        var strValueCode = ""
        self.isFilterClear = false
        
        if !(self.specificationArray[indexPath.section].id.isNilOrEmpty) {
            strKeyCode = self.specificationArray[indexPath.section].id!
            if self.specificationArray[indexPath.section].value != nil {
                if self.specificationArray[indexPath.section].value!.count > 0 {
                    if !(self.specificationArray[indexPath.section].value![indexPath.row].isEmpty) {
                        strValueCode = self.specificationArray[indexPath.section].value![indexPath.row]
                    }
                }
            }
        }
        
        let specificationArraySelectedCheck = self.specificationArraySelected
        for (index, item) in specificationArraySelectedCheck.enumerated() {
            for (key, value) in (item as! NSDictionary) {
                if (key as! String) == strKeyCode {
                    let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                    if arrayValueCode.count > 0 {
                        if arrayValueCode.contains(strValueCode) {
                            arrayValueCode.remove(strValueCode)
                        } else {
                            arrayValueCode.add(strValueCode)
                        }
                    } else {
                        arrayValueCode.add(strValueCode)
                    }
                    self.specificationArraySelected.removeObject(at: index)
                    let dictTemp = NSMutableDictionary()
                    dictTemp.setValue(arrayValueCode, forKey: strKeyCode)
                    self.specificationArraySelected.insert(dictTemp, at: index)
                    self.reloadSpecificationTableView()
                    self.setUserInteractionButton()
                    return
                }
            }
        }
    }
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {}    }
    @IBAction func clearAllButtonPressed(_ sender: UIButton) {
        self.styleArraySelected.removeAll()
        self.brandArraySelected.removeAll()
        self.featureArraySelected.removeAllObjects()
        self.specificationArraySelected.removeAllObjects()
        
        if self.featureArray.count > 0 {
            for item in self.featureArray {
                var keyCode = ""
                if !(item.id.isNilOrEmpty) {
                    keyCode = item.id!
                }
                if !(keyCode.isEmpty) {
                    let dictTemp = NSMutableDictionary()
                    dictTemp.setValue([], forKey: keyCode)
                    self.featureArraySelected.add(dictTemp)
                }
            }
        }
        if self.specificationArray.count > 0 {
            for item in self.specificationArray {
                var keyCode = ""
                if !(item.id.isNilOrEmpty) {
                    keyCode = item.id!
                }
                if !(keyCode.isEmpty) {
                    let dictTemp = NSMutableDictionary()
                    dictTemp.setValue([], forKey: keyCode)
                    self.specificationArraySelected.add(dictTemp)
                }
            }
        }
        self.setStyleUI()
        self.setBrandUI()
        self.setFeatureUI()
        self.setSpecificationUI()
        
        self.reloadStyleTableView()
        self.reloadBrandTableView()
        self.reloadFeatureTableView()
        self.reloadSpecificationTableView()
        self.setUserInteractionButton()
    }
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate!.doneButtonPressedHearingAidFilterViewController(styleArraySelected: self.styleArraySelected, brandArraySelected: self.brandArraySelected, featureArraySelected: self.featureArraySelected, specificationArraySelected: self.specificationArraySelected)
        }
    }
    
    // MARK: - Custom Methods
    func setStyleUI() {
        if self.isStyle == true {
            self.styleArrowImage.image = UIImage(named: Asset.chevrondownblue)
        } else {
            self.styleArrowImage.image = UIImage(named: Asset.chevronrightblack)
        }
    }
    func setBrandUI() {
        if self.isBrand == true {
            self.brandArrowImage.image = UIImage(named: Asset.chevrondownblue)
        } else {
            self.brandArrowImage.image = UIImage(named: Asset.chevronrightblack)
        }
    }
    func setFeatureUI() {
        if self.isFeature == true {
            self.featureArrowImage.image = UIImage(named: Asset.chevrondownblue)
        } else {
            self.featureArrowImage.image = UIImage(named: Asset.chevronrightblack)
        }
    }
    func setSpecificationUI() {
        if self.isSpecification == true {
            self.specificationArrowImage.image = UIImage(named: Asset.chevrondownblue)
        } else {
            self.specificationArrowImage.image = UIImage(named: Asset.chevronrightblack)
        }
    }
    
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            self.enableButton = true
            if self.specificationArraySelected.count > 0 {
                for item in self.specificationArraySelected {
                    for (key, value) in (item as! NSDictionary) {
                        let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                        if arrayValueCode.count > 0 {
                            self.enableButton = true
                        }
                    }
                }
            }
            if self.featureArraySelected.count > 0 {
                for item in self.featureArraySelected {
                    for (key, value) in (item as! NSDictionary) {
                        let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                        if arrayValueCode.count > 0 {
                            self.enableButton = true
                        }
                    }
                }
            }
            if self.styleArraySelected.count > 0 {
                self.enableButton = true
            }
            if self.brandArraySelected.count > 0 {
                self.enableButton = true
            }
            if self.enableButton == true {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
        }
    }
    func setButtonDisable() {
        self.doneButton.isUserInteractionEnabled = false
        self.doneButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.doneButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.doneButton.setNeedsDisplay()
        self.doneButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func setButtonEnable() {
        self.doneButton.isUserInteractionEnabled = true
        self.doneButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.doneButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.doneButton.setNeedsDisplay()
        self.doneButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
}
extension HearingAidFilterViewController: ProtocolNetworkRechabilityDelegate {
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
extension HearingAidFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if (self.styleArray.count > 0) && (tableView == self.styleTableView) {
            return 1
        } else if (self.brandArray.count > 0) && (tableView == self.brandTableView) {
            return 1
        } else if (self.featureArray.count > 0) && (tableView == self.featureTableView) {
            return self.featureArray.count
        } else if (self.specificationArray.count > 0) && (tableView == self.specificationTableView) {
            return self.specificationArray.count
        }
        return 0
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.styleArray.count > 0) && (tableView == self.styleTableView) {
            return self.styleArray.count
        } else if (self.brandArray.count > 0) && (tableView == self.brandTableView) {
            return self.brandArray.count
        } else if (self.featureArray.count > 0) && (tableView == self.featureTableView) {
            if self.featureArray[section].value !=  nil {
                return self.featureArray[section].value!.count
            }
            return 0
        } else if (self.specificationArray.count > 0) && (tableView == self.specificationTableView) {
            if self.specificationArray[section].value !=  nil {
                return self.specificationArray[section].value!.count
            }
            return 0
        }
        return 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.styleArray.count > 0) && (tableView == self.styleTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductFilterStyleTableViewCell, for: indexPath) as! ProductFilterStyleTableViewCell
            var id = ""
            var name = ""
            
            if !(self.styleArray[indexPath.row].name.isNilOrEmpty) {
                name = self.styleArray[indexPath.row].name!
            }
            if !(self.styleArray[indexPath.row].id.isNilOrEmpty) {
                id = self.styleArray[indexPath.row].id!
            }
            cell.selectButton.addTarget(self, action: #selector(styleButtonPressed(_:)), for: .touchUpInside)
            cell.selectButton.tag = 1
            cell.titleLabel.text = name.capitalized
            cell.checkMarkButton.setImage(UIImage(named: Asset.checksquaregrey), for: .normal)
            
            if self.styleArraySelected.count > 0 {
                if self.styleArraySelected.contains(id) {
                    cell.checkMarkButton.setImage(UIImage(named: Asset.checksquarelightblue), for: .normal)
                }
            }
            self.view.layoutIfNeeded()
            return cell
        } else if (self.brandArray.count > 0) && (tableView == self.brandTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductFilterBrandTableViewCell, for: indexPath) as! ProductFilterBrandTableViewCell
            var id = ""
            var name = ""
            
            if !(self.brandArray[indexPath.row].name.isNilOrEmpty) {
                name = self.brandArray[indexPath.row].name!
            }
            if !(self.brandArray[indexPath.row].id.isNilOrEmpty) {
                id = self.brandArray[indexPath.row].id!
            }
            cell.selectButton.addTarget(self, action: #selector(brandButtonPressed(_:)), for: .touchUpInside)
            cell.selectButton.tag = 1
            cell.titleLabel.text = name.capitalized
            cell.checkMarkButton.setImage(UIImage(named: Asset.checksquaregrey), for: .normal)
            
            if self.brandArraySelected.count > 0 {
                if self.brandArraySelected.contains(id) {
                    cell.checkMarkButton.setImage(UIImage(named: Asset.checksquarelightblue), for: .normal)
                }
            }
            self.view.layoutIfNeeded()
            return cell
        } else if (self.featureArray.count > 0) && (tableView == self.featureTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductFilterFeatureTableViewCell, for: indexPath) as! ProductFilterFeatureTableViewCell
            var strid = ""
            var strvalue = ""
            
            if !(self.featureArray[indexPath.section].id.isNilOrEmpty) {
                strid = self.featureArray[indexPath.section].id!
            }
            
            if self.featureArray[indexPath.section].value != nil {
                if self.featureArray[indexPath.section].value!.count > 0 {
                    if !(self.featureArray[indexPath.section].value![indexPath.row].isEmpty) {
                        strvalue = self.featureArray[indexPath.section].value![indexPath.row]
                    }
                }
            }
            cell.selectButton.addTarget(self, action: #selector(featureButtonPressed(_:)), for: .touchUpInside)
            cell.selectButton.tag = indexPath.section
            cell.titleLabel.text = strvalue.capitalized
            cell.checkMarkButton.setImage(UIImage(named: Asset.checksquaregrey), for: .normal)
            
            if !(strid.isEmpty) && !(strvalue.isEmpty) {
                if self.featureArraySelected.count > 0 {
                    for item in featureArraySelected {
                        for (key, value) in (item as! NSDictionary) {
                            if (key as! String) == strid {
                                let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                                if arrayValueCode.count > 0 {
                                    if arrayValueCode.contains(strvalue) {
                                        cell.checkMarkButton.setImage(UIImage(named: Asset.checksquarelightblue), for: .normal)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            self.view.layoutIfNeeded()
            return cell
        } else if (self.specificationArray.count > 0) && (tableView == self.specificationTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductFilterSpecificationTableViewCell, for: indexPath) as! ProductFilterSpecificationTableViewCell
            var strid = ""
            var strvalue = ""
            
            if !(self.specificationArray[indexPath.section].id.isNilOrEmpty) {
                strid = self.specificationArray[indexPath.section].id!
            }
            
            if self.specificationArray[indexPath.section].value != nil {
                if self.specificationArray[indexPath.section].value!.count > 0 {
                    if !(self.specificationArray[indexPath.section].value![indexPath.row].isEmpty) {
                        strvalue = self.specificationArray[indexPath.section].value![indexPath.row]
                    }
                }
            }
            cell.selectButton.addTarget(self, action: #selector(specificationButtonPressed(_:)), for: .touchUpInside)
            cell.selectButton.tag = indexPath.section
            cell.titleLabel.text = strvalue.capitalized
            cell.checkMarkButton.setImage(UIImage(named: Asset.checksquaregrey), for: .normal)
            
            if !(strid.isEmpty) && !(strvalue.isEmpty) {
                if self.specificationArraySelected.count > 0 {
                    for item in specificationArraySelected {
                        for (key, value) in (item as! NSDictionary) {
                            if (key as! String) == strid {
                                let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                                if arrayValueCode.count > 0 {
                                    if arrayValueCode.contains(strvalue) {
                                        cell.checkMarkButton.setImage(UIImage(named: Asset.checksquarelightblue), for: .normal)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            self.view.layoutIfNeeded()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductFilterStyleTableViewCell, for: indexPath) as! ProductFilterStyleTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 50
    //    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let rect = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        let headerView = UIView(frame: rect)
        headerView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        var name = ""
        if (self.styleArray.count > 0) && (tableView == self.styleTableView) {
        } else if (self.brandArray.count > 0) && (tableView == self.brandTableView) {
        } else if (self.featureArray.count > 0) && (tableView == self.featureTableView) {
            if !(self.featureArray[section].id.isNilOrEmpty) {
                name = self.featureArray[section].id!.capitalized
            } else {
                name = ""
            }
        } else if (self.specificationArray.count > 0) && (tableView == self.specificationTableView) {
            if !(self.specificationArray[section].id.isNilOrEmpty) {
                name = self.specificationArray[section].id!.capitalized
            } else {
                name = ""
            }
        }
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 5, width: Int(tableView.bounds.size.width) - 32, height: 40))
        headerLabel.text = name
        headerLabel.font = AppFont.regular.size(13.0)
        headerLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
        headerLabel.numberOfLines = 1
        headerLabel.textAlignment = .left
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        self.view.layoutIfNeeded()
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (self.styleArray.count > 0) && (tableView == self.styleTableView) {
            return 0
        } else if (self.brandArray.count > 0) && (tableView == self.brandTableView) {
            return 0
        } else if (self.featureArray.count > 0) && (tableView == self.featureTableView) {
            if !(self.featureArray[section].id.isNilOrEmpty) {
                return 50
            } else {
                return 0
            }
        } else if (self.specificationArray.count > 0) && (tableView == self.specificationTableView) {
            if !(self.specificationArray[section].id.isNilOrEmpty) {
                return 50
            } else {
                return 0
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if (self.styleArray.count > 0) && (tableView == self.styleTableView) {
            return 0
        } else if (self.brandArray.count > 0) && (tableView == self.brandTableView) {
            return 0
        } else if (self.featureArray.count > 0) && (tableView == self.featureTableView) {
            if !(self.featureArray[section].id.isNilOrEmpty) {
                return 50
            } else {
                return 0
            }
        } else if (self.specificationArray.count > 0) && (tableView == self.specificationTableView) {
            if !(self.specificationArray[section].id.isNilOrEmpty) {
                return 50
            } else {
                return 0
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
