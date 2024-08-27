//
//  ShopContainerViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class ShopCategoryViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: MainLogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var shopTitleView: UIView!
    @IBOutlet var titleLabel: Title2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var tabView: UIView!
    @IBOutlet var tabStackView: UIView!
    @IBOutlet var tabViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearingAidTabView: UIView!
    @IBOutlet var hearingAidTabLabel: Caption2FontLabel!
    @IBOutlet var hearingAidTabButton: FootnoteOutlineButton!
    @IBOutlet var hearingAidTabImageView: UIImageView!
    @IBOutlet var hearingAidsBGView: UIView!
    
    @IBOutlet var accessoriesTabView: UIView!
    @IBOutlet var accessoriesTabLabel: Caption2FontLabel!
    @IBOutlet var accessoriesTabButton: FootnoteOutlineButton!
    @IBOutlet var accessoriesTabImageView: UIImageView!
    @IBOutlet var accessoriesBGView: UIView!
    
    @IBOutlet var compareTabView: UIView!
    @IBOutlet var compareTabLabel: Caption2FontLabel!
    @IBOutlet var compareTabButton: FootnoteOutlineButton!
    @IBOutlet var compareTabImageView: UIImageView!
    @IBOutlet var compareBGView: UIView!
    
    @IBOutlet var hearingAidView: UIView!
    @IBOutlet var hearingAidStackView: UIStackView!
    
    @IBOutlet var hearingAidLatestTitleView: UIView!
    @IBOutlet var hearingAidLatestTitleLabel: CalloutFontLabel!
    @IBOutlet var hearingAidLatestDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var hearingAidLatestViewAllButton: FootnoteOutlineButton!
    
    @IBOutlet var hearingAidLatestView: UIView!
    @IBOutlet var hearingAidLatestCollectionView: UICollectionView!
    @IBOutlet var hearingAidLatestCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearingAidHotDealsTitleView: UIView!
    @IBOutlet var hearingAidHotDealsTitleLabel: CalloutFontLabel!
    @IBOutlet var hearingAidHotDealsDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var hearingAidHotDealsViewAllButton: FootnoteOutlineButton!
    
    @IBOutlet var hearingAidHotDealsView: UIView!
    @IBOutlet var hearingAidHotDealsCollectionView: UICollectionView!
    @IBOutlet var hearingAidHotDealsCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearingAidFilterView: UIView!
    @IBOutlet var hearingAidFilterProductCollectionView: UICollectionView!
    @IBOutlet var hearingAidFilterProductCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearingAidFilterLoadMoreView: UIView!
    @IBOutlet var hearingAidFilterLoadMoreButton: CalloutBackgroundButton!
    
    @IBOutlet var hearingAidPriceListView: UIView!
    @IBOutlet var hearingAidPriceListTableView: UITableView!
    @IBOutlet var hearingAidPriceListTableViewHeight: NSLayoutConstraint!
    @IBOutlet var hearingAidPriceListViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearingAidBrandListView: UIView!
    @IBOutlet var hearingAidBrandListTableView: UITableView!
    @IBOutlet var hearingAidBrandListTableViewHeight: NSLayoutConstraint!
    @IBOutlet var hearingAidBrandListViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearingAidPriceTitleView: UIView!
    @IBOutlet var hearingAidPriceTitleLabel: CalloutFontLabel!
    @IBOutlet var hearingAidPriceDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var hearingAidPriceView: UIView!
    @IBOutlet var hearingAidPriceCollectionView: UICollectionView!
    @IBOutlet var hearingAidPriceCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearingAidTagView: UIView!
    @IBOutlet var hearingAidTagCollectionView: UICollectionView!
    @IBOutlet var hearingAidTagCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearingAidShopBrandTitleView: UIView!
    @IBOutlet var hearingAidShopBrandTitleLabel: CalloutFontLabel!
    @IBOutlet var hearingAidShopBrandDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var hearingAidShopBrandView: UIView!
    @IBOutlet var hearingAidShopBrandCollectionView: UICollectionView!
    @IBOutlet var hearingAidShopBrandCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearingAidBrandView: UIView!
    @IBOutlet var hearingAidBrandCollectionView: UICollectionView!
    @IBOutlet var hearingAidBrandCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearingAidShopModelTitleView: UIView!
    @IBOutlet var hearingAidShopModelTitleLabel: CalloutFontLabel!
    @IBOutlet var hearingAidShopModelDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var hearingAidShopModelView: UIView!
    @IBOutlet var hearingAidShopModelCollectionView: UICollectionView!
    @IBOutlet var hearingAidShopModelCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var accessoriesView: UIView!
    @IBOutlet var accessoriesStackView: UIStackView!
    
    @IBOutlet var accessoriesTagView: UIView!
    @IBOutlet var accessoriesTagCollectionView: UICollectionView!
    @IBOutlet var accessoriesTagCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var accessoriesGreatDealsTitleView: UIView!
    @IBOutlet var accessoriesGreatDealsTitleLabel: CalloutFontLabel!
    @IBOutlet var accessoriesGreatDealsDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var accessoriesGreatDealsViewAllButton: FootnoteOutlineButton!
    
    @IBOutlet var accessoriesGreatDealsView: UIView!
    @IBOutlet var accessoriesGreatDealsCollectionView: UICollectionView!
    @IBOutlet var accessoriesGreatDealsCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var accessoriesCategoryView: UIView!
    @IBOutlet var accessoriesCategoryCollectionView: UICollectionView!
    @IBOutlet var accessoriesCategoryCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var accessoriesFilterView: UIView!
    @IBOutlet var accessoriesFilterProductCollectionView: UICollectionView!
    @IBOutlet var accessoriesFilterProductCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var accessoriesFilterLoadMoreView: UIView!
    @IBOutlet var accessoriesFilterLoadMoreButton: CalloutBackgroundButton!
    
    @IBOutlet var accessoriesBrandListView: UIView!
    @IBOutlet var accessoriesBrandListTableView: UITableView!
    @IBOutlet var accessoriesBrandListTableViewHeight: NSLayoutConstraint!
    @IBOutlet var accessoriesBrandListViewHeight: NSLayoutConstraint!
    
    @IBOutlet var compareView: UIView!
    @IBOutlet var compareStackView: UIStackView!
    
    @IBOutlet var addtoCompareView: UIView!
    @IBOutlet var addtoCompareTitleLabel: CalloutFontLabel!
    @IBOutlet var addtoCompareViewDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var compareContentView: UIView!
    @IBOutlet var compareBackgroundView: UIView!
    @IBOutlet var compareContentStackView: UIStackView!
    
    @IBOutlet var banner1ImageView: UIImageView!
    @IBOutlet var banner2ImageView: UIImageView!
    @IBOutlet var bannerImageViewHeight: NSLayoutConstraint!
    
    @IBOutlet var addModel1View: UIView!
    @IBOutlet var addModel2View: UIView!
    
    @IBOutlet var addModel1Label: FootnoteFontLabel!
    @IBOutlet var addModel2Label: FootnoteFontLabel!
    
    @IBOutlet var addModel1Button: CalloutOutlineButton!
    @IBOutlet var addModel2Button: CalloutOutlineButton!
    
    @IBOutlet var versusLabel: FootnoteFontLabel!
    @IBOutlet var versusView: UIView!
    
    @IBOutlet var brandName1Label: FootnoteFontLabel!
    @IBOutlet var brandName2Label: FootnoteFontLabel!
    
    @IBOutlet var productName1Label: Caption2FontLabel!
    @IBOutlet var productName2Label: Caption2FontLabel!
    
    @IBOutlet var price1Label: Caption2FontLabel!
    @IBOutlet var price2Label: Caption2FontLabel!
    
    @IBOutlet var addToCompareButton: CalloutBackgroundButton!
    
    @IBOutlet var comparePopularView: UIView!
    @IBOutlet var comparePopularTitleLabel: CalloutFontLabel!
    @IBOutlet var comparePopularDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var compareProductListView: UIView!
    @IBOutlet var compareProductListTableView: UITableView!
    @IBOutlet var compareProductListTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var offersTitleView: UIView!
    @IBOutlet var offersTitleLabel: CalloutFontLabel!
    @IBOutlet var offersDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var offersView: UIView!
    @IBOutlet var offersCollectionView: UICollectionView!
    @IBOutlet var offersCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var recentlyViewedTitleView: UIView!
    @IBOutlet var recentlyViewedTitleLabel: CalloutFontLabel!
    @IBOutlet var recentlyViewedDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var recentlyViewedView: UIView!
    @IBOutlet var recentlyViewedCollectionView: UICollectionView!
    @IBOutlet var recentlyViewedCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearzapDifferenceTitleView: UIView!
    @IBOutlet var hearzapDifferenceTitleLabel: CalloutFontLabel!
    @IBOutlet var hearzapDifferenceDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var hearzapDifferenceView: UIView!
    @IBOutlet var hearzapDifferenceCollectionView: UICollectionView!
    @IBOutlet var hearzapDifferenceCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var shoppingGuideView: UIView!
    @IBOutlet var shoppingGuideTitleLabel: CalloutFontLabel!
    @IBOutlet var shoppingGuideDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var compareBannerView: UIView!
    @IBOutlet var compareBannerSubview: UIView!
    @IBOutlet var fhaBannerButton: FootnoteOutlineButton!
    @IBOutlet var compareBannerImageViewHeight: NSLayoutConstraint!
    
    @IBOutlet var banner1View: UIView!
    
    @IBOutlet var banner1Subview1: UIView!
    @IBOutlet var banner1FHAButton: FootnoteOutlineButton!
    
    @IBOutlet var banner1Subview2: UIView!
    @IBOutlet var banner1CompareButton: FootnoteOutlineButton!
    
    @IBOutlet var banner2View: UIView!
    
    @IBOutlet var banner2Subview1: UIView!
    @IBOutlet var banner2SupportButton: FootnoteOutlineButton!
    
    @IBOutlet var banner2Subview2: UIView!
    @IBOutlet var banner2FAQButton: FootnoteOutlineButton!
    
    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    
    // MARK: - Lets and Var
    var tabSelectedIndex = 0
    var hearingAidFilterIndex = 0
    var accessoriesFilterIndex = 0
    var compareIndex = 0
    
    var shopCategoryViewModel = ShopCategoryViewModel()
    var recentlyViewedArray = [RecentlyViewedModel]()
    
    var tagHearingAidListArray = [HearingAidsFilterList]()
    var tagAccessoriesListArray = [AccessoriesFilterList]()
    var accessoriesFilterArray = [String]()
    
    var pageNumber = 1
    var hasnext = false
    
    var hasAlert = false
    var hasCart = false
    
    // hearingAidFilterIndex 0
    var hearingAidLatestArray = [ShopProductList]()
    var hearingAidHotDealsArray = [ShopProductList]()
    var hearingAidPriceArray = [HearingAidPriceRangeList]()
    var hearingAidBrandArray = [HearingAidBrandList]()
    var hearingAidShopModelArray = [ShopModelList]()
    
    // hearingAidFilterIndex 1
    var hearingAidPriceListArray = [HearingAidPriceRangeList]()
    
    // hearingAidFilterIndex 2
    var hearingAidBrandListArray = [HearingAidBrandList]()
    
    // hearingAidFilterIndex 3
    var styleArraySelected = [String]()
    var brandArraySelected = [String]()
    var featureArraySelected: NSMutableArray = NSMutableArray()
    var specificationArraySelected: NSMutableArray = NSMutableArray()
    
    var hearingAidFilterProductListArray = [ShopProductList]()
    
    var hearingAidShopBrandarray = [HearingAidsShopBrandModel]()
    
    var offerArray = [OfferList]()
    var hearzapDifferenceArray = [ShopHearzapDifferenceModelResult]()
    
    var accessoriesGreatDealsArray = [ShopProductList]()
    var accessoriesShopModelArray = [ShopModelList]()
    
    // hearingAidFilterIndex 0
    var viewallLatest = ""
    var latestTitle = ""
    var latestDescription = ""
    var viewallHotdeal = ""
    var hotDealTitle = ""
    var hotDealDescription = ""
    var priceTitle = ""
    var priceDescription = ""
    var brandTitle = ""
    var brandDescription = ""
    var modelTitle = ""
    var modelDescription = ""
    var viewallHotdealAccessories = ""
    
    // accessoriesFilterIndex 0
    var viewallGreatdeal = ""
    var greatDealTitle = ""
    var greatDealDescription = ""
    
    // accessoriesFilterIndex 1
    var accessoriesBrandListArray = [AccessoriesBrandList]()
    
    // accessoriesFilterIndex 2
    var accessoriesFilterProductListArray = [ShopProductList]()
    
    var compareProductListArray = [ProductComparisonHistory]()
    
    // offer
    var offerTitle = ""
    var offerDescription = ""
    
    // Hearzap Difference
    var hearzapDifferenceTitle = ""
    var hearzapDifferenceDescription = ""
    
    let hearingAidLatestCollectionViewMargin = CGFloat(0)
    let hearingAidLatestCollectionViewItemSpacing = CGFloat(16)
    var hearingAidLatestCollectionViewItemHeight = CGFloat(178)
    var hearingAidLatestCollectionViewItemWidth = CGFloat(139)
    let hearingAidLatestCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let hearingAidHotDealsCollectionViewMargin = CGFloat(0)
    let hearingAidHotDealsCollectionViewItemSpacing = CGFloat(16)
    var hearingAidHotDealsCollectionViewItemHeight = CGFloat(178)
    var hearingAidHotDealsCollectionViewItemWidth = CGFloat(139)
    let hearingAidHotDealsCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let hearingAidFilterProductCollectionViewMargin = CGFloat(0)
    let hearingAidFilterProductCollectionViewItemSpacing = CGFloat(2)
    var hearingAidFilterProductCollectionViewItemHeight = CGFloat(178)
    var hearingAidFilterProductCollectionViewItemWidth = CGFloat(139)
    let hearingAidFilterProductCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let hearingAidPriceCollectionViewMargin = CGFloat(0)
    let hearingAidPriceCollectionViewItemSpacing = CGFloat(12)
    var hearingAidPriceCollectionViewItemHeight = CGFloat(178)
    var hearingAidPriceCollectionViewItemWidth = CGFloat(139)
    let hearingAidPriceCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let hearingAidShopBrandCollectionViewMargin = CGFloat(0)
    let hearingAidShopBrandCollectionViewItemSpacing = CGFloat(12)
    var hearingAidShopBrandCollectionViewItemHeight = CGFloat(178)
    var hearingAidShopBrandCollectionViewItemWidth = CGFloat(139)
    let hearingAidShopBrandCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let hearingAidBrandCollectionViewMargin = CGFloat(0)
    let hearingAidBrandCollectionViewItemSpacing = CGFloat(10)
    var hearingAidBrandCollectionViewItemHeight = CGFloat(61)
    var hearingAidBrandCollectionViewItemWidth = CGFloat(139)
    let hearingAidBrandCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let hearingAidShopModelCollectionViewMargin = CGFloat(0)
    let hearingAidShopModelCollectionViewItemSpacing = CGFloat(16)
    var hearingAidShopModelCollectionViewItemHeight = CGFloat(178)
    var hearingAidShopModelCollectionViewItemWidth = CGFloat(139)
    let hearingAidShopModelCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let accessoriesGreatDealsCollectionViewMargin = CGFloat(0)
    let accessoriesGreatDealsCollectionViewItemSpacing = CGFloat(16)
    var accessoriesGreatDealsCollectionViewItemHeight = CGFloat(178)
    var accessoriesGreatDealsCollectionViewItemWidth = CGFloat(139)
    let accessoriesGreatDealsCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let accessoriesCategoryCollectionViewMargin = CGFloat(0)
    let accessoriesCategoryCollectionViewItemSpacing = CGFloat(16)
    var accessoriesCategoryCollectionViewItemHeight = CGFloat(178)
    var accessoriesCategoryCollectionViewItemWidth = CGFloat(139)
    let accessoriesCategoryCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let accessoriesFilterProductCollectionViewMargin = CGFloat(0)
    let accessoriesFilterProductCollectionViewItemSpacing = CGFloat(2)
    var accessoriesFilterProductCollectionViewItemHeight = CGFloat(178)
    var accessoriesFilterProductCollectionViewItemWidth = CGFloat(139)
    let accessoriesFilterProductCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let offersCollectionViewMargin = CGFloat(0)
    let offersCollectionViewItemSpacing = CGFloat(6)
    var offersCollectionViewItemHeight = CGFloat(178)
    var offersCollectionViewItemWidth = CGFloat(139)
    let offersCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let hearzapDifferenceCollectionViewMargin = CGFloat(0)
    let hearzapDifferenceCollectionViewItemSpacing = CGFloat(10)
    var hearzapDifferenceCollectionViewItemHeight = CGFloat(150)
    var hearzapDifferenceCollectionViewItemWidth = CGFloat(300)
    let hearzapDifferenceCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let recentlyViewedCollectionViewMargin = CGFloat(0)
    let recentlyViewedCollectionViewItemSpacing = CGFloat(6)
    var recentlyViewedCollectionViewItemHeight = CGFloat(178)
    var recentlyViewedCollectionViewItemWidth = CGFloat(139)
    let recentlyViewedCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var timerOffer = Timer()
    var newOffsetX: CGFloat = 0.0
    
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
            self.hasAlert = false
            self.hasCart = false
            self.commonAPICALL(retryAPIID: 4000)
        }
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.compareProductListArray.count > 0  && tabSelectedIndex == 2 {
            self.compareProductListTableViewHeight.constant = self.compareProductListTableView.contentSize.height
        } else {
            self.compareProductListTableViewHeight.constant = 0
        }
        if tabSelectedIndex == 0 && hearingAidFilterIndex == 1 && self.hearingAidPriceListArray.count > 0 {
            self.hearingAidPriceListTableView.isScrollEnabled = false
            self.hearingAidPriceListTableViewHeight.constant = (CGFloat(252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight + 97) * CGFloat(self.hearingAidPriceListArray.count) + 20
            self.hearingAidPriceListViewHeight.constant = self.hearingAidPriceListTableViewHeight.constant
        } else {
            self.hearingAidPriceListTableViewHeight.constant = 0
        }
        if tabSelectedIndex == 0 && hearingAidFilterIndex == 2 && self.hearingAidBrandListArray.count > 0 {
            self.hearingAidBrandListTableView.isScrollEnabled = false
            self.hearingAidBrandListTableViewHeight.constant = (CGFloat(252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight + 97) * CGFloat(self.hearingAidBrandListArray.count) + 20
            self.hearingAidBrandListViewHeight.constant = self.hearingAidBrandListTableViewHeight.constant
            
        } else {
            self.hearingAidBrandListTableViewHeight.constant = 0
        }
        
        if tabSelectedIndex == 0 && (hearingAidFilterIndex == 0 || hearingAidFilterIndex == 2) && self.hearingAidPriceArray.count > 0 {
            if self.hearingAidPriceArray.count % 2 == 0 {
                if self.hearingAidPriceArray.count > 4 {
                    self.hearingAidPriceCollectionViewHeight.constant = (CGFloat(self.hearingAidPriceArray.count / 2) * hearingAidPriceCollectionViewItemHeight) + (CGFloat((self.hearingAidPriceArray.count / 2) - 1) * 16)
                    
                } else {
                    self.hearingAidPriceCollectionViewHeight.constant = (CGFloat(self.hearingAidPriceArray.count / 2) * hearingAidPriceCollectionViewItemHeight) + 16
                }
            } else {
                if self.hearingAidPriceArray.count > 2 {
                    self.hearingAidPriceCollectionViewHeight.constant = (CGFloat(self.hearingAidPriceArray.count / 2) * hearingAidPriceCollectionViewItemHeight) + (CGFloat((self.hearingAidPriceArray.count / 2) - 1) * 16) + hearingAidPriceCollectionViewItemHeight + 16
                } else {
                    self.hearingAidPriceCollectionViewHeight.constant = (CGFloat(self.hearingAidPriceArray.count / 2) * hearingAidPriceCollectionViewItemHeight) + hearingAidPriceCollectionViewItemHeight + 16
                }
            }
        } else {
            self.hearingAidPriceCollectionViewHeight.constant = 0
        }
        
        if tabSelectedIndex == 1 && accessoriesFilterIndex == 1 && self.accessoriesBrandListArray.count > 0 {
            self.accessoriesBrandListTableView.isScrollEnabled = false
            self.accessoriesBrandListTableViewHeight.constant = (CGFloat(252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight + 97) * CGFloat(self.accessoriesBrandListArray.count) + 20
            self.accessoriesBrandListViewHeight.constant = self.accessoriesBrandListTableViewHeight.constant
            
        } else {
            self.accessoriesBrandListTableViewHeight.constant = 0
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hearingAidTabView.roundCorners([.topLeft, .topRight], radius: 4.0)
        self.accessoriesTabView.roundCorners([.topLeft, .topRight], radius: 4.0)
        self.compareTabView.roundCorners([.topLeft, .topRight], radius: 4.0)
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
        self.tabViewHeight.constant = CGFloat(87)
        
        self.tagHearingAidListArray = self.shopCategoryViewModel.getHearingAidFilterList()
        self.tagAccessoriesListArray = self.shopCategoryViewModel.getAccessoriesFilterList()
        
        self.hearingAidLatestViewAllButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.hearingAidLatestViewAllButton.layer.borderWidth = 1.0
        
        self.hearingAidHotDealsViewAllButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.hearingAidHotDealsViewAllButton.layer.borderWidth = 1.0
        if self.offerArray.count > 0 {
            self.reloadoffersCollectionView()
        }
        let longPressOfferRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleOfferLongPress))
        longPressOfferRecognizer.numberOfTouchesRequired = 1
        //        longPressBannerRecognizer.allowableMovement = 10
        //        longPressBannerRecognizer.minimumPressDuration = 0.5
        self.offersCollectionView.addGestureRecognizer(longPressOfferRecognizer)
        if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.accessoriestab).isNilOrEmpty) {
            UserDefaults.standard.set("", forKey: UserDefaultsPreferenceKeys.accessoriestab)
            UserDefaults.standard.synchronize()
            self.commonAPICALL(retryAPIID: 2000)
        } else {
            self.commonAPICALL(retryAPIID: 1000)
        }
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = false
        self.navigationBar.isLeftSecondaryViewHidden = true
        self.navigationBar.isRightSecondaryViewHidden = false
        self.navigationBar.leftImage = Asset.menuwhite
        self.navigationBar.rightImage = self.hasCart == false ? Asset.bagblue : Asset.bagnotificationblue
        self.navigationBar.rightSecondaryImage = self.hasAlert == false ? Asset.bellblue : Asset.bellbluenotification
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.isLogoHidden = false
        self.navigationBar.logoImage = Asset.hzlogo
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        if self.tabSelectedIndex == 0 {
            self.titleLabel.text = AppLocalizationString.shopHearingAids
            self.descriptionLabel.text = AppLocalizationString.choosefromtheBestGlobalBrands
        } else if self.tabSelectedIndex == 1 {
            self.titleLabel.text = AppLocalizationString.shopHearingAidAccessories
            self.descriptionLabel.text = AppLocalizationString.getthebestSupportforyourHearingAids
        } else if self.tabSelectedIndex == 2 {
            self.titleLabel.text = AppLocalizationString.compareHearingAids
            self.descriptionLabel.text = AppLocalizationString.choosetheBestFitforyourLifestyle
        } else {
            self.titleLabel.text = ""
            self.descriptionLabel.text = ""
        }
        self.hearingAidTabLabel.text = AppLocalizationString.hearingAids
        
        // hearingAidFilterIndex 0
        self.hearingAidLatestTitleLabel.text = self.latestTitle
        self.hearingAidLatestDescriptionLabel.text = self.latestDescription
        self.hearingAidLatestViewAllButton.setTitle(AppLocalizationString.viewAll.uppercased(), for: .normal)
        self.hearingAidHotDealsTitleLabel.text = self.hotDealTitle
        self.hearingAidHotDealsDescriptionLabel.text = self.hotDealDescription
        self.hearingAidHotDealsViewAllButton.setTitle(AppLocalizationString.viewAll.uppercased(), for: .normal)
        self.hearingAidPriceTitleLabel.text = self.priceTitle
        self.hearingAidPriceDescriptionLabel.text = self.priceDescription
        self.hearingAidShopBrandTitleLabel.text = self.brandTitle
        self.hearingAidShopBrandDescriptionLabel.text = self.brandDescription
        self.hearingAidShopModelTitleLabel.text = self.modelTitle
        self.hearingAidShopModelDescriptionLabel.text = self.modelDescription
        
        self.offersTitleLabel.text = self.offerTitle
        self.offersDescriptionLabel.text = self.offerDescription
        
        // hearingAidFilterIndex 1
        self.accessoriesTabLabel.text = AppLocalizationString.accessories
        self.accessoriesGreatDealsTitleLabel.text = self.greatDealTitle
        self.accessoriesGreatDealsDescriptionLabel.text = self.greatDealDescription
        
        self.accessoriesGreatDealsViewAllButton.setTitle(AppLocalizationString.viewAll.uppercased(), for: .normal)
        
        self.compareTabLabel.text = AppLocalizationString.compare
        self.addtoCompareTitleLabel.text = AppLocalizationString.comparehearingaids
        self.addtoCompareViewDescriptionLabel.text = AppLocalizationString.whichhearingaidisrightforyou
        self.addModel1Label.text = AppLocalizationString.addModel
        self.addModel2Label.text = AppLocalizationString.addModel
        self.versusLabel.text = AppLocalizationString.versus.uppercased()
        self.comparePopularTitleLabel.text = AppLocalizationString.popularhearingaidcomparison
        self.comparePopularDescriptionLabel.text = AppLocalizationString.compareandbuy
        
        self.recentlyViewedTitleLabel.text = AppLocalizationString.recentlyviewed
        self.recentlyViewedDescriptionLabel.text = AppLocalizationString.takealookatitagain
        self.shoppingGuideTitleLabel.text = AppLocalizationString.quickFinds
        self.shoppingGuideDescriptionLabel.text = AppLocalizationString.weareheretohelpyou
        self.addToCompareButton.setTitle(AppLocalizationString.addtocompare.uppercased(), for: .normal)
        self.hearingAidFilterLoadMoreButton.setTitle(AppLocalizationString.loadmore.uppercased(), for: .normal)
        
        self.hearzapDifferenceTitleLabel.text = AppLocalizationString.whyChooseHEARZAP
        self.hearzapDifferenceDescriptionLabel.text = AppLocalizationString.evenmorereasonstovisitourstores
        
        self.primaryMessageLabel.text = AppLocalizationString.noProductsFound
        self.secondaryMessageLabel.text = AppLocalizationString.noProductsDesc
        
    }
    // MARK: - Reload
    func reloadHearingAidTagCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .horizontal
        self.hearingAidTagCollectionView.delegate = self
        self.hearingAidTagCollectionView.dataSource = self
        self.hearingAidTagCollectionView.collectionViewLayout = layout
        self.hearingAidTagCollectionView.reloadData()
        self.hearingAidTagCollectionView.collectionViewLayout.invalidateLayout()
        self.hearingAidTagCollectionView!.layoutSubviews()
        self.hearingAidTagCollectionViewHeight.constant = tagHeight
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hearingAidTagCollectionView.scrollToItem(at: IndexPath(item: self.hearingAidFilterIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    func reloadoffersCollectionView() {
        if self.offerArray.count > 0 {
            self.offersCollectionViewHeight.constant = (CGFloat(163.19) * CGFloat(screenFrameWidth / AppConstantValue.defaultDesignScreenWidth))
            self.offersCollectionViewItemHeight = (CGFloat(163.19) * CGFloat(screenFrameWidth / AppConstantValue.defaultDesignScreenWidth))
            self.offersCollectionViewItemWidth = 222 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
            self.offersCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            self.offersCollectionViewlayout.itemSize = CGSize(width: self.offersCollectionViewItemWidth, height: self.offersCollectionViewItemHeight)
            self.offersCollectionViewlayout.minimumLineSpacing = self.offersCollectionViewItemSpacing
            self.offersCollectionViewlayout.minimumInteritemSpacing = self.offersCollectionViewItemSpacing
            self.offersCollectionViewlayout.scrollDirection = .horizontal
            self.offersCollectionView!.collectionViewLayout = self.offersCollectionViewlayout
            self.offersCollectionView.dataSource = self
            self.offersCollectionView.delegate = self
            self.offersCollectionView.reloadData()
            if self.offerArray.count > 0 {
                self.timerOffer.invalidate()
                self.startAutoScrollCollectionOffer()
            }
        } else {
            self.offersCollectionViewHeight.constant = 0
        }
    }
    func reloadHearingAidBrandCollectionview() {
        if self.hearingAidBrandArray.count > 0 {
            self.hearingAidBrandCollectionViewItemHeight = CGFloat(screenFrameWidth) * CGFloat(61.0/375.0)
            self.hearingAidBrandCollectionViewItemWidth = (CGFloat(screenFrameWidth) - CGFloat(32 + 12)) / 2
            self.hearingAidBrandCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.hearingAidBrandCollectionViewlayout.itemSize = CGSize(width: self.hearingAidBrandCollectionViewItemWidth, height: self.hearingAidBrandCollectionViewItemHeight)
            self.hearingAidBrandCollectionViewlayout.minimumLineSpacing = self.hearingAidBrandCollectionViewItemSpacing
            self.hearingAidBrandCollectionViewlayout.minimumInteritemSpacing = self.hearingAidBrandCollectionViewItemSpacing
            self.hearingAidBrandCollectionViewlayout.scrollDirection = .vertical
            self.hearingAidBrandCollectionView!.collectionViewLayout = self.hearingAidBrandCollectionViewlayout
            self.hearingAidBrandCollectionView.dataSource = self
            self.hearingAidBrandCollectionView.delegate = self
            self.hearingAidBrandCollectionView.reloadData()
            if self.hearingAidBrandArray.count > 0 {
                if self.hearingAidBrandArray.count % 2 == 0 {
                    if self.hearingAidBrandArray.count > 4 {
                        self.hearingAidBrandCollectionViewHeight.constant = (CGFloat(self.hearingAidBrandArray.count / 2) * hearingAidBrandCollectionViewItemHeight) + (CGFloat((self.hearingAidBrandArray.count / 2) - 1) * 16)
                        
                    } else {
                        self.hearingAidBrandCollectionViewHeight.constant = (CGFloat(self.hearingAidBrandArray.count / 2) * hearingAidBrandCollectionViewItemHeight) + 16
                    }
                } else {
                    if self.hearingAidBrandArray.count > 2 {
                        self.hearingAidBrandCollectionViewHeight.constant = (CGFloat(self.hearingAidBrandArray.count / 2) * hearingAidBrandCollectionViewItemHeight) + (CGFloat((self.hearingAidBrandArray.count / 2) - 1) * 16) + hearingAidBrandCollectionViewItemHeight + 16
                    } else {
                        self.hearingAidBrandCollectionViewHeight.constant = (CGFloat(self.hearingAidBrandArray.count / 2) * hearingAidBrandCollectionViewItemHeight) + hearingAidBrandCollectionViewItemHeight + 16
                    }
                }
            } else {
                self.hearingAidBrandCollectionViewHeight.constant = 0
            }
        } else {
            self.hearingAidBrandCollectionViewHeight.constant = 0
        }
        
    }
    func reloadHearingAidLatestCollectionView() {
        self.hearingAidLatestCollectionViewHeight.constant = 0
        if self.hearingAidLatestArray.count > 0 {
            self.hearingAidLatestCollectionViewHeight.constant = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.hearingAidLatestCollectionViewItemHeight = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.hearingAidLatestCollectionViewItemWidth = 222 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
            self.hearingAidLatestCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            self.hearingAidLatestCollectionViewlayout.itemSize = CGSize(width: self.hearingAidLatestCollectionViewItemWidth, height: self.hearingAidLatestCollectionViewItemHeight)
            self.hearingAidLatestCollectionViewlayout.minimumLineSpacing = self.hearingAidLatestCollectionViewItemSpacing
            self.hearingAidLatestCollectionViewlayout.minimumInteritemSpacing = self.hearingAidLatestCollectionViewItemSpacing
            self.hearingAidLatestCollectionViewlayout.scrollDirection = .horizontal
            self.hearingAidLatestCollectionView!.collectionViewLayout = self.hearingAidLatestCollectionViewlayout
            self.hearingAidLatestCollectionView.dataSource = self
            self.hearingAidLatestCollectionView.delegate = self
            self.hearingAidLatestCollectionView.reloadData()
        } else {
            self.hearingAidLatestCollectionViewHeight.constant = 0
        }
    }
    func reloadHearingAidFilterProductCollectionView() {
        self.hearingAidFilterProductCollectionViewItemWidth = (screenFrameWidth - 2) / 2
        self.hearingAidFilterProductCollectionViewItemHeight = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
        self.hearingAidFilterProductCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.hearingAidFilterProductCollectionViewlayout.itemSize = CGSize(width: self.hearingAidFilterProductCollectionViewItemWidth, height: self.hearingAidFilterProductCollectionViewItemHeight)
        self.hearingAidFilterProductCollectionViewlayout.minimumLineSpacing = self.hearingAidFilterProductCollectionViewItemSpacing
        self.hearingAidFilterProductCollectionViewlayout.minimumInteritemSpacing = self.hearingAidFilterProductCollectionViewItemSpacing
        self.hearingAidFilterProductCollectionViewlayout.scrollDirection = .vertical
        self.hearingAidFilterProductCollectionView!.collectionViewLayout = self.hearingAidFilterProductCollectionViewlayout
        self.hearingAidFilterProductCollectionView.dataSource = self
        self.hearingAidFilterProductCollectionView.delegate = self
        self.hearingAidFilterProductCollectionView.reloadData()
        if self.hearingAidFilterProductListArray.count > 0 {
            if self.hearingAidFilterProductListArray.count % 2 == 0 {
                self.hearingAidFilterProductCollectionViewHeight.constant = (CGFloat(self.hearingAidFilterProductListArray.count / 2) * hearingAidFilterProductCollectionViewItemHeight) + ((CGFloat(self.hearingAidFilterProductListArray.count / 2)) * 2) + 20
                self.hearingAidFilterProductCollectionView.isScrollEnabled = false
            } else {
                self.hearingAidFilterProductCollectionViewHeight.constant = (CGFloat(self.hearingAidFilterProductListArray.count / 2) * hearingAidFilterProductCollectionViewItemHeight) + ((CGFloat(self.hearingAidFilterProductListArray.count / 2)) * 2)  + hearingAidFilterProductCollectionViewItemHeight + 2 + 20
                self.hearingAidFilterProductCollectionView.isScrollEnabled = false
            }
        } else {
            self.hearingAidFilterProductCollectionViewHeight.constant = 0
        }
    }
    func reloadHearingAidHotDealsCollectionView() {
        self.hearingAidHotDealsCollectionViewHeight.constant = 0
        if self.hearingAidHotDealsArray.count > 0 {
            self.hearingAidHotDealsCollectionViewHeight.constant = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.hearingAidHotDealsCollectionViewItemHeight = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.hearingAidHotDealsCollectionViewItemWidth = 222 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
            self.hearingAidHotDealsCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            self.hearingAidHotDealsCollectionViewlayout.itemSize = CGSize(width: self.hearingAidHotDealsCollectionViewItemWidth, height: self.hearingAidHotDealsCollectionViewItemHeight)
            self.hearingAidHotDealsCollectionViewlayout.minimumLineSpacing = self.hearingAidHotDealsCollectionViewItemSpacing
            self.hearingAidHotDealsCollectionViewlayout.minimumInteritemSpacing = self.hearingAidHotDealsCollectionViewItemSpacing
            self.hearingAidHotDealsCollectionViewlayout.scrollDirection = .horizontal
            self.hearingAidHotDealsCollectionView!.collectionViewLayout = self.hearingAidHotDealsCollectionViewlayout
            self.hearingAidHotDealsCollectionView.dataSource = self
            self.hearingAidHotDealsCollectionView.delegate = self
            self.hearingAidHotDealsCollectionView.reloadData()
        } else {
            self.hearingAidHotDealsCollectionViewHeight.constant = 0
        }
    }
    func reloadHearingAidShopBrandCollectionView() {
        if self.hearingAidShopBrandarray.count > 0 {
            self.hearingAidShopBrandCollectionViewHeight.constant = CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(AppConstantValue.screen265slash375)
            self.hearingAidShopBrandCollectionViewItemHeight = CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(AppConstantValue.screen265slash375)
            self.hearingAidShopBrandCollectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(AppConstantValue.screen222slash375)
            self.hearingAidShopBrandCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            self.hearingAidShopBrandCollectionViewlayout.itemSize = CGSize(width: self.hearingAidShopBrandCollectionViewItemWidth, height: self.hearingAidShopBrandCollectionViewItemHeight)
            self.hearingAidShopBrandCollectionViewlayout.minimumLineSpacing = self.hearingAidShopBrandCollectionViewItemSpacing
            self.hearingAidShopBrandCollectionViewlayout.minimumInteritemSpacing = self.hearingAidShopBrandCollectionViewItemSpacing
            self.hearingAidShopBrandCollectionViewlayout.scrollDirection = .horizontal
            self.hearingAidShopBrandCollectionView!.collectionViewLayout = self.hearingAidShopBrandCollectionViewlayout
            self.hearingAidShopBrandCollectionView.dataSource = self
            self.hearingAidShopBrandCollectionView.delegate = self
            self.hearingAidShopBrandCollectionView.reloadData()
        } else {
            self.hearingAidShopBrandCollectionViewHeight.constant = 0
        }
    }
    func reloadHearingAidPriceCollectionView() {
        if self.hearingAidPriceArray.count > 0 {
            self.hearingAidPriceCollectionViewItemHeight = 90
            self.hearingAidPriceCollectionViewItemWidth = (CGFloat(screenFrameWidth) - CGFloat(32 + 12)) / 2
            self.hearingAidPriceCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.hearingAidPriceCollectionViewlayout.itemSize = CGSize(width: self.hearingAidPriceCollectionViewItemWidth, height: self.hearingAidPriceCollectionViewItemHeight)
            self.hearingAidPriceCollectionViewlayout.minimumLineSpacing = self.hearingAidPriceCollectionViewItemSpacing
            self.hearingAidPriceCollectionViewlayout.minimumInteritemSpacing = self.hearingAidPriceCollectionViewItemSpacing
            self.hearingAidPriceCollectionViewlayout.scrollDirection = .vertical
            self.hearingAidPriceCollectionView!.collectionViewLayout = self.hearingAidPriceCollectionViewlayout
            self.hearingAidPriceCollectionView.dataSource = self
            self.hearingAidPriceCollectionView.delegate = self
            self.hearingAidPriceCollectionView.reloadData()
            self.viewWillLayoutSubviews()
        } else {
            self.viewWillLayoutSubviews()
        }
    }
    
    func reloadHearingAidShopModelCollectionView() {
        if self.hearingAidShopModelArray.count > 0 {
//            self.hearingAidShopModelCollectionViewHeight.constant = (136 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight + 38 + 2
//            self.hearingAidShopModelCollectionViewItemHeight = (136 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight + 38 + 2
//            self.hearingAidShopModelCollectionViewItemWidth = 222 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)


            self.hearingAidShopModelCollectionViewHeight.constant = (533.33 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + 0 /*AppConstantValue.productInfoHeight*/ + 38 + 2
            self.hearingAidShopModelCollectionViewItemHeight = (533.33 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + 0/*AppConstantValue.productInfoHeight*/ + 38 + 2

            self.hearingAidShopModelCollectionViewItemWidth = 300 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
            self.hearingAidShopModelCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            self.hearingAidShopModelCollectionViewlayout.itemSize = CGSize(width: self.hearingAidShopModelCollectionViewItemWidth, height: self.hearingAidShopModelCollectionViewItemHeight)
            self.hearingAidShopModelCollectionViewlayout.minimumLineSpacing = self.hearingAidShopModelCollectionViewItemSpacing
            self.hearingAidShopModelCollectionViewlayout.minimumInteritemSpacing = self.hearingAidShopModelCollectionViewItemSpacing
            self.hearingAidShopModelCollectionViewlayout.scrollDirection = .horizontal
            self.hearingAidShopModelCollectionView!.collectionViewLayout = self.hearingAidShopModelCollectionViewlayout
            self.hearingAidShopModelCollectionView.dataSource = self
            self.hearingAidShopModelCollectionView.delegate = self
            self.hearingAidShopModelCollectionView.reloadData()
        } else {
            self.hearingAidShopModelCollectionViewHeight.constant = 0
        }
    }
    func reloadHearingAidPriceListTableView() {
        self.hearingAidPriceListTableView.tableFooterView = UIView()
        self.hearingAidPriceListTableView.separatorColor = UIColor.clear
        self.hearingAidPriceListTableView.backgroundColor = UIColor.clear
        self.hearingAidPriceListTableView.rowHeight = UITableView.automaticDimension
        self.hearingAidPriceListTableView.estimatedRowHeight = UITableView.automaticDimension
        self.hearingAidPriceListTableView.delegate = self
        self.hearingAidPriceListTableView.dataSource = self
        self.hearingAidPriceListTableView.reloadData()
        self.viewWillLayoutSubviews()
    }
    func reloadHearingAidBrandListTableView() {
        self.hearingAidBrandListTableView.tableFooterView = UIView()
        self.hearingAidBrandListTableView.separatorColor = UIColor.clear
        self.hearingAidBrandListTableView.backgroundColor = UIColor.clear
        self.hearingAidBrandListTableView.rowHeight = UITableView.automaticDimension
        self.hearingAidBrandListTableView.estimatedRowHeight = UITableView.automaticDimension
        self.hearingAidBrandListTableView.delegate = self
        self.hearingAidBrandListTableView.dataSource = self
        self.hearingAidBrandListTableView.reloadData()
        self.viewWillLayoutSubviews()
    }
    func reloadAccessoriesTagCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .horizontal
        self.accessoriesTagCollectionView.delegate = self
        self.accessoriesTagCollectionView.dataSource = self
        self.accessoriesTagCollectionView.collectionViewLayout = layout
        self.accessoriesTagCollectionView.reloadData()
        self.accessoriesTagCollectionView.collectionViewLayout.invalidateLayout()
        self.accessoriesTagCollectionView!.layoutSubviews()
        self.accessoriesTagCollectionViewHeight.constant = tagHeight
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.accessoriesTagCollectionView.scrollToItem(at: IndexPath(item: self.accessoriesFilterIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    func reloadAccessoriesGreatDealsCollectionView() {
        self.accessoriesGreatDealsCollectionViewHeight.constant = 0
        if self.accessoriesGreatDealsArray.count > 0 {
            self.accessoriesGreatDealsCollectionViewHeight.constant = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.accessoriesGreatDealsCollectionViewItemHeight = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.accessoriesGreatDealsCollectionViewItemWidth = 222 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
            self.accessoriesGreatDealsCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            self.accessoriesGreatDealsCollectionViewlayout.itemSize = CGSize(width: self.accessoriesGreatDealsCollectionViewItemWidth, height: self.accessoriesGreatDealsCollectionViewItemHeight)
            self.accessoriesGreatDealsCollectionViewlayout.minimumLineSpacing = self.accessoriesGreatDealsCollectionViewItemSpacing
            self.accessoriesGreatDealsCollectionViewlayout.minimumInteritemSpacing = self.accessoriesGreatDealsCollectionViewItemSpacing
            self.accessoriesGreatDealsCollectionViewlayout.scrollDirection = .horizontal
            self.accessoriesGreatDealsCollectionView!.collectionViewLayout = self.accessoriesGreatDealsCollectionViewlayout
            self.accessoriesGreatDealsCollectionView.dataSource = self
            self.accessoriesGreatDealsCollectionView.delegate = self
            self.accessoriesGreatDealsCollectionView.reloadData()
        } else {
            self.accessoriesGreatDealsCollectionViewHeight.constant = 0
        }
    }
    func reloadAccessoriesCategoryCollectionView() {
        self.accessoriesCategoryCollectionViewItemWidth = (CGFloat(AppConstantValue.screenWidthminus32) - 16) / 2
        self.accessoriesCategoryCollectionViewItemHeight = (CGFloat(AppConstantValue.screenWidthminus32) - 16) / 2 + CGFloat(95)
        self.accessoriesCategoryCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.accessoriesCategoryCollectionViewlayout.itemSize = CGSize(width: self.accessoriesCategoryCollectionViewItemWidth, height: self.accessoriesCategoryCollectionViewItemHeight)
        self.accessoriesCategoryCollectionViewlayout.minimumLineSpacing = self.accessoriesCategoryCollectionViewItemSpacing
        self.accessoriesCategoryCollectionViewlayout.minimumInteritemSpacing = self.accessoriesCategoryCollectionViewItemSpacing
        self.accessoriesCategoryCollectionViewlayout.scrollDirection = .vertical
        self.accessoriesCategoryCollectionView!.collectionViewLayout = self.accessoriesCategoryCollectionViewlayout
        self.accessoriesCategoryCollectionView.dataSource = self
        self.accessoriesCategoryCollectionView.delegate = self
        self.accessoriesCategoryCollectionView.reloadData()
        
        if self.accessoriesShopModelArray.count > 0 {
            if self.accessoriesShopModelArray.count % 2 == 0 {
                self.accessoriesCategoryCollectionViewHeight.constant = (CGFloat(self.accessoriesShopModelArray.count / 2) * accessoriesCategoryCollectionViewItemHeight) +  (CGFloat(self.accessoriesShopModelArray.count / 2) * 16) + 20
            } else {
                self.accessoriesCategoryCollectionViewHeight.constant =  (CGFloat(self.accessoriesShopModelArray.count / 2) * accessoriesCategoryCollectionViewItemHeight) +  (CGFloat(self.accessoriesShopModelArray.count / 2) * 16) + accessoriesCategoryCollectionViewItemHeight + 16 + 20
            }
        } else {
            self.accessoriesCategoryCollectionViewHeight.constant = 0
        }
        self.accessoriesCategoryCollectionView.isScrollEnabled = false
    }
    func reloadAccessoriesBrandListTableView() {
        self.accessoriesBrandListTableView.tableFooterView = UIView()
        self.accessoriesBrandListTableView.separatorColor = UIColor.clear
        self.accessoriesBrandListTableView.backgroundColor = UIColor.clear
        self.accessoriesBrandListTableView.rowHeight = UITableView.automaticDimension
        self.accessoriesBrandListTableView.estimatedRowHeight = UITableView.automaticDimension
        self.accessoriesBrandListTableView.delegate = self
        self.accessoriesBrandListTableView.dataSource = self
        self.accessoriesBrandListTableView.reloadData()
        self.viewWillLayoutSubviews()
    }
    
    func reloadAccessoriesFilterProductCollectionView() {
        self.accessoriesFilterProductCollectionViewItemWidth = (CGFloat(screenFrameWidth) - 2) / 2
        self.accessoriesFilterProductCollectionViewItemHeight = CGFloat(252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + 90
        self.accessoriesFilterProductCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.accessoriesFilterProductCollectionViewlayout.itemSize = CGSize(width: self.accessoriesFilterProductCollectionViewItemWidth, height: self.accessoriesFilterProductCollectionViewItemHeight)
        self.accessoriesFilterProductCollectionViewlayout.minimumLineSpacing = self.accessoriesFilterProductCollectionViewItemSpacing
        self.accessoriesFilterProductCollectionViewlayout.minimumInteritemSpacing = self.accessoriesFilterProductCollectionViewItemSpacing
        self.accessoriesFilterProductCollectionViewlayout.scrollDirection = .vertical
        self.accessoriesFilterProductCollectionView!.collectionViewLayout = self.accessoriesFilterProductCollectionViewlayout
        self.accessoriesFilterProductCollectionView.dataSource = self
        self.accessoriesFilterProductCollectionView.delegate = self
        self.accessoriesFilterProductCollectionView.reloadData()
        if self.accessoriesFilterProductListArray.count > 0 {
            if self.accessoriesFilterProductListArray.count % 2 == 0 {
                self.accessoriesFilterProductCollectionViewHeight.constant = (CGFloat(self.accessoriesFilterProductListArray.count / 2) * accessoriesFilterProductCollectionViewItemHeight) + ((CGFloat(self.accessoriesFilterProductListArray.count / 2)) * 2) + 20
                self.accessoriesFilterProductCollectionView.isScrollEnabled = false
            } else {
                self.accessoriesFilterProductCollectionViewHeight.constant = (CGFloat(self.accessoriesFilterProductListArray.count / 2) * accessoriesFilterProductCollectionViewItemHeight) + ((CGFloat(self.accessoriesFilterProductListArray.count / 2)) * 2)  + accessoriesFilterProductCollectionViewItemHeight + 2 + 20
                self.accessoriesFilterProductCollectionView.isScrollEnabled = false
            }
        } else {
            self.accessoriesFilterProductCollectionViewHeight.constant = 0
        }
    }
    
    func reloadCompareProductTableViewList() {
        self.compareProductListTableView.tableFooterView = UIView()
        self.compareProductListTableView.separatorColor = UIColor.clear
        self.compareProductListTableView.backgroundColor = UIColor.clear
        self.compareProductListTableView.rowHeight = UITableView.automaticDimension
        self.compareProductListTableView.estimatedRowHeight = UITableView.automaticDimension
        self.compareProductListTableView.delegate = self
        self.compareProductListTableView.dataSource = self
        self.compareProductListTableView.reloadData()
        self.viewWillLayoutSubviews()
    }
    func reloadHearzapDifferenceCollectionView() {
        if self.hearzapDifferenceArray.count > 0 {
            self.hearzapDifferenceCollectionViewItemHeight = CGFloat(150)
            self.hearzapDifferenceCollectionViewItemWidth = CGFloat(300 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth))
            self.hearzapDifferenceCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            self.hearzapDifferenceCollectionViewlayout.itemSize = CGSize(width: self.hearzapDifferenceCollectionViewItemWidth, height: self.hearzapDifferenceCollectionViewItemHeight)
            self.hearzapDifferenceCollectionViewlayout.minimumLineSpacing = self.hearzapDifferenceCollectionViewItemSpacing
            self.hearzapDifferenceCollectionViewlayout.minimumInteritemSpacing = self.hearzapDifferenceCollectionViewItemSpacing
            self.hearzapDifferenceCollectionViewlayout.scrollDirection = .horizontal
            self.hearzapDifferenceCollectionView!.collectionViewLayout = self.hearzapDifferenceCollectionViewlayout
            self.hearzapDifferenceCollectionView.dataSource = self
            self.hearzapDifferenceCollectionView.delegate = self
            self.hearzapDifferenceCollectionView.reloadData()
            self.hearzapDifferenceCollectionViewHeight.constant = CGFloat(150)
        } else {
            self.hearzapDifferenceCollectionViewHeight.constant = 0
        }
    }
    func reloadRecentlyViewedCollectionView() {
        if self.recentlyViewedArray.count > 0 {
            self.recentlyViewedCollectionViewHeight.constant = CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(AppConstantValue.screen138slash375)
            self.recentlyViewedCollectionViewItemHeight = CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(AppConstantValue.screen138slash375)
            self.recentlyViewedCollectionViewItemWidth = (CGFloat(screenFrameWidth) - CGFloat(32 + 12)) / 3
            self.recentlyViewedCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.recentlyViewedCollectionViewlayout.itemSize = CGSize(width: self.recentlyViewedCollectionViewItemWidth, height: self.recentlyViewedCollectionViewItemHeight)
            self.recentlyViewedCollectionViewlayout.minimumLineSpacing = self.recentlyViewedCollectionViewItemSpacing
            self.recentlyViewedCollectionViewlayout.minimumInteritemSpacing = self.recentlyViewedCollectionViewItemSpacing
            self.recentlyViewedCollectionViewlayout.scrollDirection = .horizontal
            self.recentlyViewedCollectionView!.collectionViewLayout = self.recentlyViewedCollectionViewlayout
            self.recentlyViewedCollectionView.dataSource = self
            self.recentlyViewedCollectionView.delegate = self
            self.recentlyViewedCollectionView.reloadData()
        } else {
            self.recentlyViewedCollectionViewHeight.constant = 0
        }
    }
    
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getHearingAidList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getHearingAidPriceRangeList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1002 {
                    self.getHearingAidBrandList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1003 {
                    self.postHearingAidProductFilterList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.getAccessoriesList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2001 {
                    self.getAccessoriesBrandList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2002 {
                    self.postAccessoriesProductFilterList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 3000 {
                    self.getCompareList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 4000 {
                    self.getNotificationCount(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 5000 {
                    self.getShopOffersList(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 5001 {
                    self.getShopHearzapDifferenceList(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 6000 {
                    
                }
                
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    //    func getHearingAidList(retryAPIID: Int, canShowLoader: Bool) {
    //
    ////    var param = ""
    ////    var sub_category_type = ""
    ////
    ////    param = String(format: "sub_category=%@&sub_category_type=%@", accessoriesSubcategoriesSlug, sub_category_type )
    ////    self.accessoriesSubCategoryColorViewModel.postAccessoriesSubcategoryProductList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postAccessoriesSubcategoryProductList, methodName: HTTPMethods.post, parameter: param, pageNumber: "\(pageNumber)", retryAPIID: retryAPIID, strQuery: "")
    //    }
    func getHearingAidList(retryAPIID: Int, canShowLoader: Bool) {
        self.shopCategoryViewModel.getHearingAidList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getHearingAidList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getHearingAidPriceRangeList(retryAPIID: Int, canShowLoader: Bool) {
        self.shopCategoryViewModel.getHearingAidPriceRangeList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getHearingAidPriceRangeList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getHearingAidBrandList(retryAPIID: Int, canShowLoader: Bool) {
        self.shopCategoryViewModel.getHearingAidBrandList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getHearingAidBrandList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    
    func postHearingAidProductFilterList(retryAPIID: Int, canShowLoader: Bool) {
        var param = ""
        
        let featureArray: NSMutableArray = NSMutableArray()
        let specificationArray: NSMutableArray = NSMutableArray()
        for (index, item) in self.featureArraySelected.enumerated() {
            for (key, value) in (item as! NSDictionary) {
                var featuredict  = [String: [String]]()
                let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                if arrayValueCode.count > 0 {
                    featuredict[key as! String] = value as! [String]
                    featureArray.add(featuredict)
                }
            }
        }
        for (index, item) in self.specificationArraySelected.enumerated() {
            for (key, value) in (item as! NSDictionary) {
                var specificationdict  = [String: [String]]()
                let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                if arrayValueCode.count > 0 {
                    specificationdict[key as! String] = value as! [String]
                    specificationArray.add(specificationdict)
                }
            }
        }
        param = String(format: "style=%@&brand=%@&feature=%@&specification=%@", self.styleArraySelected.count > 0 ? self.stringifyArray(json: self.styleArraySelected, prettyPrinted: false) : "[]", self.brandArraySelected.count > 0 ? self.stringifyArray(json: self.brandArraySelected, prettyPrinted: false) : "[]", featureArray.count > 0 ? self.stringifyArray(json: featureArray, prettyPrinted: false) : "[]", specificationArray.count > 0 ? self.stringifyArray(json: specificationArray, prettyPrinted: false) : "[]")
        
        self.shopCategoryViewModel.postHearingAidProductFilterList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postHearingAidProductFilterList, methodName: HTTPMethods.post, parameter: param, pageNumber: "\(pageNumber)", retryAPIID: retryAPIID, strQuery: "")
    }
    func getShopOffersList(retryAPIID: Int, canShowLoader: Bool) {
        self.shopCategoryViewModel.getShopOffersList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getShopOffersList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getShopHearzapDifferenceList(retryAPIID: Int, canShowLoader: Bool) {
        self.shopCategoryViewModel.getShopHearzapDifferenceList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getShopHearzapDifferenceList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getAccessoriesList(retryAPIID: Int, canShowLoader: Bool) {
        self.shopCategoryViewModel.getAccessoriesList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getAccessoriesList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getAccessoriesBrandList(retryAPIID: Int, canShowLoader: Bool) {
        self.shopCategoryViewModel.getAccessoriesBrandList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getAccessoriesBrandList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postAccessoriesProductFilterList(retryAPIID: Int, canShowLoader: Bool) {
        var param = ""
        var featureArray: NSMutableArray = NSMutableArray()
        var specificationArray: NSMutableArray = NSMutableArray()
        for (index, item) in self.featureArraySelected.enumerated() {
            for (key, value) in (item as! NSDictionary) {
                var featuredict  = [String: [String]]()
                let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                if arrayValueCode.count > 0 {
                    featuredict[key as! String] = value as! [String]
                    featureArray.add(featuredict)
                }
            }
        }
        for (index, item) in self.specificationArraySelected.enumerated() {
            for (key, value) in (item as! NSDictionary) {
                var specificationdict  = [String: [String]]()
                let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                if arrayValueCode.count > 0 {
                    specificationdict[key as! String] = value as! [String]
                    specificationArray.add(specificationdict)
                }
            }
        }
        param = String(format: "style=%@&brand=%@&feature=%@&specification=%@", self.styleArraySelected.count > 0 ? self.stringifyArray(json: self.styleArraySelected, prettyPrinted: false) : "[]", self.brandArraySelected.count > 0 ? self.stringifyArray(json: self.brandArraySelected, prettyPrinted: false) : "[]", featureArray.count > 0 ? self.stringifyArray(json: featureArray, prettyPrinted: false) : "[]", specificationArray.count > 0 ? self.stringifyArray(json: specificationArray, prettyPrinted: false) : "[]")
        self.shopCategoryViewModel.postAccessoriesProductFilterList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postAccessoriesProductFilterList, methodName: HTTPMethods.post, parameter: param, pageNumber: "\(pageNumber)", retryAPIID: retryAPIID, strQuery: "")
    }
    func getCompareList(retryAPIID: Int, canShowLoader: Bool) {
        self.shopCategoryViewModel.getCompareList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCompareList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getNotificationCount(retryAPIID: Int, canShowLoader: Bool) {
        self.shopCategoryViewModel.getNotificationCount(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getNotificationCount, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func hearingAidLatestViewAllButtonPressed(_ sender: UIButton) {
        self.navigateToViewAllProductViewController(isFrom: IsNavigateFrom.viewAllShop.rawValue, filterSlug: ViewAllProductFilter.latest.rawValue, viewAllSlug: self.viewallLatest, styleID: 0, tabSelectedIndex: 0)
    }
    @IBAction func hearingAidHotDealsViewAllButtonPressed(_ sender: UIButton) {
        self.navigateToViewAllProductViewController(isFrom: IsNavigateFrom.viewAllShop.rawValue, filterSlug: ViewAllProductFilter.hotDeals.rawValue, viewAllSlug: self.viewallHotdeal, styleID: 0, tabSelectedIndex: 0)
    }
    @IBAction func hearingAidFilterLoadMoreButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1003)
    }
    @IBAction func accessoriesFilterLoadMoreButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 2002)
    }
    @IBAction func addModelButtonPressed(_ sender: UIButton) {
        self.navigateToCompareProductBrandViewController(isFrom: IsNavigateFrom.compareShop.rawValue, product1: "", product2: "", isEdit: false)
    }
    @IBAction func addToCompareButtonPressed(_ sender: UIButton) {
    }
    @IBAction func fhaBannerButtonPressed(_ sender: UIButton) {
    }
    @IBAction func banner1FHAButtonPressed(_ sender: UIButton) {
        self.navigateToFindRightDeviceIntroductionViewController(isFrom: IsNavigateFrom.fhaShop.rawValue)
    }
    @IBAction func banner1CompareButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 3000)
    }
    @IBAction func banner2SupportButtonPressed(_ sender: UIButton) {
        self.navigateToSupportViewController(isFrom: IsNavigateFrom.supportShop.rawValue)
    }
    @IBAction func banner2FAQButtonPressed(_ sender: UIButton) {
        self.navigateToFAQViewController(isFrom: IsNavigateFrom.faqShop.rawValue)
    }
    @IBAction func hearingAidTabButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    @IBAction func accessoriesTabButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 2000)
    }
    @IBAction func compareTabButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 3000)
    }
    @IBAction func accessoriesGreatDealsViewAllButtonPressed(_ sender: UIButton) {
        self.navigateToViewAllProductViewController(isFrom: IsNavigateFrom.viewAllShop.rawValue, filterSlug: ViewAllProductFilter.accessories.rawValue, viewAllSlug: self.viewallHotdealAccessories, styleID: 0, tabSelectedIndex: 1)
    }
    // MARK: - Custom Methods
    func setTabSelection() {
        self.setDefaultTabSelection()
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        
        if self.tabSelectedIndex == 0 {
            self.setDefaultHearingAidSelection()
        } else if self.tabSelectedIndex == 1 {
            self.setDefaultAccessoriesSelection()
        } else {
            self.setDefaultCompareSelection()
        }
    }
    func setDefaultTabSelection() {
        self.hearingAidTabView.roundCorners([.topLeft, .topRight], radius: 4.0)
        self.accessoriesTabView.roundCorners([.topLeft, .topRight], radius: 4.0)
        self.compareTabView.roundCorners([.topLeft, .topRight], radius: 4.0)
        
        self.hearingAidTabView.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
        //        self.hearingAidTabView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        //        self.hearingAidTabView.layer.borderWidth = 1
        self.hearingAidTabLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.hearingAidTabLabel.font = AppFont.regular.size(11)
        self.hearingAidsBGView.isHidden = true
        
        self.accessoriesTabView.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
        //        self.accessoriesTabView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        //        self.accessoriesTabView.layer.borderWidth = 1
        self.accessoriesTabLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.accessoriesTabLabel.font = AppFont.regular.size(11)
        self.accessoriesBGView.isHidden = true
        
        self.compareTabView.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
        //        self.compareTabView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        //        self.compareTabView.layer.borderWidth = 1
        self.compareTabLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.compareTabLabel.font = AppFont.regular.size(11)
        self.compareBGView.isHidden = true
    }
    func setDefaultHearingAidSelection() {
        self.tabSelectedIndex = 0
        self.hearingAidTabView.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        //        self.hearingAidTabView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        //        self.hearingAidTabView.layer.borderWidth = 1
        self.hearingAidTabLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
        self.hearingAidTabLabel.font = AppFont.medium.size(13)
        self.hearingAidsBGView.isHidden = false
        self.titleLabel.text = AppLocalizationString.shopHearingAids
        self.descriptionLabel.text = AppLocalizationString.choosefromtheBestGlobalBrands
        
    }
    func setDefaultAccessoriesSelection() {
        self.tabSelectedIndex = 1
        self.accessoriesTabView.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        //        self.accessoriesTabView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        //        self.accessoriesTabView.layer.borderWidth = 1
        self.accessoriesTabLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
        self.accessoriesTabLabel.font = AppFont.medium.size(13)
        self.accessoriesBGView.isHidden = false
        self.titleLabel.text = AppLocalizationString.shopHearingAidAccessories
        self.descriptionLabel.text = AppLocalizationString.getthebestSupportforyourHearingAids
    }
    func setDefaultCompareSelection() {
        self.tabSelectedIndex = 2
        self.compareTabView.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        //        self.compareTabView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        //        self.compareTabView.layer.borderWidth = 1
        self.compareTabLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
        self.compareTabLabel.font = AppFont.medium.size(13)
        self.compareBGView.isHidden = false
        self.titleLabel.text = AppLocalizationString.compareHearingAids
        self.descriptionLabel.text = AppLocalizationString.choosetheBestFitforyourLifestyle
        
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
    func startAutoScrollCollectionOffer() {
        DispatchQueue.main.async {
            self.timerOffer.invalidate()
            self.timerOffer =  Timer.scheduledTimer(timeInterval: Double(AppConstantValue.timerIntervalOffer), target: self, selector: #selector(self.autoScrollCollectionOffer), userInfo: nil, repeats: true)
        }
    }
    @objc func autoScrollCollectionOffer(_ timer1: Timer) {
        if let coll  = self.offersCollectionView {
            let initailPoint = CGPoint(x: self.newOffsetX, y: 0)
            
            if __CGPointEqualToPoint(initailPoint, self.offersCollectionView.contentOffset) {
                
                if self.newOffsetX < self.offersCollectionView.contentSize.width {
                    self.newOffsetX += 0.25
                }
                if self.newOffsetX > self.offersCollectionView.contentSize.width - self.offersCollectionView.frame.size.width {
                    self.newOffsetX = 0
                }
                
                self.offersCollectionView.contentOffset = CGPoint(x: self.newOffsetX, y: 0)
                
            } else {
                self.newOffsetX = self.offersCollectionView.contentOffset.x
            }
        }
    }
    
    func checkCartVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginCartShop.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToCartDetailViewController(isFrom: IsNavigateFrom.cartShop.rawValue)
        }
    }
    func verifiedCartUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkCartVerifiedUser()
    }
    func checkMyAlertVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginMyAlertShop.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToMyAlertViewController(isFrom: IsNavigateFrom.myalertShop.rawValue)
        }
    }
    func verifiedMyAlertUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkMyAlertVerifiedUser()
    }
    
    // MARK: - GestureRecognizer Delegate
    @objc func handleOfferLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            self.timerOffer.invalidate()
            if self.offerArray.count > 1 {
                self.startAutoScrollCollectionOffer()
            }
            return
        } else if gestureRecognizer.state == .began {
            self.timerOffer.invalidate()
            let pointOfContact = gestureRecognizer.location(in: self.offersCollectionView)
            let indexPath = self.offersCollectionView.indexPathForItem(at: pointOfContact)
            if let index = indexPath {
                var cell = self.offersCollectionView.cellForItem(at: index)
                // do stuff with your cell, for example print the indexPath
            } else {}
        }
    }
    
}
extension ShopCategoryViewController: ProtocolMainLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftSecondaryButtonPressed() {}
    func rightSecondaryButtonPressed() {
        self.checkMyAlertVerifiedUser()
    }
    func leftButtonPressed() {
        UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    func rightButtonPressed() {
        self.checkCartVerifiedUser()
    }
}
extension ShopCategoryViewController: ProtocolNetworkRechabilityDelegate {
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
extension ShopCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.compareProductListTableView {
            return self.compareProductListArray.count
        } else if tableView == self.hearingAidPriceListTableView {
            return self.hearingAidPriceListArray.count
        } else if tableView == self.hearingAidBrandListTableView {
            return self.hearingAidBrandListArray.count
        } else {
            return self.accessoriesBrandListArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.compareProductListTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CompareProductTableViewCell, for: indexPath) as! CompareProductTableViewCell
            cell.configure(productComparisonHistory: compareProductListArray[indexPath.row], indexpath: indexPath.row)
            cell.delegate = self
            return cell
        } else if tableView == self.hearingAidPriceListTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.HearingAidPriceListTableViewCell, for: indexPath) as! HearingAidPriceListTableViewCell
            cell.configure(priceRangeList: self.hearingAidPriceListArray[indexPath.row], indexpath: indexPath.row, viewCon: self)
            cell.delegate = self
            return cell
        } else if tableView == self.hearingAidBrandListTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.HearingAidBrandListTableViewCell, for: indexPath) as! HearingAidBrandListTableViewCell
            cell.configure(hearingAidBrandList: self.hearingAidBrandListArray[indexPath.row], indexpath: indexPath.row, viewCon: self)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.AccessoriesBrandListTableViewCell, for: indexPath) as! AccessoriesBrandListTableViewCell
            cell.configure(accessoriesBrandList: self.accessoriesBrandListArray[indexPath.row], indexpath: indexPath.row, viewCon: self)
            //            cell.delegate = self
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
        if tableView == self.compareProductListTableView && self.compareProductListArray.count > 0 {
            self.compareProductListTableViewHeight.constant = tableView.contentSize.height
        } else if tableView == self.hearingAidPriceListTableView && self.hearingAidPriceListArray.count > 0 {
            self.hearingAidPriceListTableViewHeight.constant = (CGFloat(252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight + 97) * CGFloat(self.hearingAidPriceListArray.count) + 20
            self.hearingAidPriceListViewHeight.constant = self.hearingAidPriceListTableViewHeight.constant
        } else if tableView == self.hearingAidBrandListTableView && self.hearingAidBrandListArray.count > 0 {
            self.hearingAidBrandListTableViewHeight.constant = (CGFloat(252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight + 97) * CGFloat(self.hearingAidBrandListArray.count) + 20
            self.hearingAidBrandListViewHeight.constant = self.hearingAidBrandListTableViewHeight.constant
        } else if tableView == self.accessoriesBrandListTableView && self.accessoriesBrandListArray.count > 0 {
            self.accessoriesBrandListTableViewHeight.constant = (CGFloat(252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight + 97) * CGFloat(self.accessoriesBrandListArray.count) + 20
            self.accessoriesBrandListViewHeight.constant = self.accessoriesBrandListTableViewHeight.constant
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension ShopCategoryViewController: ProtocolCompareProductTableViewCell, ProtocolHearingAidPriceListTableViewCell, ProtocolHearingAidBrandListTableViewCell {
    func tapButtonPressedCompareProductTableViewCell(senderTag: Int) {
        var product1 = ""
        var product2 = ""
        if self.compareProductListArray[senderTag].product1 != nil {
            if !(self.compareProductListArray[senderTag].product1!.uid.isNilOrEmpty) {
                product1 = self.compareProductListArray[senderTag].product1!.uid!
            }
        }
        if self.compareProductListArray[senderTag].product2 != nil {
            if !(self.compareProductListArray[senderTag].product2!.uid.isNilOrEmpty) {
                product2 = self.compareProductListArray[senderTag].product2!.uid!
            }
        }
        self.navigateToCompareProductViewController(isFrom: IsNavigateFrom.compareShop.rawValue, product1: product1, product2: product2)
    }
    func viewAllButtonPressedHearingAidPriceListTableViewCell(senderTag: Int) {
        if self.hearingAidPriceListArray.count > 0 {
            var viewAllSlug = ""
            if !(self.hearingAidPriceListArray[senderTag].slug.isNilOrEmpty) {
                viewAllSlug = self.hearingAidPriceListArray[senderTag].slug!
            }
            self.navigateToViewAllProductViewController(isFrom: IsNavigateFrom.viewAllShop.rawValue, filterSlug: ViewAllProductFilter.price.rawValue, viewAllSlug: viewAllSlug, styleID: 0, tabSelectedIndex: 0)
        }
    }
    func viewAllButtonPressedHearingAidBrandListTableViewCell (senderTag: Int) {
        if self.hearingAidBrandListArray.count > 0 {
            var viewAllSlug = ""
            if !(self.hearingAidBrandListArray[senderTag].code.isNilOrEmpty) {
                viewAllSlug = self.hearingAidBrandListArray[senderTag].code!
            }
            self.navigateToViewAllProductViewController(isFrom: IsNavigateFrom.viewAllShop.rawValue, filterSlug: ViewAllProductFilter.brand.rawValue, viewAllSlug: viewAllSlug, styleID: 0, tabSelectedIndex: 0)
        }
    }
}

extension ShopCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.hearingAidTagCollectionView {
            return self.tagHearingAidListArray.count
        } else if collectionView == self.hearingAidLatestCollectionView {
            return self.hearingAidLatestArray.count
        } else if collectionView == self.hearingAidHotDealsCollectionView {
            return self.hearingAidHotDealsArray.count
        } else if collectionView == self.hearingAidPriceCollectionView {
            return self.hearingAidPriceArray.count
        } else if collectionView == self.hearingAidBrandCollectionView {
            return self.hearingAidBrandArray.count
        } else if collectionView == self.hearingAidShopModelCollectionView {
            return self.hearingAidShopModelArray.count
        } else if collectionView == self.hearingAidShopBrandCollectionView {
            return self.hearingAidShopBrandarray.count
        } else if collectionView == self.hearingAidFilterProductCollectionView {
            return self.hearingAidFilterProductListArray.count
        } else if collectionView == self.offersCollectionView {
            return self.offerArray.count
        } else if collectionView == self.accessoriesTagCollectionView {
            return self.tagAccessoriesListArray.count
        } else if collectionView == self.accessoriesGreatDealsCollectionView {
            return self.accessoriesGreatDealsArray.count
        } else if collectionView == self.accessoriesCategoryCollectionView {
            return self.accessoriesShopModelArray.count
        } else if collectionView == self.accessoriesFilterProductCollectionView {
            return self.accessoriesFilterProductListArray.count
        } else if collectionView == self.hearzapDifferenceCollectionView {
            return self.hearzapDifferenceArray.count
        } else if collectionView == self.recentlyViewedCollectionView{
            return self.recentlyViewedArray.count
        } else  {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.hearingAidTagCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearingAidFilterTagCollectionViewCell, for: indexPath) as! HearingAidFilterTagCollectionViewCell
            cell.configure(hearingAidsFilterList: self.tagHearingAidListArray[indexPath.item], selectedIndex: self.hearingAidFilterIndex, indexpath: indexPath.item, viewCon: self)
            cell.delegate = self
            return cell
        } else if collectionView == self.hearingAidLatestCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearingAidLatestCollectionViewCell, for: indexPath) as! HearingAidLatestCollectionViewCell
            cell.configure(product: hearingAidLatestArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        } else if collectionView == self.hearingAidHotDealsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearingAidHotDealsCollectionViewCell, for: indexPath) as! HearingAidHotDealsCollectionViewCell
            cell.configure(product: hearingAidHotDealsArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        } else if collectionView == self.hearingAidPriceCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearingAidPriceCollectionViewCell, for: indexPath) as! HearingAidPriceCollectionViewCell
            cell.configure(priceRangeList: self.hearingAidPriceArray[indexPath.item], indexpath: indexPath.row)
            cell.delegate = self
            return cell
        } else if collectionView == self.hearingAidBrandCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearingAidBrandCollectionViewCell, for: indexPath) as! HearingAidBrandCollectionViewCell
            cell.configure(hearingAidBrandList: self.hearingAidBrandArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        } else if collectionView == self.hearingAidShopModelCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearingAidShopModelCollectionViewCell, for: indexPath) as! HearingAidShopModelCollectionViewCell
            cell.configure(modelList: self.hearingAidShopModelArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        } else if collectionView == self.hearingAidShopBrandCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearingAidShopBrandCollectionViewCell, for: indexPath) as! HearingAidShopBrandCollectionViewCell
            //            cell.configure(hearingAidsShopBrandModel: self.hearingAidShopBrandarray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        } else if collectionView == self.hearingAidFilterProductCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearingAidFilterProductCollectionViewCell, for: indexPath) as! HearingAidFilterProductCollectionViewCell
            cell.configue(product: self.hearingAidFilterProductListArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        } else if collectionView == self.offersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.ShopOfferCollectionViewCell, for: indexPath) as! ShopOfferCollectionViewCell
            cell.configure(offerList: self.offerArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        }  else if collectionView == self.accessoriesTagCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.AccessoriesFilterTagCollectionViewCell, for: indexPath) as! AccessoriesFilterTagCollectionViewCell
            cell.configure(accessoriesFilterList: self.tagAccessoriesListArray[indexPath.item], selectedIndex: self.accessoriesFilterIndex, indexpath: indexPath.item, viewCon: self)
            cell.delegate = self
            return cell
        } else if collectionView == self.accessoriesGreatDealsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.AccessoriesGreatDealsCollectionViewCell, for: indexPath) as! AccessoriesGreatDealsCollectionViewCell
            cell.configure(product: accessoriesGreatDealsArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        } else if collectionView == self.accessoriesCategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.AccessoriesCategoryCollectionViewCell, for: indexPath) as! AccessoriesCategoryCollectionViewCell
            cell.configure(shopModelList: accessoriesShopModelArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
            
        } else if collectionView == self.accessoriesFilterProductCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.AccessoriesFilterProductCollectionViewCell, for: indexPath) as! AccessoriesFilterProductCollectionViewCell
            cell.configue(product: self.accessoriesFilterProductListArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        } else if collectionView == self.hearzapDifferenceCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearzapDifferenceCollectionViewCell, for: indexPath) as! HearzapDifferenceCollectionViewCell
            cell.configure(hearzapDifference: self.hearzapDifferenceArray[indexPath.item], indexpath: indexPath.item)
            return cell
        } else if collectionView == self.recentlyViewedCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.ShopRecentlyViewedCollectionViewCell, for: indexPath) as! ShopRecentlyViewedCollectionViewCell
            cell.configure(recentlyViewedModel: self.recentlyViewedArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.ShopRecentlyViewedCollectionViewCell, for: indexPath) as! ShopRecentlyViewedCollectionViewCell
            cell.configure(recentlyViewedModel: self.recentlyViewedArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.hearingAidTagCollectionView {
            if self.tagHearingAidListArray.count > 0 {
                let tag = self.tagHearingAidListArray[indexPath.item].title
                let font = AppFont.regular.size(13)
                let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
                cellWidth = 12 + size.width + 12
                if self.tagHearingAidListArray[indexPath.item].showImage == true {
                    cellWidth = cellWidth + CGFloat(10) + 16/*height*/
                }
                if (self.tagHearingAidListArray.count > 0) && (indexPath.item == 3) {
                    cellWidth = cellWidth + 2/*height*/
                }
                cellHeight = tagHeight
            }
        } else if collectionView == self.hearingAidLatestCollectionView {
            if self.hearingAidLatestArray.count > 0 {
                cellWidth = self.hearingAidLatestCollectionViewItemWidth
                cellHeight = self.hearingAidLatestCollectionViewItemHeight
            }
        } else if collectionView == self.hearingAidHotDealsCollectionView {
            if self.hearingAidHotDealsArray.count > 0 {
                cellWidth = self.hearingAidHotDealsCollectionViewItemWidth
                cellHeight = self.hearingAidHotDealsCollectionViewItemHeight
            }
        } else if collectionView == self.hearingAidPriceCollectionView {
            if self.hearingAidPriceArray.count > 0 {
                cellWidth = self.hearingAidPriceCollectionViewItemWidth
                cellHeight = self.hearingAidPriceCollectionViewItemHeight
            }
        } else if collectionView == self.hearingAidBrandCollectionView {
            if self.hearingAidBrandArray.count > 0 {
                cellWidth = self.hearingAidBrandCollectionViewItemWidth
                cellHeight = self.hearingAidBrandCollectionViewItemHeight
            }
        } else if collectionView == self.hearingAidShopModelCollectionView {
            if self.hearingAidShopModelArray.count > 0 {
                cellWidth = self.hearingAidShopModelCollectionViewItemWidth
                cellHeight = self.hearingAidShopModelCollectionViewItemHeight
            }
        } else if collectionView == self.hearingAidShopBrandCollectionView {
            if self.hearingAidShopBrandarray.count > 0 {
                cellWidth = self.hearingAidShopBrandCollectionViewItemWidth
                cellHeight = self.hearingAidShopBrandCollectionViewItemHeight
            }
        } else if collectionView == self.hearingAidFilterProductCollectionView {
            if self.hearingAidFilterProductListArray.count > 0 {
                cellWidth = self.hearingAidFilterProductCollectionViewItemWidth
                cellHeight = self.hearingAidFilterProductCollectionViewItemHeight
            }
        } else if collectionView == self.offersCollectionView {
            if self.offerArray.count > 0 {
                cellWidth = self.offersCollectionViewItemWidth
                cellHeight = self.offersCollectionViewItemHeight
            }
        } else if collectionView == self.accessoriesTagCollectionView {
            if self.tagAccessoriesListArray.count > 0 {
                let tag = self.tagAccessoriesListArray[indexPath.item].title
                let font = AppFont.regular.size(13)
                let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
                cellWidth = 12 + size.width + 12
                
                if self.tagAccessoriesListArray[indexPath.item].showImage == true {
                    cellWidth = cellWidth + CGFloat(10) + 16/*height*/
                }
                if (self.tagAccessoriesListArray.count > 0) && (indexPath.item == 2) {
                    cellWidth = cellWidth + 2/*height*/
                }
                cellHeight = tagHeight
            }
        } else if collectionView == self.accessoriesGreatDealsCollectionView {
            if self.accessoriesGreatDealsArray.count > 0 {
                cellWidth = self.accessoriesGreatDealsCollectionViewItemWidth
                cellHeight = self.accessoriesGreatDealsCollectionViewItemHeight
            }
        } else if collectionView == self.accessoriesCategoryCollectionView {
            if self.accessoriesShopModelArray.count > 0 {
                cellWidth = self.accessoriesCategoryCollectionViewItemWidth
                cellHeight = self.accessoriesCategoryCollectionViewItemHeight
            }
        } else if collectionView == self.accessoriesFilterProductCollectionView {
            if self.accessoriesFilterProductListArray.count > 0 {
                cellWidth = self.accessoriesFilterProductCollectionViewItemWidth
                cellHeight = self.accessoriesFilterProductCollectionViewItemHeight
            }
        } else if collectionView == self.hearzapDifferenceCollectionView {
            if self.hearzapDifferenceArray.count > 0{
                cellWidth = self.hearzapDifferenceCollectionViewItemWidth
                cellHeight = self.hearzapDifferenceCollectionViewItemHeight
            }
        } else if collectionView == self.recentlyViewedCollectionView {
            if self.recentlyViewedArray.count > 0 {
                cellWidth = self.recentlyViewedCollectionViewItemWidth
                cellHeight = self.recentlyViewedCollectionViewItemHeight
            }
        }
        self.view.layoutIfNeeded()
        self.viewWillLayoutSubviews()
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension ShopCategoryViewController: ProtocolAccessoriesFilterTagCollectionViewCell, ProtocolHearingAidFilterTagCollectionViewCell, ProtocolShopRecentlyViewedCollectionViewCell, ProtocolHearingAidLatestCollectionViewCell, ProtocolHearingAidPriceCollectionViewCell, ProtocolHearingAidShopBrandCollectionViewCell, ProtocolHearingAidBrandCollectionViewCell, ProtocolShopOfferCollectionViewCell, ProtocolHearingAidShopModelCollectionViewCell, ProtocolHearingAidHotDealsCollectionViewCell, ProtocolHearingAidFilterProductCollectionViewCell, ProtocolAccessoriesGreatDealsCollectionViewCell, ProtocolAccessoriesCategoryCollectionViewCell, ProtocolAccessoriesFilterProductCollectionViewCell, BottomPopupDelegate {
    
    func tagButtonPressedHearingAidFilterTagCollectionViewCell(senderTag: Int) {
        if senderTag == 0 {
            self.commonAPICALL(retryAPIID: 1000)
        } else if senderTag == 1 {
            self.commonAPICALL(retryAPIID: 1001)
        } else if senderTag == 2 {
            self.commonAPICALL(retryAPIID: 1002)
        } else if senderTag == 3 {
            self.navigateToHearingAidFilterViewController(styleArraySelected: self.styleArraySelected, brandArraySelected: self.brandArraySelected, featureArraySelected: self.featureArraySelected, specificationArraySelected: self.specificationArraySelected)
        }
    }
    func tapButtonPressedHearingAidLatestCollectionViewCell(senderTag: Int) {
        if !(self.hearingAidLatestArray[senderTag].slug.isNilOrEmpty) {
            self.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productDetailShopHA.rawValue, productslug: self.hearingAidLatestArray[senderTag].slug!)
        }
    }
    func wishlistButtonPressedHearingAidLatestCollectionViewCell(senderTag: Int) {
        // hearingAidLatestArray
    }
    func tapButtonPressedHearingAidHotDealsCollectionViewCell(senderTag: Int) {
        if !(self.hearingAidHotDealsArray[senderTag].slug.isNilOrEmpty) {
            self.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productDetailShopHA.rawValue, productslug: self.hearingAidHotDealsArray[senderTag].slug!)
        }
    }
    func wishlistButtonPressedHearingAidHotDealsCollectionViewCell(senderTag: Int) {
        // hearingAidHotDealsArray
    }
    func priceButtonPressedHearingAidPriceCollectionViewCell(senderTag: Int) {
        if self.hearingAidPriceArray.count > 0 {
            var viewAllSlug = ""
            if !(self.hearingAidPriceArray[senderTag].slug.isNilOrEmpty) {
                viewAllSlug = self.hearingAidPriceArray[senderTag].slug!
            }
            self.navigateToViewAllProductViewController(isFrom: IsNavigateFrom.viewAllShop.rawValue, filterSlug: ViewAllProductFilter.price.rawValue, viewAllSlug: viewAllSlug, styleID: 0, tabSelectedIndex: 0)
        }
    }
    func brandButtonPressedHearingAidBrandCollectionViewCell(senderTag: Int) {
        if self.hearingAidBrandArray.count > 0 {
            var viewAllSlug = ""
            if !(self.hearingAidBrandArray[senderTag].code.isNilOrEmpty) {
                viewAllSlug = self.hearingAidBrandArray[senderTag].code!
            }
            self.navigateToViewAllProductViewController(isFrom: IsNavigateFrom.viewAllShop.rawValue, filterSlug: ViewAllProductFilter.brand.rawValue, viewAllSlug: viewAllSlug, styleID: 0, tabSelectedIndex: 0)
        }
    }
    func infoButtonPressedHearingAidShopModelCollectionViewCell(senderTag: Int) {
        var imageViewName = ""
        var titlemessage = ""
        var descriptionmessage = ""
        var proArrayList = [String]()
        var consArrayList = [String]()
        var deviceArrayList = [String]()
        var humanArrayList = [String]()
        if self.hearingAidShopModelArray[senderTag].info != nil {
            if !(self.hearingAidShopModelArray[senderTag].info!.description.isNilOrEmpty) {
                descriptionmessage = "\(String(describing: self.hearingAidShopModelArray[senderTag].info!.description!))"
            }
            if !(self.hearingAidShopModelArray[senderTag].info!.name.isNilOrEmpty) {
                titlemessage = "\(String(describing: self.hearingAidShopModelArray[senderTag].info!.name!))"
            }
            if self.hearingAidShopModelArray[senderTag].info!.pros != nil {
                if self.hearingAidShopModelArray[senderTag].info!.pros!.count > 0 {
                    for item in self.hearingAidShopModelArray[senderTag].info!.pros! {
                        if !(item.isEmpty) {
                            proArrayList.append(item)
                        }
                    }
                }
            }
            if self.hearingAidShopModelArray[senderTag].info!.cons != nil {
                if self.hearingAidShopModelArray[senderTag].info!.cons!.count > 0 {
                    for item in self.hearingAidShopModelArray[senderTag].info!.cons! {
                        if !(item.isEmpty) {
                            consArrayList.append(item)
                        }
                    }
                }
            }
            if self.hearingAidShopModelArray[senderTag].info!.deviceView != nil {
                if self.hearingAidShopModelArray[senderTag].info!.deviceView!.count > 0 {
                    for item in self.hearingAidShopModelArray[senderTag].info!.deviceView! {
                        if !(item.isEmpty) {
                            deviceArrayList.append(item)
                        }
                    }
                }
            }
            if self.hearingAidShopModelArray[senderTag].info!.humanEarView != nil {
                if self.hearingAidShopModelArray[senderTag].info!.humanEarView!.count > 0 {
                    for item in self.hearingAidShopModelArray[senderTag].info!.humanEarView! {
                        if !(item.isEmpty) {
                            humanArrayList.append(item)
                        }
                    }
                }
            }
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
            guard let popupViewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetFeatureViewController) as? BottomSheetFeatureViewController else { return }
            popupViewCon.topCornerRadius = 0
            popupViewCon.presentDuration = Double(1)
            popupViewCon.dismissDuration = Double(1)
            popupViewCon.shouldDismissInteractivelty = true
            
            var bottomPadding: CGFloat = 0
            var topPadding: CGFloat = 0
            let defaultheight: CGFloat = screenFrameHeight * (4 / 5)
            
            let popvcheight = defaultheight
            if #available(iOS 11.0, *) {
                bottomPadding = self.view.safeAreaInsets.bottom
                topPadding = self.view.safeAreaInsets.top
            }
            popupViewCon.height = popvcheight + bottomPadding + topPadding
            popupViewCon.popupDelegate = self as BottomPopupDelegate
            popupViewCon.titlemessage = titlemessage
            popupViewCon.descriptionmessage = descriptionmessage
            popupViewCon.proArrayList = proArrayList
            popupViewCon.consArrayList = consArrayList
            popupViewCon.deviceArrayList = deviceArrayList
            popupViewCon.humanArrayList = humanArrayList
            present(popupViewCon, animated: true, completion: nil)
        }
    }
    func shopNowButtonPressedHearingAidShopModelCollectionViewCell(senderTag: Int) {
        if self.hearingAidShopModelArray.count > 0 {
            self.navigateToViewAllProductViewController(isFrom: IsNavigateFrom.viewAllShop.rawValue, filterSlug: ViewAllProductFilter.style.rawValue, viewAllSlug: "", styleID: self.hearingAidShopModelArray[senderTag].id!, tabSelectedIndex: 0)
        }
    }
    func offerButtonPressedShopOfferCollectionViewCell(senderTag: Int) {
        var categorySlug = ""
        var productSlug = ""
        
        if self.offerArray.count > 0 {
            if self.offerArray[senderTag] != nil {
                if !(self.offerArray[senderTag].categorySlug.isNilOrEmpty) {
                    categorySlug = self.offerArray[senderTag].categorySlug!
                }
                if !(self.offerArray[senderTag].productSlug.isNilOrEmpty) {
                    productSlug = self.offerArray[senderTag].productSlug!
                }
                if !(categorySlug.isEmpty) && !(productSlug.isEmpty) {
                    if categorySlug.lowercased() == "hearing-aids" {
                        self.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productDetailShopOffer.rawValue, productslug: productSlug)
                    } else {
                        self.navigateToProductDetailViewController(isFrom: IsNavigateFrom.productDetailShopOffer.rawValue, productslug: productSlug)
                    }
                } else if !(categorySlug.isEmpty)  {
                    if categorySlug.lowercased() == "hearing-aids" {
                        self.commonAPICALL(retryAPIID: 1000)
                    } else {
                        self.commonAPICALL(retryAPIID: 2000)
                    }
                }
                else {
                    self.commonAPICALL(retryAPIID: 1000)
                }
            }
        }
    }
    func shopBrandButtonPressedHearingAidShopBrandCollectionViewCell(senderTag: Int) {
        // hearingAidShopBrandarray
    }
    func shopButtonPressedShopRecentlyViewedCollectionViewCell(senderTag: Int) {}
    func tapButtonPressedHearingAidFilterProductCollectionViewCell(senderTag: Int) {
        if !(self.hearingAidFilterProductListArray[senderTag].slug.isNilOrEmpty) {
            self.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productDetailShopHA.rawValue, productslug: self.hearingAidFilterProductListArray[senderTag].slug!)
        }
    }
    
    func wishlistButtonPressedHearingAidFilterProductCollectionViewCell(senderTag: Int) {
        //        hearingAidFilterProductListArray
    }
    func tapButtonPressedAccessoriesFilterProductCollectionViewCell(senderTag: Int) {
        if !(self.accessoriesFilterProductListArray[senderTag].slug.isNilOrEmpty) {
            self.navigateToProductDetailViewController(isFrom: IsNavigateFrom.productDetailShopAccessories.rawValue, productslug: self.accessoriesFilterProductListArray[senderTag].slug!)
        }
    }
    
    func wishlistButtonPressedAccessoriesFilterProductCollectionViewCell(senderTag: Int) {
        //        accessoriesFilterProductListArray
    }
    func tagButtonPressedAccessoriesFilterTagCollectionViewCell(senderTag: Int) {
        if senderTag == 0 {
            self.commonAPICALL(retryAPIID: 2000)
        } else if senderTag == 1 {
            self.commonAPICALL(retryAPIID: 2001)
        } else if senderTag == 2 {
            self.navigateToAccessoriesFilterViewController(styleArraySelected: self.styleArraySelected, brandArraySelected: self.brandArraySelected, featureArraySelected: self.featureArraySelected, specificationArraySelected: self.specificationArraySelected)
        }
    }
    func tapButtonPressedAccessoriesCategoryCollectionViewCell(senderTag: Int) {
        if !(self.accessoriesShopModelArray[senderTag].slug.isNilOrEmpty) {
            self.navigateToAccessoriesSubCategoryViewController(accessoriesSubcategoriesSlug: self.accessoriesShopModelArray[senderTag].slug!)
        }
    }
    func tapButtonPressedAccessoriesGreatDealsCollectionViewCell(senderTag: Int) {
        if !(self.accessoriesGreatDealsArray[senderTag].slug.isNilOrEmpty) {
            self.navigateToProductDetailViewController(isFrom: IsNavigateFrom.productDetailShopAccessories.rawValue, productslug: self.accessoriesGreatDealsArray[senderTag].slug!)
        }
    }
    func wishlistButtonPressedAccessoriesGreatDealsCollectionViewCell(senderTag: Int) {
        // accessoriesGreatDealsArray
    }
}

extension ShopCategoryViewController: ProtocolViewAllProductViewController {
    func tapButtonPressedViewAllProductViewController(selectedTab: Int) {
        if selectedTab == 0 {
            self.commonAPICALL(retryAPIID: 1000)
        } else if selectedTab == 1 {
            self.commonAPICALL(retryAPIID: 2000)
        } else if selectedTab == 2 {
            self.commonAPICALL(retryAPIID: 3000)
        }
    }
}
extension ShopCategoryViewController: ProtocolHearingAidFilterViewController, ProtocolAccessoriesFilterViewController {
    func doneButtonPressedHearingAidFilterViewController(styleArraySelected: [String], brandArraySelected: [String], featureArraySelected: NSMutableArray, specificationArraySelected: NSMutableArray) {
        self.pageNumber = 1
        self.hasnext = false
        self.styleArraySelected = styleArraySelected
        self.brandArraySelected = brandArraySelected
        self.featureArraySelected = featureArraySelected
        self.specificationArraySelected = specificationArraySelected
        self.hearingAidFilterIndex = 3
        self.commonAPICALL(retryAPIID: 1003)
    }
    func doneButtonPressedAccessoriesFilterViewController(styleArraySelected: [String], brandArraySelected: [String], featureArraySelected: NSMutableArray, specificationArraySelected: NSMutableArray) {
        self.pageNumber = 1
        self.hasnext = false
        self.styleArraySelected = styleArraySelected
        self.brandArraySelected = brandArraySelected
        self.featureArraySelected = featureArraySelected
        self.specificationArraySelected = specificationArraySelected
        self.accessoriesFilterIndex = 2
        self.commonAPICALL(retryAPIID: 2002)
    }
}
