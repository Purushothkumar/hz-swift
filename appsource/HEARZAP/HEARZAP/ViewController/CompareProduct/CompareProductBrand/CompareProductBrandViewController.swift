//
//  CompareProductBrandViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CompareProductBrandViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var compareProductHeaderView: CompareProductHeaderView!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var brandTitleView: UIView!
    @IBOutlet var brandTitleLabel: Caption2FontLabel!

    @IBOutlet var brandView: UIView!
    @IBOutlet var brandCollectionView: UICollectionView!
    @IBOutlet var brandCollectionViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    var compareProductViewModel = CompareProductViewModel()

    let brandCollectionViewMargin = 0
    let brandCollectionViewItemSpacing = CGFloat(6)
    var brandCollectionViewItemHeight = CGFloat(178)
    var brandCollectionViewItemWidth = CGFloat(139)
    let brandCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var priceRangeListArray = [HearingAidPriceRangeList]()
    var brandListArray = [HearingAidBrandList]()
    var modelListArray = [ShopModelList]()
    var tagArray = [CompareTagModel]()

    var isFrom = ""
    var product1 = ""
    var product2 = ""

    var isEdit = false

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.compareProductHeaderView.setupView(currentPage: CompareProductHeader.brand.rawValue)
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
        self.compareProductHeaderView.setupView(currentPage: CompareProductHeader.brand.rawValue)
        self.commonAPICALL(retryAPIID: 1000)
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = true
        self.navigationBar.isRightViewHidden = false
        //        self.navigationBar.leftImage = Asset.menuwhite
        self.navigationBar.rightImage = Asset.xlargewhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.addmodeltocompare
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.brandTitleLabel.text = AppLocalizationString.selectyourBrand
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getCompareList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCompareList(retryAPIID: Int, canShowLoader: Bool) {
        self.compareProductViewModel.getCompareList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCompareList, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - Custom Methods
    func reloadBrandCollectionview() {
        if self.brandListArray.count > 0 {
            self.brandCollectionViewItemHeight = CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(67.0/375.0)
            self.brandCollectionViewItemWidth = (CGFloat(screenFrameWidth) - (CGFloat(32) + 12)) / 3
            self.brandCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.brandCollectionViewlayout.itemSize = CGSize(width: self.brandCollectionViewItemWidth, height: self.brandCollectionViewItemHeight)
            self.brandCollectionViewlayout.minimumLineSpacing = self.brandCollectionViewItemSpacing
            self.brandCollectionViewlayout.minimumInteritemSpacing = self.brandCollectionViewItemSpacing
            self.brandCollectionViewlayout.scrollDirection = .vertical
            self.brandCollectionView!.collectionViewLayout = self.brandCollectionViewlayout
            self.brandCollectionView.dataSource = self
            self.brandCollectionView.delegate = self
            self.brandCollectionView.reloadData()

            if self.brandListArray.count % 3 == 0 {
                self.brandCollectionViewHeight.constant = CGFloat(self.brandListArray.count / 3) * brandCollectionViewItemHeight + CGFloat(10)
            } else {
                self.brandCollectionViewHeight.constant = (CGFloat(self.brandListArray.count / 3) * brandCollectionViewItemHeight) + brandCollectionViewItemHeight + CGFloat(10)
            }
        } else {
            self.brandCollectionViewHeight.constant = 0
        }
    }
}
extension CompareProductBrandViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
    }
    func rightButtonPressed() {
        if self.isEdit == true {
            self.navigateBackToCompareProductViewController()
        } else if self.isFrom == IsNavigateFrom.compareShop.rawValue {
            self.navigateBackToShopCategoryViewController()
        } else if self.isFrom == IsNavigateFrom.compareView.rawValue {
            self.navigateBackToCompareProductViewController()
        } else if self.isFrom == IsNavigateFrom.compareProductDetail.rawValue {
            self.navigateBackToHAProductDetailViewController()
        } else if self.isFrom == IsNavigateFrom.compareFHA.rawValue {
            self.navigateBackToFindRightDeviceRecommendViewController()
        } else {
            self.navigateBackToViewController()
        }
    }
}
extension CompareProductBrandViewController: ProtocolNetworkRechabilityDelegate {
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
extension CompareProductBrandViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.brandListArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.CompareProductBrandCollectionViewCell, for: indexPath) as! CompareProductBrandCollectionViewCell
        cell.configure(productBrand: self.brandListArray[indexPath.item], indexpath: indexPath.item)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.brandCollectionView {
            if self.brandListArray.count > 0 {
                cellWidth = self.brandCollectionViewItemWidth
                cellHeight = self.brandCollectionViewItemHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension CompareProductBrandViewController: ProtocolCompareProductBrandCollectionViewCell {
    func tapButtonPressedCompareProductBrandCollectionViewCell(senderTag: Int) {
        var name = ""
        var slug = ""
        let type = CompareProductHeader.brand.rawValue
        if !(brandListArray[senderTag].name.isNilOrEmpty) {
            name = brandListArray[senderTag].name!
        }
        if brandListArray[senderTag].id != nil {
            slug = "\(brandListArray[senderTag].id!)"
        }
        self.tagArray.removeAll()
        self.tagArray.append(CompareTagModel(name: name, slug: slug, type: type))
        self.navigateToCompareProductPriceViewController(isFrom: self.isFrom, product1: self.product1, product2: self.product2, brandListArray: self.brandListArray, priceRangeListArray: self.priceRangeListArray, modelListArray: self.modelListArray, tagArray: self.tagArray, isEdit: self.isEdit)
    }
}
