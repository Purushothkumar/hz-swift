//
//  HearingAidPriceListTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 26/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
protocol ProtocolHearingAidPriceListTableViewCell {
    func viewAllButtonPressedHearingAidPriceListTableViewCell(senderTag: Int)
}
class HearingAidPriceListTableViewCell: UITableViewCell {
    
    @IBOutlet var hearingAidPriceListTitleView: UIView!
    @IBOutlet var titleLabel: CalloutFontLabel!
    @IBOutlet var descriptionLabel: FootnoteFontLabel!
    @IBOutlet var viewAllButton: FootnoteOutlineButton!
    
    @IBOutlet var hearingAidPriceListView: UIView!
    @IBOutlet var hearingAidPriceListCollectionView: UICollectionView!
    @IBOutlet var hearingAidPriceListCollectionViewHeight: NSLayoutConstraint!
    
    let hearingAidPriceListCollectionViewMargin = CGFloat(0)
    let hearingAidPriceListCollectionViewItemSpacing =  CGFloat(16)
    var hearingAidPriceListCollectionViewItemHeight = CGFloat(178)
    var hearingAidPriceListCollectionViewItemWidth = CGFloat(139)
    let hearingAidPriceListCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var productList = [ShopProductList]()
    var delegate: ProtocolHearingAidPriceListTableViewCell?
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
    
    public func configure(priceRangeList: HearingAidPriceRangeList, indexpath: Int, viewCon: ShopCategoryViewController) {
        self.viewCon = viewCon
        self.rowIndex = indexpath
        self.viewAllButton.tag = indexpath
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        var priceStartRange = ""
        var priceEndRange = ""
        self.viewAllButton.setTitle(AppLocalizationString.viewAll.uppercased(), for: .normal)
        self.viewAllButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.viewAllButton.layer.borderWidth = 1.0
        self.viewAllButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.viewAllButton.clipsToBounds = true
        
        if priceRangeList.priceStartRange != nil {
            if priceRangeList.priceStartRange != 0 {
                priceStartRange = String(format: "%@%d", AppConstantValue.rupeesymbol, priceRangeList.priceStartRange!)
            }
        }
        if priceRangeList.priceEndRange != nil {
            if priceRangeList.priceEndRange != 0 {
                priceEndRange = String(format: "%@%d", AppConstantValue.rupeesymbol, priceRangeList.priceEndRange!)
            }
        }
        if !(priceStartRange.isEmpty) && !(priceEndRange.isEmpty) {
            self.titleLabel.text = "\(priceStartRange) - \(priceEndRange)"
        } else {
            if !(priceStartRange.isEmpty) {
                self.titleLabel.text = "\(AppLocalizationString.above.capitalized) \(priceStartRange)"
            } else if !(priceEndRange.isEmpty) {
                self.titleLabel.text = "\(AppLocalizationString.below.capitalized) \(priceEndRange)"
            }
        }
        if !(priceRangeList.name.isNilOrEmpty) {
            self.descriptionLabel.text  = priceRangeList.name
        }
        self.productList = priceRangeList.products!
        self.reloadHearingAidPriceListCollectionView()
    }
    @IBAction func viewAllButtonPressed(_ sender: UIButton) {
        self.delegate?.viewAllButtonPressedHearingAidPriceListTableViewCell( senderTag: sender.tag)
    }
    func reloadHearingAidPriceListCollectionView() {
        self.hearingAidPriceListCollectionViewHeight.constant = 0
        if self.productList.count > 0 {
            self.hearingAidPriceListCollectionViewHeight.constant = (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.hearingAidPriceListCollectionViewItemHeight =  (252 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)) + AppConstantValue.productInfoHeight
            self.hearingAidPriceListCollectionViewItemWidth = 222 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth)
            self.hearingAidPriceListCollectionViewlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            self.hearingAidPriceListCollectionViewlayout.itemSize = CGSize(width: self.hearingAidPriceListCollectionViewItemWidth, height: self.hearingAidPriceListCollectionViewItemHeight)
            self.hearingAidPriceListCollectionViewlayout.minimumLineSpacing = self.hearingAidPriceListCollectionViewItemSpacing
            self.hearingAidPriceListCollectionViewlayout.minimumInteritemSpacing = self.hearingAidPriceListCollectionViewItemSpacing
            self.hearingAidPriceListCollectionViewlayout.scrollDirection = .horizontal
            self.hearingAidPriceListCollectionView!.collectionViewLayout = self.hearingAidPriceListCollectionViewlayout
            self.hearingAidPriceListCollectionView.dataSource = self
            self.hearingAidPriceListCollectionView.delegate = self
            self.hearingAidPriceListCollectionView.reloadData()
        } else {
            self.hearingAidPriceListCollectionViewHeight.constant = 0
        }
    }
}
extension HearingAidPriceListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HearingAidPriceListCollectionViewCell, for: indexPath) as! HearingAidPriceListCollectionViewCell
        cell.configure(product: productList[indexPath.item], indexpath: indexPath.item, rowIndex: self.rowIndex!, viewCon: self.viewCon!)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.hearingAidPriceListCollectionView {
            if self.productList.count > 0 {
                cellWidth = self.hearingAidPriceListCollectionViewItemWidth
                cellHeight = self.hearingAidPriceListCollectionViewItemHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension HearingAidPriceListTableViewCell: ProtocolHearingAidPriceListCollectionViewCell {
    func tapButtonPressedHearingAidPriceListCollectionViewCell(rowIndex: Int, senderTag: Int, viewCon: ShopCategoryViewController) {
        if !(self.productList[senderTag].slug.isNilOrEmpty) {
            viewCon.navigateToHAProductDetailViewController(isFrom: IsNavigateFrom.productDetailShopHA.rawValue, productslug: self.productList[senderTag].slug!)
        }
    }
    func wishlistButtonPressedHearingAidPriceListCollectionViewCell(rowIndex: Int, senderTag: Int, viewCon: ShopCategoryViewController) {
    }
}
