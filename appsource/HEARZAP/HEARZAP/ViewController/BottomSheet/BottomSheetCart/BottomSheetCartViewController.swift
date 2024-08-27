//
//  BottomSheetCartViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 16/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup
import FLAnimatedImage

protocol ProtocolBottomSheetCartViewControllerDelegate {
    func updateBottomSheetCartViewController()
}

class BottomSheetCartViewController: BottomPopupViewController {

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var quantityLabel: FootnoteFontLabel!

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!

    @IBOutlet var quantityErrorLabel: FootnoteFontLabel!

    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!

    @IBOutlet var addCartButton: CalloutBackgroundButton!

    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?

    var bottomSheetCartViewModel = BottomSheetCartViewModel()

    var isQuantityUpdate = false
    var isSpecificationUpdate = false

    var cartID = ""
    var productID = ""
    var quantity = ""
    var colorName = ""
    var specificationMsg = ""
    var categorySlug = ""
    //    categorySlug == "hearing-aids"

    var enableButton = false
    var quantityArray = [String]()
    var productSpecficationArray = [ProductSpecification]()
    var selectArray: NSMutableArray = NSMutableArray()

    var delegate: ProtocolBottomSheetCartViewControllerDelegate!

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.productSpecficationArray.count > 0 {
            self.tableViewHeight.constant = CGFloat(self.productSpecficationArray.count * (8/*stack top*/ + 38/*title*/ + 8/*space*/ + 38/*collectionviewHeight*/ + 8/*stack bottom*/)) + 10
            self.tableView.isScrollEnabled = false
        } else {
            self.tableViewHeight.constant = 0
        }
    }
    // MARK: - Set Initial View
    func setInitialView() {
        overrideUserInterfaceStyle = .light
        let view1 = self.mainStackView.arrangedSubviews[1]// titleView
        let view2 = self.mainStackView.arrangedSubviews[2]// collectionview
        let view3 = self.mainStackView.arrangedSubviews[3]// errorview
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        self.setUserInteractionButton()
        if isQuantityUpdate == false && isSpecificationUpdate == false {
            if self.productSpecficationArray.count > 0 {
                for item in self.productSpecficationArray {
                    var keyCode = ""
                    if !(item.name.isNilOrEmpty) {
                        keyCode = item.name!
                    }
                    if !(keyCode.isEmpty) {
                        let dictTemp = NSMutableDictionary()
                        dictTemp.setValue("", forKey: keyCode)
                        self.selectArray.add(dictTemp)
                    }
                }
            } else{
                self.commonAPICALL(retryAPIID: 1003)
            }
        } else {
            if self.productSpecficationArray.count > 0 {
                for item in self.productSpecficationArray {
                    var keyCode = ""
                    var valueCode = ""
                    if !(item.name.isNilOrEmpty) {
                        keyCode = item.name!
                    }
                    if !(keyCode.isEmpty) {
                        let dictTemp = NSMutableDictionary()
                        let value = item.values as! [Value]
                        for itemvalue in value {
                            let dataitem = itemvalue as! Value
                            if dataitem.selected != nil {
                                if dataitem.selected == true {
                                    if !(dataitem.id.isNilOrEmpty) {
                                        valueCode = dataitem.id!
                                        if keyCode.lowercased() == "color" {
                                            colorName = dataitem.id!
                                        }
                                    }
                                }
                            }
                        }
                        dictTemp.setValue(valueCode, forKey: keyCode)
                        self.selectArray.add(dictTemp)
                    }
                }
            }
            self.commonAPICALL(retryAPIID: 1003)
        }
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.reloadTableView()
        self.reloadCollectionView()
        self.tableViewHeight.constant = 0

        if self.productSpecficationArray.count > 0 {
            //            self.tableViewHeight.constant = (CGFloat(self.productSpecficationArray.count) * (38 + 38 + 10)) +  24
            self.tableViewHeight.constant = CGFloat(self.productSpecficationArray.count * (8/*stack top*/ + 38/*title*/ + 8/*space*/ + 38/*collectionviewHeight*/ + 8/*stack bottom*/)) + 24
        }
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.quantityLabel.text = AppLocalizationString.quantity
        self.quantityErrorLabel.text = self.specificationMsg
    }

    // MARK: - Reload
    func reloadCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .horizontal
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = layout
        self.collectionView.reloadData()
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView!.layoutSubviews()
        self.collectionViewHeight.constant = tagHeight
    }
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
                    self.postAddToCart(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 1001 || retryAPIID == 1002 {
                    self.postCartItem(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 1003 {
                    self.postCartItemQuantity(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func postAddToCart(retryAPIID: Int, canShowLoader: Bool) {
        var paramdict  = [String: String]()
        var param  = ""

        for (index, item) in selectArray.enumerated() {
            for (key, value) in (item as! NSDictionary) {
                let valueCode = value as! String
                if !(valueCode.isEmpty) {
                    paramdict[key as! String] = valueCode as! String
                }
            }
        }
        param = String(format: "product_id=%@&quantity=%@&specification=%@", self.productID, self.quantity, paramdict.count > 0  ? self.stringifyArray(json: paramdict, prettyPrinted: false) : "{}")

        self.bottomSheetCartViewModel.postAddToCart(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postAddToCart, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    func postCartItem(retryAPIID: Int, canShowLoader: Bool) {
        var paramdict  = [String: String]()
        var param  = ""

        for (index, item) in selectArray.enumerated() {
            for (key, value) in (item as! NSDictionary) {
                let valueCode = value as! String
                if !(valueCode.isEmpty) {
                    paramdict[key as! String] = valueCode as! String
                }
            }
        }
        param = String(format: "quantity=%@&specification=%@", self.quantity, paramdict.count > 0  ? self.stringifyArray(json: paramdict, prettyPrinted: false) : "{}")

        let url = "\(SubAPIUrl.postCartItem)\(self.cartID)/"
        self.bottomSheetCartViewModel.postCartItem(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postCartItemQuantity(retryAPIID: Int, canShowLoader: Bool) {
        var paramdict  = [String: String]()
        var param  = ""

        for (index, item) in selectArray.enumerated() {
            for (key, value) in (item as! NSDictionary) {
                let valueCode = value as! String
                if !(valueCode.isEmpty) {
                    paramdict[key as! String] = valueCode as! String
                }
            }
        }
        param = String(format: "product_id=%@&specification=%@", self.productID, paramdict.count > 0  ? self.stringifyArray(json: paramdict, prettyPrinted: false) : "{}")
        self.bottomSheetCartViewModel.postCartItemQuantity(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postCartItemQuantity, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - BottomPopUp Delegate
    override var popupHeight: CGFloat {
        get {
            return height ?? CGFloat(300)
        }
    }
    override var popupTopCornerRadius: CGFloat {
        get {
            return topCornerRadius ?? 0
        }
    }
    func getPopupHeight() -> CGFloat {return height ?? CGFloat(300)}
    func getPopupTopCornerRadius() -> CGFloat {return topCornerRadius ?? 0}
    func getPopupPresentDuration() -> Double {return presentDuration ?? 1.0}
    func getPopupDismissDuration() -> Double {return dismissDuration ?? 1.0}
    func shouldPopupDismissInteractivelty() -> Bool {return shouldDismissInteractivelty ?? true}
    // MARK: - IBAction
    @IBAction func addCartButtonPressed(_ sender: UIButton) {
        if isQuantityUpdate == false && isSpecificationUpdate == false {
            self.commonAPICALL(retryAPIID: 1000)
        } else if isSpecificationUpdate == true {
            self.commonAPICALL(retryAPIID: 1001)
        } else if isQuantityUpdate == true {
            self.commonAPICALL(retryAPIID: 1002)
        }
    }
    // MARK: - Custom Methods
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
        return "{}"
    }
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            self.enableButton = false
            if self.categorySlug.lowercased() == "hearing-aids" {
                if self.productSpecficationArray.count > 0 {
                    if !(self.quantity.isEmpty) && (self.quantityArray.count > 0) {
                        if self.selectArray.count > 0 {
                            self.enableButton = true
                            for (index, item) in self.selectArray.enumerated() {
                                for (key, value) in (item as! NSDictionary) {
                                    let valueCode = value as! String
                                    if valueCode.isEmpty {
                                        self.enableButton = false
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                if self.productSpecficationArray.count > 0 {
                    if !(self.quantity.isEmpty) && (self.quantityArray.count > 0) {
                        if self.selectArray.count > 0 {
                            self.enableButton = true
                            for (index, item) in self.selectArray.enumerated() {
                                for (key, value) in (item as! NSDictionary) {
                                    let valueCode = value as! String
                                    if valueCode.isEmpty {
                                        self.enableButton = false
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if !(self.quantity.isEmpty) && (self.quantityArray.count > 0) {
                        self.enableButton = true
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
        self.addCartButton.isUserInteractionEnabled = false
        self.addCartButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.addCartButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.addCartButton.setNeedsDisplay()
        self.addCartButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.addCartButton.isUserInteractionEnabled = true
        self.addCartButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.addCartButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.addCartButton.setNeedsDisplay()
        self.addCartButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
}
extension BottomSheetCartViewController: ProtocolNetworkRechabilityDelegate {
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
extension BottomSheetCartViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productSpecficationArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BottomSheetCartSpecificationTableViewCell, for: indexPath) as! BottomSheetCartSpecificationTableViewCell
        cell.configure(specification: self.productSpecficationArray[indexPath.row], indexpath: indexPath.row, viewCon: self)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableViewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}

extension BottomSheetCartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.quantityArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BottomSheetCartQuantityCollectionViewCell, for: indexPath) as! BottomSheetCartQuantityCollectionViewCell
        cell.configure(quantityTag: self.quantityArray[indexPath.item], indexpath: indexPath.item, quantity: self.quantity)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.quantityArray.count > 0 {
            let tag = "  \(self.quantityArray[indexPath.item])  "
            let font = AppFont.regular.size(13)
            let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
            cellWidth = 12 + size.width + 12
            cellHeight = tagHeight
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension BottomSheetCartViewController: ProtocolBottomSheetCartQuantityCollectionViewCell {
    func tagButtonPressedBottomSheetCartQuantityCollectionViewCell(senderTag: Int) {
        self.quantity = self.quantityArray[senderTag]
        self.reloadCollectionView()
        self.setUserInteractionButton()
    }
}
