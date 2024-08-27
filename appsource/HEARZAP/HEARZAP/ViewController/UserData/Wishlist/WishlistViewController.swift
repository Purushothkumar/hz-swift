//
//  WishlistViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 11/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class WishlistViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var wishlistCollectionView: UICollectionView!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var errorTapButton: FootnoteOutlineButton!

    // MARK: - Lets and Var
    var wishlistViewModel = WishlistViewModel()
    var isFrom = ""

    var wishlistArray = [WishlistModelData]()

    let wishlistCollectionViewMargin = 0
    let wishlistCollectionViewItemSpacing = CGFloat(8)
    var wishlistCollectionViewItemHeight = CGFloat(178)
    var wishlistCollectionViewItemWidth = CGFloat(139)
    let wishlistCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var productID = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.commonAPICALL(retryAPIID: 1000)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
        self.errorView.isHidden = true
        self.setNavigationBar()
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.wishlist
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.primaryMessageLabel.text = AppLocalizationString.noItemsaddedtothewishlist
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
    func reloadWishlistCollectionView() {
        self.wishlistCollectionViewItemWidth = (screenFrameWidth - 8) / 2
        self.wishlistCollectionViewItemHeight = (239.38 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight + 38 + 2
        self.wishlistCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        self.wishlistCollectionViewlayout.itemSize = CGSize(width: self.wishlistCollectionViewItemWidth, height: self.wishlistCollectionViewItemHeight)
        self.wishlistCollectionViewlayout.minimumLineSpacing = self.wishlistCollectionViewItemSpacing
        self.wishlistCollectionViewlayout.minimumInteritemSpacing = self.wishlistCollectionViewItemSpacing
        self.wishlistCollectionViewlayout.scrollDirection = .vertical
        self.wishlistCollectionView!.collectionViewLayout = self.wishlistCollectionViewlayout

        self.wishlistCollectionView.dataSource = self
        self.wishlistCollectionView.delegate = self
        self.wishlistCollectionView.reloadData()
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getWishlist(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.getWishlist(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 3000 {
                    self.postWishlist(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getWishlist(retryAPIID: Int, canShowLoader: Bool) {
        self.wishlistViewModel.getWishlist(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getWishlist, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postWishlist(retryAPIID: Int, canShowLoader: Bool) {
        let param = String(format: "product_id=%@&mode=remove", self.productID)
        self.wishlistViewModel.postWishlist(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postWishlist, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func errorTapButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
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
        return "[]"
    }
}

extension WishlistViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if isFrom == IsNavigateFrom.wishlistMenu.rawValue {
            UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.sceneDelegate?.navigateToCustomTabbar()
        } else if isFrom == IsNavigateFrom.wishlistCart.rawValue {
            self.navigateBackToCartDetailViewController()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {
    }
}
extension WishlistViewController: ProtocolNetworkRechabilityDelegate {
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

extension WishlistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wishlistArray.count

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.WishlistCollectionViewCell, for: indexPath) as! WishlistCollectionViewCell
        cell.configure(product: wishlistArray[indexPath.item], indexpath: indexPath.item)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.wishlistCollectionView {
            if self.wishlistArray.count > 0 {
                cellWidth = self.wishlistCollectionViewItemWidth
                cellHeight = self.wishlistCollectionViewItemHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension WishlistViewController: ProtocolWishlistCollectionViewCell {
    func removeWishlistButtonPressedWishlistCollectionViewCell(senderTag: Int) {
        self.productID = ""
        if self.wishlistArray.count > 0 {
            if self.wishlistArray[senderTag] !=  nil {
                if self.wishlistArray[senderTag].id != nil {
                    self.productID = String(format: "%d", self.wishlistArray[senderTag].id!)
                    if !(self.productID.isEmpty) {
                        self.showDeletePopupScreen(isDelete: false)
                    }
                }
            }
        }
    }
    func viewProductButtonPressedWishlistCollectionViewCell(senderTag: Int) {
        var categorySlug = ""
        var productSlug = ""

        if self.wishlistArray.count > 0 {
            if self.wishlistArray[senderTag] != nil {
                if !(self.wishlistArray[senderTag].category.isNilOrEmpty) {
                    categorySlug = self.wishlistArray[senderTag].category!
                }
                if !(self.wishlistArray[senderTag].slug.isNilOrEmpty) {
                    productSlug = self.wishlistArray[senderTag].slug!
                }
                if !(categorySlug.isEmpty) && !(productSlug.isEmpty) {
                    if categorySlug.lowercased() == "hearing-aids" {
                        self.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productDetailWishlist.rawValue, productslug: productSlug)
                    } else {
                        self.navigateToProductDetailViewController(isFrom: IsNavigateFrom.productDetailWishlist.rawValue, productslug: productSlug)
                    }
                }
            }
        }
    }
}
extension WishlistViewController: BottomPopupDelegate, ProtocolBottomSheetCommonDeleteViewControllerDelegate {

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

        let primaryMsgText = AppLocalizationString.removeproductfromwishlist
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
        self.commonAPICALL(retryAPIID: 3000)
    }
}
