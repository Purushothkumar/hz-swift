//
//  BottomSheetCartSpecificationTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 16/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BottomSheetCartSpecificationTableViewCell: UITableViewCell {

    @IBOutlet var stackview: UIStackView!

    @IBOutlet var titleLabel: FootnoteFontLabel!

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!

    var valueArray = [Value]()

    var selectedRow: Int?
    var titleID = ""

    var viewCon: BottomSheetCartViewController = BottomSheetCartViewController()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView!.layoutSubviews()
        self.collectionViewHeight.constant = tagHeight
        self.layoutIfNeeded()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK: - Reload
    func reloadCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }

    public func configure(specification: ProductSpecification, indexpath: Int, viewCon: BottomSheetCartViewController) {
        self.viewCon = viewCon
        self.selectedRow = indexpath
        self.titleLabel.text = ""
        if !(specification.name.isNilOrEmpty) {
            self.titleID = specification.name!
            self.titleLabel.text = specification.name!

            if self.titleID.lowercased() == "color" {
                self.setTitleColorForLabel()
            }
            if specification.values != nil {
                self.valueArray = specification.values!
                if self.valueArray.count > 0 {
                    self.reloadCollectionView()
                }
            }
        }
    }

    func setTitleColorForLabel() {
        let msg1 = self.titleID
        let titleFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_112F70, NSAttributedString.Key.font: AppFont.medium.size(13)]
        let colorFontAttributesBeige = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorBeige, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]
        let colorFontAttributesTaupe = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorTaupe, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]
        let colorFontAttributesDarkGray = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorDarkGray, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]
        let colorFontAttributesGray = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorGray, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]
        let colorFontAttributesBlack = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorBlack, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]
        let colorFontAttributesBrown = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorBrown, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]
        let colorFontAttributesBlue = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorBlue, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]
        let colorFontAttributesRed = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorRed, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]
        let colorFontAttributesSilver = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorSilver, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]
        let colorFontAttributesGold = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorGold, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]
        let colorFontAttributesRoseGold = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorRoseGold, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]
        let colorFontAttributesWhite = [NSAttributedString.Key.foregroundColor: UIColor.ProductColor.productColorBlack, NSAttributedString.Key.font: AppFont.medium.size(13)] as [NSAttributedString.Key: Any]

        let strmsgcolor = NSMutableAttributedString(string: String(format: "%@", msg1), attributes: titleFontAttributes as [NSAttributedString.Key: Any])
        let strColon = NSMutableAttributedString(string: String(format: "%@", ":"), attributes: titleFontAttributes as [NSAttributedString.Key: Any])
        let strColorBeige = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesBeige as [NSAttributedString.Key: Any])
        let strColorTaupe = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesTaupe as [NSAttributedString.Key: Any])
        let strColorDarkGray = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesDarkGray as [NSAttributedString.Key: Any])
        let strColorGray = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesGray as [NSAttributedString.Key: Any])
        let strColorBlack = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesBlack as [NSAttributedString.Key: Any])
        let strColorBrown = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesBrown as [NSAttributedString.Key: Any])
        let strColorBlue = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesBlue as [NSAttributedString.Key: Any])
        let strColorRed = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesRed as [NSAttributedString.Key: Any])
        let strColorSilver = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesSilver as [NSAttributedString.Key: Any])
        let strColorGold = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesGold as [NSAttributedString.Key: Any])
        let strColorRoseGold = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesRoseGold as [NSAttributedString.Key: Any])
        let strColorWhite = NSMutableAttributedString(string: String(format: " %@", viewCon.colorName), attributes: colorFontAttributesWhite as [NSAttributedString.Key: Any])

        let combination = NSMutableAttributedString()
        combination.append(strmsgcolor)
        if !(viewCon.colorName.isEmpty) {
            if viewCon.colorName.lowercased() == "Beige".lowercased() {
                combination.append(strColon)
                combination.append(strColorBeige)
            } else if viewCon.colorName.lowercased() == "Taupe".lowercased() {
                combination.append(strColon)
                combination.append(strColorTaupe)
            } else if viewCon.colorName.lowercased() == "Dark gray".lowercased() {
                combination.append(strColon)
                combination.append(strColorDarkGray)
            } else if viewCon.colorName.lowercased() == "Gray".lowercased() {
                combination.append(strColon)
                combination.append(strColorGray)
            } else if viewCon.colorName.lowercased() == "Black".lowercased() {
                combination.append(strColon)
                combination.append(strColorBlack)
            } else if viewCon.colorName.lowercased() == "Brown".lowercased() {
                combination.append(strColon)
                combination.append(strColorBrown)
            } else if viewCon.colorName.lowercased() == "Blue".lowercased() {
                combination.append(strColon)
                combination.append(strColorBlue)
            } else if viewCon.colorName.lowercased() == "Red".lowercased() {
                combination.append(strColon)
                combination.append(strColorRed)
            } else if viewCon.colorName.lowercased() == "Silver".lowercased() {
                combination.append(strColon)
                combination.append(strColorSilver)
            } else if viewCon.colorName.lowercased() == "Gold".lowercased() {
                combination.append(strColon)
                combination.append(strColorGold)
            } else if viewCon.colorName.lowercased() == "RoseGold".lowercased() {
                combination.append(strColon)
                combination.append(strColorRoseGold)
            } else if viewCon.colorName.lowercased() == "White".lowercased() {
                combination.append(strColon)
                combination.append(strColorWhite)
            }
        }
        self.titleLabel.attributedText = combination
    }
}
extension BottomSheetCartSpecificationTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.valueArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !(titleID.isEmpty) {
            if titleID.lowercased() == "color" {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BottomSheetCartColorCollectionViewCell, for: indexPath) as! BottomSheetCartColorCollectionViewCell
                cell.configure(value: self.valueArray[indexPath.item], indexpath: indexPath.item, selectedRow: self.selectedRow!, titleID: self.titleID, selectArray: viewCon.selectArray, viewCon: self.viewCon)
                cell.delegate = self
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BottomSheetCartSpecificationCollectionViewCell, for: indexPath) as! BottomSheetCartSpecificationCollectionViewCell
                cell.configure(value: self.valueArray[indexPath.item], indexpath: indexPath.item, selectedRow: self.selectedRow!, titleID: self.titleID, selectArray: viewCon.selectArray)
                cell.delegate = self
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BottomSheetCartSpecificationCollectionViewCell, for: indexPath) as! BottomSheetCartSpecificationCollectionViewCell
            cell.configure(value: self.valueArray[indexPath.item], indexpath: indexPath.item, selectedRow: self.selectedRow!, titleID: self.titleID, selectArray: viewCon.selectArray)
            cell.delegate = self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.valueArray.count > 0 {
            if !(self.valueArray[indexPath.item].name.isNilOrEmpty) {
                if titleID.lowercased() == "color" {
                    //                    var valueCode = ""
                    //                    if viewCon.selectArray.count > 0 {
                    //                        for (index, item) in viewCon.selectArray.enumerated() {
                    //                            for (key, value) in (item as! NSDictionary) {
                    //                                if (key as! String).lowercased() == "color" {
                    //                                    valueCode = value as! String
                    //                                }
                    //                            }
                    //                        }
                    //                    }
                    //                    let colorName = self.valueArray[indexPath.item].name!
                    //                    let tag = "  \(colorName)  "
                    //                    let font = AppFont.regular.size(13)
                    //                    let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
                    //                    if (valueCode == colorName){
                    //                        cellWidth = tagHeight + 5 + size.width + 5
                    //                    } else{
                    //                        cellWidth = tagHeight
                    //                    }
                    cellWidth = tagHeight
                    cellHeight = tagHeight
                } else {
                    let tag = "  \(self.valueArray[indexPath.item].name!)  "
                    let font = AppFont.regular.size(13)
                    let size = tag.size(withAttributes: [NSAttributedString.Key.font: font])
                    cellWidth = 12 + size.width + 12
                    cellHeight = tagHeight
                }
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
extension BottomSheetCartSpecificationTableViewCell: ProtocolBottomSheetCartSpecificationCollectionViewCell, ProtocolBottomSheetCartColorCollectionViewCell {
    func tagButtonPressedBottomSheetCartSpecificationCollectionViewCell(senderTag: Int, selectedRow: Int) {
        if viewCon.productSpecficationArray.count > 0 {
            var strKeyCode = ""
            var strValueCode = ""
            if !(viewCon.productSpecficationArray[selectedRow].name.isNilOrEmpty) {
                strKeyCode = String(format: "%@", viewCon.productSpecficationArray[selectedRow].name!)
                if !(strKeyCode.isEmpty) {
                    if viewCon.productSpecficationArray[selectedRow].values != nil {
                        if viewCon.productSpecficationArray[selectedRow].values!.count > 0 {
                            if viewCon.productSpecficationArray[selectedRow].values![senderTag].id != nil {
                                strValueCode = String(format: "%@", viewCon.productSpecficationArray[selectedRow].values![senderTag].id!)
                            }
                        }
                    }
                }
            }
            if !(strKeyCode.isEmpty) && !(strValueCode.isEmpty) {
                let filterTempArray = viewCon.selectArray.mutableCopy() as! NSMutableArray
                viewCon.selectArray.removeAllObjects()
                if filterTempArray.count > 0 {
                    for (index, item) in filterTempArray.enumerated() {
                        for (key, value) in (item as! NSDictionary) {
                            if key as! String == strKeyCode {
                                let dictTemp = NSMutableDictionary()
                                dictTemp.setValue(strValueCode, forKey: strKeyCode)
                                viewCon.selectArray.add(dictTemp)
                            } else {
                                viewCon.selectArray.add(item)
                            }
                            if filterTempArray.count >= viewCon.selectArray.count {
                                viewCon.reloadTableView()
                            }
                        }
                    }
                    self.getProductQuantity()
                }
            }
        }
    }
    func tagButtonPressedBottomSheetCartColorCollectionViewCell(senderTag: Int, selectedRow: Int) {
        if viewCon.productSpecficationArray.count > 0 {
            var strKeyCode = ""
            var strValueCode = ""
            if !(viewCon.productSpecficationArray[selectedRow].name.isNilOrEmpty) {
                strKeyCode = String(format: "%@", viewCon.productSpecficationArray[selectedRow].name!)
                if !(strKeyCode.isEmpty) {
                    if viewCon.productSpecficationArray[selectedRow].values != nil {
                        if viewCon.productSpecficationArray[selectedRow].values!.count > 0 {
                            if viewCon.productSpecficationArray[selectedRow].values![senderTag].id != nil {
                                strValueCode = String(format: "%@", viewCon.productSpecficationArray[selectedRow].values![senderTag].id!)
                                viewCon.colorName = strValueCode
                            }
                        }
                    }
                }
            }
            if !(strKeyCode.isEmpty) && !(strValueCode.isEmpty) {
                let filterTempArray = viewCon.selectArray.mutableCopy() as! NSMutableArray
                viewCon.selectArray.removeAllObjects()
                if filterTempArray.count > 0 {
                    for (index, item) in filterTempArray.enumerated() {
                        for (key, value) in (item as! NSDictionary) {
                            if key as! String == strKeyCode {
                                let dictTemp = NSMutableDictionary()
                                dictTemp.setValue(strValueCode, forKey: strKeyCode)
                                viewCon.selectArray.add(dictTemp)
                            } else {
                                viewCon.selectArray.add(item)
                            }
                            if filterTempArray.count >= viewCon.selectArray.count {
                                viewCon.reloadTableView()
                            }
                        }
                    }
                    self.getProductQuantity()
                }
            }
        }
    }
    func getProductQuantity() {
        var isSpecificationSelected = true
        for (index, item) in viewCon.selectArray.enumerated() {
            for (key, value) in (item as! NSDictionary) {
                let valueCode = value as! String
                if valueCode.isEmpty {
                    isSpecificationSelected = false
                }
            }
        }
        if isSpecificationSelected == true {
            viewCon.commonAPICALL(retryAPIID: 1003)
        }
    }
}
