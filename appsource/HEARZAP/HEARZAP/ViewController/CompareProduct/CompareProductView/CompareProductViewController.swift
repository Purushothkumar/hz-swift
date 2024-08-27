//
//  CompareProductViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class CompareProductViewController: UIViewController, BottomPopupDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var scrollSelectionView: UIView!
    @IBOutlet var scrollSelectionStackView: UIStackView!
    @IBOutlet var scrollSelectionViewHeight: NSLayoutConstraint!

    @IBOutlet var scrollOverviewView: UIView!
    @IBOutlet var scrollOverviewLabel: Caption1FontLabel!
    @IBOutlet var scrollOverviewButton: FootnoteOutlineButton!

    @IBOutlet var scrollSpecificationView: UIView!
    @IBOutlet var scrollSpecificationLabel: Caption1FontLabel!
    @IBOutlet var scrollSpecificationButton: FootnoteOutlineButton!

    @IBOutlet var scrollFeatureView: UIView!
    @IBOutlet var scrollFeatureLabel: Caption1FontLabel!
    @IBOutlet var scrollFeatureButton: FootnoteOutlineButton!

    @IBOutlet var scrollLifeStyleView: UIView!
    @IBOutlet var scrollLifeStyleLabel: Caption1FontLabel!
    @IBOutlet var scrollLifeStyleButton: FootnoteOutlineButton!

    @IBOutlet var productView: UIView!
    @IBOutlet var productImageView1: UIImageView!
    @IBOutlet var productImageView2: UIImageView!

    @IBOutlet var editButton1: FootnoteOutlineButton!
    @IBOutlet var editButton2: FootnoteOutlineButton!

    @IBOutlet var productInfoView: UIView!
    @IBOutlet var productInfoStackView1: UIStackView!
    @IBOutlet var productInfoStackView2: UIStackView!
    @IBOutlet var brandNameLabel1: Caption1FontLabel!
    @IBOutlet var brandNameLabel2: Caption1FontLabel!
    @IBOutlet var productName1: FootnoteFontLabel!
    @IBOutlet var productName2: FootnoteFontLabel!
    @IBOutlet var priceLabel1: Caption1FontLabel!
    @IBOutlet var priceLabel2: Caption1FontLabel!

    @IBOutlet var addToBagButton1: OutlineButton!
    @IBOutlet var addToBagButton2: OutlineButton!

    @IBOutlet var addModel1View: UIView!
    @IBOutlet var addModel2View: UIView!

    @IBOutlet var addModel1Label: FootnoteFontLabel!
    @IBOutlet var addModel2Label: FootnoteFontLabel!

    @IBOutlet var addModel1Button: FootnoteOutlineButton!
    @IBOutlet var addModel2Button: FootnoteOutlineButton!

    @IBOutlet var selectionView: UIView!
    @IBOutlet var selectionStackView: UIStackView!
    @IBOutlet var selectionViewHeight: NSLayoutConstraint!

    @IBOutlet var overviewView: UIView!
    @IBOutlet var overviewLabel: Caption1FontLabel!
    @IBOutlet var overviewButton: FootnoteOutlineButton!

    @IBOutlet var specificationView: UIView!
    @IBOutlet var specificationLabel: Caption1FontLabel!
    @IBOutlet var specificationButton: FootnoteOutlineButton!

    @IBOutlet var featuresView: UIView!
    @IBOutlet var featuresLabel: Caption1FontLabel!
    @IBOutlet var featuresButton: FootnoteOutlineButton!

    @IBOutlet var lifestyleView: UIView!
    @IBOutlet var lifestyleLabel: Caption1FontLabel!
    @IBOutlet var lifestyleButton: FootnoteOutlineButton!

    @IBOutlet var overviewTitleView: UIView!
    @IBOutlet var overviewTitleLabel: CalloutFontLabel!
    @IBOutlet var overviewTitleButton: FootnoteOutlineButton!

    @IBOutlet var overviewContentView: UIView!
    @IBOutlet var overviewTableView: UITableView!
    @IBOutlet var overviewTableViewHeight: NSLayoutConstraint!

    @IBOutlet var specificationTitleView: UIView!
    @IBOutlet var specificationTitleLabel: CalloutFontLabel!
    @IBOutlet var specificationTitleButton: FootnoteOutlineButton!

    @IBOutlet var specificationContentView: UIView!
    @IBOutlet var specificationTableView: UITableView!
    @IBOutlet var specificationTableViewHeight: NSLayoutConstraint!

    @IBOutlet var featuresTitleView: UIView!
    @IBOutlet var featuresTitleLabel: CalloutFontLabel!
    @IBOutlet var featuresTitleButton: FootnoteOutlineButton!

    @IBOutlet var featuresContentView: UIView!
    @IBOutlet var featuresTableView: UITableView!
    @IBOutlet var featuresTableViewHeight: NSLayoutConstraint!

    @IBOutlet var lifestyleTitleView: UIView!
    @IBOutlet var lifestyleTitleLabel: CalloutFontLabel!
    @IBOutlet var lifestyleTitleButton: FootnoteOutlineButton!

    @IBOutlet var lifestyleContentView: UIView!
    @IBOutlet var lifestyleTableView: UITableView!
    @IBOutlet var lifestyleTableViewHeight: NSLayoutConstraint!

    @IBOutlet var viewDetailsStackView1: UIStackView!
    @IBOutlet var viewDetailsStackView2: UIStackView!
    @IBOutlet var viewDetailsButton1: FootnoteBackgroundButton!
    @IBOutlet var viewDetailsButton2: FootnoteBackgroundButton!

    // MARK: - Lets and Var
    var compareViewModel = CompareViewModel()
    var overViewListarray = [CompareProductModelProductOverViewElement]()
    var specificationListarray = [CompareProductModelProductSpecificationElement]()
    var featureListarray = [CompareProductModelProductFeatureElement]()
    var lifeStyleListarray = [CompareProductModelProductCompatability]()
    var product1Specification = [ProductSpecification]()
    var product2Specification = [ProductSpecification]()

    var product1 = ""
    var product2 = ""
    var isFrom = ""

    var productID1 = ""
    var productID2 = ""

    var showOverView = true
    var showSpecification = true
    var showFeature = true
    var showLifeStyle = true
    var isProductAvailable1 = false
    var isProductAvailable2 = false

    var quantity = ""
    var product1slug = ""
    var product2slug = ""
    var category1Slug = ""
    var category2Slug = ""

    // MARK: - App Life Cycle
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
        if self.overViewListarray.count > 0 {
            if self.showOverView == true {
                self.overviewTableViewHeight.constant = self.overviewTableView.contentSize.height
            } else {
                self.overviewTableViewHeight.constant = 0
            }
        } else {
            self.overviewTableViewHeight.constant = 0

        }
        if self.specificationListarray.count > 0 {
            if self.showSpecification == true {
                self.specificationTableViewHeight.constant = self.specificationTableView.contentSize.height
            } else {
                self.specificationTableViewHeight.constant = 0
            }
        } else {
            self.specificationTableViewHeight.constant = 0
        }
        if self.featureListarray.count > 0 {
            if self.showFeature == true {
                self.featuresTableViewHeight.constant = self.featuresTableView.contentSize.height
            } else {
                self.featuresTableViewHeight.constant = 0
            }
        } else {
            self.featuresTableViewHeight.constant = 0
        }
        if self.lifeStyleListarray.count > 0 {
            if self.showLifeStyle == true {
                self.lifestyleTableViewHeight.constant = self.lifestyleTableView.contentSize.height
            } else {
                self.lifestyleTableViewHeight.constant = 0
            }
        } else {
            self.lifestyleTableViewHeight.constant = 0

        }
        self.view.layer.layoutIfNeeded()
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
        self.mainScrollView.delegate = self
        self.addToBagButton1.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.addToBagButton1.layer.borderWidth = 1.0
        self.addToBagButton2.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.addToBagButton2.layer.borderWidth = 1.0

        self.productImageView1.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.productImageView1.layer.borderWidth = 1.0
        self.productImageView2.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.productImageView2.layer.borderWidth = 1.0

        self.setDefaultScrollHeight()
        self.setDefaultScrollLabelColor()
        self.initialOverviewListTableView()
        self.initialSpecificationListTableView()
        self.initialFeatureListTableView()
        self.initialLifeStyleListTableView()

        self.viewDetailsButton1.isHidden = true
        self.viewDetailsButton2.isHidden = true

        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = false
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = self.quantity == "" ? Asset.bagblue : Asset.bagnotificationblue
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.shop
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.addModel1Label.text = AppLocalizationString.addModel
        self.addModel2Label.text = AppLocalizationString.addModel

        self.viewDetailsButton1.setTitle(AppLocalizationString.viewDetails.uppercased(), for: .normal)
        self.viewDetailsButton2.setTitle(AppLocalizationString.viewDetails.uppercased(), for: .normal)

        self.scrollOverviewLabel.text = AppLocalizationString.overview
        self.overviewLabel.text = AppLocalizationString.overview
        self.overviewTitleLabel.text = AppLocalizationString.overview

        self.scrollSpecificationLabel.text = AppLocalizationString.specification
        self.specificationLabel.text = AppLocalizationString.specification
        self.specificationTitleLabel.text = AppLocalizationString.specification

        self.scrollFeatureLabel.text = AppLocalizationString.features
        self.featuresLabel.text = AppLocalizationString.features
        self.featuresTitleLabel.text = AppLocalizationString.features

        self.scrollLifeStyleLabel.text = AppLocalizationString.lifestyle
        self.lifestyleLabel.text = AppLocalizationString.lifestyle
        self.lifestyleTitleLabel.text = AppLocalizationString.lifestyle

        if self.isProductAvailable1 == false {
            self.addToBagButton1.setTitle(AppLocalizationString.outOfStock.uppercased(), for: .normal)
        } else {
            self.addToBagButton1.setTitle(AppLocalizationString.addtobag.uppercased(), for: .normal)
        }

        if self.isProductAvailable2 == false {
            self.addToBagButton2.setTitle(AppLocalizationString.outOfStock.uppercased(), for: .normal)
        } else {
            self.addToBagButton2.setTitle(AppLocalizationString.addtobag.uppercased(), for: .normal)
        }
    }
    // MARK: - Reload
    func reloadOverviewListTableView() {
        self.overviewTableView.delegate = self
        self.overviewTableView.dataSource = self
        self.overviewTableView.reloadData()
        self.viewWillLayoutSubviews()
    }
    func reloadSpecificationListTableView() {
        self.specificationTableView.delegate = self
        self.specificationTableView.dataSource = self
        self.specificationTableView.reloadData()
        self.viewWillLayoutSubviews()
    }
    func reloadFeatureListTableView() {
        self.featuresTableView.delegate = self
        self.featuresTableView.dataSource = self
        self.featuresTableView.reloadData()
        self.viewWillLayoutSubviews()
    }
    func reloadLifeStyleListTableView() {
        self.lifestyleTableView.delegate = self
        self.lifestyleTableView.dataSource = self
        self.lifestyleTableView.reloadData()
        self.viewWillLayoutSubviews()
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getCompareList(retryAPIID: retryAPIID, canShowLoader: true)
                }
                if retryAPIID == 2000 {
                    self.getCartList(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCompareList(retryAPIID: Int, canShowLoader: Bool) {
        var url = SubAPIUrl.getCompareList
        if !(product1.isEmpty) && !(product2.isEmpty) {
            url = "\(SubAPIUrl.getCompareList)\(product1)/\(product2)/"
        } else if !(product1.isEmpty) || !(product2.isEmpty) {
            if !(product1.isEmpty) {
                url = "\(SubAPIUrl.getCompareList)\(product1)/"
            } else if !(product2.isEmpty) {
                url = "\(SubAPIUrl.getCompareList)\(product2)/"
            }
        }
        self.compareViewModel.getCompareList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func getCartList(retryAPIID: Int, canShowLoader: Bool) {
        self.compareViewModel.getCartList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCartList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func scrollOverviewButtonPressed(_ sender: UIButton) {
        self.tabOverview()
    }
    @IBAction func scrollSpecificationButtonPressed(_ sender: UIButton) {
        self.tapSpecification()
    }
    @IBAction func scrollFeatureButtonPressed(_ sender: UIButton) {
        self.tapFeature()
    }
    @IBAction func scrollLifeStyleButtonPressed(_ sender: UIButton) {
        self.tapLifeStyle()
    }
    @IBAction func editButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            self.navigateToCompareProductBrandViewController(isFrom: self.isFrom, product1: "", product2: product2, isEdit: true)
        } else {
            self.navigateToCompareProductBrandViewController(isFrom: self.isFrom, product1: product1, product2: "", isEdit: true)
        }
    }
    @IBAction func addToBagButtonPressed(_ sender: UIButton) {
        self.checkCartVerifiedUser(senderTag: sender.tag)
    }

    @IBAction func overviewButtonPressed(_ sender: UIButton) {
        self.tabOverview()
    }
    @IBAction func specificationButtonPressed(_ sender: UIButton) {
        self.tapSpecification()
    }
    @IBAction func featuresButtonPressed(_ sender: UIButton) {
        self.tapFeature()    }
    @IBAction func lifestyleButtonPressed(_ sender: UIButton) {
        self.tapLifeStyle()
    }
    @IBAction func overviewTitleButtonPressed(_ sender: UIButton) {
        //        self.showOverView == true ? (self.showOverView = false) : (self.showOverView = true)
        self.showOverView = true
        self.reloadOverviewListTableView()
    }
    @IBAction func specificationTitleButtonPressed(_ sender: UIButton) {
        //        self.showSpecification == true ? (self.showSpecification = false) : (self.showSpecification = true)
        self.showSpecification = true
        self.reloadSpecificationListTableView()
    }
    @IBAction func featuresTitleButtonPressed(_ sender: UIButton) {
        //        self.showFeature == true ? (self.showFeature = false) : (self.showFeature = true)
        self.showFeature = true
        self.reloadFeatureListTableView()
    }
    @IBAction func lifestyleTitleButtonPressed(_ sender: UIButton) {
        //        self.showLifeStyle == true ? (self.showLifeStyle = false) : (self.showLifeStyle = true)
        self.showLifeStyle = true
        self.reloadLifeStyleListTableView()
    }
    @IBAction func addModelButtonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            self.navigateToCompareProductBrandViewController(isFrom: IsNavigateFrom.compareView.rawValue, product1: "", product2: product2, isEdit: true)
        } else {
            self.navigateToCompareProductBrandViewController(isFrom: IsNavigateFrom.compareView.rawValue, product1: product1, product2: "", isEdit: true)
        }
    }
    @IBAction func viewProductDetailButtonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            if !(product2slug.isEmpty) {
                self.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productCompareDetail.rawValue, productslug: product2slug)
            }
        } else {
            if !(product1slug.isEmpty) {
                self.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productCompareDetail.rawValue, productslug: product1slug)
            }
        }
    }

    // MARK: - Custom Methods
    func setAddtoCartButton1Color() {
        if self.isProductAvailable1 == false {
            self.addToBagButton1.titleLabel?.textColor = UIColor.colorLiteral.theme_red_FF6961
            self.addToBagButton1.layer.borderColor = UIColor.colorLiteral.theme_red_FF6961.cgColor
            self.addToBagButton1.setTitle(AppLocalizationString.outOfStock.uppercased(), for: .normal)
            self.addToBagButton1.isUserInteractionEnabled = false
        } else {
            self.addToBagButton1.titleLabel?.textColor = UIColor.colorLiteral.theme_blue_2AACEF
            self.addToBagButton1.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            self.addToBagButton1.setTitle(AppLocalizationString.addtobag.uppercased(), for: .normal)
            self.addToBagButton1.isUserInteractionEnabled = true
        }
    }
    func setAddtoCartButton2Color() {
        if self.isProductAvailable2 == false {
            self.addToBagButton2.titleLabel?.textColor = UIColor.colorLiteral.theme_red_FF6961
            self.addToBagButton2.layer.borderColor = UIColor.colorLiteral.theme_red_FF6961.cgColor
            self.addToBagButton2.setTitle(AppLocalizationString.outOfStock.uppercased(), for: .normal)
            self.addToBagButton2.isUserInteractionEnabled = false
        } else {
            self.addToBagButton2.titleLabel?.textColor = UIColor.colorLiteral.theme_blue_2AACEF
            self.addToBagButton2.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            self.addToBagButton2.setTitle(AppLocalizationString.addtobag.uppercased(), for: .normal)
            self.addToBagButton2.isUserInteractionEnabled = true
        }
    }
    func checkCartVerifiedUser(senderTag: Int) {
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            if senderTag == 0 {
                self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginCartCompare2.rawValue, isWishlist: false, productUID: "")
            } else {
                self.navigateToLoginViewController(isFrom: IsNavigateFrom.loginCartCompare1.rawValue, isWishlist: false, productUID: "")
            }
        } else {
            self.showPopupScreen(senderTag: senderTag)
        }
    }
    func showBottomSheetLifeStyle(senderTag: Int) {
        var imageViewName = ""
        var titlemessage = ""
        var descriptionmessage = ""
        var arrlist = [String]()
        if self.lifeStyleListarray[senderTag].key != nil {
            if !(self.lifeStyleListarray[senderTag].key!.description.isNilOrEmpty) {
                descriptionmessage = "\(String(describing: self.lifeStyleListarray[senderTag].key!.description!))"
            }
            if !(self.lifeStyleListarray[senderTag].key!.name.isNilOrEmpty) {
                titlemessage = "\(String(describing: self.lifeStyleListarray[senderTag].key!.name!))"
            }
            if self.lifeStyleListarray[senderTag].key!.situation != nil {
                if self.lifeStyleListarray[senderTag].key!.situation!.count > 0 {
                    for item in self.lifeStyleListarray[senderTag].key!.situation! {
                        if !(item.isEmpty) {
                            arrlist.append(item)
                        }
                    }
                }
            }
            if !(self.lifeStyleListarray[senderTag].key!.image.isNilOrEmpty) {
                imageViewName = "\(String(describing: self.lifeStyleListarray[senderTag].key!.image!))"
            }

            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BottomSheet, bundle: nil)
            guard let popupVC = storyBoard.instantiateViewController(withIdentifier: ViewController.BottomSheetLifeStyleViewController) as? BottomSheetLifeStyleViewController else { return }
            popupVC.topCornerRadius = 0
            popupVC.presentDuration = 1
            popupVC.dismissDuration = 1
            popupVC.shouldDismissInteractivelty = true

            var bottomPadding: CGFloat = 0
            var topPadding: CGFloat = 0

            let textHeight: CGFloat = 22 + self.heightForText(text: titlemessage, Font: AppFont.semibold.size(16), Width: AppConstantValue.screenWidthminus32) + 6 + self.heightForText(text: descriptionmessage, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32) + 16

            let imageheight: CGFloat = 278 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
            var tableviewheight: CGFloat = 0
            var tagHeight: CGFloat = 0

            if arrlist.count > 0 {
                for item in arrlist {
                    tagHeight = tagHeight + 10 + self.heightForText(text: item.description, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - (18 + 10)) + 10
                }
            } else {
                tagHeight = 0
            }

            // calculate tableview Height
            tableviewheight = tagHeight

            // Calculate View Height
            let defaultheight: CGFloat = screenFrameHeight * (4 / 5)
            let popvcheight = defaultheight
            if #available(iOS 11.0, *) {
                bottomPadding = self.view.safeAreaInsets.bottom
                topPadding = self.view.safeAreaInsets.top
            }
            popupVC.height = popvcheight  + bottomPadding + topPadding
            popupVC.popupDelegate = self as BottomPopupDelegate
            //            popupVC.boardingPopupListViewControllerDelegate = self
            popupVC.titlemessage = titlemessage
            popupVC.descriptionmessage = descriptionmessage
            popupVC.imageViewName = imageViewName
            popupVC.tableviewheightConstant = tableviewheight
            popupVC.arrlist = arrlist
            present(popupVC, animated: true, completion: nil)

        }
    }
    func tabOverview() {
        DispatchQueue.main.async {
            let view0 = self.mainStackView.arrangedSubviews[0]// Product View
            let view1 = self.mainStackView.arrangedSubviews[1]// Product Info view
            let view2 = self.mainStackView.arrangedSubviews[2]// Empty view

            let overviewViewY = view0.frame.height + view1.frame.height + view2.frame.height
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: overviewViewY), animated: false)
            self.setScrollHeight()
            self.setscrollOverviewLabelColor()
        }
    }
    func tapSpecification() {
        DispatchQueue.main.async {
            let view0 = self.mainStackView.arrangedSubviews[0]// Product View
            let view1 = self.mainStackView.arrangedSubviews[1]// Product Info view
            let view2 = self.mainStackView.arrangedSubviews[2]// Empty view
            let view3 = self.mainStackView.arrangedSubviews[3]// Selection View
            let view4 = self.mainStackView.arrangedSubviews[4]// Empty view
            let view5 = self.mainStackView.arrangedSubviews[5]// Overview Title View
            let view6 = self.mainStackView.arrangedSubviews[6]// Overview Content View
            let view7 = self.mainStackView.arrangedSubviews[7]// Empty view
            let view8 = self.mainStackView.arrangedSubviews[8]// Spectication Title View
            let specificationViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height

            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: specificationViewY - (view7.frame.height + view8.frame.height)), animated: false)
            self.setScrollHeight()
            self.setscrollSpecificationLabelColor()
        }
    }
    func tapFeature() {
        DispatchQueue.main.async {
            let view0 = self.mainStackView.arrangedSubviews[0]// Product View
            let view1 = self.mainStackView.arrangedSubviews[1]// Product Info view
            let view2 = self.mainStackView.arrangedSubviews[2]// Empty view
            let view3 = self.mainStackView.arrangedSubviews[3]// Selection View
            let view4 = self.mainStackView.arrangedSubviews[4]// Empty view
            let view5 = self.mainStackView.arrangedSubviews[5]// Overview Title View
            let view6 = self.mainStackView.arrangedSubviews[6]// Overview Content View
            let view7 = self.mainStackView.arrangedSubviews[7]// Empty view
            let view8 = self.mainStackView.arrangedSubviews[8]// Spectication Title View
            let view9 = self.mainStackView.arrangedSubviews[9]// Spectication Content View
            let view10 = self.mainStackView.arrangedSubviews[10]// Empty view
            let view11 = self.mainStackView.arrangedSubviews[11]// Features Title View

            let featureViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height + view7.frame.height + view8.frame.height + view9.frame.height
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: featureViewY - (view10.frame.height + view11.frame.height)), animated: false)

            self.setScrollHeight()
            self.setscrollFeatureLabelColor()
        }
    }
    func tapLifeStyle() {
        DispatchQueue.main.async {
            let view0 = self.mainStackView.arrangedSubviews[0]// Product View
            let view1 = self.mainStackView.arrangedSubviews[1]// Product Info view
            let view2 = self.mainStackView.arrangedSubviews[2]// Empty view
            let view3 = self.mainStackView.arrangedSubviews[3]// Selection View
            let view4 = self.mainStackView.arrangedSubviews[4]// Empty view
            let view5 = self.mainStackView.arrangedSubviews[5]// Overview Title View
            let view6 = self.mainStackView.arrangedSubviews[6]// Overview Content View
            let view7 = self.mainStackView.arrangedSubviews[7]// Empty view
            let view8 = self.mainStackView.arrangedSubviews[8]// Spectication Title View
            let view9 = self.mainStackView.arrangedSubviews[9]// Spectication Content View
            let view10 = self.mainStackView.arrangedSubviews[10]// Empty view
            let view11 = self.mainStackView.arrangedSubviews[11]// Features Title View
            let view12 = self.mainStackView.arrangedSubviews[12]// Features Content View
            let view13 = self.mainStackView.arrangedSubviews[13]// Empty view
            let view14 = self.mainStackView.arrangedSubviews[14]// Style Title View

            let styleViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height + view7.frame.height + view8.frame.height + view9.frame.height + view10.frame.height + view11.frame.height + view12.frame.height

            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: styleViewY - (view13.frame.height + view14.frame.height)), animated: false)
            self.setScrollHeight()
            self.setscrollLifeStyleLabelColor()
        }
    }

    func initialOverviewListTableView() {
        self.overviewTableView.tableFooterView = UIView()
        self.overviewTableView.separatorColor = UIColor.clear
        self.overviewTableView.backgroundColor = UIColor.clear
        self.overviewTableView.rowHeight = UITableView.automaticDimension
        self.overviewTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadOverviewListTableView()
    }
    func initialSpecificationListTableView() {
        self.specificationTableView.tableFooterView = UIView()
        self.specificationTableView.separatorColor = UIColor.clear
        self.specificationTableView.backgroundColor = UIColor.clear
        self.specificationTableView.rowHeight = UITableView.automaticDimension
        self.specificationTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadSpecificationListTableView()
    }
    func initialFeatureListTableView() {
        self.featuresTableView.tableFooterView = UIView()
        self.featuresTableView.separatorColor = UIColor.clear
        self.featuresTableView.backgroundColor = UIColor.clear
        self.featuresTableView.rowHeight = UITableView.automaticDimension
        self.featuresTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadFeatureListTableView()
    }
    func initialLifeStyleListTableView() {
        self.lifestyleTableView.tableFooterView = UIView()
        self.lifestyleTableView.separatorColor = UIColor.clear
        self.lifestyleTableView.backgroundColor = UIColor.clear
        self.lifestyleTableView.rowHeight = UITableView.automaticDimension
        self.lifestyleTableView.estimatedRowHeight = UITableView.automaticDimension
        self.reloadLifeStyleListTableView()
    }

    func setDefaultScrollHeight() {
        self.scrollSelectionViewHeight.constant = 0
        self.scrollSelectionView.isHidden = true
    }
    func setScrollHeight() {
        self.scrollSelectionViewHeight.constant = 48
        self.scrollSelectionView.isHidden = false
    }
    func setDefaultScrollLabelColor() {
        self.scrollOverviewLabel.font = AppFont.regular.size(13)
        self.scrollOverviewLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.scrollSpecificationLabel.font = AppFont.regular.size(13)
        self.scrollSpecificationLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.scrollFeatureLabel.font = AppFont.regular.size(13)
        self.scrollFeatureLabel.textColor = UIColor.colorLiteral.theme_grey_777777
        self.scrollLifeStyleLabel.font = AppFont.regular.size(13)
        self.scrollLifeStyleLabel.textColor = UIColor.colorLiteral.theme_grey_777777
    }
    func setscrollOverviewLabelColor() {
        self.setDefaultScrollLabelColor()
        self.scrollOverviewLabel.font = AppFont.medium.size(13)
        self.scrollOverviewLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
    }
    func setscrollSpecificationLabelColor() {
        self.setDefaultScrollLabelColor()
        self.scrollSpecificationLabel.font = AppFont.medium.size(13)
        self.scrollSpecificationLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
    }
    func setscrollFeatureLabelColor() {
        self.setDefaultScrollLabelColor()
        self.scrollFeatureLabel.font = AppFont.medium.size(13)
        self.scrollFeatureLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
    }
    func setscrollLifeStyleLabelColor() {
        self.setDefaultScrollLabelColor()
        self.scrollLifeStyleLabel.font = AppFont.medium.size(13)
        self.scrollLifeStyleLabel.textColor = UIColor.colorLiteral.theme_blue_112F70
    }
}

extension CompareProductViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if self.isFrom == IsNavigateFrom.compareShop.rawValue {
            self.navigateBackToShopCategoryViewController()
        } else if self.isFrom == IsNavigateFrom.compareView.rawValue {
            self.navigateBackToShopCategoryViewController()
        } else if self.isFrom == IsNavigateFrom.compareFHA.rawValue {
            self.navigateBackToFindRightDeviceRecommendViewController()
        } else if self.isFrom == IsNavigateFrom.compareProductDetail.rawValue {
            self.navigateBackToHAProductDetailViewController()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {
    }
}
extension CompareProductViewController: ProtocolNetworkRechabilityDelegate {
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
extension CompareProductViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.overviewTableView {
            return self.overViewListarray.count
        } else if tableView == self.specificationTableView {
            return self.specificationListarray.count
        } else if tableView == self.featuresTableView {
            return self.featureListarray.count
        } else {
            return self.lifeStyleListarray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.overviewTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CompareProductOverviewTableViewCell, for: indexPath) as! CompareProductOverviewTableViewCell
            cell.configure(compareOverviewModel: self.overViewListarray[indexPath.row], indexpath: indexPath.row, product1: self.product1, product2: self.product2)
            return cell
        } else if tableView == self.specificationTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CompareProductSpecificationTableViewCell, for: indexPath) as! CompareProductSpecificationTableViewCell
            cell.configure(compareSpecificationModel: self.specificationListarray[indexPath.row], indexpath: indexPath.row, product1: self.product1, product2: self.product2)
            return cell
        } else if tableView == self.featuresTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CompareProductFeatureTableViewCell, for: indexPath) as! CompareProductFeatureTableViewCell
            cell.configure(compareFeaturesModel: self.featureListarray[indexPath.row], indexpath: indexPath.row, product1: self.product1, product2: self.product2)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CompareProductLifestyleTableViewCell, for: indexPath) as! CompareProductLifestyleTableViewCell
            cell.configure(compareLifeStyleModel: self.lifeStyleListarray[indexPath.row], indexpath: indexPath.row, product1: self.product1, product2: self.product2)
            cell.delegate = self
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
        if tableView == self.overviewTableView {
            if self.showOverView == true {
                self.overviewTableViewHeight.constant = tableView.contentSize.height
                self.view.layer.layoutIfNeeded()
                self.viewWillLayoutSubviews()
            } else {
                self.overviewTableViewHeight.constant = 0
                self.view.layer.layoutIfNeeded()
                self.viewWillLayoutSubviews()
            }
        } else if tableView == self.specificationTableView {
            if self.showSpecification == true {
                self.specificationTableViewHeight.constant = tableView.contentSize.height
                self.view.layer.layoutIfNeeded()
                self.viewWillLayoutSubviews()
            } else {
                self.specificationTableViewHeight.constant = 0
                self.view.layer.layoutIfNeeded()
                self.viewWillLayoutSubviews()
            }
        } else if tableView == self.featuresTableView {
            if self.showFeature == true {
                self.featuresTableViewHeight.constant = tableView.contentSize.height
                self.view.layer.layoutIfNeeded()
                self.viewWillLayoutSubviews()
            } else {
                self.featuresTableViewHeight.constant = 0
                self.view.layer.layoutIfNeeded()
                self.viewWillLayoutSubviews()
            }
        } else {
            if self.showLifeStyle == true {
                self.lifestyleTableViewHeight.constant = tableView.contentSize.height
                self.view.layer.layoutIfNeeded()
                self.viewWillLayoutSubviews()
            } else {
                self.lifestyleTableViewHeight.constant = 0
                self.view.layer.layoutIfNeeded()
                self.viewWillLayoutSubviews()
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.mainScrollView {
            let view0 = self.mainStackView.arrangedSubviews[0]// Product View
            let view1 = self.mainStackView.arrangedSubviews[1]// Product Info view
            let view2 = self.mainStackView.arrangedSubviews[2]// Empty view
            let view3 = self.mainStackView.arrangedSubviews[3]// Selection View
            let view4 = self.mainStackView.arrangedSubviews[4]// Empty view
            let view5 = self.mainStackView.arrangedSubviews[5]// Overview Title View
            let view6 = self.mainStackView.arrangedSubviews[6]// Overview Content View
            let view7 = self.mainStackView.arrangedSubviews[7]// Empty view
            let view8 = self.mainStackView.arrangedSubviews[8]// Spectication Title View
            let view9 = self.mainStackView.arrangedSubviews[9]// Spectication Content View
            let view10 = self.mainStackView.arrangedSubviews[10]// Empty view
            let view11 = self.mainStackView.arrangedSubviews[11]// Features Title View
            let view12 = self.mainStackView.arrangedSubviews[12]// Features Content View
            let view13 = self.mainStackView.arrangedSubviews[13]// Empty view
            let view14 = self.mainStackView.arrangedSubviews[14]// Style Title View
            let view15 = self.mainStackView.arrangedSubviews[15]// Style Content View

            let overviewViewY = view0.frame.height + view1.frame.height + view2.frame.height
            let specificationViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height
            let featureViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height + view7.frame.height + view8.frame.height + view9.frame.height
            let styleViewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height + view7.frame.height + view8.frame.height + view9.frame.height + view10.frame.height  +  view11.frame.height + view12.frame.height
            let stackviewY = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height + view7.frame.height + view8.frame.height + view9.frame.height + view10.frame.height  +  view11.frame.height + view12.frame.height + view13.frame.height + view14.frame.height + view15.frame.height
            self.setDefaultScrollLabelColor()
            if scrollView.contentOffset.y < overviewViewY {
                self.setDefaultScrollHeight()
                self.setDefaultScrollLabelColor()
            } else if scrollView.contentOffset.y > styleViewY - (view13.frame.height + view14.frame.height) {
                self.setScrollHeight()
                self.setscrollLifeStyleLabelColor()
            } else if scrollView.contentOffset.y > featureViewY - (view10.frame.height + view11.frame.height) {
                self.setScrollHeight()
                self.setscrollFeatureLabelColor()
            } else if scrollView.contentOffset.y > specificationViewY - (view7.frame.height + view8.frame.height) {
                self.setScrollHeight()
                self.setscrollSpecificationLabelColor()
            } else if scrollView.contentOffset.y > overviewViewY {
                self.setScrollHeight()
                self.setscrollOverviewLabelColor()
            }
        }
    }
}
extension CompareProductViewController: ProtocolCompareProductLifestyleTableViewCell {
    func infoButtonCompareProductLifestyleTableViewCell(senderTag: Int) {
        self.showBottomSheetLifeStyle(senderTag: senderTag)
    }
}
extension CompareProductViewController: ProtocolBottomSheetCartViewControllerDelegate {
    // MARK: - BottomSheetCart
    func showPopupScreen(senderTag: Int) {
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
        popupVC.productSpecficationArray = senderTag == 1 ? self.product2Specification : self.product1Specification
        popupVC.productID = senderTag == 1 ? self.productID2 : self.productID1
        popupVC.categorySlug = senderTag == 1 ? self.category2Slug : self.category1Slug

        self.present(popupVC, animated: true, completion: nil)
    }

    // MARK: - ProtocolBottomSheetCommonDeleteViewControllerDelegate
    func updateBottomSheetCartViewController() {
        self.showToastAlert(AppLocalizationString.addtocartmessage, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: self)
        self.commonAPICALL(retryAPIID: 2000)
    }
}
