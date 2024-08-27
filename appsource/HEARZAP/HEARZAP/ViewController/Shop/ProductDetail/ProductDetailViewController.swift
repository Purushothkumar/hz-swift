//
//  ProductDetailViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 12/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup
import WebKit
import YouTubePlayer

class ProductDetailViewController: UIViewController, WKNavigationDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var scrollSelectionView: UIView!
    @IBOutlet var scrollSelectionStackView: UIStackView!
    @IBOutlet var scrollSelectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var scrollAboutView: UIView!
    @IBOutlet var scrollAboutLabel: Caption1FontLabel!
    @IBOutlet var scrollAboutButton: FootnoteOutlineButton!
    
    @IBOutlet var scrollFeatureView: UIView!
    @IBOutlet var scrollFeatureLabel: Caption1FontLabel!
    @IBOutlet var scrollFeatureButton: FootnoteOutlineButton!
    
    @IBOutlet var scrollSpecificationView: UIView!
    @IBOutlet var scrollSpecificationLabel: Caption1FontLabel!
    @IBOutlet var scrollSpecificationButton: FootnoteOutlineButton!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var productImageView: UIView!
    @IBOutlet var productImageCollectionView: UICollectionView!
    @IBOutlet var productImageCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var buttonStackView: UIStackView!
    
    @IBOutlet var wishlistView: UIView!
    @IBOutlet var wishlistImageView: UIImageView!
    @IBOutlet var wishlistButton: FootnoteOutlineButton!
    
    @IBOutlet var productPageControlView: UIView!
    @IBOutlet var productPageControl: UIPageControl!
    @IBOutlet var productPageControlHeight: NSLayoutConstraint!
    
    @IBOutlet var productInfoView: UIView!
    @IBOutlet var productInfoStackView: UIStackView!
    
    @IBOutlet var productBrandView: UIView!
    @IBOutlet var productBrandLabel: CalloutFontLabel!
    
    @IBOutlet var productNameView: UIView!
    @IBOutlet var productNameLabel: HeadlineFontLabel!
    
    @IBOutlet var productPriceView: UIView!
    @IBOutlet var productPriceLabel: CalloutFontLabel!
    
    @IBOutlet var productTaxView: UIView!
    @IBOutlet var productTaxLabel: Caption2FontLabel!
    
    @IBOutlet var productAddtoBagView: UIView!
    @IBOutlet var productAddtoBagButton: CalloutBackgroundButton!
    
    @IBOutlet var productDealsView: UIView!
    @IBOutlet var productDealsStackView: UIStackView!
    
    @IBOutlet var productEasyEMIView: UIView!
    @IBOutlet var productEasyEMILabel: Caption2FontLabel!
    @IBOutlet var productEasyEMIViewWidth: NSLayoutConstraint!
    
    @IBOutlet var productWarrantyView: UIView!
    @IBOutlet var productWarrantyLabel: Caption2FontLabel!
    @IBOutlet var productWarrantyWidth: NSLayoutConstraint!
    
    @IBOutlet var productEasyReturnView: UIView!
    @IBOutlet var productEasyReturnLabel: Caption2FontLabel!
    @IBOutlet var productEasyReturnViewWidth: NSLayoutConstraint!
    
    @IBOutlet var productAboutView: UIView!
    @IBOutlet var productAboutStackView: UIStackView!
    
    @IBOutlet var productAboutTitleView: UIView!
    @IBOutlet var productAboutTitleLabel: FootnoteFontLabel!
    
    @IBOutlet var productAboutDescriptionView: UIView!
    @IBOutlet var webview: WKWebView!
    @IBOutlet var webviewheight: NSLayoutConstraint!
    
    @IBOutlet var productFeatureView: UIView!
    @IBOutlet var productFeatureTitleLabel: FootnoteFontLabel!
    @IBOutlet var productFeatureTableView: UITableView!
    @IBOutlet var productFeatureTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var productLifeStyleStackView: UIStackView!
    @IBOutlet var productLifeStyleContentView: UIView!
    
    @IBOutlet var productSpecificationView: UIView!
    @IBOutlet var productSpecificationTitleLabel: FootnoteFontLabel!
    @IBOutlet var productSpecificationTableView: UITableView!
    @IBOutlet var productSpecificationTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var productDVStackView: UIStackView!
    @IBOutlet var productDVTitleLabel: FootnoteFontLabel!
    
    @IBOutlet var dvPlayerView: UIView!
    @IBOutlet var dvYouTubePlayerView: YouTubePlayerView!
    
    @IBOutlet var productBoxView: UIView!
    @IBOutlet var productBoxTitleLabel: FootnoteFontLabel!
    @IBOutlet var productBoxTableView: UITableView!
    @IBOutlet var productBoxTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var productCMStackView: UIStackView!
    @IBOutlet var productCMTitleLabel: FootnoteFontLabel!
    
    @IBOutlet var cmPlayerView: UIView!
    @IBOutlet var cmYouTubePlayerView: YouTubePlayerView!
    
    @IBOutlet var productAccessoriesTitleView: UIView!
    @IBOutlet var productAccessoriesViewTitleLabel: CalloutFontLabel!
    
    @IBOutlet var productAccessoriesContentView: UIView!
    @IBOutlet var productAccessoriesStackView: UIStackView!
    
    @IBOutlet var productAccessoriesView: UIView!
    @IBOutlet var productAccessoriesTableView: UITableView!
    @IBOutlet var productAccessoriesTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var productAccessoriesImageView: UIView!
    @IBOutlet var productAccessoriesProduct1ImageView: UIImageView!
    @IBOutlet var productAccessoriesProduct2ImageView: UIImageView!
    @IBOutlet var productAccessoriesProduct3ImageView: UIImageView!
    @IBOutlet var productAccessoriesPlus1ImageView: UIImageView!
    @IBOutlet var productAccessoriesPlus2ImageView: UIImageView!
    
    @IBOutlet var productAddAccessoriestoBagButton: CalloutBackgroundButton!
    
    @IBOutlet var productSuggestionTitleView: UIView!
    @IBOutlet var productSuggestionTitleLabel: CalloutFontLabel!
    
    @IBOutlet var productSuggestionView: UIView!
    @IBOutlet var productSuggestionCollectionView: UICollectionView!
    @IBOutlet var productSuggestionCollectionViewHeight: NSLayoutConstraint!
    
    // MARK: - Lets and Var
    var productDetailViewModel = ProductDetailViewModel()
    var productPhotoArray = [String]()
    var productFeatureArray = [ProductFeature]()
    var productLifeStyleArray = [ProductLifestyle]()
    var productSpecificationArray = [ProductSpecification]()
    var productBoxArray = [ProductBoxing]()
    var product: ShopProductList?
    var productSuggestionArray = [RelatedProduct]()
    
    var productAccessoriesSelectedArray = [String]()
    var productAccessoriesArray = [ShopProductList]()
    
    var isWishlist = false
    var about = ""
    var productslug = ""
    var productUID = ""
    var productID = ""
    var categorySlug = ""
    
    var warrantyInYears = ""
    var emiAvailable = ""
    var returnPeriod = ""
    var isFrom = ""
    
    var isReturnAvailable = false
    var isWarrantyAvailable = false
    var isEmiAvailable = false
    
    var canShowDemoVideo = false
    var canShowCMVideo = false
    var canShowBox = false
    
    var isProductAvailable = false
    
    //    var productImageCollectionView_index = 1
    var timerBanner = Timer()
    var timerRelatedProducts = Timer()
    var newOffsetX: CGFloat = 0.0
    var quantity = ""
    
    let productImageCollectionViewMargin = CGFloat(0)
    let productImageCollectionViewItemSpacing = CGFloat(0)
    var productImageCollectionViewItemHeight = CGFloat(367.17)
    var productImageCollectionViewItemWidth = CGFloat(343)
    let productImageCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let productSuggestionCollectionViewMargin = CGFloat(0)
    let productSuggestionCollectionViewItemSpacing =  CGFloat(16)
    var productSuggestionCollectionViewItemHeight = CGFloat(178)
    var productSuggestionCollectionViewItemWidth = CGFloat(139)
    let productSuggestionCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
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
            self.commonAPICALL(retryAPIID: 3000)
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.webviewheight.constant = self.webview.scrollView.contentSize.height
        
        if self.productFeatureArray.count > 0 {
            self.productFeatureTableViewHeight.constant = self.productFeatureTableView.contentSize.height
        } else {
            self.productFeatureTableViewHeight.constant = 0
        }
        if self.productSpecificationArray.count > 0 {
            self.productSpecificationTableViewHeight.constant = self.productSpecificationTableView.contentSize.height
        } else {
            self.productSpecificationTableViewHeight.constant = 0
        }
        if self.productBoxArray.count > 0 {
            self.productBoxTableViewHeight.constant = self.productBoxTableView.contentSize.height
        } else {
            self.productBoxTableViewHeight.constant = 0
        }
        if self.productAccessoriesArray.count > 0 {
            self.productAccessoriesTableViewHeight.constant = self.productAccessoriesTableView.contentSize.height
        } else {
            self.productAccessoriesTableViewHeight.constant = 0
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
        self.setDefaultScrollHeight()
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.mainScrollView.delegate = self
        self.productFeatureTableView.tableFooterView = UIView()
        //        self.productFeatureTableView.separatorColor = UIColor.clear
        self.productFeatureTableView.backgroundColor = UIColor.clear
        self.productFeatureTableView.rowHeight = UITableView.automaticDimension
        self.productFeatureTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.productAccessoriesTableView.tableFooterView = UIView()
        //        self.productAccessoriesTableView.separatorColor = UIColor.clear
        self.productAccessoriesTableView.backgroundColor = UIColor.clear
        self.productAccessoriesTableView.rowHeight = UITableView.automaticDimension
        self.productAccessoriesTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.productBoxTableView.tableFooterView = UIView()
        //        self.productBoxTableView.separatorColor = UIColor.clear
        self.productBoxTableView.backgroundColor = UIColor.clear
        self.productBoxTableView.rowHeight = UITableView.automaticDimension
        self.productBoxTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.productSpecificationTableView.tableFooterView = UIView()
        //        self.productSpecificationTableView.separatorColor = UIColor.clear
        self.productSpecificationTableView.backgroundColor = UIColor.clear
        self.productSpecificationTableView.rowHeight = UITableView.automaticDimension
        self.productSpecificationTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.webview.backgroundColor = UIColor.clear
        self.webview.scrollView.showsHorizontalScrollIndicator = false
        self.webview.scrollView.showsVerticalScrollIndicator = false
        self.webview.translatesAutoresizingMaskIntoConstraints = false
        
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
        self.scrollAboutLabel.text = AppLocalizationString.about
        self.scrollFeatureLabel.text = AppLocalizationString.features
        self.scrollSpecificationLabel.text = AppLocalizationString.specification
        self.productTaxLabel.text = AppLocalizationString.inclusiveofalltaxes
        self.productEasyEMILabel.text = emiAvailable
        self.productWarrantyLabel.text = warrantyInYears
        self.productEasyReturnLabel.text = returnPeriod
        self.productAboutTitleLabel.text = AppLocalizationString.productDescription
        self.productSpecificationTitleLabel.text = AppLocalizationString.specification
        self.productBoxTitleLabel.text = AppLocalizationString.whatinsidethebox
        self.productAccessoriesViewTitleLabel.text = AppLocalizationString.accessoriesboughttogether
        self.productAddAccessoriestoBagButton.setTitle(AppLocalizationString.addtobag.uppercased(), for: .normal)
        self.productSuggestionTitleLabel.text = AppLocalizationString.similarProducts
        self.productDVTitleLabel.text = AppLocalizationString.demoVideo
        self.productCMTitleLabel.text = AppLocalizationString.careMaintenanceVideo
        if self.isProductAvailable == false {
            self.productAddtoBagButton.setTitle(AppLocalizationString.outOfStock.uppercased(), for: .normal)
        } else {
            self.productAddtoBagButton.setTitle(AppLocalizationString.addtobag.uppercased(), for: .normal)
        }
        
    }
    // MARK: - Reload
    func reloadProductFeatureTableView() {
        self.productFeatureTableView.delegate = self
        self.productFeatureTableView.dataSource = self
        self.productFeatureTableView.reloadData()
    }
    func reloadProductSpecificationTableView() {
        self.productSpecificationTableView.delegate = self
        self.productSpecificationTableView.dataSource = self
        self.productSpecificationTableView.reloadData()
    }
    func reloadProductBoxTableView() {
        self.productBoxTableView.delegate = self
        self.productBoxTableView.dataSource = self
        self.productBoxTableView.reloadData()
    }
    func reloadProductAccessoriesTableView() {
        self.productAccessoriesTableView.delegate = self
        self.productAccessoriesTableView.dataSource = self
        self.productAccessoriesTableView.reloadData()
    }
    func reloadProductSuggestionCollectionView() {
        if self.productSuggestionArray.count > 0 {
            self.productSuggestionCollectionViewHeight.constant = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.productSuggestionCollectionViewItemHeight = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.productSuggestionCollectionViewItemWidth = 222 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
            self.productSuggestionCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            self.productSuggestionCollectionViewlayout.itemSize = CGSize(width: self.productSuggestionCollectionViewItemWidth, height: self.productSuggestionCollectionViewItemHeight)
            self.productSuggestionCollectionViewlayout.minimumLineSpacing = self.productSuggestionCollectionViewItemSpacing
            self.productSuggestionCollectionViewlayout.minimumInteritemSpacing = self.productSuggestionCollectionViewItemSpacing
            self.productSuggestionCollectionViewlayout.scrollDirection = .horizontal
            self.productSuggestionCollectionView!.collectionViewLayout = self.productSuggestionCollectionViewlayout
            self.productSuggestionCollectionView.dataSource = self
            self.productSuggestionCollectionView.delegate = self
            self.productSuggestionCollectionView.reloadData()
            if self.productSuggestionArray.count > 1 {
                self.startautoScrollCollectionRelatedProducts()
            }
        } else {
            self.productSuggestionCollectionViewHeight.constant = 0
        }
    }
    
    func reloadProductImageCollectionView() {
        self.productImageCollectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32)
        self.productImageCollectionViewHeight.constant = 367.17 * CGFloat(screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
        self.productImageCollectionViewItemHeight = 367.17 * CGFloat(screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
        self.productImageCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.productImageCollectionViewlayout.itemSize = CGSize(width: self.productImageCollectionViewItemWidth, height: self.productImageCollectionViewItemHeight)
        self.productImageCollectionViewlayout.minimumLineSpacing = self.productImageCollectionViewItemSpacing
        self.productImageCollectionViewlayout.minimumInteritemSpacing = self.productImageCollectionViewItemSpacing
        self.productImageCollectionViewlayout.scrollDirection = .horizontal
        self.productImageCollectionView!.collectionViewLayout = self.productImageCollectionViewlayout
        self.productImageCollectionView.dataSource = self
        self.productImageCollectionView.delegate = self
        self.productImageCollectionView.reloadData()
        self.productPageControl.numberOfPages = self.productPhotoArray.count
        if self.productPhotoArray.count > 1 {
            self.startAutoScrollCollectionBanner()
        }
    }
    func reloadWebView() {
        if !(self.about.isEmpty) {
            self.webview.loadHTMLString("<!DOCTYPE html><head><meta charset='utf-8'><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' /><link href='https://fonts.googleapis.com/css?family=Poppins' rel='stylesheet'><style>:root,* {font-family: 'Poppins';text-align: left;-webkit-user-select: none;user-select: none;}</style></head><body style='color:grey;'>\(self.about)</body>", baseURL: nil)
            self.webview.navigationDelegate = self
            self.webview.reload()
            self.viewWillLayoutSubviews()
        }
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getAccessoriesList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 || retryAPIID == 2001 || retryAPIID == 2002 {
                    self.getAccessoriesList(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 3000 {
                    self.getCartList(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 4000 {
                    self.postWishlist(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getAccessoriesList(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.getAccessoriesList)\(productslug)/view/"
        self.productDetailViewModel.getAccessoriesList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getCartList(retryAPIID: Int, canShowLoader: Bool) {
        self.productDetailViewModel.getCartList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCartList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postWishlist(retryAPIID: Int, canShowLoader: Bool) {
        var productIDArray = [String]()
        productIDArray.append(productID)
        var param = ""
        
        if self.isWishlist == false {
            param = String(format: "product_id=%@&mode=add", productIDArray.count > 0 ? self.stringifyArray(json: productIDArray, prettyPrinted: false) : "[]")
        } else {
            param = String(format: "product_id=%@&mode=remove", self.productID)
        }
        self.productDetailViewModel.postWishlist(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postWishlist, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    
    @IBAction func productAddtoBagButtonPressed(_ sender: UIButton) {
        self.checkCartVerifiedUser()
    }
    @IBAction func productAddAccessoriestoBagButton(_ sender: UIButton) {}
    @IBAction func wishlistButtonPressed(_ sender: UIButton) {
        self.checkWishlistVerifiedUser()
    }
    
    @IBAction func scrollAboutButtonPressed(_ sender: UIButton) {
        self.tapAbout()
    }
    @IBAction func scrollFeatureButtonPressed(_ sender: UIButton) {
        self.tapFeatures()
    }
    @IBAction func scrollSpecificationButtonPressed(_ sender: UIButton) {
        self.tapSpecification()
    }
    // MARK: - Custom Methods
    func setAddtoCartButtonColor() {
        if self.isProductAvailable == false {
            self.productAddtoBagButton.backgroundColor = UIColor.colorLiteral.theme_red_FF6961
            self.productAddtoBagButton.setTitle(AppLocalizationString.outOfStock.uppercased(), for: .normal)
            self.productAddtoBagButton.isUserInteractionEnabled = false
        } else {
            self.productAddtoBagButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
            self.productAddtoBagButton.setTitle(AppLocalizationString.addtobag.uppercased(), for: .normal)
            self.productAddtoBagButton.isUserInteractionEnabled = true
        }
    }
    func setDefaultScrollHeight() {
        self.scrollSelectionViewHeight.constant = 0
        self.scrollSelectionView.isHidden = true
    }
    func setScrollHeight() {
        self.scrollSelectionViewHeight.constant = CGFloat(48)
        self.scrollSelectionView.isHidden = false
    }
    func setDefaultScrollLabelColor() {
        self.scrollAboutLabel.font = AppFont.regular.size(13)
        self.scrollAboutLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.scrollFeatureLabel.font = AppFont.regular.size(13)
        self.scrollFeatureLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.scrollSpecificationLabel.font = AppFont.regular.size(13)
        self.scrollSpecificationLabel.textColor = UIColor.colorLiteral.theme_grey_777777
    }
    func setScrollAboutLabelColor() {
        self.setDefaultScrollLabelColor()
        self.scrollAboutLabel.font = AppFont.medium.size(13)
        self.scrollAboutLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
    }
    func setScrollFeatureLabelColor() {
        self.setDefaultScrollLabelColor()
        self.scrollFeatureLabel.font = AppFont.medium.size(13)
        self.scrollFeatureLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
    }
    func setScrollSpecificationLabelColor() {
        self.setDefaultScrollLabelColor()
        self.scrollSpecificationLabel.font = AppFont.medium.size(13)
        self.scrollSpecificationLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
    }
    
    func tapAbout() {
        let view0 = self.mainStackView.arrangedSubviews[0]// Image Collection
        let view1 = self.mainStackView.arrangedSubviews[1]// PageControl
        let view2 = self.mainStackView.arrangedSubviews[2]// Product Information
        let view3 = self.mainStackView.arrangedSubviews[3]// Deals View
        
        UIView.animate(withDuration: 100) {
            let scrolly = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + 16
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: scrolly), animated: true)
        }
    }
    func tapFeatures() {
        let view0 = self.mainStackView.arrangedSubviews[0]// Image Collection
        let view1 = self.mainStackView.arrangedSubviews[1]// PageControl
        let view2 = self.mainStackView.arrangedSubviews[2]// Product Information
        let view3 = self.mainStackView.arrangedSubviews[3]// Deals View
        let view4 = self.mainStackView.arrangedSubviews[4]// about view
        
        UIView.animate(withDuration: 100) {
            let scrolly = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + 16
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: scrolly), animated: true)
        }
    }
    func tapSpecification() {
        let view0 = self.mainStackView.arrangedSubviews[0]// Image Collection
        let view1 = self.mainStackView.arrangedSubviews[1]// PageControl
        let view2 = self.mainStackView.arrangedSubviews[2]// Product Information
        let view3 = self.mainStackView.arrangedSubviews[3]// Deals View
        let view4 = self.mainStackView.arrangedSubviews[4]// about view
        let view5 = self.mainStackView.arrangedSubviews[5]// Features View
        
        UIView.animate(withDuration: 100) {
            let scrolly = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + 16
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: scrolly), animated: true)
        }
    }
    
    func startAutoScrollCollectionBanner() {
        DispatchQueue.main.async {
            self.timerBanner.invalidate()
            self.timerBanner =  Timer.scheduledTimer(timeInterval: Double(AppConstantValue.timerInterval), target: self, selector: #selector(self.autoScrollCollectionBanner), userInfo: nil, repeats: true)
        }
    }
    func startautoScrollCollectionRelatedProducts() {
        DispatchQueue.main.async {
            self.timerRelatedProducts.invalidate()
            self.timerRelatedProducts =  Timer.scheduledTimer(timeInterval: Double(AppConstantValue.timerIntervalSimilarProducts), target: self, selector: #selector(self.autoScrollCollectionRelatedProducts), userInfo: nil, repeats: true)
        }
    }
    @objc func autoScrollCollectionBanner(_ timer: Timer) {
        if let coll  = self.productImageCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if (indexPath?.item)! < self.productPhotoArray.count - 1 {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(item: (indexPath?.item)! + 1, section: 0)
                    productPageControl.currentPage = (indexPath1?.item)!
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                } else {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(item: 0, section: 0)
                    productPageControl.currentPage = 0
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
            }
        }
    }
    @objc func autoScrollCollectionRelatedProducts(_ timer: Timer) {
        if let coll  = self.productSuggestionCollectionView {
            let initailPoint = CGPoint(x: self.newOffsetX, y: 0)
            if __CGPointEqualToPoint(initailPoint, coll.contentOffset) {
                if self.newOffsetX < coll.contentSize.width {
                    self.newOffsetX += (self.productSuggestionCollectionViewItemWidth + 16)
                }
                if self.newOffsetX > coll.contentSize.width - self.productSuggestionCollectionViewItemWidth {
                    self.newOffsetX = 0
                }
                coll.contentOffset = CGPoint(x: self.newOffsetX, y: 0)
                
            } else {
                self.newOffsetX = coll.contentOffset.x
            }
        }
    }
    func checkCartVerifiedUserLogo() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginCartProductDetailLogo.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToCartDetailViewController(isFrom: IsNavigateFrom.cartProductDetailLogo.rawValue)
        }
    }
    func verifiedCartUserLogo(isFrom: String, isWishlist: Bool, productUID: String) {
        self.commonAPICALL(retryAPIID: 2001)
    }
    func checkCartVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginCartProductDetail.rawValue, isWishlist: false, productUID: "")
        } else {
            self.showPopupScreen()
        }
    }
    func verifiedCartUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.commonAPICALL(retryAPIID: 2000)
    }
    func checkWishlistVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginWishlistProductDetail.rawValue, isWishlist: false, productUID: "")
        } else {
            if self.isWishlist == false {
                self.commonAPICALL(retryAPIID: 4000)
            } else {
                self.showDeletePopupScreen(isDelete: false)
            }
        }
    }
    func verifiedWishlistUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkWishlistVerifiedUser()
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
    // MARK: - GestureRecognizer Delegate
    
    @objc func handleLongPressBanner(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            self.timerBanner.invalidate()
            if self.productPhotoArray.count > 1 {
                self.startAutoScrollCollectionBanner()
            }
            return
        } else if gestureRecognizer.state == .began {
            self.timerBanner.invalidate()
            let pointOfContact = gestureRecognizer.location(in: self.productImageCollectionView)
            let indexPath = self.productImageCollectionView.indexPathForItem(at: pointOfContact)
            if let index = indexPath {
                var cell = self.productImageCollectionView.cellForItem(at: index)
                // do stuff with your cell, for example print the indexPath
                self.productPageControl.currentPage = index.item
            } else {}
        }
    }
    // MARK: - WKWebview Delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if !(self.about.isEmpty) {
                self.webview.loadHTMLString("<!DOCTYPE html><head><meta charset='utf-8'><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' /><link href='https://fonts.googleapis.com/css?family=Poppins' rel='stylesheet'><style>:root,* {font-family: 'Poppins';text-align: left;-webkit-user-select: none;user-select: none;}</style></head><body style='color:grey;'>\(self.about)</body>", baseURL: nil)
            }
            self.webview.frame.size.height = 1
            self.webview.frame.size = webView.scrollView.contentSize
            self.webviewheight.constant = webView.scrollView.contentSize.height
            self.view.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        }
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard case .linkActivated = navigationAction.navigationType,
              let url = navigationAction.request.url
        else {
            decisionHandler(.allow)
            return
        }
        decisionHandler(.cancel)
        var websiteLink = ""
        websiteLink = navigationAction.request.url?.absoluteString ?? ""
        if !(websiteLink.isEmpty) {
            guard let appURL = URL(string: websiteLink.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    
}

extension ProductDetailViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.productDetailShopHA.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.productDetailShopAccessories.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.productDetailAccessoriesSubcategory.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.productDetailAccessoriesColor.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.productDetailViewAll.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.productDetailRegisterDevice.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.productDetail.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.productCompareDetail.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.productDetailFHA.rawValue {
            self.navigateBackToFindRightDeviceRecommendViewController()
        } else if self.isFrom == IsNavigateFrom.productDetailWishlist.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.productDetailShopFHA.rawValue {
            self.navigateBackToViewController()
        } else if self.isFrom == IsNavigateFrom.productDetailShopOffer.rawValue {
            self.navigateBackToViewController()
        } else {
            self.navigateBackToViewController()
        }
        
    }
    func rightButtonPressed() {
        self.checkCartVerifiedUserLogo()
    }
}
extension ProductDetailViewController: ProtocolNetworkRechabilityDelegate {
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
extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.productImageCollectionView {
            if self.productPhotoArray.count > 0 {
                return self.productPhotoArray.count
            } else {
                return 1
            }
        } else {
            return self.productSuggestionArray.count
        }
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.productImageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.ProductDetailImageCollectionViewCell, for: indexPath) as! ProductDetailImageCollectionViewCell
            var imgurl = ""
            if self.productPhotoArray.count > 0 {
                if !(self.productPhotoArray[indexPath.item].isEmpty) {
                    imgurl = self.productPhotoArray[indexPath.item]
                }
            }
            cell.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.ProductDetailSuggestionCollectionViewCell, for: indexPath) as! ProductDetailSuggestionCollectionViewCell
            cell.configure(relatedProduct: self.productSuggestionArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        
        if collectionView == self.productImageCollectionView {
            cellWidth = self.productImageCollectionViewItemWidth
            cellHeight = self.productImageCollectionViewItemHeight
        } else if collectionView == self.productSuggestionCollectionView {
            if self.productSuggestionArray.count > 0 {
                cellWidth = self.productSuggestionCollectionViewItemWidth
                cellHeight = self.productSuggestionCollectionViewItemHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
    // MARK: - Scrollview Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.productPhotoArray.count > 1 {
            for cell in self.productImageCollectionView.visibleCells {
                let indexPath = self.productImageCollectionView.indexPath(for: cell)
                self.productPageControl.currentPage = indexPath!.item
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.mainScrollView {
            let view0 = self.mainStackView.arrangedSubviews[0]// Image Collection
            let view1 = self.mainStackView.arrangedSubviews[1]// PageControl
            let view2 = self.mainStackView.arrangedSubviews[2]// Product Information
            let view3 = self.mainStackView.arrangedSubviews[3]// Deals View
            let view4 = self.mainStackView.arrangedSubviews[4]// about view
            let view5 = self.mainStackView.arrangedSubviews[5]// Features View
            let view6 = self.mainStackView.arrangedSubviews[6]// specification
            let view7 = self.mainStackView.arrangedSubviews[7]// box
            let view8 = self.mainStackView.arrangedSubviews[8]// Accessories title
            let view9 = self.mainStackView.arrangedSubviews[9]// Accessories
            let view10 = self.mainStackView.arrangedSubviews[10]// suggestion title
            let view11 = self.mainStackView.arrangedSubviews[11]// suggestion
            
            let aboutViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height
            let featureViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height
            let specificationViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height
            
            let emptyViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height
            
            let stackviewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height + view7.frame.height + view8.frame.height + view9.frame.height + view10.frame.height + view11.frame.height + view11.frame.height
            self.setDefaultScrollLabelColor()
            //            if scrollView.contentOffset.y < aboutViewY {
            //                self.setDefaultScrollHeight()
            //                self.setDefaultScrollLabelColor()
            //            } else if scrollView.contentOffset.y > emptyViewY {
            //                self.setScrollHeight()
            //                self.setDefaultScrollLabelColor()
            //            } else if scrollView.contentOffset.y > specificationViewY {
            //                self.setScrollHeight()
            //                self.setScrollSpecificationLabelColor()
            //            } else if scrollView.contentOffset.y > featureViewY {
            //                self.setScrollHeight()
            //                self.setScrollFeatureLabelColor()
            //            } else if scrollView.contentOffset.y > aboutViewY {
            //                self.setScrollHeight()
            //                self.setScrollAboutLabelColor()
            //            }
        }
    }
}
extension ProductDetailViewController: ProtocolProductDetailSuggestionCollectionViewCell {
    func tapButtonPressedProductDetailSuggestionCollectionViewCell(senderTag: Int) {
        if self.productSuggestionArray.count > 0 {
            if self.productSuggestionArray[senderTag].relatedProduct != nil {
                if !(self.productSuggestionArray[senderTag].relatedProduct!.slug.isNilOrEmpty) {
                    if !(self.productSuggestionArray[senderTag].relatedProduct!.category.isNilOrEmpty) {
                        let category = self.productSuggestionArray[senderTag].relatedProduct!.category!
                        if category.lowercased() == "hearing-aids" {
                            self.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productDetail.rawValue, productslug: self.productSuggestionArray[senderTag].relatedProduct!.slug!)
                        } else {
                            self.navigateToProductDetailViewController(isFrom: IsNavigateFrom.productDetail.rawValue, productslug: self.productSuggestionArray[senderTag].relatedProduct!.slug!)
                        }
                    }
                }
            }
        }
        
    }
    func wishlistButtonPressedProductDetailSuggestionCollectionViewCell(senderTag: Int) {
    }
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == self.productFeatureTableView) && (self.productFeatureArray.count > 0) {
            return 1
        } else if (tableView == self.productSpecificationTableView) && (self.productSpecificationArray.count > 0) {
            return 1
        } else if (tableView == self.productAccessoriesTableView) && (self.productAccessoriesArray.count > 0) {
            return 2
        } else if (tableView == self.productBoxTableView) && (self.productBoxArray.count > 0) {
            return 1
        }
        return  0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.productFeatureTableView {
            return self.productFeatureArray.count
        } else if tableView == self.productSpecificationTableView {
            return self.productSpecificationArray.count
        } else if (tableView == self.productAccessoriesTableView) && (self.productAccessoriesArray.count > 0) {
            if section == 0 {
                return self.productAccessoriesArray.count
            } else {
                return 1
            }
        } else {
            return self.productBoxArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.productFeatureTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductDetailFeatureTableViewCell, for: indexPath) as! ProductDetailFeatureTableViewCell
            cell.configure(productFeature: self.productFeatureArray[indexPath.row], indexpath: indexPath.row)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            cell.showSeparator()
            if self.productFeatureArray.count > 0 {
                if indexPath.row == (self.productFeatureArray.count - 1) {
                    cell.hideSeparator()
                }
            }
            return cell
        } else if tableView == self.productSpecificationTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductDetailSpecificationTableViewCell, for: indexPath) as! ProductDetailSpecificationTableViewCell
            cell.configure(productSpecification: self.productSpecificationArray[indexPath.row], indexpath: indexPath.row)
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
            cell.showSeparator()
            if self.productSpecificationArray.count > 0 {
                if indexPath.row == (self.productSpecificationArray.count - 1) {
                    cell.hideSeparator()
                }
            }
            return cell
        } else if tableView == self.productAccessoriesTableView {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductDetailAccessoriesTableViewCell, for: indexPath) as! ProductDetailAccessoriesTableViewCell
                //                cell.configure(productItemModel: self.productAccessoriesArray[indexPath.row], indexpath: indexPath.row, productAccessoriesSelectedArray: self.productAccessoriesSelectedArray)
                cell.delegate = self
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductDetailTotalAmountTableViewCell, for: indexPath) as! ProductDetailTotalAmountTableViewCell
                //                cell.configure(total: "10000", indexpath: indexPath.row)
                return cell
                
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductDetailBoxTableViewCell, for: indexPath) as! ProductDetailBoxTableViewCell
            cell.configure(productBoxing: self.productBoxArray[indexPath.row], indexpath: indexPath.row)
            cell.showSeparator()
            if self.productBoxArray.count > 0 {
                if indexPath.row == (self.productBoxArray.count - 1) {
                    cell.hideSeparator()
                }
            }
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
        if tableView == self.productFeatureTableView && self.productFeatureArray.count > 0 {
            return self.productFeatureTableViewHeight.constant = tableView.contentSize.height
        } else if tableView == self.productSpecificationTableView && self.productFeatureArray.count > 0 {
            return self.productSpecificationTableViewHeight.constant = tableView.contentSize.height
        } else if tableView == self.productAccessoriesTableView && self.productFeatureArray.count > 0 {
            return self.productAccessoriesTableViewHeight.constant = tableView.contentSize.height
        } else if tableView == self.productBoxTableView && self.productFeatureArray.count > 0 {
            return self.productBoxTableViewHeight.constant = tableView.contentSize.height
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension ProductDetailViewController: ProtocolProductDetailAccessoriesTableViewCell {
    func checkButtonPressedProductDetailAccessoriesTableViewCell(senderTag: Int) {}
}

extension ProductDetailViewController: ProtocolBottomSheetCartViewControllerDelegate, BottomPopupDelegate, ProtocolBottomSheetCommonDeleteViewControllerDelegate {
    // MARK: - DeletePopupScreen
    func showPopupScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
        guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetCartViewController) as? BottomSheetCartViewController else { return }
        popupVC.topCornerRadius = 0
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        
        var bottomPadding: CGFloat = 0
        var topPadding: CGFloat = 0
        let defaultheight: CGFloat = screenFrameHeight * (4 / 5)
        
        let popvcheight = defaultheight
        if #available(iOS 11.0, *) {
            bottomPadding = self.view.safeAreaInsets.bottom
            topPadding = self.view.safeAreaInsets.top
        }
        popupVC.height = popvcheight + bottomPadding + topPadding
        popupVC.popupDelegate = self
        popupVC.delegate = self
        
        popupVC.quantity = ""
        popupVC.productSpecficationArray = self.productSpecificationArray
        popupVC.productID = self.productID
        self.present(popupVC, animated: true, completion: nil)
    }
    
    // MARK: - ProtocolBottomSheetCommonDeleteViewControllerDelegate
    func updateBottomSheetCartViewController() {
        self.showToastAlert(AppLocalizationString.addtocartmessage, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: self)
        self.commonAPICALL(retryAPIID: 3000)
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
        
        let primaryMsgText = AppLocalizationString.removeproductfromwishlist
        let secondaryMsgText = AppLocalizationString.areyousureyouwanttoremove
        let deleteText = AppLocalizationString.yesremove
        let cancelText = AppLocalizationString.nocancel
        
        let popvcheight = 37/*image top*/ + 36/*image height*/ + 25/*image bottom*/ + CGFloat(self.heightForText(text: primaryMsgText, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32 - 32))/*primary height*/ + 5/*primary bottom*/ + CGFloat(self.heightForText(text: secondaryMsgText, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - 32))/*secondary height*/ + 5/*secondary bottom*/ + 20/*button top*/ + 38 /*button height*/ + 25/*button bottom*/
        
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
        self.commonAPICALL(retryAPIID: 4000)
    }
}
