//
//  CompareProductPriceViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CompareProductPriceViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var compareProductHeaderView: CompareProductHeaderView!

    @IBOutlet var tagView: UIView!
    @IBOutlet var tagCollectionView: UICollectionView!
    @IBOutlet var tagCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var priceTitleView: UIView!
    @IBOutlet var priceTitleLabel: Caption2FontLabel!

    @IBOutlet var priceView: UIView!
    @IBOutlet var priceCollectionView: UICollectionView!
    @IBOutlet var priceCollectionViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    let priceCollectionViewMargin = 0
    let priceCollectionViewItemSpacing = CGFloat(12)
    var priceCollectionViewItemHeight = CGFloat(178)
    var priceCollectionViewItemWidth = CGFloat(139)
    let priceCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

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
        self.compareProductHeaderView.setupView(currentPage: CompareProductHeader.price.rawValue)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.priceRangeListArray.count > 0 {
            if self.priceRangeListArray.count % 2 == 0 {
                if self.priceRangeListArray.count > 4 {
                    self.priceCollectionViewHeight.constant = (CGFloat(self.priceRangeListArray.count / 2) * priceCollectionViewItemHeight) + (CGFloat((self.priceRangeListArray.count / 2) - 1) * 12) + CGFloat(20)
                } else {
                    self.priceCollectionViewHeight.constant = (CGFloat(self.priceRangeListArray.count / 2) * priceCollectionViewItemHeight) + 12 + CGFloat(20)
                }
            } else {
                if self.priceRangeListArray.count > 4 {
                    self.priceCollectionViewHeight.constant = (CGFloat(self.priceRangeListArray.count / 2) * priceCollectionViewItemHeight) + (CGFloat((self.priceRangeListArray.count / 2) - 1) * 12) + priceCollectionViewItemHeight + 12 + CGFloat(20)
                } else {
                    self.priceCollectionViewHeight.constant = (CGFloat(self.priceRangeListArray.count / 2) * priceCollectionViewItemHeight) + priceCollectionViewItemHeight + 12 + CGFloat(20)
                }
            }
        } else {
            self.priceCollectionViewHeight.constant = 0
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
        self.compareProductHeaderView.setupView(currentPage: CompareProductHeader.price.rawValue)
        if self.tagArray.count > 0 {
            self.reloadTagCollectionView()
        }
        self.reloadPriceCollectionview()
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
        self.priceTitleLabel.text = AppLocalizationString.selectpricerange
    }
    // MARK: - Custom Methods
    func reloadTagCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .horizontal
        self.tagCollectionView.delegate = self
        self.tagCollectionView.dataSource = self
        self.tagCollectionView.collectionViewLayout = layout
        self.tagCollectionView.reloadData()
        self.tagCollectionView.collectionViewLayout.invalidateLayout()
        self.tagCollectionView!.layoutSubviews()
        self.tagCollectionViewHeight.constant = tagHeight
    }
    func reloadPriceCollectionview() {
        if self.priceRangeListArray.count > 0 {
            self.priceCollectionViewItemHeight = 90
            self.priceCollectionViewItemWidth = (CGFloat(screenFrameWidth) - (CGFloat(32) + 12)) / 2
            self.priceCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.priceCollectionViewlayout.itemSize = CGSize(width: self.priceCollectionViewItemWidth, height: self.priceCollectionViewItemHeight)
            self.priceCollectionViewlayout.minimumLineSpacing = self.priceCollectionViewItemSpacing
            self.priceCollectionViewlayout.minimumInteritemSpacing = self.priceCollectionViewItemSpacing
            self.priceCollectionViewlayout.scrollDirection = .vertical
            self.priceCollectionView!.collectionViewLayout = self.priceCollectionViewlayout
            self.priceCollectionView.dataSource = self
            self.priceCollectionView.delegate = self
            self.priceCollectionView.reloadData()
            self.viewWillLayoutSubviews()
        } else {
            self.viewWillLayoutSubviews()
        }
    }
}
extension CompareProductPriceViewController: ProtocolTitleNavigationBar {
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
extension CompareProductPriceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.priceCollectionView {
            return self.priceRangeListArray.count
        } else {
            return self.tagArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.priceCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.CompareProductPriceCollectionViewCell, for: indexPath) as! CompareProductPriceCollectionViewCell
            cell.configure(priceRangeList: self.priceRangeListArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.CompareProductTagCollectionViewCell, for: indexPath) as! CompareProductTagCollectionViewCell
            cell.configure(compareTag: self.tagArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.priceCollectionView {
            cellHeight = priceCollectionViewItemHeight
            cellWidth = priceCollectionViewItemWidth
        } else {
            if self.tagArray.count > 0 {
                let tag = self.tagArray[indexPath.item].name
                let font = AppFont.regular.size(13)
                let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
                cellWidth = 12 + size.width + 5 + 16/*imagewidth*/ + 12
                cellHeight = tagHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension CompareProductPriceViewController: ProtocolCompareProductPriceCollectionViewCell, ProtocolCompareProductTagCollectionViewCell {
    func tagButtonPressedCompareProductTagCollectionViewCell(senderTag: Int) {
        if self.tagArray[senderTag].type == CompareProductHeader.brand.rawValue {
            self.navigateBackToCompareProductBrandViewController()
        } else if self.tagArray[senderTag].type == CompareProductHeader.price.rawValue {
            self.navigateBackToCompareProductPriceViewController()
        } else if self.tagArray[senderTag].type == CompareProductHeader.style.rawValue {
            self.navigateBackToCompareProductStyleViewController()
        }
    }
    func priceButtonPressedCompareProductPriceCollectionViewCell(senderTag: Int) {
        var name = ""
        var slug = ""
        let type = CompareProductHeader.price.rawValue
        if !(priceRangeListArray[senderTag].name.isNilOrEmpty) {
            name = priceRangeListArray[senderTag].name!
        }
        if priceRangeListArray[senderTag].id != nil {
            slug = "\(priceRangeListArray[senderTag].id!)"
        }
        if self.tagArray.count > 1 {
            self.tagArray.remove(at: 1)
            self.tagArray.append(CompareTagModel(name: name, slug: slug, type: type))
        } else {
            self.tagArray.append(CompareTagModel(name: name, slug: slug, type: type))
        }
        self.navigateToCompareProductStyleViewController(isFrom: self.isFrom, product1: self.product1, product2: self.product2, brandListArray: self.brandListArray, priceRangeListArray: self.priceRangeListArray, modelListArray: self.modelListArray, tagArray: self.tagArray, isEdit: self.isEdit)
    }
}
