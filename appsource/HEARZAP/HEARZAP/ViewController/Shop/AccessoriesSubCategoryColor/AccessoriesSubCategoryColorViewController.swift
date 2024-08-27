//
//  AccessoriesSubCategoryColorViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 10/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class AccessoriesSubCategoryColorViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var accessoriesSubcategoryTitleView: UIView!
    @IBOutlet var accessoriesSubcategoryTitleLabel: Title2FontLabel!
    @IBOutlet var accessoriesSubcategoryDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var accessoriesSubcategoryColorView: UIView!
    @IBOutlet var accessoriesSubcategoryColorTableView: UITableView!
    @IBOutlet var accessoriesSubcategoryColorTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var accessoriesSubcategoryProductView: UIView!
    @IBOutlet var accessoriesSubcategoryProductCollectionView: UICollectionView!
    @IBOutlet var accessoriesSubcategoryProductCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var loadMoreView: UIView!
    @IBOutlet var loadMoreButton: BackgroundButton!
    
    @IBOutlet var errorView: UIView!
    @IBOutlet var errorViewHeight: NSLayoutConstraint!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    
    // MARK: - Lets and Var
    var accessoriesSubCategoryColorViewModel = AccessoriesSubCategoryColorViewModel()
    var accessoriesSubcategoriesArray = [SubCategorySpec]()
    var accessoriesProductListArray = [ShopProductList]()
    var accessoriesSubcategoriesSlug = ""
    var accessoriesSubcategoriesTitle = ""
    var accessoriesSubcategoriesDescription = ""
    var accessoriesSubcategoriesImage = ""
    
    var pageNumber = 1
    var hasnext = false
    var quantity = ""
    
    let accessoriesSubcategoryProductCollectionViewMargin = 0
    let accessoriesSubcategoryProductCollectionViewItemSpacing = CGFloat(2)
    var accessoriesSubcategoryProductCollectionViewItemHeight = CGFloat(178)
    var AccessoriesSubcategoryProductCollectionViewItemWidth = CGFloat(139)
    let accessoriesSubcategoryProductCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty) {
            self.quantity = ""
            self.commonAPICALL(retryAPIID: 2000)
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.accessoriesSubcategoriesArray.count > 0 && (self.accessoriesSubcategoriesSlug.lowercased() == AppLocalizationString.batteries.lowercased()) {
            self.accessoriesSubcategoryColorTableViewHeight.constant = self.accessoriesSubcategoryColorTableView.contentSize.height + CGFloat(20)
        } else {
            self.accessoriesSubcategoryColorTableViewHeight.constant = 0
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
        self.accessoriesSubcategoryColorTableView.tableFooterView = UIView()
        self.accessoriesSubcategoryColorTableView.separatorColor = UIColor.clear
        self.accessoriesSubcategoryColorTableView.backgroundColor = UIColor.clear
        self.accessoriesSubcategoryColorTableView.rowHeight = UITableView.automaticDimension
        self.accessoriesSubcategoryColorTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadaccessoriesSubcategoryColorTableViewList()
        self.commonAPICALL(retryAPIID: 1000)
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
        self.accessoriesSubcategoryTitleLabel.text = self.accessoriesSubcategoriesTitle
        self.accessoriesSubcategoryDescriptionLabel.text = self.accessoriesSubcategoriesDescription
        self.primaryMessageLabel.text = AppLocalizationString.noProductsFound
        self.secondaryMessageLabel.text = AppLocalizationString.noProductsDesc
    }
    func reloadAccessoriesSubcategoryProductCollectionView() {
        self.AccessoriesSubcategoryProductCollectionViewItemWidth = (screenFrameWidth - 2) / 2
        self.accessoriesSubcategoryProductCollectionViewItemHeight = (239.38 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
        self.accessoriesSubcategoryProductCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.accessoriesSubcategoryProductCollectionViewlayout.itemSize = CGSize(width: self.AccessoriesSubcategoryProductCollectionViewItemWidth, height: self.accessoriesSubcategoryProductCollectionViewItemHeight)
        self.accessoriesSubcategoryProductCollectionViewlayout.minimumLineSpacing = self.accessoriesSubcategoryProductCollectionViewItemSpacing
        self.accessoriesSubcategoryProductCollectionViewlayout.minimumInteritemSpacing = self.accessoriesSubcategoryProductCollectionViewItemSpacing
        self.accessoriesSubcategoryProductCollectionViewlayout.scrollDirection = .vertical
        self.accessoriesSubcategoryProductCollectionView!.collectionViewLayout = self.accessoriesSubcategoryProductCollectionViewlayout
        
        self.accessoriesSubcategoryProductCollectionView.dataSource = self
        self.accessoriesSubcategoryProductCollectionView.delegate = self
        self.accessoriesSubcategoryProductCollectionView.reloadData()
        
        if self.accessoriesProductListArray.count > 0 {
            if self.accessoriesProductListArray.count % 2 == 0 {
                self.accessoriesSubcategoryProductCollectionViewHeight.constant = ((CGFloat(self.accessoriesProductListArray.count / 2)) * accessoriesSubcategoryProductCollectionViewItemHeight) + (CGFloat((self.accessoriesProductListArray.count / 2)) * 16) + CGFloat(20)
            } else {
                self.accessoriesSubcategoryProductCollectionViewHeight.constant = (CGFloat(self.accessoriesProductListArray.count / 2) * accessoriesSubcategoryProductCollectionViewItemHeight) + (CGFloat((self.accessoriesProductListArray.count / 2)) * 16) + accessoriesSubcategoryProductCollectionViewItemHeight + 16 + CGFloat(20)
            }
        } else {
            self.accessoriesSubcategoryProductCollectionViewHeight.constant = 0
        }
        self.accessoriesSubcategoryProductCollectionView.isScrollEnabled = false
    }
    func reloadaccessoriesSubcategoryColorTableViewList() {
        self.accessoriesSubcategoryColorTableView.delegate = self
        self.accessoriesSubcategoryColorTableView.dataSource = self
        self.accessoriesSubcategoryColorTableView.reloadData()
        self.viewWillLayoutSubviews()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.postAccessoriesSubcategoryProductList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.getCartList(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func postAccessoriesSubcategoryProductList(retryAPIID: Int, canShowLoader: Bool) {
        var param = ""
        var subCategoryType = ""
        if !(accessoriesSubcategoriesArray[0].key.isNilOrEmpty) {
            subCategoryType = accessoriesSubcategoriesArray[0].key!
        }
        else{
            return
        }
        param = String(format: "sub_category=%@&sub_category_type=%@", accessoriesSubcategoriesSlug, subCategoryType )
        self.accessoriesSubCategoryColorViewModel.postAccessoriesSubcategoryProductList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postAccessoriesSubcategoryProductList, methodName: HTTPMethods.post, parameter: param, pageNumber: "\(pageNumber)", retryAPIID: retryAPIID, strQuery: "")
    }
    func getCartList(retryAPIID: Int, canShowLoader: Bool) {
        self.accessoriesSubCategoryColorViewModel.getCartList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCartList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func loadMoreButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Custom Methods
    func checkCartVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginCartAccessoriesSubcategroryColor.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToCartDetailViewController(isFrom: IsNavigateFrom.cartAccessoriesSubcategroryColor.rawValue)
        }
    }
    func verifiedCartUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkCartVerifiedUser()
    }
}

extension AccessoriesSubCategoryColorViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
        self.checkCartVerifiedUser()
        
    }
}
extension AccessoriesSubCategoryColorViewController: ProtocolNetworkRechabilityDelegate {
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

extension AccessoriesSubCategoryColorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.accessoriesProductListArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.AccessoriesSubcategoryProductCollectionViewCell, for: indexPath) as! AccessoriesSubcategoryProductCollectionViewCell
        cell.configure(product: self.accessoriesProductListArray[indexPath.item], indexpath: indexPath.item)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.accessoriesProductListArray.count > 0 {
            cellWidth = self.AccessoriesSubcategoryProductCollectionViewItemWidth
            cellHeight = self.accessoriesSubcategoryProductCollectionViewItemHeight
        }
        self.view.layoutIfNeeded()
        self.viewWillLayoutSubviews()
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension AccessoriesSubCategoryColorViewController: ProtocolAccessoriesSubcategoryProductCollectionViewCell {
    func tapButtonPressedAccessoriesSubcategoryProductCollectionViewCell(senderTag: Int) {}
    func wishlistButtonPressedAccessoriesSubcategoryProductCollectionViewCell(senderTag: Int) {}
}
extension AccessoriesSubCategoryColorViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accessoriesSubcategoriesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.AccessoriesSubCategoryColorImageTableViewCell, for: indexPath) as! AccessoriesSubCategoryColorImageTableViewCell
        cell.configure(accessoriesSubcategoriesImage: self.accessoriesSubcategoriesImage, subCategorySpec: self.accessoriesSubcategoriesArray[indexPath.item], indexpath: indexPath.item)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == self.accessoriesSubcategoryColorTableView && self.accessoriesSubcategoriesArray.count > 0 {
            self.accessoriesSubcategoryColorTableViewHeight.constant = tableView.contentSize.height + CGFloat(20)
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension AccessoriesSubCategoryColorViewController: ProtocolAccessoriesSubCategoryColorImageTableViewCell {
    func tapButtonPressedAccessoriesSubCategoryColorImageTableViewCell(senderTag: Int) {
        if self.accessoriesProductListArray[senderTag].slug.isNilOrEmpty {
            self.navigateToProductDetailViewController(isFrom: IsNavigateFrom.productDetailAccessoriesColor.rawValue, productslug: self.accessoriesProductListArray[senderTag].slug!)
        }
    }
}
