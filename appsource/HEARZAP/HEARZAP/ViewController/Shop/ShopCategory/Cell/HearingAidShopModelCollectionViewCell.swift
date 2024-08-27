//
//  HearingAidShopModelCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 26/10/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolHearingAidShopModelCollectionViewCell {
    func infoButtonPressedHearingAidShopModelCollectionViewCell(senderTag: Int)
    func shopNowButtonPressedHearingAidShopModelCollectionViewCell(senderTag: Int)
}

class HearingAidShopModelCollectionViewCell: UICollectionViewCell {

    @IBOutlet var infoView: UIView!
    @IBOutlet var infoButton: FootnoteOutlineButton!

    @IBOutlet var ProductView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productImageViewHeight: NSLayoutConstraint!

    @IBOutlet var productModelLabel: CalloutFontLabel!
    @IBOutlet var productDescriptionLabel: Caption1FontLabel!

    @IBOutlet var shopNowButton: FootnoteOutlineButton!

    var delegate: ProtocolHearingAidShopModelCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()


    }
    public func configure(modelList: ShopModelList, indexpath: Int) {
        self.shopNowButton.tag = indexpath
        self.infoButton.tag = indexpath
        self.shopNowButton.setTitle("  \(AppLocalizationString.shopnow.uppercased())  ", for: .normal)

        self.shopNowButton.isUserInteractionEnabled = true
        self.shopNowButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.shopNowButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.shopNowButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.shopNowButton.layer.borderWidth = 1.0

        self.productModelLabel.text = ""
        self.productDescriptionLabel.text = ""

        var productImage = ""
        self.infoView.isHidden = true
        self.productImageViewHeight.constant = (CGFloat(533.33) * CGFloat(screenFrameWidth / AppConstantValue.defaultDesignScreenWidth))
        var slug = ""

        //        if !(modelList.name.isNilOrEmpty) {
        //            self.productModelLabel.text = modelList.name!.capitalized
        //        }
        //        if modelList.info != nil{
        //            if modelList.info!.image != nil{
        //                if !(modelList.info!.image.isNilOrEmpty){
        //                    productImage = modelList.info!.image!
        //                }
        //            }
        //        }

        //        if modelList.info != nil {
        //            if !(modelList.info!.description.isNilOrEmpty) {
        //                self.productDescriptionLabel.text = modelList.info!.description!.capitalized
        //            }
        //        }
//        self.productImageView.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)


        
        if !(modelList.slug.isNilOrEmpty) {
            slug = modelList.slug!
            if (slug == "discreet"){
                self.productImageView.image = UIImage(named: Asset.lifestylecic)
            } else if (slug == "power-house"){
                self.productImageView.image = UIImage(named: Asset.lifestylebte)
            } else if (slug == "slim"){
                self.productImageView.image = UIImage(named: Asset.lifestyleric)
            } else if (slug == "mini"){
                self.productImageView.image = UIImage(named: Asset.lifestyleitc)
            } else if (slug == "invisible"){
                self.productImageView.image = UIImage(named: Asset.hearzapplaceholder)
            } else if (slug == "in-the-ear"){
                self.productImageView.image = UIImage(named: Asset.hearzapplaceholder)
            }
            else{
                self.productImageView.image = UIImage(named: Asset.hearzapplaceholder)
            }
        }


        if modelList.info != nil {
            self.infoView.isHidden = false
        }

        self.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.colorLiteral.theme_blue_E7F4FF.cgColor
    }
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        self.delegate?.infoButtonPressedHearingAidShopModelCollectionViewCell(senderTag: sender.tag)
    }
    @IBAction func shopNowButtonPressed(_ sender: UIButton) {
        self.delegate?.shopNowButtonPressedHearingAidShopModelCollectionViewCell(senderTag: sender.tag)
    }
}
