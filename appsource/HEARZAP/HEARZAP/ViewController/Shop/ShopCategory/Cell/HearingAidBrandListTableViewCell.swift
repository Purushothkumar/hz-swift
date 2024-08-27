//
//  HearingAidBrandListTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 26/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolHearingAidBrandListTableViewCell {
    func viewAllButtonPressedHearingAidBrandListTableViewCell(senderTag: Int)
}
class HearingAidBrandListTableViewCell: UITableViewCell {
    
    @IBOutlet var titleView: UIView!
    @IBOutlet var hearingAidTitleLabel: CalloutFontLabel!
    @IBOutlet var hearingAidDescriptionLabel: FootnoteFontLabel!
    @IBOutlet var viewAllButton: FootnoteOutlineButton!
    
    @IBOutlet var hearingAidBrandListView: UIView!
    @IBOutlet var hearingAidBrandListCollectionView: UICollectionView!
    @IBOutlet var hearingAidBrandListCollectionViewHeight: NSLayoutConstraint!
    
    let hearingAidBrandListCollectionViewMargin = 0
    let hearingAidBrandListCollectionViewItemSpacing =  CGFloat(16)
    var hearingAidBrandListCollectionViewItemHeight = CGFloat(178)
    var hearingAidBrandListCollectionViewItemWidth = CGFloat(139)
    let hearingAidBrandListCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var productListArray = [ShopProductList]()
    var delegate: ProtocolHearingAidBrandListTableViewCell?
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
    
    public func configure(hearingAidBrandList: HearingAidBrandList, indexpath: Int, viewCon: ShopCategoryViewController) {
        self.viewCon = viewCon
        self.rowIndex = indexpath
        self.viewAllButton.setTitle(AppLocalizationString.viewAll.uppercased(), for: .normal)
        self.viewAllButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.viewAllButton.layer.borderWidth = 1.0
        self.viewAllButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.viewAllButton.clipsToBounds = true
        
        self.productListArray = hearingAidBrandList.products!
        self.rowIndex = indexpath
        
        var brandName = ""
        if !(hearingAidBrandList.name.isNilOrEmpty) {
            brandName = hearingAidBrandList.name!
        }
        self.hearingAidTitleLabel.text = brandName
        self.hearingAidDescriptionLabel.text = ""
        self.reloadHearingAidBrandListCollectionView()
    }
    @IBAction func viewAllButtonPressed(_ sender: UIButton) {
        self.delegate?.viewAllButtonPressedHearingAidBrandListTableViewCell( senderTag: sender.tag)
    }
    func reloadHearingAidBrandListCollectionView() {
        self.hearingAidBrandListCollectionViewHeight.constant = 0
        if self.productListArray.count > 0 {
            self.hearingAidBrandListCollectionViewHeight.constant = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.hearingAidBrandListCollectionViewItemHeight = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.hearingAidBrandListCollectionViewItemWidth = 222 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
            self.hearingAidBrandListCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            self.hearingAidBrandListCollectionViewlayout.itemSize = CGSize(width: self.hearingAidBrandListCollectionViewItemWidth, height: self.hearingAidBrandListCollectionViewItemHeight)
            self.hearingAidBrandListCollectionViewlayout.minimumLineSpacing = self.hearingAidBrandListCollectionViewItemSpacing
            self.hearingAidBrandListCollectionViewlayout.minimumInteritemSpacing = self.hearingAidBrandListCollectionViewItemSpacing
            self.hearingAidBrandListCollectionViewlayout.scrollDirection = .horizontal
            self.hearingAidBrandListCollectionView!.collectionViewLayout = self.hearingAidBrandListCollectionViewlayout
            self.hearingAidBrandListCollectionView.dataSource = self
            self.hearingAidBrandListCollectionView.delegate = self
            self.hearingAidBrandListCollectionView.reloadData()
        } else {
            self.hearingAidBrandListCollectionViewHeight.constant = 0
        }
    }
    
}
extension HearingAidBrandListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productListArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearingAidBrandListCollectionViewCell, for: indexPath) as! HearingAidBrandListCollectionViewCell
        cell.configure(product: productListArray[indexPath.item], indexpath: indexPath.item, rowIndex: self.rowIndex!, viewCon: viewCon!)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.hearingAidBrandListCollectionView {
            if self.productListArray.count > 0 {
                cellWidth = self.hearingAidBrandListCollectionViewItemWidth
                cellHeight = self.hearingAidBrandListCollectionViewItemHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension HearingAidBrandListTableViewCell: ProtocolHearingAidBrandListCollectionViewCell {
    func tapButtonPressedHearingAidBrandListCollectionViewCell(rowIndex: Int, senderTag: Int, viewCon: ShopCategoryViewController) {
        if !(self.productListArray[senderTag].slug.isNilOrEmpty) {
            viewCon.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productDetailShopHA.rawValue, productslug: self.productListArray[senderTag].slug!)
        }
    }
    func wishlistButtonPressedHearingAidBrandListCollectionViewCell(rowIndex: Int, senderTag: Int, viewCon: ShopCategoryViewController) {
    }
}
