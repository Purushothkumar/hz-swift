//
//  CompareProductStyleViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CompareProductStyleViewController: UIViewController {
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

    @IBOutlet var styleTitleView: UIView!
    @IBOutlet var styleTitleLabel: Caption2FontLabel!

    @IBOutlet var styleView: UIView!
    @IBOutlet var styleCollectionView: UICollectionView!
    @IBOutlet var styleCollectionViewHeight: NSLayoutConstraint!

    // MARK: - Lets and Var
    let styleCollectionViewMargin = 0
    let styleCollectionViewItemSpacing = CGFloat(6)
    var styleCollectionViewItemHeight = CGFloat(178)
    var styleCollectionViewItemWidth = CGFloat(139)
    let styleCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

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
        self.compareProductHeaderView.setupView(currentPage: CompareProductHeader.style.rawValue)
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
        self.compareProductHeaderView.setupView(currentPage: CompareProductHeader.style.rawValue)
        self.reloadTagCollectionView()
        self.reloadStyleCollectionView()

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
        self.styleTitleLabel.text = AppLocalizationString.selectyourStyle
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
    func reloadStyleCollectionView() {
        if self.modelListArray.count > 0 {
            self.styleCollectionViewItemHeight = CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(AppConstantValue.screen165slash375)
            self.styleCollectionViewItemWidth = (CGFloat(screenFrameWidth) - (CGFloat(32) + CGFloat(6))) / 2
            self.styleCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.styleCollectionViewlayout.itemSize = CGSize(width: self.styleCollectionViewItemWidth, height: self.styleCollectionViewItemHeight)
            self.styleCollectionViewlayout.minimumLineSpacing = self.styleCollectionViewItemSpacing
            self.styleCollectionViewlayout.minimumInteritemSpacing = self.styleCollectionViewItemSpacing
            self.styleCollectionViewlayout.scrollDirection = .vertical
            self.styleCollectionView!.collectionViewLayout = self.styleCollectionViewlayout
            self.styleCollectionView.dataSource = self
            self.styleCollectionView.delegate = self
            self.styleCollectionView.reloadData()
            if self.modelListArray.count % 2 == 0 {
                self.styleCollectionViewHeight.constant = CGFloat(self.modelListArray.count / 2) * styleCollectionViewItemHeight + CGFloat(20)
            } else {
                self.styleCollectionViewHeight.constant = (CGFloat(self.modelListArray.count / 2) * styleCollectionViewItemHeight) + styleCollectionViewItemHeight + CGFloat(20)
            }
        } else {
            self.styleCollectionViewHeight.constant = 0
        }
    }
}
extension CompareProductStyleViewController: ProtocolTitleNavigationBar {
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
extension CompareProductStyleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.styleCollectionView {
            return self.modelListArray.count
        } else {
            return self.tagArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.styleCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.CompareProductStyleCollectionViewCell, for: indexPath) as! CompareProductStyleCollectionViewCell
            cell.configure(modelList: self.modelListArray[indexPath.item], indexpath: indexPath.item)
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
        if collectionView == self.styleCollectionView {
            if self.modelListArray.count > 0 {
                cellWidth = self.styleCollectionViewItemWidth
                cellHeight = self.styleCollectionViewItemHeight
            }
        } else if collectionView == self.tagCollectionView {
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

extension CompareProductStyleViewController: ProtocolCompareProductStyleCollectionViewCell, ProtocolCompareProductTagCollectionViewCell {
    func tagButtonPressedCompareProductTagCollectionViewCell(senderTag: Int) {
        if self.tagArray[senderTag].type == CompareProductHeader.brand.rawValue {
            self.navigateBackToCompareProductBrandViewController()
        } else if self.tagArray[senderTag].type == CompareProductHeader.price.rawValue {
            self.navigateBackToCompareProductPriceViewController()
        } else if self.tagArray[senderTag].type == CompareProductHeader.style.rawValue {
            self.navigateBackToCompareProductStyleViewController()
        }
    }
    func styleButtonPressedCompareProductStyleCollectionViewCell(senderTag: Int) {
        var name = ""
        var slug = ""
        let type = CompareProductHeader.style.rawValue
        if !(modelListArray[senderTag].name.isNilOrEmpty) {
            name = modelListArray[senderTag].name!
        }
        if modelListArray[senderTag].id != nil {
            slug = "\(modelListArray[senderTag].id!)"
        }
        if self.tagArray.count > 2 {
            self.tagArray.remove(at: 2)
            self.tagArray.append(CompareTagModel(name: name, slug: slug, type: type))
        } else {
            self.tagArray.append(CompareTagModel(name: name, slug: slug, type: type))
        }
        self.navigateToCompareProductModelViewController(isFrom: self.isFrom, product1: self.product1, product2: self.product2, brandListArray: self.brandListArray, priceRangeListArray: self.priceRangeListArray, modelListArray: self.modelListArray, tagArray: self.tagArray, isEdit: self.isEdit)
    }
}
