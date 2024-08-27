//
//  HearingAidFilterTagCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 16/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolHearingAidFilterTagCollectionViewCell {
    func tagButtonPressedHearingAidFilterTagCollectionViewCell(senderTag: Int)
}

class HearingAidFilterTagCollectionViewCell: UICollectionViewCell {
    @IBOutlet var filterView: UIView!
    @IBOutlet var tagLabel: Caption1FontLabel!
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var imageviewLeftPadding: NSLayoutConstraint!
    @IBOutlet var imageviewHeight: NSLayoutConstraint!
    @IBOutlet var selectedView: UIView!
    @IBOutlet var tagButton: FootnoteOutlineButton!
    var delegate: ProtocolHearingAidFilterTagCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(hearingAidsFilterList: HearingAidsFilterList, selectedIndex: Int, indexpath: Int, viewCon: ShopCategoryViewController) {
        
        var paramArray: NSMutableArray = NSMutableArray()
        if viewCon.specificationArraySelected.count > 0 {
            for (index, item) in viewCon.specificationArraySelected.enumerated() {
                for (key, value) in (item as! NSDictionary) {
                    let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                    if arrayValueCode.count > 0 {
                        paramArray.add(item)
                    }
                }
            }
        }
        if viewCon.featureArraySelected.count > 0 {
            for (index, item) in viewCon.featureArraySelected.enumerated() {
                for (key, value) in (item as! NSDictionary) {
                    let arrayValueCode: NSMutableArray = NSMutableArray(array: value as! NSArray)
                    if arrayValueCode.count > 0 {
                        paramArray.add(item)
                    }
                }
            }
        }
        var filterCount = 0
        
        if indexpath == 3 {
            filterCount = paramArray.count
            
            if viewCon.styleArraySelected.count > 0 {
                filterCount += 1
            }
            if viewCon.brandArraySelected.count > 0 {
                filterCount += 1
            }
        }
        
        self.tagLabel.text = hearingAidsFilterList.title
        self.tagButton.tag = indexpath
        self.filterView.isHidden = true
        
        if selectedIndex == indexpath {
            self.tagLabel.textColor = UIColor.colorLiteral.theme_blue_2AACEF
            self.selectedView.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
            self.imageview.image = UIImage(named: hearingAidsFilterList.imageSelected)
        } else {
            self.tagLabel.textColor = UIColor.colorLiteral.theme_grey_777777
            self.selectedView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
            self.imageview.image = UIImage(named: hearingAidsFilterList.image)
        }
        if hearingAidsFilterList.showImage == true {
            self.imageviewHeight.constant = 16
            self.imageviewLeftPadding.constant = CGFloat(10)
        } else {
            self.imageviewHeight.constant = 0
            self.imageviewLeftPadding.constant = 0
        }
        if (selectedIndex == 3) && (filterCount > 0) && (selectedIndex == indexpath) {
            self.filterView.isHidden = false
        }
    }
    @IBAction func tagButtonPressed(_ sender: UIButton) {
        self.delegate?.tagButtonPressedHearingAidFilterTagCollectionViewCell(senderTag: sender.tag)
    }
}
