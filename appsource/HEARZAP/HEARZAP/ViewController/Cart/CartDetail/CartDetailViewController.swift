//
//  CartDetailViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 07/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class CartDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var cartLabel: FootnoteFontLabel!

    @IBOutlet var cartView: UIView!
    @IBOutlet var cartTableView: UITableView!
    @IBOutlet var cartTableViewHeight: NSLayoutConstraint!

    @IBOutlet var addItemsButton: FootnoteOutlineButton!

    @IBOutlet var buttonView: UIView!
    @IBOutlet var continueShoppingButton: FootnoteOutlineButton!
    @IBOutlet var checkoutButton: FootnoteBackgroundButton!
    @IBOutlet var buttonViewHeight: NSLayoutConstraint!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var errorTapButton: FootnoteOutlineButton!

    // MARK: - Lets and Var
    var cartDetailViewModel = CartDetailViewModel()

    var cartListArray = [CartDetailModelData]()
    var isFrom = ""

    var cartID = ""

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
        if self.cartListArray.count > 0 {
            self.cartTableView.isScrollEnabled = false
            self.cartTableViewHeight.constant = CGFloat(140 * self.cartListArray.count) + 16
        } else {
            self.cartTableViewHeight.constant = 0
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
        self.errorView.isHidden = true
        self.cartTableView.tableFooterView = UIView()
        self.cartTableView.separatorColor = UIColor.colorLiteral.theme_white_F2F2F2
        self.cartTableView.backgroundColor = UIColor.clear
        self.cartTableView.rowHeight = UITableView.automaticDimension
        self.cartTableView.estimatedRowHeight = UITableView.automaticDimension

        self.checkoutButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.checkoutButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.checkoutButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.checkoutButton.clipsToBounds = true

        self.continueShoppingButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.continueShoppingButton.layer.borderWidth = 1.0
        self.continueShoppingButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.continueShoppingButton.layer.cornerRadius = AppConstantValue.cornerRadius8
        self.continueShoppingButton.clipsToBounds = true

        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.myBag
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.cartLabel.text = AppLocalizationString.itemsaddedtoyourbagbracket
        self.checkoutButton.setTitle(AppLocalizationString.checkout.uppercased(), for: .normal)
        self.continueShoppingButton.setTitle(AppLocalizationString.continueshopping.uppercased(), for: .normal)
        self.addItemsButton.setTitle(AppLocalizationString.addMoreitemsfromwishlist.uppercased(), for: .normal)

        self.primaryMessageLabel.text = AppLocalizationString.noItemsaddedtothecart
        let errorcombination = NSMutableAttributedString()
        let errorTitleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let errorContentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(13)]

        let errorTitle = NSMutableAttributedString(string: String(format: "%@ ", AppLocalizationString.explorehearzap), attributes: errorTitleAttributes as [NSAttributedString.Key: Any])
        let errorContent = NSMutableAttributedString(string: String(format: "%@", AppLocalizationString.onlineShopping), attributes: errorContentFontAttributes as [NSAttributedString.Key: Any])
        errorcombination.append(errorTitle)
        errorcombination.append(errorContent)
        self.secondaryMessageLabel.attributedText = errorcombination
    }
    // MARK: - Reload
    func reloadCartTableView() {
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        self.cartTableView.reloadData()
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getCartList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.removeCartItem(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 {
                    self.postCheckout(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.getCartList(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 2001 { // specification
                    self.getCartItem(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 2002 { // quantity
                    self.getCartItem(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func postCheckout(retryAPIID: Int, canShowLoader: Bool) {
        self.cartDetailViewModel.postCheckout(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postCheckout, methodName: HTTPMethods.post, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getCartList(retryAPIID: Int, canShowLoader: Bool) {
        self.cartDetailViewModel.getCartList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCartList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    func getCartItem(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getCartItem)\(self.cartID)/"
        self.cartDetailViewModel.getCartItem(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func removeCartItem(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "cart_id=%@", self.cartID)
        self.cartDetailViewModel.removeCartItem(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.removeCartItem, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    // MARK: - IBAction
    @IBAction func addItemsButtonPressed(_ sender: UIButton) { // redirect to Wishlist
        self.navigateToWishlistViewController(isFrom: IsNavigateFrom.wishlistCart.rawValue)
    }
    @IBAction func continueShoppingButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()    }
    @IBAction func checkoutButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1002)
    }
    @IBAction func errorTapButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    // MARK: - Custom Methods

}

extension CartDetailViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if isFrom == IsNavigateFrom.cartHearingCare.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else  if isFrom == IsNavigateFrom.cartStore.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabStores, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if isFrom == IsNavigateFrom.cartShop.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if isFrom == IsNavigateFrom.cartMenu.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if isFrom == IsNavigateFrom.cartViewAll.rawValue || isFrom == IsNavigateFrom.cartAccessoriesSubcategrory.rawValue || isFrom == IsNavigateFrom.cartAccessoriesSubcategroryColor.rawValue || isFrom == IsNavigateFrom.cartProductDetailLogo.rawValue {
            self.navigateBackToViewController()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {
    }
}
extension CartDetailViewController: ProtocolNetworkRechabilityDelegate {
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

extension CartDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CartDetailTableViewCell, for: indexPath) as! CartDetailTableViewCell
        cell.configure(data: self.cartListArray[indexPath.row], indexpath: indexPath.row)
        cell.delegate = self
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
        self.cartTableViewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension CartDetailViewController: ProtocolCartDetailTableViewCell {
    func quantityButtonPressedCartDetailTableViewCell(senderTag: Int) {
        if self.cartListArray.count > 0 {
            if self.cartListArray[senderTag].id != nil {
                self.cartID = String(format: "%d", self.cartListArray[senderTag].id!)
                self.commonAPICALL(retryAPIID: 2002)
            }
        }
    }
    func optionsButtonPressedCartDetailTableViewCell(senderTag: Int) {
        if self.cartListArray.count > 0 {
            if self.cartListArray[senderTag].id != nil {
                self.cartID = String(format: "%d", self.cartListArray[senderTag].id!)
                self.commonAPICALL(retryAPIID: 2001)
            }
        }
    }
    func deleteButtonPressedCartDetailTableViewCell(senderTag: Int) {
        if self.cartListArray.count > 0 {
            if self.cartListArray[senderTag].id != nil {
                self.cartID = String(format: "%d", self.cartListArray[senderTag].id!)
                self.showDeletePopupScreen(isDelete: false)
            }
        }
    }
}

extension CartDetailViewController: ProtocolBottomSheetCartViewControllerDelegate, BottomPopupDelegate, ProtocolBottomSheetCommonDeleteViewControllerDelegate {
    // MARK: - DeletePopupScreen
    func showPopupScreen(isQuantityUpdate: Bool, isSpecificationUpdate: Bool, productID: String, cartID: String, quantity: String, productSpecficationArray: [ProductSpecification], categorySlug: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetCartViewController) as? BottomSheetCartViewController else { return }
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true

        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0
        let defaultheight: CGFloat = screenFrameHeight * (2 / 3)

        let popvcheight = defaultheight
        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        popupVC.height = popvcheight + bottomPadding + topPadding
        popupVC.popupDelegate = self
        popupVC.delegate = self
        popupVC.isQuantityUpdate = isQuantityUpdate
        popupVC.isSpecificationUpdate = isSpecificationUpdate
        popupVC.productID = productID
        popupVC.cartID = cartID
        popupVC.quantity = quantity
        popupVC.categorySlug = categorySlug
        popupVC.productSpecficationArray = productSpecficationArray

        self.present(popupVC, animated: true, completion: nil)
    }

    // MARK: - ProtocolBottomSheetCommonDeleteViewControllerDelegate
    func updateBottomSheetCartViewController() {
        self.commonAPICALL(retryAPIID: 2000)
    }

    // MARK: - DeletePopupScreen
    func showDeletePopupScreen(isDelete: Bool) {
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetCommonDeleteViewController) as? BottomSheetCommonDeleteViewController else { return }
        popupVC.topCornerRadius = CGFloat(25)
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0

        let primaryMsgText = AppLocalizationString.removeitemfromcart
        let secondaryMsgText = AppLocalizationString.areyousureyouwanttoremove
        let deleteText = AppLocalizationString.yesremove
        let cancelText = AppLocalizationString.nocancel

        let popvcheight = 37/*image top*/ + 36/*image height*/ + 25/*image bottom*/ + CGFloat(self.heightForText(text: primaryMsgText, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - 32))/*primary height*/ + 5/*primary bottom*/ + CGFloat(self.heightForText(text: secondaryMsgText, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - 32))/*secondary height*/ + 5/*secondary bottom*/ + 20/*button top*/ + 38/*button height*/ + 25/*button bottom*/

        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        popupVC.height = popvcheight + bottomPadding + topPadding

        popupVC.popupDelegate = self
        popupVC.protocolBottomSheetCommonDeleteViewControllerDelegate = self
        popupVC.primaryMsgText = primaryMsgText
        popupVC.secondaryMsgText = secondaryMsgText
        popupVC.deleteText = deleteText
        popupVC.cancelText = cancelText
        popupVC.isDelete = isDelete

        self.present(popupVC, animated: true, completion: nil)
    }

    // MARK: - ProtocolBottomSheetCommonDeleteViewControllerDelegate
    func deleteButtonPressedBottomSheetCommonDeleteViewController() {
        self.commonAPICALL(retryAPIID: 1001)
    }
}
