//
//  HearingCareViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class HearingCareViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: MainLogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var titleLabel: Title2FontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var cardTableView: UITableView!
    @IBOutlet var cardTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var ratingView: UIView!
    @IBOutlet var happyTitleLabel: CalloutFontLabel!
    @IBOutlet var happyDescriptionLabel: Caption1FontLabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    //    @IBOutlet var ratingViewHeight: NSLayoutConstraint!
    
    // MARK: - Lets and Var
    var hearingcareViewModel = HearingCareViewModel()
    var reviewRatingArray = [CustomerTestimonial]()
    var cardArray = [HearingcareModelService]()
    //    var collectionView_index = 1
    var timer = Timer()
    
    let collectionViewMargin = CGFloat(0)
    let collectionViewItemSpacing = CGFloat(0)
    var collectionViewItemHeight = CGFloat(135)
    var collectionViewItemWidth = CGFloat(screenFrameWidth)
    let collectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
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
        UserDefaults.standard.set(AppLocalizationString.tabHearingCare, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.setNavigationBar()
        if self.reviewRatingArray.count > 0 {
            self.timer.invalidate()
            self.startAutoScrollCollectionBanner()
            self.collectionView.reloadData()
        }
        self.cardTableView.tableFooterView = UIView()
        //        self.cardTableView.separatorColor = UIColor.clear
        self.cardTableView.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.cardTableView.rowHeight = UITableView.automaticDimension
        self.cardTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadCardTableView()
        self.commonAPICALL(retryAPIID: 1000)
        if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty) {
            self.hasAlert = false
            self.hasCart = false
            self.commonAPICALL(retryAPIID: 2000)
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.cardArray.count > 0 {
            self.cardTableViewHeight.constant = self.cardTableView.contentSize.height
        } else {
            self.cardTableViewHeight.constant = 0
        }
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
        let view2 = self.mainStackView.arrangedSubviews[2]// cardlist
        let view3 = self.mainStackView.arrangedSubviews[3]// Rating
        view2.isHidden = true
        view3.isHidden = self.reviewRatingArray.count > 0 ? true : false
        self.reloadCollectionView()
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isLeftSecondaryViewHidden = true
        self.navigationBar.isRightViewHidden = false
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
        self.titleLabel.text = AppLocalizationString.hearingCareTitle
        self.descriptionLabel.text = AppLocalizationString.hearingCareDescription
        self.happyTitleLabel.text = AppLocalizationString.happyCustomers
        self.happyDescriptionLabel.text = AppLocalizationString.satisfiedcustomers
    }
    // MARK: - Reload
    
    func reloadCollectionView() {
        self.collectionViewItemHeight = CGFloat(135)
        self.collectionViewItemWidth = CGFloat(screenFrameWidth) - CGFloat(32 + 32)
        self.collectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionViewlayout.itemSize = CGSize(width: self.collectionViewItemWidth, height: self.collectionViewItemHeight)
        self.collectionViewlayout.minimumLineSpacing = self.collectionViewItemSpacing
        self.collectionViewlayout.minimumInteritemSpacing = self.collectionViewItemSpacing
        self.collectionViewlayout.scrollDirection = .horizontal
        self.collectionView!.collectionViewLayout = self.collectionViewlayout
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
        self.pageControl.numberOfPages = self.reviewRatingArray.count
        self.pageControl.currentPage = 0
        self.pageControl.isHidden = true
        if self.reviewRatingArray.count > 1 {
            self.timer.invalidate()
            self.startAutoScrollCollectionBanner()
            self.pageControl.isHidden = false
        }
    }
    func reloadCardTableView() {
        self.cardTableView.delegate = self
        self.cardTableView.dataSource = self
        self.cardTableView.reloadData()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getHearingCareData(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 2000 {
                    self.getNotificationCount(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getHearingCareData(retryAPIID: Int, canShowLoader: Bool) {
        self.hearingcareViewModel.getHearingCareData(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getHearingCareData, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getNotificationCount(retryAPIID: Int, canShowLoader: Bool) {
        self.hearingcareViewModel.getNotificationCount(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getNotificationCount, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - Custom Methods
    func startAutoScrollCollectionBanner() {
        DispatchQueue.main.async {
            self.timer.invalidate()
            self.timer =  Timer.scheduledTimer(timeInterval: Double(AppConstantValue.timerInterval), target: self, selector: #selector(self.autoScrollCollectionBanner), userInfo: nil, repeats: true)
        }
    }
    @objc func autoScrollCollectionBanner(_ timer1: Timer) {
        if let coll  = self.collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if (indexPath?.item)! < self.reviewRatingArray.count - 1 {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(item: (indexPath?.item)! + 1, section: 0)
                    pageControl.currentPage = (indexPath1?.item)!
                    let rect = coll.layoutAttributesForItem(at: indexPath1!)?.frame
                    coll.scrollRectToVisible(rect!, animated: false)
                    
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
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginCartHearingCare.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToCartDetailViewController(isFrom: IsNavigateFrom.cartHearingCare.rawValue)
        }
    }
    func verifiedCartUser(isFrom: String, isWishlist: Bool, productUID: String) {
        self.checkCartVerifiedUser()
    }
    func checkMyAlertVerifiedUser() {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginMyAlertHearingCare.rawValue, isWishlist: false, productUID: "")
        } else {
            self.navigateToMyAlertViewController(isFrom: IsNavigateFrom.myalertHearingCare.rawValue)
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
            let pointOfContact = gestureRecognizer.location(in: self.collectionView)
            let indexPath = self.collectionView.indexPathForItem(at: pointOfContact)
            if let index = indexPath {
                var cell = self.collectionView.cellForItem(at: index)
                // do stuff with your cell, for example print the indexPath
                self.pageControl.currentPage = index.item
            } else {}
        }
    }
}
extension HearingCareViewController: ProtocolMainLogoNavigationBar {
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
extension HearingCareViewController: ProtocolNetworkRechabilityDelegate {
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

extension HearingCareViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reviewRatingArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.ReviewRatingCollectionViewCell, for: indexPath) as! ReviewRatingCollectionViewCell
        cell.configure(testimonial: self.reviewRatingArray[indexPath.item], indexpath: indexPath.item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.reviewRatingArray.count > 0 {
            cellWidth = self.collectionViewItemWidth
            cellHeight = self.collectionViewItemHeight
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
    // MARK: - Scrollview Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView {
            if self.reviewRatingArray.count > 1 {
                for cell in self.collectionView.visibleCells {
                    let indexPath = self.collectionView.indexPath(for: cell)
                    self.pageControl.currentPage = indexPath!.item
                }
            }
        }
    }
}
extension HearingCareViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.cardArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.HearingCareCardTableViewCell, for: indexPath) as! HearingCareCardTableViewCell
        cell.configure(card: self.cardArray[indexPath.row], indexpath: indexPath.row)
        cell.delegate = self
        cell.hideSeparator()
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    public  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.cardTableViewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension HearingCareViewController: ProtocolHearingCareCardTableViewCell {
    func cardButtonPressedHearingCareCardTableViewCell(senderTag: Int) {
        if self.cardArray.count > 0 {
            if self.cardArray[senderTag].data != nil {
                if !(self.cardArray[senderTag].data!.serviceType.isNilOrEmpty) {
                    let serviceType = self.cardArray[senderTag].data!.serviceType!
                    if serviceType == "OC" {
                        self.navigateToOnlineConsultationLocationViewController(isFrom: IsNavigateFrom.ocHearingCare.rawValue)
                    } else if serviceType == "BOOK_APPOINTMENT" {
                        self.navigateToBookAppointmentLocationViewController(isFrom: IsNavigateFrom.baHearingCare.rawValue)
                    } else if serviceType == "QUICK_CHECKUP" {
                        self.navigateToQuickTestProfileViewController(isFrom:  IsNavigateFrom.qcHearingCare.rawValue)
                    } else if serviceType == "HAF" {
                        self.navigateToFindRightDeviceIntroductionViewController(isFrom: IsNavigateFrom.fhaHearingCare.rawValue)
                    }
                }
            }
        }
    }
}
