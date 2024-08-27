//
//  StoreFinderViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import YouTubePlayer
import BottomPopup

class StoreFinderViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: MainLogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var mainBackgroundView: UIView!
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    
    @IBOutlet var storeTitleView: UIView!
    
    @IBOutlet var titleLabel: Title2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var videoView: UIView!
    @IBOutlet var youTubePlayerView: YouTubePlayerView!
    
    @IBOutlet var filterTitleView: UIView!
    @IBOutlet var filterTitleBackgroundView: UIView!
    @IBOutlet var findNearbyLabel: HeadlineFontLabel!
    @IBOutlet var findNearbyTextfield: Caption1FontTextfield!
    @IBOutlet var findNearbyButton: CalloutBackgroundButton!
    
    @IBOutlet var experienceStoreTitleView: UIView!
    @IBOutlet var experienceStoreTitleLabel: CalloutFontLabel!
    
    @IBOutlet var cityView: UIView!
    @IBOutlet var cityCollectionView: UICollectionView!
    @IBOutlet var cityCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var metroStoreView: UIView!
    @IBOutlet var metroStoreCollectionView: UICollectionView!
    @IBOutlet var metroStoreCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var nearbyTitleView: UIView!
    @IBOutlet var nearbyTitleLabel: HeadlineFontLabel!
    
    @IBOutlet var filterView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var hearzapDifferenceTitleView: UIView!
    @IBOutlet var hearzapDifferenceTitleLabel: HeadlineFontLabel!
    @IBOutlet var hearzapDifferenceDescriptionLabel: Caption1FontLabel!
    
    @IBOutlet var hearzapDifferenceView: UIView!
    @IBOutlet var hearzapDifferenceCollectionView: UICollectionView!
    @IBOutlet var hearzapDifferenceCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var bannercommitmentView: UIView!
    
    @IBOutlet var statsTitleView: UIView!
    @IBOutlet var statsTitleLabel: HeadlineFontLabel!
    @IBOutlet var statsDescriptionLabel: Caption1FontLabel!
    
    @IBOutlet var providerView: UIView!
    @IBOutlet var providerTableView: UITableView!
    @IBOutlet var providerTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var ratingView: UIView!
    @IBOutlet var happyTitleLabel: CalloutFontLabel!
    @IBOutlet var happyDescriptionLabel: Caption1FontLabel!
    @IBOutlet var storeRatingCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var FAQTitleView: UIView!
    @IBOutlet var FAQTitleLabel: HeadlineFontLabel!
    
    @IBOutlet var faqView: UIView!
    @IBOutlet var faqTableView: UITableView!
    @IBOutlet var faqTableViewHeight: NSLayoutConstraint!
    @IBOutlet var viewMoreButton: FootnoteOutlineButton!
    
    // MARK: - Lets and Var
    
    let storeFinderViewModel = StoreFinderViewModel()
    var cityNamesArray = [String]()
    var metroStoreArray = [StoreList]()
    var stateCountArray = [StoreFinderModelStateList]()
    var hearzapDifferenceArray = [StoreFinderDifferenceModelResult]()
    var providerArray = [StoreProvidersModel]()
    var faqArray = [FAQModelExpanded]()
    var reviewRatingArray = [StoreFinderCustomerTestimonialResult]()
    var faqPageNumber = 1
    var testimonialPageNumber = 1
    var storeRatingCollectionView_index = 1
    var faqnext = false
    var testimonialnext = false
    var timer = Timer()
    
    let metroStoreCollectionViewMargin = 0
    let metroStoreCollectionViewItemSpacing = CGFloat(16)
    var metroStoreCollectionViewItemHeight = CGFloat(266)
    var metroStoreCollectionViewItemWidth = CGFloat(300)
    let metroStoreCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let hearzapDifferenceCollectionViewMargin = 0
    let hearzapDifferenceCollectionViewItemSpacing = CGFloat(10)
    var hearzapDifferenceCollectionViewItemHeight = CGFloat(150)
    var hearzapDifferenceCollectionViewItemWidth = CGFloat(300)
    let hearzapDifferenceCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let storeRatingCollectionViewMargin = CGFloat(0)
    let storeRatingCollectionViewItemSpacing = CGFloat(0)
    var storeRatingCollectionViewItemHeight = CGFloat(135)
    var storeRatingCollectionViewItemWidth = CGFloat(300)
    let storeRatingCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var hasAlert = false
    var hasCart = false
    
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
        self.storeFinderViewModel.getStoreProvidersList(viewCon: self)
        UserDefaults.standard.set(AppLocalizationString.tabStores, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.reloadProviderTableView()
        self.faqPageNumber = 1
        self.testimonialPageNumber = 1
        self.storeRatingCollectionView_index = 1
        self.faqnext = false
        self.testimonialnext = false
        self.commonAPICALL(retryAPIID: 1000)
        if self.reviewRatingArray.count > 0 {
            self.reloadStoreRatingCollectionView()
        }
        if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty) {
            self.hasAlert = false
            self.hasCart = false
            self.commonAPICALL(retryAPIID: 2000)
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.stateCountArray.count > 0 {
            self.tableViewHeight.constant = self.tableView.contentSize.height
        } else {
            self.tableViewHeight.constant = 0
        }
        if self.providerArray.count > 0 {
            var height: CGFloat = 0
            for item in providerArray {
                let itemHeight = self.heightForText(text: item.title, Font: AppFont.medium.size(13), Width: AppConstantValue.screenWidthminus32 - (16 + 8 + 72 + 72)) + 16 + 16
                height += itemHeight
            }
            self.providerTableView.isScrollEnabled = false
            self.providerTableViewHeight.constant =  height
        } else {
            self.providerTableViewHeight.constant = 0
        }
        if self.faqArray.count > 0 {
            self.faqTableViewHeight.constant = self.faqTableView.contentSize.height
        } else {
            self.faqTableViewHeight.constant = 0
        }
        self.filterView.roundCorners([.bottomLeft, .bottomRight], radius: AppConstantValue.cornerRadius4)
        self.tableView.roundCorners([.bottomLeft, .bottomRight], radius: AppConstantValue.cornerRadius4)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
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
        let view0 = self.mainStackView.arrangedSubviews[0]// title
        let view1 = self.mainStackView.arrangedSubviews[1]// video
        let view2 = self.mainStackView.arrangedSubviews[2]// filter title
        let view3 = self.mainStackView.arrangedSubviews[3]// experience store title
        let view4 = self.mainStackView.arrangedSubviews[4]// city list
        
        let view5 = self.mainStackView.arrangedSubviews[5]// metro list
        let view6 = self.mainStackView.arrangedSubviews[6]// nearby title
        let view7 = self.mainStackView.arrangedSubviews[7]// State list
        let view8 = self.mainStackView.arrangedSubviews[8]// hearzap difference title
        let view9 = self.mainStackView.arrangedSubviews[9]// hearzap difference Collection view
        let view10 = self.mainStackView.arrangedSubviews[10]// empty view
        let view11 = self.mainStackView.arrangedSubviews[11]// banner commitment view
        let view12 = self.mainStackView.arrangedSubviews[12]//stats view
        let view13 = self.mainStackView.arrangedSubviews[13]//provider view
        let view14 = self.mainStackView.arrangedSubviews[14]//empty
        let view15 = self.mainStackView.arrangedSubviews[15]// testimonial Collection view
        let view16 = self.mainStackView.arrangedSubviews[16]// Faq Title
        let view17 = self.mainStackView.arrangedSubviews[17]// Faq table View
        let view18 = self.mainStackView.arrangedSubviews[18]// load more
        
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
        view12.isHidden = true
        view13.isHidden = true
        view14.isHidden = true
        view15.isHidden = true
        view16.isHidden = true
        view17.isHidden = true
        view18.isHidden = true

        self.findNearbyTextfield.setLeftPaddingPoints(CGFloat(10))
        self.findNearbyTextfield.setRightPaddingPoints(CGFloat(10))
        
        self.tableView.tableFooterView = UIView()
        //            self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.providerTableView.tableFooterView = UIView()
        self.providerTableView.separatorColor = UIColor.clear
        //        self.providerTableView.backgroundColor = UIColor.clear
        self.providerTableView.rowHeight = UITableView.automaticDimension
        self.providerTableView.estimatedRowHeight = UITableView.automaticDimension
        self.storeFinderViewModel.getStoreProvidersList(viewCon: self)
        
        self.faqTableView.tableFooterView = UIView()
        //            self.tableView.separatorColor = UIColor.clear
        self.faqTableView.backgroundColor = UIColor.clear
        self.faqTableView.rowHeight = UITableView.automaticDimension
        self.faqTableView.estimatedRowHeight = UITableView.automaticDimension
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
        self.navigationBar.isLogoHidden = false
        self.navigationBar.logoImage = Asset.hzlogo
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.titleLabel.text = AppLocalizationString.storesNearYou
        self.descriptionLabel.text = AppLocalizationString.storesNearYouDescription
        self.experienceStoreTitleLabel.text = AppLocalizationString.hearzapExperienceStores
        self.nearbyTitleLabel.text = AppLocalizationString.nearbyStores
        self.findNearbyLabel.text = AppLocalizationString.searchstoresNearYou
        self.findNearbyTextfield.placeholder = AppLocalizationString.enteryourcityorpincode
        self.hearzapDifferenceTitleLabel.text = AppLocalizationString.hearzapTheSmarterChoice
        self.hearzapDifferenceDescriptionLabel.text = AppLocalizationString.evenmorereasonstovisitourstores
        self.statsTitleLabel.text = AppLocalizationString.hEARZAPVsOtherProviders
        self.statsDescriptionLabel.text = AppLocalizationString.howweexcelfromotherhearingcareproviders
        self.happyTitleLabel.text = AppLocalizationString.happyCustomers
        self.happyDescriptionLabel.text = AppLocalizationString.satisfiedcustomers
        self.FAQTitleLabel.text = AppLocalizationString.faq.uppercased()
        self.viewMoreButton.setTitle(AppLocalizationString.viewMore.uppercased(), for: .normal)
    }
    
    // MARK: - Reload
    func reloadCityCollectionView() {
        if self.cityNamesArray.count > 0 {
            self.cityCollectionViewHeight.constant = CGFloat(26)
        } else {
            self.cityCollectionViewHeight.constant = 0
        }
        let cityCollectionViewlayout = UICollectionViewFlowLayout()
        cityCollectionViewlayout.scrollDirection = .horizontal
        cityCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cityCollectionViewlayout.minimumLineSpacing = CGFloat(8)
        cityCollectionViewlayout.minimumInteritemSpacing = CGFloat(8)
        self.cityCollectionView.collectionViewLayout = cityCollectionViewlayout
        self.cityCollectionView.delegate = self
        self.cityCollectionView.dataSource = self
        self.cityCollectionView.reloadData()
        self.cityCollectionView.collectionViewLayout.invalidateLayout()
        self.cityCollectionView!.layoutSubviews()
    }
    
    func reloadMetroStoreCollectionView() {
        self.metroStoreCollectionViewItemHeight = CGFloat(330)
        self.metroStoreCollectionViewItemWidth = CGFloat(300)
        self.metroStoreCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.metroStoreCollectionViewlayout.itemSize = CGSize(width: self.metroStoreCollectionViewItemWidth, height: self.metroStoreCollectionViewItemHeight)
        self.metroStoreCollectionViewlayout.minimumLineSpacing = self.metroStoreCollectionViewItemSpacing
        self.metroStoreCollectionViewlayout.minimumInteritemSpacing = self.metroStoreCollectionViewItemSpacing
        self.metroStoreCollectionViewlayout.scrollDirection = .horizontal
        self.metroStoreCollectionView!.collectionViewLayout = self.metroStoreCollectionViewlayout
        self.metroStoreCollectionView.dataSource = self
        self.metroStoreCollectionView.delegate = self
        self.metroStoreCollectionView.reloadData()
        if self.metroStoreArray.count > 0 {
            self.metroStoreCollectionViewHeight.constant = CGFloat(330)
        } else {
            self.metroStoreCollectionViewHeight.constant = 0
        }
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
            self.hearzapDifferenceCollectionViewHeight.constant = 150
        } else {
            self.hearzapDifferenceCollectionViewHeight.constant = 0
        }
    }
    
    func reloadStoreRatingCollectionView() {
        self.storeRatingCollectionViewItemHeight = CGFloat(135)
        self.storeRatingCollectionViewItemWidth = CGFloat(screenFrameWidth) - CGFloat(32 + 32)
        self.storeRatingCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.storeRatingCollectionViewlayout.itemSize = CGSize(width: self.storeRatingCollectionViewItemWidth, height: self.storeRatingCollectionViewItemHeight)
        self.storeRatingCollectionViewlayout.minimumLineSpacing = self.storeRatingCollectionViewItemSpacing
        self.storeRatingCollectionViewlayout.minimumInteritemSpacing = self.storeRatingCollectionViewItemSpacing
        self.storeRatingCollectionViewlayout.scrollDirection = .horizontal
        self.storeRatingCollectionView!.collectionViewLayout = self.storeRatingCollectionViewlayout
        self.storeRatingCollectionView.dataSource = self
        self.storeRatingCollectionView.delegate = self
        self.storeRatingCollectionView.reloadData()
        self.pageControl.numberOfPages = self.reviewRatingArray.count
        self.pageControl.currentPage = 0
        
        if self.reviewRatingArray.count > 1 {
            self.timer.invalidate()
            self.startAutoScrollCollectionBanner()
        } else {
            self.pageControl.isHidden = true
        }
    }
    func reloadStateCountTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    func reloadProviderTableView() {
        self.providerTableView.delegate = self
        self.providerTableView.dataSource = self
        self.providerTableView.reloadData()
    }
    func reloadFAQTableView() {
        self.faqTableView.delegate = self
        self.faqTableView.dataSource = self
        self.faqTableView.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getStoreFinderList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getStoreFinderHearzapDifferenceList(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 1002 {
                    self.getStoreFinderCustomerTestimonial(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 1003 {
                    self.getStoreFAQList(retryAPIID: retryAPIID, canShowLoader: false)
                } else if retryAPIID == 1004 {
                    self.getStoreFAQList(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.getNotificationCount(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getStoreFinderList(retryAPIID: Int, canShowLoader: Bool) {
        self.storeFinderViewModel.getStoreFinderList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getStoreFinderList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getStoreFinderHearzapDifferenceList(retryAPIID: Int, canShowLoader: Bool) {
        self.storeFinderViewModel.getStoreFinderHearzapDifferenceList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getStoreFinderHearzapDifferenceList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getStoreFinderCustomerTestimonial(retryAPIID: Int, canShowLoader: Bool) {
        self.storeFinderViewModel.getStoreFinderCustomerTestimonial(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getStoreFinderCustomerTestimonialList, methodName: HTTPMethods.get, parameter: "", pageNumber: String(format: "%d", self.testimonialPageNumber), retryAPIID: retryAPIID, strQuery: "")
    }
    func getStoreFAQList(retryAPIID: Int, canShowLoader: Bool) {
        self.storeFinderViewModel.getStoreFAQList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getStoreFAQList, methodName: HTTPMethods.get, parameter: "", pageNumber: String(format: "%d", self.faqPageNumber), retryAPIID: retryAPIID, strQuery: "")
    }
    func getNotificationCount(retryAPIID: Int, canShowLoader: Bool) {
        self.storeFinderViewModel.getNotificationCount(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getNotificationCount, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func findNearbyButtonPressed(_ sender: UIButton) {
        self.navigateToStoreFilterViewController(queryString: "", isState: false, isCity: false, isZipCode: false)
    }
    @IBAction func viewMoreButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1004)
    }
    // MARK: - Custom Methods
    func startAutoScrollCollectionBanner() {
        DispatchQueue.main.async {
            self.timer.invalidate()
            self.timer =  Timer.scheduledTimer(timeInterval: Double(AppConstantValue.timerInterval), target: self, selector: #selector(self.autoScrollCollectionBanner), userInfo: nil, repeats: true)
        }
    }
    @objc func autoScrollCollectionBanner(_ timer1: Timer) {
        if let coll  = self.storeRatingCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if (indexPath?.item)! < self.reviewRatingArray.count - 1 {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(item: (indexPath?.item)! + 1, section: 0)
                    pageControl.currentPage = (indexPath1?.item)!
                    let rect = coll.layoutAttributesForItem(at: indexPath1!)?.frame
                    coll.scrollRectToVisible(rect!, animated: true)
                } else {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(item: 0, section: 0)
                    pageControl.currentPage = 0
                    let rect = coll.layoutAttributesForItem(at: indexPath1!)?.frame
                    coll.scrollRectToVisible(rect!, animated: true)
                    
                }
            }
        }
    }
    func checkCartVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginCartStore.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToCartDetailViewController(isFrom: IsNavigateFrom.cartStore.rawValue)
        }
    }
    func verifiedCartUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkCartVerifiedUser()
    }
    func checkMyAlertVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginMyAlertStore.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToMyAlertViewController(isFrom: IsNavigateFrom.myalertStore.rawValue)
        }
    }
    func verifiedMyAlertUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkMyAlertVerifiedUser()
    }
    // MARK: - GestureRecognizer Delegate
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            self.timer.invalidate()
            if self.reviewRatingArray.count > 1 {
                self.startAutoScrollCollectionBanner()
            }
            return
        } else if gestureRecognizer.state == .began {
            self.timer.invalidate()
            let pointOfContact = gestureRecognizer.location(in: self.storeRatingCollectionView)
            let indexPath = self.storeRatingCollectionView.indexPathForItem(at: pointOfContact)
            if let index = indexPath {
                var cell = self.storeRatingCollectionView.cellForItem(at: index)
                // do stuff with your cell, for example print the indexPath
                self.pageControl.currentPage = index.item
            } else {}
        }
    }
}
extension StoreFinderViewController: ProtocolMainLogoNavigationBar {
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
extension StoreFinderViewController: ProtocolNetworkRechabilityDelegate {
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
extension StoreFinderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.metroStoreCollectionView {
            return self.metroStoreArray.count
        } else if collectionView == self.hearzapDifferenceCollectionView {
            return self.hearzapDifferenceArray.count
        } else if collectionView == self.storeRatingCollectionView {
            return self.reviewRatingArray.count
        } else {
            return self.cityNamesArray.count
        }
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.metroStoreCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.MetroStoreCollectionViewCell, for: indexPath) as! MetroStoreCollectionViewCell
            cell.delegate = self
            cell.configure(storeList: metroStoreArray[indexPath.item], indexpath: indexPath.item)
            return cell
        } else if collectionView == self.hearzapDifferenceCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.StoreFinderHearzapDifferenceCollectionViewCell, for: indexPath) as! StoreFinderHearzapDifferenceCollectionViewCell
            cell.configure(hearzapDifference: self.hearzapDifferenceArray[indexPath.item], indexpath: indexPath.item)
            return cell
        } else if collectionView == self.storeRatingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.StoreReviewRatingCollectionViewCell, for: indexPath) as! StoreReviewRatingCollectionViewCell
            cell.configure(storeFinderCustomerTestimonialResult: reviewRatingArray[indexPath.item], indexpath: indexPath.item)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.StoreCityListCollectionViewCell, for: indexPath) as! StoreCityListCollectionViewCell
            if cityNamesArray[indexPath.item].isEmpty {
                cell.configure(cityNames: "", indexpath: indexPath.item)
            } else {
                cell.configure(cityNames: cityNamesArray[indexPath.item].capitalized, indexpath: indexPath.item)
            }
            cell.delegate = self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.metroStoreCollectionView {
            cellWidth = self.metroStoreCollectionViewItemWidth
            cellHeight = self.metroStoreCollectionViewItemHeight
        } else if collectionView == self.hearzapDifferenceCollectionView {
            cellWidth = self.hearzapDifferenceCollectionViewItemWidth
            cellHeight = self.hearzapDifferenceCollectionViewItemHeight
        } else if collectionView == self.storeRatingCollectionView {
            cellWidth = self.storeRatingCollectionViewItemWidth
            cellHeight = self.storeRatingCollectionViewItemHeight
        } else {
            let tag = self.cityNamesArray[indexPath.item].uppercased()
            let font = AppFont.medium.size(13)
            let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
            cellWidth = size.width + CGFloat(20)
            cellHeight = CGFloat(26)
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
    // MARK: - Scrollview Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.storeRatingCollectionView {
            if self.reviewRatingArray.count > 1 {
                for cell in self.storeRatingCollectionView.visibleCells {
                    let indexPath = self.storeRatingCollectionView.indexPath(for: cell)
                    self.pageControl.currentPage = indexPath!.item
                }
            }
        }
    }
}
extension StoreFinderViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == faqTableView {
            return self.faqArray.count
        } else if tableView == providerTableView {
            return self.providerArray.count
        } else if tableView == tableView {
            return self.stateCountArray.count
        }
        return 0
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == faqTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.StoreFAQTableViewCell, for: indexPath) as! StoreFAQTableViewCell
            cell.configure(FAQModelExpanded: self.faqArray[indexPath.row], indexpath: indexPath.row)
            if self.faqArray.count > 0 {
                if indexPath.row == (self.faqArray.count - 1) {
                    cell.hideSeparator()
                }
            } else {
                cell.hideSeparator()
            }
            return cell
        } else if tableView == providerTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.StoreProvidersTableViewCell, for: indexPath) as! StoreProvidersTableViewCell
            cell.configure(storeProvidersModel: self.providerArray[indexPath.row], indexpath: indexPath.row)
            cell.hideSeparator()
            return cell
        } else if tableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindNearbyTableViewCell, for: indexPath) as! FindNearbyTableViewCell
            cell.delegate = self
            cell.configure(storeFinderModelStateList: self.stateCountArray[indexPath.row], indexpath: indexPath.row)
            if self.stateCountArray.count > 0 {
                if indexPath.row == (self.stateCountArray.count - 1) {
                    cell.hideSeparator()
                }
            } else {
                cell.hideSeparator()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.StoreProvidersTableViewCell, for: indexPath) as! StoreProvidersTableViewCell
            cell.configure(storeProvidersModel: self.providerArray[indexPath.row], indexpath: indexPath.row)
            cell.hideSeparator()
            return cell
        }
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    public  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == faqTableView {
            self.faqTableViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        } else if tableView == providerTableView {
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        } else if tableView == tableView {
            self.tableViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        }
    }
    public  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == faqTableView {
            faqArray[indexPath.row].expanded = !faqArray[indexPath.row].expanded
            let FAQModelExpanded: FAQModelExpanded = faqArray[indexPath.row]
            tableView.beginUpdates()
            let cell = tableView.cellForRow(at: indexPath) as! StoreFAQTableViewCell
            cell.configure(FAQModelExpanded: FAQModelExpanded, indexpath: indexPath.row)
            tableView.endUpdates()
            self.faqTableViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        }
    }
}
extension StoreFinderViewController: ProtocolStoreCityListCollectionViewCell, ProtocolMetroStoreCollectionViewCell, ProtocolStoreFAQTableViewCell, ProtocolFindNearbyTableViewCell {
    func viewStoreButtonPressedMetroStoreCollectionViewCell(senderTag: Int) {
        if  self.metroStoreArray.count > 0 {
            if self.metroStoreArray[senderTag].store != nil {
                if !(self.metroStoreArray[senderTag].store!.slug.isNilOrEmpty) {
                    let slug = "\(self.metroStoreArray[senderTag].store!.slug!)"
                    self.navigateToStoreDetailViewController(slug: slug)
                }
            }
        }
    }
    func viewStoreButtonPressedFindNearbyTableViewCell(senderTag: Int) {
        var name = ""
        if self.stateCountArray.count > 0 {
            if !(self.stateCountArray[senderTag].name.isNilOrEmpty) {
                name = stateCountArray[senderTag].name!
                if !(name.isEmpty) {
                    self.navigateToStoreFilterViewController(queryString: name, isState: true, isCity: false, isZipCode: false)
                }
            }
        }
    }
    func storeFAQButtonPressedStoreFAQTableViewCell() {
        self.reloadFAQTableView()
    }
    func cityButtonPressedStoreCityListCollectionViewCell(senderTag: Int) {
        if self.cityNamesArray.count > 0 {
            if !(self.cityNamesArray[senderTag].isEmpty) {
                self.navigateToStoreFilterViewController(queryString: cityNamesArray[senderTag], isState: false, isCity: true, isZipCode: false)
            }
        }
    }
}
