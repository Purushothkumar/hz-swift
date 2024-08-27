//
//  ViewAllProductViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 02/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import MapKit

protocol ProtocolViewAllProductViewController {
    func tapButtonPressedViewAllProductViewController(selectedTab: Int)
}

class ViewAllProductViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var shopTitleView: UIView!
    @IBOutlet var titleLabel: Title2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var collectionListView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var loadMoreView: UIView!
    @IBOutlet var loadMoreButton: CalloutBackgroundButton!
    
    @IBOutlet var errorView: UIView!
    @IBOutlet var errorViewHeight: NSLayoutConstraint!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    
    // MARK: - Lets and Var
    var tabSelectedIndex = 0
    var viewAllProductViewModel = ViewAllProductViewModel()
    var delegate: ProtocolViewAllProductViewController?
    
    var listArray = [ShopProductList]()
    var filterSlug = ""
    var viewAllSlug = ""
    var pageNumber = 1
    var hasnext = false
    var styleID: Int?
    var collectionListTitle = ""
    var collectionListDescription = ""
    var quantity = ""
    var isFrom = ""
    
    let collectionViewMargin = 0
    let collectionViewItemSpacing = CGFloat(8)
    var collectionViewItemHeight = CGFloat(178)
    var collectionViewItemWidth = CGFloat(139)
    let collectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty) {
            self.quantity = ""
            self.commonAPICALL(retryAPIID: 2001)
        }
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
        self.setNavigationBar()
        if ViewAllProductFilter.latest.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 1000)
        } else if ViewAllProductFilter.hotDeals.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 1001)
        } else  if ViewAllProductFilter.style.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 1002)
        } else  if ViewAllProductFilter.price.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 1003)
        } else  if ViewAllProductFilter.brand.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 1004)
        } else  if ViewAllProductFilter.accessories.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 2000)
        }
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = false
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = self.quantity == "" ? Asset.bagblue : Asset.bagnotificationblue
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.tabShop
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.titleLabel.text = self.collectionListTitle.capitalized
        self.descriptionLabel.text = self.collectionListDescription.capitalized
        self.loadMoreButton.setTitle(AppLocalizationString.loadmore.uppercased(), for: .normal)
        self.primaryMessageLabel.text = AppLocalizationString.noProductsFound
        self.secondaryMessageLabel.text = AppLocalizationString.noProductsDesc
    }
    // MARK: - Reload
    func reloadcollectionView() {
        self.collectionViewItemWidth = (screenFrameWidth - 8) / 2
        self.collectionViewItemHeight = (239.38 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
        self.collectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionViewlayout.itemSize = CGSize(width: self.collectionViewItemWidth, height: self.collectionViewItemHeight)
        self.collectionViewlayout.minimumLineSpacing = self.collectionViewItemSpacing
        self.collectionViewlayout.minimumInteritemSpacing = self.collectionViewItemSpacing
        self.collectionViewlayout.scrollDirection = .vertical
        self.collectionView!.collectionViewLayout = self.collectionViewlayout
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
        
        if self.listArray.count > 0 {
            if self.listArray.count % 2 == 0 {
                self.collectionViewHeight.constant = (CGFloat(self.listArray.count / 2) * collectionViewItemHeight) + ((CGFloat(self.listArray.count / 2)) * 8) + 20
            } else {
                self.collectionViewHeight.constant = (CGFloat(self.listArray.count / 2) * collectionViewItemHeight) + ((CGFloat(self.listArray.count / 2)) * 8)  + collectionViewItemHeight + 8 + 20
            }
        } else {
            self.collectionViewHeight.constant = 0
        }
        self.collectionView.isScrollEnabled = false
    }
    
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getHearingAidLatestProductlist(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getHearingAidHotDealsProductlist(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 {
                    self.getHearingAidStyleProductlist(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1003 {
                    self.getHearingAidPriceRangeList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1004 {
                    self.getHearingAidBrandList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.getAccessoriesFilterList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2001 {
                    self.getCartList(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getHearingAidLatestProductlist(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getHearingAidViewAllList)\(viewAllSlug)/"
        self.viewAllProductViewModel.getHearingAidLatestProductlist(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(pageNumber)", retryAPIID: retryAPIID, strQuery: "")
    }
    func getHearingAidHotDealsProductlist(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getHearingAidViewAllList)\(viewAllSlug)/"
        self.viewAllProductViewModel.getHearingAidHotDealsProductlist(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(pageNumber)", retryAPIID: retryAPIID, strQuery: "")
    }
    
    func getHearingAidStyleProductlist(retryAPIID: Int, canShowLoader: Bool) {
        let strQuery = String(format: "&\(AppLocalizationString.style.lowercased())=%d", self.styleID!)
        self.viewAllProductViewModel.getHearingAidStyleProductlist(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getHearingAidViewAllList, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(pageNumber)", retryAPIID: retryAPIID, strQuery: strQuery)
    }
    func getHearingAidPriceRangeList(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getHearingAidPriceRangeList)\(viewAllSlug)/"
        self.viewAllProductViewModel.getHearingAidPriceRangeList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(pageNumber)", retryAPIID: retryAPIID, strQuery: "")
    }
    func getHearingAidBrandList(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getHearingAidBrandList)\(viewAllSlug)/"
        self.viewAllProductViewModel.getHearingAidBrandList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(pageNumber)", retryAPIID: retryAPIID, strQuery: "")
    }
    func getAccessoriesFilterList(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getAccessoriesFilterList)\(viewAllSlug)/"
        self.viewAllProductViewModel.getAccessoriesFilterList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(pageNumber)", retryAPIID: retryAPIID, strQuery: "")
    }
    func getCartList(retryAPIID: Int, canShowLoader: Bool) {
        self.viewAllProductViewModel.getCartList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCartList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func loadMoreButtonPressed(_ sender: UIButton) {
        if ViewAllProductFilter.latest.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 1000)
        } else if ViewAllProductFilter.hotDeals.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 1001)
        } else  if ViewAllProductFilter.style.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 1002)
        } else  if ViewAllProductFilter.price.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 1003)
        } else  if ViewAllProductFilter.brand.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 1004)
        } else if ViewAllProductFilter.accessories.rawValue == filterSlug {
            self.commonAPICALL(retryAPIID: 2000)
        }
    }
    
    // MARK: - Custom Methods
    func checkCartVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginCartViewAll.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToCartDetailViewController(isFrom: IsNavigateFrom.cartViewAll.rawValue)
        }
    }
    func verifiedCartUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkCartVerifiedUser()
    }
}

extension ViewAllProductViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
        self.checkCartVerifiedUser()
    }
}
extension ViewAllProductViewController: ProtocolNetworkRechabilityDelegate {
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

extension ViewAllProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.ViewAllProductCollectionViewCell, for: indexPath) as! ViewAllProductCollectionViewCell
        cell.configure(product: listArray[indexPath.item], indexpath: indexPath.item)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.listArray.count > 0 {
            cellWidth = self.collectionViewItemWidth
            cellHeight = self.collectionViewItemHeight
        }
        self.view.layoutIfNeeded()
        self.viewWillLayoutSubviews()
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension ViewAllProductViewController: ProtocolViewAllProductCollectionViewCell {
    func tapButtonPressedViewAllProductCollectionViewCell(senderTag: Int) {
        if !(self.listArray[senderTag].slug.isNilOrEmpty) {
            if ViewAllProductFilter.accessories.rawValue == filterSlug {
                self.navigateToProductDetailViewController(isFrom: IsNavigateFrom.productDetailViewAll.rawValue, productslug: self.listArray[senderTag].slug!)
            } else {
                self.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productDetailViewAll.rawValue, productslug: self.listArray[senderTag].slug!)
            }
        }
    }
    func wishlistButtonPressedViewAllProductCollectionViewCell(senderTag: Int) {
    }
}
