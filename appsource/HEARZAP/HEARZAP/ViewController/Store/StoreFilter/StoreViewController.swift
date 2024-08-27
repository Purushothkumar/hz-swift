//
//  StoreViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/07/22.
//  Copyright © 2022 SeaAnt. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    // MARK: -  IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var storeTitleView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    @IBOutlet var videoView: UIView!
    @IBOutlet var videoImageView: UIImageView!
    @IBOutlet var videoButton: UIButton!

    @IBOutlet var cityView: UIView!
    @IBOutlet var cityTitleLabel: UILabel!
    @IBOutlet var cityCollectionView: UICollectionView!

    @IBOutlet var metroStoreView: UIView!
    @IBOutlet var metroStoreCollectionView: UICollectionView!
    @IBOutlet var metroStoreCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var nearbyTitleView: UIView!
    @IBOutlet var nearbyTitleLabel: UILabel!

    @IBOutlet var nearbyStoreView: UIView!
    @IBOutlet var nearbyStoreCollectionView: UICollectionView!
    @IBOutlet var nearbyStoreCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var filterView: UIView!
    @IBOutlet var findNearbyLabel: UILabel!
    @IBOutlet var findNearbyTextfield: UITextField!
    @IBOutlet var findNearbyButton: UIButton!

    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!

    @IBOutlet var hearzapDifferenceTitleView: UIView!
    @IBOutlet var hearzapDifferenceTitleLabel: UILabel!
    @IBOutlet var hearzapDifferenceDescriptionLabel: UILabel!

    @IBOutlet var hearzapDifferenceView: UIView!
    @IBOutlet var hearzapDifferenceCollectionView: UICollectionView!
    @IBOutlet var hearzapDifferenceCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var bannercommitmentView: UIView!
    @IBOutlet var bannercommitmentButton: UIButton!
    @IBOutlet var bannercommitmentImageViewHeight: NSLayoutConstraint!

    @IBOutlet var statsTitleView: UIView!
    @IBOutlet var statsTitleLabel: UILabel!
    @IBOutlet var statsDescriptionLabel: UILabel!

    @IBOutlet var bannerstatsView: UIView!
    @IBOutlet var bannerstatsButton: UIButton!
    @IBOutlet var bannerstatsImageViewHeight: NSLayoutConstraint!

    @IBOutlet var ratingView: UIView!
    @IBOutlet var happyTitleLabel: UILabel!
    @IBOutlet var happyDescriptionLabel: UILabel!
    @IBOutlet var storeRatingCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var ratingViewHeight: NSLayoutConstraint!

    @IBOutlet var FAQTitleView: UIView!
    @IBOutlet var FAQTitleLabel: UILabel!

    @IBOutlet var faqView: UIView!
    @IBOutlet var faqTableView: UITableView!
    @IBOutlet var faqTableViewHeight: NSLayoutConstraint!
    @IBOutlet var viewMoreButton: UIButton!

    // MARK: -  Lets and Var

    let storeViewModel = StoreViewModel()
    var cityNamesArray = [CityNames]()
    var metroStoreArray = [MetroCityModel]()
    var nearbyStoreArray = [NearbyStoreModel]()
    var stateCountArray = [FindNearbyStateModel]()
    var hearzapDifferenceArray = [HearzapDifferenceModel]()
    var faqarray = [FAQModel]()

    let metroStoreCollectionViewMargin = CGFloat(0)
    let metroStoreCollectionViewItemSpacing = CGFloat(18.5)
    var metroStoreCollectionViewItemHeight = CGFloat(255)
    var metroStoreCollectionViewItemWidth = CGFloat(300)
    let metroStoreCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    let nearbyStoreCollectionViewMargin = CGFloat(0)
    let nearbyStoreCollectionViewItemSpacing = CGFloat(18.5)
    var nearbyStoreCollectionViewItemHeight = CGFloat(255)
    var nearbyStoreCollectionViewItemWidth = CGFloat(300)
    let nearbyStoreCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    let hearzapDifferenceCollectionViewMargin = CGFloat(0)
    let hearzapDifferenceCollectionViewItemSpacing = CGFloat(18.5)
    var hearzapDifferenceCollectionViewItemHeight = CGFloat(255)
    var hearzapDifferenceCollectionViewItemWidth = CGFloat(300)
    let hearzapDifferenceCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var reviewRatingArray = [RatingReviewModel]()
    var storeRatingCollectionView_index = 1
    var timer = Timer()

    let storeRatingCollectionViewMargin = CGFloat(0)
    let storeRatingCollectionViewItemSpacing = CGFloat(0)
    var storeRatingCollectionViewItemHeight = CGFloat(129)
    var storeRatingCollectionViewItemWidth = CGFloat(307)
    let storeRatingCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    // MARK: -  App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        UserDefaults.standard.set(AppLocalizationString.tabStores, forKey: UserDefaultsPreferenceKeys.activeTab)
        self.setNavigationBar()
        if self.reviewRatingArray.count > 0 {
            self.timer.invalidate()
            self.startAutoScrollCollectionBanner()
            self.storeRatingCollectionView.reloadData()
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.stateCountArray.count > 0 {
            self.tableViewHeight.constant = self.tableView.contentSize.height + 20
        } else {
            self.tableViewHeight.constant = 0
        }

        if self.faqarray.count > 0 {
            self.faqTableViewHeight.constant = self.faqTableView.contentSize.height + 20
        } else {
            self.faqTableViewHeight.constant = 0
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }
    // MARK: -  Status Bar Color
    func changeStatusBarColor() {
        self.FnGoToChangeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_blue_112F70)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: - Set Initial View
    func setInitialView() {
        if #available(iOS 14.0, *) {
            self.titleLabel.lineBreakStrategy = []
            self.descriptionLabel.lineBreakStrategy = []
            self.cityTitleLabel.lineBreakStrategy = []
            self.nearbyTitleLabel.lineBreakStrategy = []
            self.findNearbyLabel.lineBreakStrategy = []
            self.hearzapDifferenceTitleLabel.lineBreakStrategy = []
            self.hearzapDifferenceDescriptionLabel.lineBreakStrategy = []
            self.statsTitleLabel.lineBreakStrategy = []
            self.statsDescriptionLabel.lineBreakStrategy = []
            self.happyTitleLabel.lineBreakStrategy = []
            self.happyDescriptionLabel.lineBreakStrategy = []
            self.FAQTitleLabel.lineBreakStrategy = []
        }
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        UserDefaults.standard.set(AppLocalizationString.tabStores, forKey: UserDefaultsPreferenceKeys.activeTab)
        self.setNavigationBar()

        self.findNearbyTextfield.setLeftPaddingPoints(10)
        self.findNearbyTextfield.setRightPaddingPoints(10)

        self.cityNamesArray = self.storeViewModel.getCityList()
        self.metroStoreArray = self.storeViewModel.getMetroStoreList()
        self.nearbyStoreArray = self.storeViewModel.getNearbyStoreList()
        self.stateCountArray = self.storeViewModel.getStateCountList()
        self.hearzapDifferenceArray = self.storeViewModel.getHearzapDifferenceList()
        self.reviewRatingArray = self.storeViewModel.getReviewRatingArray()
        self.faqarray = self.storeViewModel.getFAQArray()

        let cityCollectionViewlayout = UICollectionViewFlowLayout()
        cityCollectionViewlayout.scrollDirection = .horizontal
        cityCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        cityCollectionViewlayout.minimumLineSpacing = 8
        cityCollectionViewlayout.minimumInteritemSpacing = 8
        self.cityCollectionView.collectionViewLayout = cityCollectionViewlayout
        self.cityCollectionView.delegate = self
        self.cityCollectionView.dataSource = self
        self.cityCollectionView.reloadData()
        self.cityCollectionView.collectionViewLayout.invalidateLayout()
        self.cityCollectionView!.layoutSubviews()

        self.metroStoreCollectionViewHeight.constant = CGFloat(255)
        self.metroStoreCollectionViewItemHeight = CGFloat(255)
        self.metroStoreCollectionViewItemWidth = CGFloat(300)
        self.metroStoreCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 18.5, bottom: 0, right: 18.5)
        self.metroStoreCollectionViewlayout.itemSize = CGSize(width: self.metroStoreCollectionViewItemWidth, height: self.metroStoreCollectionViewItemHeight)
        self.metroStoreCollectionViewlayout.minimumLineSpacing = self.metroStoreCollectionViewItemSpacing
        self.metroStoreCollectionViewlayout.minimumInteritemSpacing = self.metroStoreCollectionViewItemSpacing
        self.metroStoreCollectionViewlayout.scrollDirection = .horizontal
        self.metroStoreCollectionView!.collectionViewLayout = self.metroStoreCollectionViewlayout
        self.metroStoreCollectionView.dataSource = self
        self.metroStoreCollectionView.delegate = self
        self.metroStoreCollectionView.reloadData()

        self.nearbyStoreCollectionViewHeight.constant = CGFloat(178)
        self.nearbyStoreCollectionViewItemHeight = CGFloat(178)
        self.nearbyStoreCollectionViewItemWidth = CGFloat(300)
        self.nearbyStoreCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 18.5, bottom: 0, right: 18.5)
        self.nearbyStoreCollectionViewlayout.itemSize = CGSize(width: self.nearbyStoreCollectionViewItemWidth, height: self.nearbyStoreCollectionViewItemHeight)
        self.nearbyStoreCollectionViewlayout.minimumLineSpacing = self.nearbyStoreCollectionViewItemSpacing
        self.nearbyStoreCollectionViewlayout.minimumInteritemSpacing = self.nearbyStoreCollectionViewItemSpacing
        self.nearbyStoreCollectionViewlayout.scrollDirection = .horizontal
        self.nearbyStoreCollectionView!.collectionViewLayout = self.nearbyStoreCollectionViewlayout
                self.nearbyStoreCollectionView.dataSource = self
                self.nearbyStoreCollectionView.delegate = self
                self.nearbyStoreCollectionView.reloadData()

        self.tableView.tableFooterView = UIView()
//            self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        if self.stateCountArray.count > 0 {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }

        self.hearzapDifferenceCollectionViewHeight.constant = CGFloat(130)
        self.hearzapDifferenceCollectionViewItemHeight = CGFloat(130)
        self.hearzapDifferenceCollectionViewItemWidth = CGFloat(222)
        self.hearzapDifferenceCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 18.5, bottom: 0, right: 18.5)
        self.hearzapDifferenceCollectionViewlayout.itemSize = CGSize(width: self.hearzapDifferenceCollectionViewItemWidth, height: self.hearzapDifferenceCollectionViewItemHeight)
        self.hearzapDifferenceCollectionViewlayout.minimumLineSpacing = self.hearzapDifferenceCollectionViewItemSpacing
        self.hearzapDifferenceCollectionViewlayout.minimumInteritemSpacing = self.hearzapDifferenceCollectionViewItemSpacing
        self.hearzapDifferenceCollectionViewlayout.scrollDirection = .horizontal
        self.hearzapDifferenceCollectionView!.collectionViewLayout = self.hearzapDifferenceCollectionViewlayout
        self.hearzapDifferenceCollectionView.dataSource = self
        self.hearzapDifferenceCollectionView.delegate = self
        self.hearzapDifferenceCollectionView.reloadData()

        self.bannercommitmentImageViewHeight.constant = CGFloat((self.view.frame.width - 37) * (427/338))
        self.bannerstatsImageViewHeight.constant = CGFloat((self.view.frame.width - 37) * (377/338))

        if self.reviewRatingArray.count > 2 {
            self.pageControl.isHidden = false
            self.pageControl.numberOfPages = self.reviewRatingArray.count
        } else {
            self.pageControl.isHidden = true
        }
        self.storeRatingCollectionViewItemHeight = CGFloat(128)
        self.storeRatingCollectionViewItemWidth = CGFloat(self.view.frame.width - (36 + 32))
        self.storeRatingCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.storeRatingCollectionViewlayout.itemSize = CGSize(width: self.storeRatingCollectionViewItemWidth, height: self.storeRatingCollectionViewItemHeight)
        self.storeRatingCollectionViewlayout.minimumLineSpacing = self.storeRatingCollectionViewItemSpacing
        self.storeRatingCollectionViewlayout.minimumInteritemSpacing = self.storeRatingCollectionViewItemSpacing
        self.storeRatingCollectionViewlayout.scrollDirection = .horizontal
        self.storeRatingCollectionView!.collectionViewLayout = self.storeRatingCollectionViewlayout
        self.storeRatingCollectionView.dataSource = self
        self.storeRatingCollectionView.delegate = self
        self.storeRatingCollectionView.reloadData()

        self.faqTableView.tableFooterView = UIView()
//            self.tableView.separatorColor = UIColor.clear
        self.faqTableView.backgroundColor = UIColor.clear
        self.faqTableView.rowHeight = UITableView.automaticDimension
        self.faqTableView.estimatedRowHeight = UITableView.automaticDimension
        if self.faqarray.count > 0 {
            self.faqTableView.delegate = self
            self.faqTableView.dataSource = self
            self.faqTableView.reloadData()
        }
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isleftViewHidden = true
        self.navigationBar.isRightViewHidden = true
//        self.navigationBar.leftimage = Asset.menuwhite
//        self.navigationBar.rightimage = Asset.telephonewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.tabStores
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.titleLabel.text = AppLocalizationString.thebesthearingexperiencesOnlyonHEARZAPstores
        self.descriptionLabel.text = AppLocalizationString.hearingcarestoresacrossIndia
        self.cityTitleLabel.text = AppLocalizationString.experiencestoresinmetrocities
        self.nearbyTitleLabel.text = AppLocalizationString.nearbyStores
        self.findNearbyLabel.text = AppLocalizationString.findnearbystores
        self.findNearbyTextfield.placeholder = AppLocalizationString.enteryourcityorpincode
        self.hearzapDifferenceTitleLabel.text = AppLocalizationString.theHEARZAPDifference
        self.hearzapDifferenceDescriptionLabel.text = AppLocalizationString.evenmorereasonstovisitourstores
        self.statsTitleLabel.text = AppLocalizationString.hEARZAPVsOtherProviders
        self.statsDescriptionLabel.text = AppLocalizationString.howweexcelfromotherhearingcareproviders
        self.happyTitleLabel.text = AppLocalizationString.happyCustomers
        self.happyDescriptionLabel.text = AppLocalizationString.satisfiedcustomers
        self.FAQTitleLabel.text = AppLocalizationString.frequentlyAskedQuestion
        self.viewMoreButton.setTitle(AppLocalizationString.viewMore.capitalizingFirstLetter(), for: .normal)
    }

    // MARK: - APICALL
    func CommonAPICALL(Retry_APIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }

    // MARK: - IBAction
    @IBAction func videoButtonPressed(_ sender: UIButton) {
    }

    @IBAction func viewMoreButtonPressed(_ sender: UIButton) {
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
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                } else {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(item: 0, section: 0)
                    pageControl.currentPage = 0
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
            }
        }
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
            let p = gestureRecognizer.location(in: self.storeRatingCollectionView)
            let indexPath = self.storeRatingCollectionView.indexPathForItem(at: p)
            if let index = indexPath {
                var cell = self.storeRatingCollectionView.cellForItem(at: index)
                // do stuff with your cell, for example print the indexPath
                print(index.item)
                self.pageControl.currentPage = index.item
            } else {
                print("Could not find index path")
            }
        }
    }
}

// MARK: - Navigation Bar Delegates
extension StoreViewController: ProtocolTitleNavigationBar {
    func leftButtonPressed() {
    }
    func rightButtonPressed() {
    }
}

extension StoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.metroStoreCollectionView {
            return self.metroStoreArray.count
        } else if collectionView == self.nearbyStoreCollectionView {
            return self.nearbyStoreArray.count
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
            cell.viewStoreButton.tag = indexPath.item
            cell.viewStoreButton.setTitle(AppLocalizationString.viewStore.uppercased(), for: .normal)
            cell.configure(metroCityModel: metroStoreArray[indexPath.item])
            return cell
        } else if collectionView == self.nearbyStoreCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.NearbyStoreCollectionViewCell, for: indexPath) as! NearbyStoreCollectionViewCell
            cell.viewStoreButton.tag = indexPath.item
            cell.viewStoreButton.setTitle(AppLocalizationString.viewStore.uppercased(), for: .normal)
            cell.configure(nearbyStoreModel: self.nearbyStoreArray[indexPath.item])
            return cell
        } else if collectionView == self.hearzapDifferenceCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearzapDifferenceCollectionViewCell, for: indexPath) as! HearzapDifferenceCollectionViewCell
//            cell.viewStoreButton.tag = indexPath.item
            cell.configure(hearzapDifferenceModel: self.hearzapDifferenceArray[indexPath.item])
            return cell
        } else if collectionView == self.storeRatingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.StoreReviewRatingCollectionViewCell, for: indexPath) as! StoreReviewRatingCollectionViewCell
//            cell.viewStoreButton.tag = indexPath.item
            cell.configure(RatingReviewModel: reviewRatingArray[indexPath.item])
            return cell

        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.StoreCityListCollectionViewCell, for: indexPath) as! StoreCityListCollectionViewCell
            cell.cityButton.tag = indexPath.item
            cell.configure(CityNames: cityNamesArray[indexPath.item])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth = CGFloat(0)
        var cellHeight = CGFloat(0)

        if collectionView == self.metroStoreCollectionView {
            cellWidth = self.metroStoreCollectionViewItemWidth
            cellHeight = self.metroStoreCollectionViewItemHeight
        } else if collectionView == self.nearbyStoreCollectionView {
            cellWidth = self.nearbyStoreCollectionViewItemWidth
            cellHeight = self.nearbyStoreCollectionViewItemHeight
        } else if collectionView == self.hearzapDifferenceCollectionView {
            cellWidth = self.hearzapDifferenceCollectionViewItemWidth
            cellHeight = self.hearzapDifferenceCollectionViewItemHeight
        } else if collectionView == self.storeRatingCollectionView {
            cellWidth = self.storeRatingCollectionViewItemWidth
            cellHeight = self.storeRatingCollectionViewItemHeight
        } else {
            let tag = self.cityNamesArray[indexPath.item].title
            let font = AppFont.medium.size(13)
            let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
            cellWidth = size.width + 20
            cellHeight = 26
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
extension StoreViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == faqTableView {
            return self.faqarray.count
        } else {
            return self.stateCountArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == faqTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.StoreFAQTableViewCell, for: indexPath) as! StoreFAQTableViewCell
            cell.configure(fAQModel: faqarray[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.FindNearbyTableViewCell, for: indexPath) as! FindNearbyTableViewCell
            cell.viewStoreButton.tag = indexPath.row
            cell.viewStoreButton.setTitle(AppLocalizationString.viewStore.uppercased(), for: .normal)
            cell.configure(findNearbyStateModel: self.stateCountArray[indexPath.row])
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
        if tableView == faqTableView {
            self.faqTableViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        } else {
            self.tableViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == faqTableView {
            faqarray[indexPath.row].expanded = !faqarray[indexPath.row].expanded
            let faqModel: FAQModel = faqarray[indexPath.row]
            tableView.beginUpdates()
            let cell = tableView.cellForRow(at: indexPath) as! StoreFAQTableViewCell
            cell.configure(fAQModel: faqModel)
            tableView.endUpdates()
            self.faqTableViewHeight.constant = tableView.contentSize.height
            self.view.layer.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        }
    }
}
extension StoreViewController: ProtocolStoreCityListCollectionViewCell, ProtocolMetroStoreCollectionViewCell, ProtocolNearbyStoreCollectionViewCell, ProtocolFindNearbyTableViewCell, ProtocolStoreFAQTableViewCell {
    func cityButtonPressed(senderTag: Int) {
    }

    func metroViewStoreButtonPressed(senderTag: Int) {
    }

    func nearbyviewStoreButtonPressed(senderTag: Int) {
    }

    func findNearbyViewStoreButtonPressed() {
    }

    func storeFAQButtonPressed() {
    }
}
