//
//  CompareProductModelViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CompareProductModelViewController: UIViewController {
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

    @IBOutlet var productModelTitleView: UIView!
    @IBOutlet var productModelTitleLabel: Caption2FontLabel!

    @IBOutlet var productModelView: UIView!
    @IBOutlet var productModelTableView: UITableView!
    @IBOutlet var productModelTableViewHeight: NSLayoutConstraint!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: FootnoteFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!

    // MARK: - Lets and Var
    var compareProductModelViewModel = CompareProductModelViewModel()

    var productListarray = [ShopProductList]()
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
        self.compareProductHeaderView.setupView(currentPage: CompareProductHeader.model.rawValue)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if self.productListarray.count > 0 {
            self.productModelTableViewHeight.constant = self.productModelTableView.contentSize.height
        } else {
            self.productModelTableViewHeight.constant = 0
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
        self.compareProductHeaderView.setupView(currentPage: CompareProductHeader.model.rawValue)
        self.reloadTagCollectionView()
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
        self.productModelTitleLabel.text = AppLocalizationString.selectyourModel
        self.primaryMessageLabel.text = AppLocalizationString.noMatchFound
        self.secondaryMessageLabel.text = AppLocalizationString.redefinepleaseselectdifferentoptions
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getCompareModelProductList(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getCompareModelProductList(retryAPIID: Int, canShowLoader: Bool) {
        var style = ""
        var brand = ""
        var price = ""
        if self.tagArray.count > 0 {
            for item in self.tagArray {
                if item.type == CompareProductHeader.brand.rawValue {
                    brand = item.slug
                } else if item.type == CompareProductHeader.price.rawValue {
                    price = item.slug
                } else if item.type == CompareProductHeader.style.rawValue {
                    style = item.slug
                }
            }
            var param = ""
            var productUID = ""
            if !(product1.isEmpty) {
                productUID = product1
            } else if !(product2.isEmpty) {
                productUID = product2
            }
            if productUID.isEmpty {
                param = String(format: "style=%@&brand=%@&price=%@", style, brand, price)
            } else {
                param = String(format: "style=%@&brand=%@&price=%@&product_id=%@", style, brand, price, productUID)
            }
            self.compareProductModelViewModel.getCompareModelProductList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getCompareModelProductList, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
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
    func reloadProductListTableView() {
        self.productModelTableView.tableFooterView = UIView()
        self.productModelTableView.separatorColor = UIColor.clear
        self.productModelTableView.backgroundColor = UIColor.clear
        self.productModelTableView.rowHeight = UITableView.automaticDimension
        self.productModelTableView.estimatedRowHeight = UITableView.automaticDimension
        self.productModelTableView.delegate = self
        self.productModelTableView.dataSource = self
        self.productModelTableView.reloadData()
        self.viewWillLayoutSubviews()
    }
}
extension CompareProductModelViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
    }
    func rightButtonPressed() {
        if self.isEdit == true {
            self.navigateBackToCompareProductViewController()
        } else if isFrom == IsNavigateFrom.compareShop.rawValue {
            self.navigateBackToShopCategoryViewController()
        } else if isFrom == IsNavigateFrom.compareView.rawValue {
            self.navigateBackToCompareProductViewController()
        } else if isFrom == IsNavigateFrom.compareProductDetail.rawValue {
            self.navigateBackToHAProductDetailViewController()
        } else if self.isFrom == IsNavigateFrom.compareFHA.rawValue {
            self.navigateBackToFindRightDeviceRecommendViewController()
        } else {
            self.navigateBackToViewController()
        }
    }
}
extension CompareProductModelViewController: ProtocolNetworkRechabilityDelegate {
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
extension CompareProductModelViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tagArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.CompareProductTagCollectionViewCell, for: indexPath) as! CompareProductTagCollectionViewCell
        cell.configure(compareTag: self.tagArray[indexPath.item], indexpath: indexPath.item)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.tagArray.count > 0 {
            let tag = self.tagArray[indexPath.item].name
            let font = AppFont.regular.size(13)
            let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
            cellWidth = 12 + size.width + 5 + 16/*imagewidth*/ + 12
            cellHeight = tagHeight
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension CompareProductModelViewController: ProtocolCompareProductTagCollectionViewCell {
    func tagButtonPressedCompareProductTagCollectionViewCell(senderTag: Int) {
        if self.tagArray[senderTag].type == CompareProductHeader.brand.rawValue {
            self.navigateBackToCompareProductBrandViewController()
        } else if self.tagArray[senderTag].type == CompareProductHeader.price.rawValue {
            self.navigateBackToCompareProductPriceViewController()
        } else if self.tagArray[senderTag].type == CompareProductHeader.style.rawValue {
            self.navigateBackToCompareProductStyleViewController()
        }
    }
}
extension CompareProductModelViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productListarray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.CompareProductModelTableViewCell, for: indexPath) as! CompareProductModelTableViewCell
        cell.delegate = self
        cell.configure(product: self.productListarray[indexPath.row], indexpath: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.productModelTableViewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
extension CompareProductModelViewController: ProtocolCompareProductModelTableViewCell {
    func modelButtonPressedCompareProductModelTableViewCell(senderTag: Int) {
        if !(productListarray[senderTag].uid.isNilOrEmpty) {
            if product1.isEmpty {
                self.product1 = productListarray[senderTag].uid!
            } else {
                self.product2 = productListarray[senderTag].uid!
            }
        }
        self.navigateToCompareProductViewController(isFrom: self.isFrom, product1: self.product1, product2: self.product2)
    }
}
