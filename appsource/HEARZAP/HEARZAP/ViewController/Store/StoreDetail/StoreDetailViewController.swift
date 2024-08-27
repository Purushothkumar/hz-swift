//
//  StoreDetailViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 27/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import MessageUI
import Cosmos
import IQKeyboardManagerSwift

class StoreDetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var scrollSelectionView: UIView!
    @IBOutlet var scrollSelectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var scrollServiceView: UIView!
    @IBOutlet var scrollServiceLabel: Caption1FontLabel!
    @IBOutlet var scrollServicebutton: CalloutOutlineButton!
    
    @IBOutlet var scrollFeatureView: UIView!
    @IBOutlet var scrollFeatureLabel: Caption1FontLabel!
    @IBOutlet var scrollFeatureButton: CalloutOutlineButton!
    
    @IBOutlet var scrollLocationView: UIView!
    @IBOutlet var scrollLocationLabel: Caption1FontLabel!
    @IBOutlet var scrollLocationButton: CalloutOutlineButton!
    
    @IBOutlet var scrollWorkingHoursView: UIView!
    @IBOutlet var scrollWorkingHoursLabel: Caption1FontLabel!
    @IBOutlet var scrollWorkingHoursButton: CalloutOutlineButton!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var storeImageView: UIView!
    @IBOutlet var storeImageCollectionView: UICollectionView!
    @IBOutlet var storeImageCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var storePageControlView: UIView!
    @IBOutlet var storePageControl: UIPageControl!
    @IBOutlet var storePageControlHeight: NSLayoutConstraint!
    
    @IBOutlet var storeInformationView: UIView!
    @IBOutlet var storeInformationBackgroundView: UIView!
    @IBOutlet var storeInformationStackView: UIStackView!
    // empty
    @IBOutlet var experienceView: UIView!
    @IBOutlet var experienceLabel: FootnoteFontLabel!
    
    @IBOutlet var storeNameLabel: Title2FontLabel!
    @IBOutlet var storecityLabel: CalloutFontLabel!
    
    @IBOutlet var storeOverallRating: CosmosView!
    
    @IBOutlet var storeAddressLabel: Caption1FontLabel!
    
    @IBOutlet var callDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var emailDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var callButton: FootnoteOutlineButton!
    @IBOutlet var emailbutton: FootnoteOutlineButton!
    
    @IBOutlet var storeStatusView: UIView!
    @IBOutlet var storeStatusLabel: FootnoteFontLabel!
    @IBOutlet var storeTimingLabel: Caption1FontLabel!
    
    @IBOutlet var storeCallView: UIView!
    @IBOutlet var storeCallLabel: Caption2FontLabel!
    @IBOutlet var storeCallButton: FootnoteOutlineButton!
    
    @IBOutlet var storeDirectionView: UIView!
    @IBOutlet var storeDirectionLabel: Caption2FontLabel!
    @IBOutlet var storeDirectionButton: FootnoteOutlineButton!
    
    @IBOutlet var storeShareView: UIView!
    @IBOutlet var storeShareLabel: Caption2FontLabel!
    @IBOutlet var storeShareButton: FootnoteOutlineButton!
    
    @IBOutlet var storeReviewView: UIView!
    @IBOutlet var storeReviewLabel: Caption2FontLabel!
    @IBOutlet var storeReviewButton: FootnoteOutlineButton!
    
    @IBOutlet var storeBookAppointmentButton: CalloutBackgroundButton!
    
    @IBOutlet var storeServiceView: UIView!
    @IBOutlet var storeServiceLabel: HeadlineFontLabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var storeOtherFeatureView: UIView!
    @IBOutlet var storeOtherFeatureTitleLabel: HeadlineFontLabel!
    @IBOutlet var storeOtherFeatureTableView: UITableView!
    @IBOutlet var storeOtherFeatureTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var storeLocationView: UIView!
    @IBOutlet var storeLocationStackView: UIStackView!
    @IBOutlet var storeLocationTitleLabel: HeadlineFontLabel!
    @IBOutlet var storeLocationAddressLabel: Caption1FontLabel!
    @IBOutlet var viewOnMapButton: FootnoteOutlineButton!
    
    @IBOutlet var storeLocationContactStackView: UIStackView!
    @IBOutlet var storeLocationCallTitleLabel: HeadlineFontLabel!
    @IBOutlet var storeLocationCallDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var storeLocationEmailDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var storeLocationCallButton: FootnoteOutlineButton!
    @IBOutlet var storeLocationEmailbutton: FootnoteOutlineButton!
    
    @IBOutlet var storeWorkingHoursView: UIView!
    @IBOutlet var storeWorkingHoursTitleLabel: HeadlineFontLabel!
    @IBOutlet var storeWorkingHoursTableView: UITableView!
    @IBOutlet var storeWorkingHoursTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var bookNowView: UIView!
    @IBOutlet var bookNowStackView: UIStackView!
    @IBOutlet var bookNowTitleLabel: HeadlineFontLabel!
    @IBOutlet var bookNowStoreNameLabel: CalloutFontLabel!
    @IBOutlet var bookNowAddressLabel: Caption1FontLabel!
    @IBOutlet var bookNowCallDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var bookNowEmailDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var bookNowButton: CalloutBackgroundButton!
    
    @IBOutlet var bannercommitmentView: UIView!
    
    @IBOutlet var ratingView: UIView!
    @IBOutlet var happyTitleLabel: CalloutFontLabel!
    @IBOutlet var happyDescriptionLabel: Caption1FontLabel!
    @IBOutlet var storeRatingCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    //    @IBOutlet var ratingViewHeight: NSLayoutConstraint!
    
    // MARK: - Lets and Var
    
    var storeDetailViewModel = StoreDetailViewModel()
    //    var storeImageCollectionView_index = 1
    //    var storeRatingCollectionView_index = 1
    var timer = Timer()
    var timer1 = Timer()
    var storePhotoArray = [StorePhoto]()
    var storeServiceArray = [StoreService]()
    var storeFeatureArray = [StoreFeature]()
    var storeRatingArray = [StoreReview]()
    var storeWorkHourArray = [StoreWorkHour]()
    
    var slug = ""
    var phoneNumber = ""
    var email = ""
    var storeAddress = ""
    var latitude = AppConstantValue.defaultlatlong
    var longitude = AppConstantValue.defaultlatlong
    var sharedLink = ""
    var storename = ""
    var hasPhoneNumber = false
    var hasEmail = false
    var datePicker = UIDatePicker()
    var timePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    var strDate = ""
    var strTime = ""
    var componentsDay = 0
    var displayStrDate = ""
    var displayStrTime = ""
    var displayStrDateTime = ""
    var activeField = UITextField()
    let storeImageCollectionViewMargin = CGFloat(0)
    let storeImageCollectionViewItemSpacing = CGFloat(0)
    var storeImageCollectionViewItemHeight = CGFloat(367.17)
    var storeImageCollectionViewItemWidth = CGFloat(343)
    let storeImageCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let storeRatingCollectionViewMargin = CGFloat(0)
    let storeRatingCollectionViewItemSpacing = CGFloat(0)
    var storeRatingCollectionViewItemHeight = CGFloat(135)
    var storeRatingCollectionViewItemWidth = CGFloat(307)
    let storeRatingCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
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
        if self.storeRatingArray.count > 1 {
            self.timer1.invalidate()
            self.startAutoScrollCollectionRatingBanner()
            self.storeRatingCollectionView.reloadData()
        }
        if self.storePhotoArray.count > 1 {
            self.timer.invalidate()
            self.startAutoScrollCollectionBanner()
            self.storeImageCollectionView.reloadData()
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.storeServiceArray.count > 0 {
            self.tableViewHeight.constant = self.tableView.contentSize.height
        } else {
            self.tableViewHeight.constant = 0
        }
        if self.storeFeatureArray.count > 0 {
            self.storeOtherFeatureTableViewHeight.constant = self.storeOtherFeatureTableView.contentSize.height
        } else {
            self.storeOtherFeatureTableViewHeight.constant = 0
        }
        if self.storeWorkHourArray.count > 0 {
            self.storeWorkingHoursTableViewHeight.constant = self.storeWorkingHoursTableView.contentSize.height
        } else {
            self.storeWorkingHoursTableViewHeight.constant = 0
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
        self.timer1.invalidate()
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

        let view0 = self.mainStackView.arrangedSubviews[0]// collection view
        let view1 = self.mainStackView.arrangedSubviews[1]// page control
        let view2 = self.mainStackView.arrangedSubviews[2]// information card
        let view3 = self.mainStackView.arrangedSubviews[3]// service
        let view4 = self.mainStackView.arrangedSubviews[4]// feature
        let view5 = self.mainStackView.arrangedSubviews[5]// loaction
        let view6 = self.mainStackView.arrangedSubviews[6]// working hours
        let view7 = self.mainStackView.arrangedSubviews[7]// empty
        let view8 = self.mainStackView.arrangedSubviews[8]// bookappointment
        let view9 = self.mainStackView.arrangedSubviews[9]// empty
        let view10 = self.mainStackView.arrangedSubviews[10]// banner
        let view11 = self.mainStackView.arrangedSubviews[11]// review
        
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
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        self.setDefaultScrollHeight()
        self.setDefaultScrollLabelColor()
        self.mainScrollView.delegate = self
        self.scrollServiceLabel.text = ""
        self.scrollFeatureLabel.text = ""
        self.scrollLocationLabel.text = ""
        self.scrollWorkingHoursLabel.text = ""
        self.storecityLabel.text = ""
        self.storeAddressLabel.text = ""
        self.storeTimingLabel.text = ""
        self.storeStatusLabel.text = ""
        self.storeCallLabel.text = ""
        self.storeDirectionLabel.text = ""
        self.storeShareLabel.text = ""
        self.storeReviewLabel.text = ""
        self.storeServiceLabel.text = ""
        self.storeOtherFeatureTitleLabel.text = ""
        self.storeLocationTitleLabel.text = ""
        self.storeLocationAddressLabel.text = ""
        self.storeLocationCallTitleLabel.text = ""
        self.storeLocationCallDescriptionLabel.text = ""
        self.storeWorkingHoursTitleLabel.text = ""
        self.happyTitleLabel.text = ""
        self.happyDescriptionLabel.text = ""
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.storeOtherFeatureTableView.tableFooterView = UIView()
        self.storeOtherFeatureTableView.separatorColor = UIColor.clear
        self.storeOtherFeatureTableView.backgroundColor = UIColor.clear
        self.storeOtherFeatureTableView.rowHeight = UITableView.automaticDimension
        self.storeOtherFeatureTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.storeWorkingHoursTableView.tableFooterView = UIView()
        self.storeWorkingHoursTableView.separatorColor = UIColor.clear
        self.storeWorkingHoursTableView.backgroundColor = UIColor.clear
        self.storeWorkingHoursTableView.rowHeight = UITableView.automaticDimension
        self.storeWorkingHoursTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.viewOnMapButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.viewOnMapButton.layer.borderWidth = 1.0
        
        if !(self.slug.isEmpty) {
            self.commonAPICALL(retryAPIID: 1000)
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
        self.scrollServiceLabel.text = AppLocalizationString.services
        self.scrollFeatureLabel.text = AppLocalizationString.features
        self.scrollLocationLabel.text = AppLocalizationString.location
        self.scrollWorkingHoursLabel.text = AppLocalizationString.workingHours
        self.storeCallLabel.text = AppLocalizationString.call.uppercased()
        self.storeDirectionLabel.text = AppLocalizationString.direction.uppercased()
        self.storeShareLabel.text = AppLocalizationString.share.uppercased()
        self.storeReviewLabel.text = AppLocalizationString.review.uppercased()
        self.storeBookAppointmentButton.setTitle(AppLocalizationString.bookAppointment.uppercased(), for: .normal)
        self.storeServiceLabel.text = AppLocalizationString.services
        self.storeOtherFeatureTitleLabel.text = AppLocalizationString.otherFeatures
        self.storeLocationTitleLabel.text = AppLocalizationString.location
        self.viewOnMapButton.setTitle(AppLocalizationString.viewinMap, for: .normal)
        self.bookNowTitleLabel.text = AppLocalizationString.bookYourStoreVisit
        self.storeLocationCallTitleLabel.text = AppLocalizationString.contact
        self.storeWorkingHoursTitleLabel.text = AppLocalizationString.workingHours
        self.bookNowButton.setTitle(AppLocalizationString.bookAppointment.uppercased(), for: .normal)
        self.happyTitleLabel.text = AppLocalizationString.storeReviews
    }
    // MARK: - Reload
    func reloadStoreImageCollectionView() {
        self.storeImageCollectionViewHeight.constant = CGFloat(367.17) * CGFloat(screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
        self.storeImageCollectionViewItemHeight = CGFloat(367.17) * CGFloat(screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
        self.storeImageCollectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32)
        self.storeImageCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.storeImageCollectionViewlayout.itemSize = CGSize(width: self.storeImageCollectionViewItemWidth, height: self.storeImageCollectionViewItemHeight)
        self.storeImageCollectionViewlayout.minimumLineSpacing = self.storeImageCollectionViewItemSpacing
        self.storeImageCollectionViewlayout.minimumInteritemSpacing = self.storeImageCollectionViewItemSpacing
        self.storeImageCollectionViewlayout.scrollDirection = .horizontal
        self.storeImageCollectionView!.collectionViewLayout = self.storeImageCollectionViewlayout
        self.storeImageCollectionView.dataSource = self
        self.storeImageCollectionView.delegate = self
        self.storeImageCollectionView.reloadData()
        self.storePageControl.numberOfPages = self.storePhotoArray.count
        self.storePageControl.currentPage = 0
        if self.storePhotoArray.count > 1 {
            self.startAutoScrollCollectionBanner()
        }
    }
    func reloadStoreRatingCollectionView() {
        self.storeRatingCollectionViewItemHeight = CGFloat(135)
        self.storeRatingCollectionViewItemWidth = CGFloat(screenFrameWidth) - (CGFloat(32) + CGFloat(32))
        self.storeRatingCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.storeRatingCollectionViewlayout.itemSize = CGSize(width: self.storeRatingCollectionViewItemWidth, height: self.storeRatingCollectionViewItemHeight)
        self.storeRatingCollectionViewlayout.minimumLineSpacing = self.storeRatingCollectionViewItemSpacing
        self.storeRatingCollectionViewlayout.minimumInteritemSpacing = self.storeRatingCollectionViewItemSpacing
        self.storeRatingCollectionViewlayout.scrollDirection = .horizontal
        self.storeRatingCollectionView!.collectionViewLayout = self.storeRatingCollectionViewlayout
        self.storeRatingCollectionView.dataSource = self
        self.storeRatingCollectionView.delegate = self
        self.storeRatingCollectionView.reloadData()
        self.pageControl.numberOfPages = self.storeRatingArray.count
        self.pageControl.currentPage = 0
        if self.storeRatingArray.count > 0 {
            self.startAutoScrollCollectionRatingBanner()
        }
    }
    func reloadTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    func reloadStoreOtherFeatureTableView() {
        self.storeOtherFeatureTableView.delegate = self
        self.storeOtherFeatureTableView.dataSource = self
        self.storeOtherFeatureTableView.reloadData()
    }
    func reloadStoreWorkingHoursTableView() {
        self.storeWorkingHoursTableView.delegate = self
        self.storeWorkingHoursTableView.dataSource = self
        self.storeWorkingHoursTableView.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getStoreDetailList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getStoreDetailList(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.slug.isEmpty) {
            let suburl = "\(SubAPIUrl.getStoreDetailList)\(slug.allowSpecialCharacters)/"
            self.storeDetailViewModel.getStoreDetailList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: suburl, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    // MARK: - IBAction
    @IBAction func storeCallButtonPressed(_ sender: UIButton) {
        if !(self.phoneNumber.isEmpty) && (self.hasPhoneNumber == true) {
            self.makeCall(phoneNumber: self.phoneNumber)
        } else {
            self.navigateToSupportViewController(isFrom: IsNavigateFrom.supportStore.rawValue)
        }
    }
    @IBAction func storeDirectionButtonPressed(_ sender: UIButton) {
        self.openMapview()
    }
    @IBAction func storeShareButtonPressed(_ sender: UIButton) {
        if !(self.sharedLink.isEmpty) {
            let objectsToShare = [sharedLink.checkhttpCharacter]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func storeReviewButtonPressed(_ sender: UIButton) {
        self.checkVerifiedUser()
    }
    @IBAction func storeBookAppointmentButtonPressed(_ sender: UIButton) {
        self.navigateToBookAppointmentLocationViewController(isFrom: IsNavigateFrom.baStoreDetail.rawValue)
    }
    @IBAction func viewOnMapButtonPressed(_ sender: UIButton) {
        self.openMapview()
    }
    @IBAction func bookAppointmentButtonPressed(_ sender: UIButton) {
        self.navigateToBookAppointmentLocationViewController(isFrom: IsNavigateFrom.baStoreDetail.rawValue)
    }
    @IBAction func scrollServicebuttonPressed(_ sender: UIButton) {
        self.tapService()
    }
    @IBAction func scrollFeatureButtonPressed(_ sender: UIButton) {
        self.tapFeature()
    }
    @IBAction func scrollLocationButtonPressed(_ sender: UIButton) {
        self.tapLocation()
    }
    @IBAction func scrollWorkingHoursButtonPressed(_ sender: UIButton) {
        self.tapWorkingHours()
    }
    @IBAction func storeLocationCallButtonPressed(_ sender: UIButton) {
        if !(self.phoneNumber.isEmpty) && (self.hasPhoneNumber == true) {
            self.makeCall(phoneNumber: self.phoneNumber)
        } else {
            self.navigateToSupportViewController(isFrom: IsNavigateFrom.supportStore.rawValue)
        }
    }
    @IBAction func storeLocationEmailbuttonPressed(_ sender: UIButton) {
        if !(self.email.isEmpty) && (self.hasEmail == true) {
            self.openMail(emailAddress: self.email)
        } else {
            self.navigateToSupportViewController(isFrom: IsNavigateFrom.supportStore.rawValue)
        }
    }
    
    // MARK: - Custom Methods
    
    func checkVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginStoreDetail.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToStoreReviewViewController(slug: self.slug, storeName: self.storename, storeAddress: self.storeAddress)
        }
    }
    func verifiedUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkVerifiedUser()
    }
    func tapWorkingHours() {
        DispatchQueue.main.async {
            let view0 = self.mainStackView.arrangedSubviews[0]// Collection View
            let view1 = self.mainStackView.arrangedSubviews[1]// Page control
            let view2 = self.mainStackView.arrangedSubviews[2]// Store Infomation
            let view3 = self.mainStackView.arrangedSubviews[3]// Service View
            let view4 = self.mainStackView.arrangedSubviews[4]// Features View
            let view5 = self.mainStackView.arrangedSubviews[5]// Location View
            let workingViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: Int(workingViewY) + 16), animated: false)
            self.setScrollHeight()
            self.setScrollWorkingHoursLabelColor()
        }
    }
    func tapLocation() {
        DispatchQueue.main.async {
            let view0 = self.mainStackView.arrangedSubviews[0]// Collection View
            let view1 = self.mainStackView.arrangedSubviews[1]// Page control
            let view2 = self.mainStackView.arrangedSubviews[2]// Store Infomation
            let view3 = self.mainStackView.arrangedSubviews[3]// Service View
            let view4 = self.mainStackView.arrangedSubviews[4]// Features View
            let locationViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: Int(locationViewY) + 16), animated: false)
            self.setScrollHeight()
            self.setScrollLocationLabelColor()
        }
    }
    func tapFeature() {
        DispatchQueue.main.async {
            let view0 = self.mainStackView.arrangedSubviews[0]// Collection View
            let view1 = self.mainStackView.arrangedSubviews[1]// Page control
            let view2 = self.mainStackView.arrangedSubviews[2]// Store Infomation
            let view3 = self.mainStackView.arrangedSubviews[3]// Service View
            let featureViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: Int(featureViewY) + 16), animated: false)
            self.setScrollHeight()
            self.setScrollFeatureLabelColor()
        }
    }
    func tapService() {
        DispatchQueue.main.async {
            let view0 = self.mainStackView.arrangedSubviews[0]// Collection View
            let view1 = self.mainStackView.arrangedSubviews[1]// Page control
            let view2 = self.mainStackView.arrangedSubviews[2]// Store Infomation
            let serviceViewY = view0.frame.height + view1.frame.height + view2.frame.height
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: Int(serviceViewY) + 16), animated: false)
            self.setScrollHeight()
            self.setScrollServiceLabelColor()
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
        self.scrollServiceLabel.font = AppFont.regular.size(13)
        self.scrollServiceLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.scrollFeatureLabel.font = AppFont.regular.size(13)
        self.scrollFeatureLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.scrollLocationLabel.font = AppFont.regular.size(13)
        self.scrollLocationLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.scrollWorkingHoursLabel.font = AppFont.regular.size(13)
        self.scrollWorkingHoursLabel.textColor = UIColor.colorLiteral.theme_grey_777777
    }
    func setScrollServiceLabelColor() {
        self.setDefaultScrollLabelColor()
        self.scrollServiceLabel.font = AppFont.medium.size(13)
        self.scrollServiceLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
    }
    func setScrollFeatureLabelColor() {
        self.setDefaultScrollLabelColor()
        self.scrollFeatureLabel.font = AppFont.medium.size(13)
        self.scrollFeatureLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
    }
    func setScrollLocationLabelColor() {
        self.setDefaultScrollLabelColor()
        self.scrollLocationLabel.font = AppFont.medium.size(13)
        self.scrollLocationLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
    }
    func setScrollWorkingHoursLabelColor() {
        self.setDefaultScrollLabelColor()
        self.scrollWorkingHoursLabel.font = AppFont.medium.size(13)
        self.scrollWorkingHoursLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
    }
    func startAutoScrollCollectionRatingBanner() {
        DispatchQueue.main.async {
            self.timer1.invalidate()
            self.timer1 =  Timer.scheduledTimer(timeInterval: Double(AppConstantValue.timerInterval), target: self, selector: #selector(self.autoScrollCollectionRatingBanner), userInfo: nil, repeats: true)
        }
    }
    func startAutoScrollCollectionBanner() {
        DispatchQueue.main.async {
            self.timer.invalidate()
            self.timer =  Timer.scheduledTimer(timeInterval: Double(AppConstantValue.timerInterval), target: self, selector: #selector(self.autoScrollCollectionBanner), userInfo: nil, repeats: true)
        }
    }
    @objc func autoScrollCollectionRatingBanner(_ timer: Timer) {
        if let coll  = self.storeRatingCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if (indexPath?.item)! < self.storeRatingArray.count - 1 {
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
    @objc func autoScrollCollectionBanner(_ timer: Timer) {
        if let coll  = self.storeImageCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if (indexPath?.item)! < self.storePhotoArray.count - 1 {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(item: (indexPath?.item)! + 1, section: 0)
                    storePageControl.currentPage = (indexPath1?.item)!
                    let rect = coll.layoutAttributesForItem(at: indexPath1!)?.frame
                    coll.scrollRectToVisible(rect!, animated: true)
                } else {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(item: 0, section: 0)
                    storePageControl.currentPage = 0
                    let rect = coll.layoutAttributesForItem(at: indexPath1!)?.frame
                    coll.scrollRectToVisible(rect!, animated: true)
                }
            }
        }
    }
    func openMapview() {
        var latitudeString = ""
        var longitudeString = ""
        if self.latitude != AppConstantValue.defaultlatlong {
            latitudeString = String(format: "%f", self.latitude)
        }
        if self.longitude != AppConstantValue.defaultlatlong {
            longitudeString = String(format: "%f", self.longitude)
        }
        if !(latitudeString.isEmpty) && !(longitudeString.isEmpty) {
            let string = "http://maps.google.com/maps?q=\(latitudeString),\(longitudeString)&zoom=14"
            UIApplication.shared.open(URL(string: string)!)
        } else if !(self.storeAddress.isEmpty) {
            let string = "http://maps.google.com/maps?q=\(storeAddress)&zoom=14"
            UIApplication.shared.open(URL(string: string)!)
        } else {
            NSLog("Can't use com.google.maps://")
        }
    }
    
    // MARK: - GestureRecognizer Delegate
    @objc func handleLongPressRatingBanner(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            self.timer1.invalidate()
            if self.storeRatingArray.count > 1 {
                self.startAutoScrollCollectionRatingBanner()
            }
            return
        } else if gestureRecognizer.state == .began {
            self.timer1.invalidate()
            let pointOfContact = gestureRecognizer.location(in: self.storeRatingCollectionView)
            let indexPath = self.storeRatingCollectionView.indexPathForItem(at: pointOfContact)
            if let index = indexPath {
                var cell = self.storeRatingCollectionView.cellForItem(at: index)
                // do stuff with your cell, for example print the indexPath
                self.pageControl.currentPage = index.item
            } else {}
        }
    }
    
    @objc func handleLongPressBanner(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            self.timer.invalidate()
            if self.storePhotoArray.count > 1 {
                self.startAutoScrollCollectionBanner()
            }
            return
        } else if gestureRecognizer.state == .began {
            self.timer.invalidate()
            let pointOfContact = gestureRecognizer.location(in: self.storeImageCollectionView)
            let indexPath = self.storeImageCollectionView.indexPathForItem(at: pointOfContact)
            if let index = indexPath {
                var cell = self.storeImageCollectionView.cellForItem(at: index)
                // do stuff with your cell, for example print the indexPath
                self.storePageControl.currentPage = index.item
            } else {}
        }
    }
}
extension StoreDetailViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
    }
}
extension StoreDetailViewController: ProtocolNetworkRechabilityDelegate {
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
extension StoreDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.storeImageCollectionView {
            if self.storePhotoArray.count > 0 {
                return self.storePhotoArray.count
            } else {
                return 1
            }
        } else {
            return self.storeRatingArray.count
        }
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.storeImageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.StoreImageCollectionViewCell, for: indexPath) as! StoreImageCollectionViewCell
            if self.storePhotoArray.count > 0 {
                cell.configure(storePhoto: self.storePhotoArray[indexPath.item], indexpath: indexPath.item)
            } else {
                cell.storeImageView.image = UIImage(named: Asset.hearzapplaceholder)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.StoreDetailReviewRatingCollectionViewCell, for: indexPath) as! StoreDetailReviewRatingCollectionViewCell
            cell.configure(storeReview: self.storeRatingArray[indexPath.item], indexpath: indexPath.item)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        
        if collectionView == self.storeImageCollectionView {
            cellWidth = self.storeImageCollectionViewItemWidth
            cellHeight = self.storeImageCollectionViewItemHeight
        } else {
            cellWidth = self.storeRatingCollectionViewItemWidth
            cellHeight = self.storeRatingCollectionViewItemHeight
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
    // MARK: - Scrollview Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.storeRatingCollectionView {
            if self.storeRatingArray.count > 1 {
                for cell in self.storeRatingCollectionView.visibleCells {
                    let indexPath = self.storeRatingCollectionView.indexPath(for: cell)
                    self.pageControl.currentPage = indexPath!.item
                }
            }
        } else {
            if self.storePhotoArray.count > 1 {
                for cell in self.storeImageCollectionView.visibleCells {
                    let indexPath = self.storeImageCollectionView.indexPath(for: cell)
                    self.storePageControl.currentPage = indexPath!.item
                }
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.mainScrollView {
            let view0 = self.mainStackView.arrangedSubviews[0]// Collection View
            let view1 = self.mainStackView.arrangedSubviews[1]// Page control
            let view2 = self.mainStackView.arrangedSubviews[2]// Store Infomation
            let view3 = self.mainStackView.arrangedSubviews[3]// Service View
            let view4 = self.mainStackView.arrangedSubviews[4]// Features View
            let view5 = self.mainStackView.arrangedSubviews[5]// Location View
            let view6 = self.mainStackView.arrangedSubviews[6]// Working Hour View
            let view7 = self.mainStackView.arrangedSubviews[7]// Empty view
            let view8 = self.mainStackView.arrangedSubviews[8]// Book store visit
            let view9 = self.mainStackView.arrangedSubviews[9]// Empty view
            let view10 = self.mainStackView.arrangedSubviews[10]// Banner View
            let view11 = self.mainStackView.arrangedSubviews[11]// Rating View
            
            let serviceViewY = view0.frame.height + view1.frame.height + view2.frame.height
            let featureViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height
            let locationViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height
            let workingViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height
            
            let emptyViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height
            
            let stackviewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height + view7.frame.height + view8.frame.height + view9.frame.height + view10.frame.height + view11.frame.height
            self.setDefaultScrollLabelColor()
            if scrollView.contentOffset.y < serviceViewY {
                self.setDefaultScrollHeight()
                self.setDefaultScrollLabelColor()
            } else if scrollView.contentOffset.y > emptyViewY {
                self.setScrollHeight()
                self.setDefaultScrollLabelColor()
            } else if scrollView.contentOffset.y > workingViewY {
                self.setScrollHeight()
                self.setScrollWorkingHoursLabelColor()
            } else if scrollView.contentOffset.y > locationViewY {
                self.setScrollHeight()
                self.setScrollLocationLabelColor()
            } else if scrollView.contentOffset.y > featureViewY {
                self.setScrollHeight()
                self.setScrollFeatureLabelColor()
            } else if scrollView.contentOffset.y > serviceViewY {
                self.setScrollHeight()
                self.setScrollServiceLabelColor()
            }
        }
    }
}
extension StoreDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return self.storeServiceArray.count
        } else if tableView == self.storeWorkingHoursTableView {
            return self.storeWorkHourArray.count
        } else {
            return self.storeFeatureArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.StoreServiceTableViewCell, for: indexPath) as! StoreServiceTableViewCell
            cell.configure(storeService: self.storeServiceArray[indexPath.row], indexpath: indexPath.row)
            if indexPath.row == (self.storeServiceArray.count - 1) {
                cell.hideSeparator()
            }
            return cell
        } else if tableView == self.storeWorkingHoursTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.StoreWorkingHourTableViewCell, for: indexPath) as! StoreWorkingHourTableViewCell
            cell.configure(storeWorkHour: self.storeWorkHourArray[indexPath.row], indexpath: indexPath.row)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.StoreFeatureTableViewCell, for: indexPath) as! StoreFeatureTableViewCell
            cell.configure(storeFeature: self.storeFeatureArray[indexPath.row], indexpath: indexPath.row)
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
        if tableView == self.tableView {
            self.tableViewHeight.constant = tableView.contentSize.height
        } else if tableView == self.storeWorkingHoursTableView {
            self.storeWorkingHoursTableViewHeight.constant = tableView.contentSize.height
        } else {
            self.storeOtherFeatureTableViewHeight.constant = tableView.contentSize.height
        }
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}

extension StoreDetailViewController: MFMailComposeViewControllerDelegate {
    // MARK: - To Open Email
    func openMail(emailAddress: String) {
        // Modify following variables with your text / recipient
        let recipientEmail = emailAddress
        let subject = ""
        let body = ""
        
        if recipientEmail.isEmailValid {
            // Show default mail composer
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([recipientEmail])
                mail.setSubject(subject)
                mail.setMessageBody(body, isHTML: false)
                present(mail, animated: true)
                // Show third party email composer if default Mail app is not present
            } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
                UIApplication.shared.open(emailUrl)
            }
        }
    }
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
