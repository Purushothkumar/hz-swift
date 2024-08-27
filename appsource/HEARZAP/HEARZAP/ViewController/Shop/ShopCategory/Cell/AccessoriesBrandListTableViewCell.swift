//
//  accessoriesBrandListTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 09/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class AccessoriesBrandListTableViewCell: UITableViewCell {
    
    @IBOutlet var titleView: UIView!
    @IBOutlet var accessoriesTitleLabel: CalloutFontLabel!
    @IBOutlet var accessoriesDescriptionLabel: FootnoteFontLabel!
    
    @IBOutlet var accessoriesBrandListView: UIView!
    @IBOutlet var accessoriesBrandListCollectionView: UICollectionView!
    @IBOutlet var accessoriesBrandListCollectionViewHeight: NSLayoutConstraint!
    
    let accessoriesBrandListCollectionViewMargin = CGFloat(0)
    let accessoriesBrandListCollectionViewItemSpacing = CGFloat(16)
    var accessoriesBrandListCollectionViewItemHeight = CGFloat(178)
    var accessoriesBrandListCollectionViewItemWidth = CGFloat(139)
    let accessoriesBrandListCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var productListArray = [ShopProductList]()
    var rowIndex: Int?
    var viewCon: ShopCategoryViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func configure(accessoriesBrandList: AccessoriesBrandList, indexpath: Int, viewCon: ShopCategoryViewController) {
        self.viewCon = viewCon
        self.rowIndex = indexpath
        self.productListArray = accessoriesBrandList.products!
        self.rowIndex = indexpath
        var brandName = ""
        if !(accessoriesBrandList.brandName.isNilOrEmpty) {
            brandName = accessoriesBrandList.brandName!
        }
        self.accessoriesTitleLabel.text = brandName
        self.accessoriesDescriptionLabel.text = ""
        
        self.reloadaccessoriesBrandListCollectionView()
    }
    
    func reloadaccessoriesBrandListCollectionView() {
        self.accessoriesBrandListCollectionViewHeight.constant = 0
        if self.productListArray.count > 0 {
            self.accessoriesBrandListCollectionViewHeight.constant = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.accessoriesBrandListCollectionViewItemHeight = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.accessoriesBrandListCollectionViewItemWidth = 222 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
            self.accessoriesBrandListCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            self.accessoriesBrandListCollectionViewlayout.itemSize = CGSize(width: self.accessoriesBrandListCollectionViewItemWidth, height: self.accessoriesBrandListCollectionViewItemHeight)
            self.accessoriesBrandListCollectionViewlayout.minimumLineSpacing = self.accessoriesBrandListCollectionViewItemSpacing
            self.accessoriesBrandListCollectionViewlayout.minimumInteritemSpacing = self.accessoriesBrandListCollectionViewItemSpacing
            self.accessoriesBrandListCollectionViewlayout.scrollDirection = .horizontal
            self.accessoriesBrandListCollectionView!.collectionViewLayout = self.accessoriesBrandListCollectionViewlayout
            self.accessoriesBrandListCollectionView.dataSource = self
            self.accessoriesBrandListCollectionView.delegate = self
            self.accessoriesBrandListCollectionView.reloadData()
        } else {
            self.accessoriesBrandListCollectionViewHeight.constant = 0
        }
    }
}
extension AccessoriesBrandListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productListArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.AccessoriesBrandListCollectionViewCell, for: indexPath) as! AccessoriesBrandListCollectionViewCell
        cell.configure(product: productListArray[indexPath.item], indexpath: indexPath.item, rowIndex: self.rowIndex!, viewCon: viewCon!)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.accessoriesBrandListCollectionView {
            if self.productListArray.count > 0 {
                cellWidth = self.accessoriesBrandListCollectionViewItemWidth
                cellHeight = self.accessoriesBrandListCollectionViewItemHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension AccessoriesBrandListTableViewCell: ProtocolAccessoriesBrandListCollectionViewCell {
    func tapButtonPressedAccessoriesBrandListCollectionViewCell(rowIndex: Int, senderTag: Int, viewCon: ShopCategoryViewController) {
        if !(self.productListArray[senderTag].slug.isNilOrEmpty) {
            viewCon.navigateToProductDetailViewController(isFrom: IsNavigateFrom.productDetailShopAccessories.rawValue, productslug: self.productListArray[senderTag].slug!)
        }
    }
    
    func wishlistButtonPressedAccessoriesBrandListCollectionViewCell(rowIndex: Int, senderTag: Int, viewCon: ShopCategoryViewController) {
    }
}
