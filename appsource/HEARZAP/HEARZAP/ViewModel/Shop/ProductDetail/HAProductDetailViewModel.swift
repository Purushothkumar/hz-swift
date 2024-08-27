//
//  HAProductDetailViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 02/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct HAProductDetailViewModel {
    func getCartList(canShowLoader: Bool, viewCon: HAProductDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CartDetailModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.quantity = ""
                    if json.data!.count > 0 {
                        viewCon.quantity = String(format: "%d", json.data!)
                    }
                    viewCon.setNavigationBar()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postWishlist(canShowLoader: Bool, viewCon: HAProductDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(EditWishlistModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.commonAPICALL(retryAPIID: 2002)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getHearingAidList(canShowLoader: Bool, viewCon: HAProductDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// Image Collection
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// PageControl
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// Product Information
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// Deals View
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// about view
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// Features View
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// Specification View
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// Demo View
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// Box View
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// lifestyle View
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// CM View
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// Accessories title
        let view12 = viewCon.mainStackView.arrangedSubviews[12]// Accessories
        let view13 = viewCon.mainStackView.arrangedSubviews[13]// suggestion title
        let view14 = viewCon.mainStackView.arrangedSubviews[14]// suggestion
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        view6.isHidden = true
        view7.isHidden = true
        view8.isHidden = true
        view9.isHidden = true
        view10.isHidden = true
        view11.isHidden = true
        view12.isHidden = true
        view13.isHidden = true
        view14.isHidden = true
        
        let viewProductInfo0 = viewCon.productInfoStackView.arrangedSubviews[0]// Brand
        let viewProductInfo1 = viewCon.productInfoStackView.arrangedSubviews[1]// Name
        let viewProductInfo2 = viewCon.productInfoStackView.arrangedSubviews[2]// Price
        let viewProductInfo3 = viewCon.productInfoStackView.arrangedSubviews[3]// inclusive text
        let viewProductInfo4 = viewCon.productInfoStackView.arrangedSubviews[4]// Add to cart
        let viewProductInfo5 = viewCon.productInfoStackView.arrangedSubviews[5]// Free home Trail
        let viewProductInfo6 = viewCon.productInfoStackView.arrangedSubviews[6]// empty
        
        viewProductInfo0.isHidden = true
        viewProductInfo1.isHidden = true
        viewProductInfo2.isHidden = true
        viewProductInfo3.isHidden = true
        viewProductInfo4.isHidden = true
        viewProductInfo5.isHidden = true
        viewProductInfo6.isHidden = true
        
        let viewDeal0 = viewCon.productDealsStackView.arrangedSubviews[0]// Brand
        let viewDeal1 = viewCon.productDealsStackView.arrangedSubviews[1]// Name
        let viewDeal2 = viewCon.productDealsStackView.arrangedSubviews[2]// Price
        
        viewDeal0.isHidden = true
        viewDeal1.isHidden = true
        viewDeal2.isHidden = true
        
        let viewAbout0 = viewCon.productAboutStackView.arrangedSubviews[0]// title
        let viewAbout1 = viewCon.productAboutStackView.arrangedSubviews[1]// description
        
        viewAbout0.isHidden = true
        viewAbout1.isHidden = true
        
        let viewLifeStyle0 = viewCon.productLifeStyleStackView.arrangedSubviews[0]// banner
        let viewLifeStyle1 = viewCon.productLifeStyleStackView.arrangedSubviews[1]// message
        let viewLifeStyle2 = viewCon.productLifeStyleStackView.arrangedSubviews[2]// life style list view
        let viewLifeStyle3 = viewCon.productLifeStyleStackView.arrangedSubviews[3]// chart
        let viewLifeStyle4 = viewCon.productLifeStyleStackView.arrangedSubviews[4]// message
        let viewLifeStyle5 = viewCon.productLifeStyleStackView.arrangedSubviews[5]// Know more
        
        viewLifeStyle0.isHidden = false
        viewLifeStyle1.isHidden = false
        viewLifeStyle2.isHidden = false
        viewLifeStyle3.isHidden = false
        viewLifeStyle4.isHidden = false
        viewLifeStyle5.isHidden = true
        
        let viewAccessories0 = viewCon.productAccessoriesStackView.arrangedSubviews[0]// image
        let viewAccessories1 = viewCon.productAccessoriesStackView.arrangedSubviews[1]// list
        let viewAccessories2 = viewCon.productAccessoriesStackView.arrangedSubviews[2]// button
        viewAccessories0.isHidden = true
        viewAccessories1.isHidden = true
        viewAccessories2.isHidden = true
        
        viewCon.addtoCompareButton.isHidden = true
        viewCon.wishlistButton.isHidden = true
        viewCon.setDefaultScrollHeight()
        
        let scrollSelectionStackView0 = viewCon.scrollSelectionStackView.arrangedSubviews[0]// about
        let scrollSelectionStackView1 = viewCon.scrollSelectionStackView.arrangedSubviews[1]// feature
        let scrollSelectionStackView2 = viewCon.scrollSelectionStackView.arrangedSubviews[2]// specification
        let scrollSelectionStackView3 = viewCon.scrollSelectionStackView.arrangedSubviews[2]// compatibility
        
        scrollSelectionStackView0.isHidden = true
        scrollSelectionStackView1.isHidden = true
        scrollSelectionStackView2.isHidden = true
        scrollSelectionStackView3.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HAProductDetailModel.self, from: result as Data)
                if json.data != nil {
                    //                    viewCon.knowMorebool = false
                    viewCon.knowMorebool = true
                    viewCon.canShowCMVideo = false
                    viewCon.canShowDemoVideo = false
                    viewCon.canShowBox = false
                    view0.isHidden = false
                    
                    if json.data!.productLifestyle != nil {
                        viewCon.productLifeStyleArray = json.data!.productLifestyle!
                    }
                    
                    if viewCon.productLifeStyleArray.count > 0 {
                        view9.isHidden = false
                        scrollSelectionStackView3.isHidden = false
                        for item in viewCon.productLifeStyleArray {
                            if item.compatibilityScore != nil {
                                viewCon.compatabilityScoreArray.append(item.compatibilityScore!)
                            }
                            if !(item.lifestyleName.isNilOrEmpty) {
                                viewCon.xaxisArray.append(item.lifestyleName!)
                            }
                        }
                        if (viewCon.compatabilityScoreArray.count > 0) && (viewCon.xaxisArray.count > 0) {
                            viewCon.setChart()
                            viewCon.showHideChartView()
                        }
                    }
                    viewCon.reloadProductLifeStyleTableView()
                    if json.data!.product != nil {
                        view2.isHidden = false
                        viewProductInfo4.isHidden = false
                        viewProductInfo5.isHidden = false
                        viewProductInfo6.isHidden = false
                        
                        if json.data!.product!.id != nil {
                            viewCon.addtoCompareButton.isHidden = false
                            viewCon.productID  = String(format: "%d", json.data!.product!.id!)
                        }
                        if !(json.data!.product!.uid.isNilOrEmpty) {
                            viewCon.productUID  = json.data!.product!.uid!
                        }
                        if !(json.data!.product!.brand.isNilOrEmpty) {
                            viewCon.productBrandLabel.text = json.data!.product!.brand!
                            viewProductInfo0.isHidden = false
                        }
                        if !(json.data!.product!.name.isNilOrEmpty) {
                            viewCon.productNameLabel.text = json.data!.product!.name!
                            viewProductInfo1.isHidden = false
                        }
                        if !(json.data!.product!.category.isNilOrEmpty) {
                            viewCon.categorySlug = json.data!.product!.category!
                        }
                        var productSell = ""
                        var productCost = ""
                        var productDiscount = ""
                        
                        if !(json.data!.product!.unitPrice.isNilOrEmpty) {
                            productCost = String(format: "%@%@", AppConstantValue.rupeesymbol, json.data!.product!.unitPrice!)
                            viewProductInfo2.isHidden = false
                        }
                        if !(json.data!.product!.unitSellingPrice.isNilOrEmpty) {
                            productSell = String(format: "%@%@", AppConstantValue.rupeesymbol, json.data!.product!.unitSellingPrice!)
                            viewProductInfo2.isHidden = false
                        }
                        if json.data!.product!.productDiscount != nil {
                            if json.data!.product!.productDiscount! > 0 {
                                productDiscount = String(format: "%d%% %@", json.data!.product!.productDiscount!, AppLocalizationString.off)
                                viewProductInfo2.isHidden = false
                            }
                        }
                        let combination = NSMutableAttributedString()
                        
                        let sellFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_orange_F7732F, NSAttributedString.Key.font: AppFont.semibold.size(16)]
                        let costFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13), NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                                  NSAttributedString.Key.strikethroughColor: UIColor.colorLiteral.theme_grey_777777] as [NSAttributedString.Key: Any]
                        
                        let discountFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_green_27AE60, NSAttributedString.Key.font: AppFont.regular.size(13)]
                        let offFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_green_27AE60, NSAttributedString.Key.font: AppFont.regular.size(13)] as [NSAttributedString.Key: Any]
                        
                        var sell = NSMutableAttributedString(string: String(format: "%@", productSell), attributes: sellFontAttributes as [NSAttributedString.Key: Any])
                        if !(productCost.isEmpty) || !(productDiscount.isEmpty) {
                            sell = NSMutableAttributedString(string: String(format: "%@ ", productSell), attributes: sellFontAttributes as [NSAttributedString.Key: Any])
                        }
                        let cost = NSMutableAttributedString(string: String(format: "%@", productCost), attributes: costFontAttributes as [NSAttributedString.Key: Any])
                        var discount = NSMutableAttributedString(string: String(format: "%@", productDiscount), attributes: discountFontAttributes as [NSAttributedString.Key: Any])
                        if !(productCost.isEmpty) {
                            discount = NSMutableAttributedString(string: String(format: " %@", productDiscount), attributes: discountFontAttributes as [NSAttributedString.Key: Any])
                        }
                        
                        if !(productSell.isEmpty) {
                            combination.append(sell)
                        }
                        if !(productCost.isEmpty) {
                            combination.append(cost)
                        }
                        if !(productDiscount.isEmpty) {
                            combination.append(discount)
                        }
                        viewCon.productPriceLabel.attributedText = combination
                        viewProductInfo2.isHidden = false
                        
                        viewCon.productTaxLabel.text = AppLocalizationString.inclusiveofalltaxes
                        viewProductInfo3.isHidden = false
                        
                        if  json.data!.product!.isWishlist != nil {
                            viewCon.wishlistButton.isHidden = false
                            viewCon.isWishlist = json.data!.product!.isWishlist!
                        }
                        viewCon.wishlistImageView.image = viewCon.isWishlist == true ? UIImage(named: Asset.heartorangecircle) : UIImage(named: Asset.heartwhitecircle)
                        
                        if !(json.data!.product!.mainImage.isNilOrEmpty) {
                            viewCon.productPhotoArray.append(json.data!.product!.mainImage!)
                        }
                        if !(json.data!.product!.image1.isNilOrEmpty) {
                            viewCon.productPhotoArray.append(json.data!.product!.image1!)
                        }
                        if !(json.data!.product!.image2.isNilOrEmpty) {
                            viewCon.productPhotoArray.append(json.data!.product!.image2!)
                        }
                        if !(json.data!.product!.image3.isNilOrEmpty) {
                            viewCon.productPhotoArray.append(json.data!.product!.image3!)
                        }
                        if !(json.data!.product!.image4.isNilOrEmpty) {
                            viewCon.productPhotoArray.append(json.data!.product!.image4!)
                        }
                        if !(json.data!.product!.image5.isNilOrEmpty) {
                            viewCon.productPhotoArray.append(json.data!.product!.image5!)
                        }
                        if viewCon.productPhotoArray.count > 0 {
                            view0.isHidden = false
                            if viewCon.productPhotoArray.count > 1 {
                                view1.isHidden = false
                            }
                        }
                        if !(json.data!.product!.warrantyInYears.isNilOrEmpty) {
                            viewCon.warrantyInYears  = json.data!.product!.warrantyInYears!
                        }
                        viewCon.returnPeriod = AppLocalizationString.easyReturns
                        viewCon.emiAvailable = AppLocalizationString.easyEMI
                        viewCon.isEmiAvailable = false
                        viewCon.isReturnAvailable = false
                        viewCon.isWarrantyAvailable = false
                        viewCon.isProductAvailable = false
                        
                        if json.data!.product!.isProductAvailable != nil {
                            viewCon.isProductAvailable  = json.data!.product!.isProductAvailable!
                        }
                        viewCon.setAddtoCartButtonColor()
                        var boolArray = [Bool]()
                        
                        if json.data!.product!.isEmiAvailable != nil {
                            viewCon.isEmiAvailable  = json.data!.product!.isEmiAvailable!
                        }
                        if json.data!.product!.isReturnAvailable != nil {
                            viewCon.isReturnAvailable  = json.data!.product!.isReturnAvailable!
                        }
                        if json.data!.product!.isWarrantyAvailable != nil {
                            viewCon.isWarrantyAvailable  = json.data!.product!.isWarrantyAvailable!
                        }
                        if viewCon.isEmiAvailable == true {
                            boolArray.append(viewCon.isEmiAvailable)
                        }
                        if viewCon.isReturnAvailable == true {
                            boolArray.append(viewCon.isReturnAvailable)
                        }
                        if viewCon.isWarrantyAvailable == true {
                            boolArray.append(viewCon.isWarrantyAvailable)
                        }
                        viewCon.productEasyEMIViewWidth.constant = 0
                        viewCon.productEasyReturnViewWidth.constant = 0
                        viewCon.productWarrantyWidth.constant = 0
                        
                        if boolArray.count > 0 {
                            let dealwidth = AppConstantValue.screenWidthminus32 / CGFloat(boolArray.count)
                            if viewCon.isEmiAvailable == true || viewCon.isReturnAvailable == true || viewCon.isWarrantyAvailable == true {
                                view3.isHidden = false
                                if viewCon.isEmiAvailable == true {
                                    viewDeal0.isHidden = false
                                    viewCon.productEasyEMIViewWidth.constant = dealwidth
                                }
                                if viewCon.isWarrantyAvailable == true {
                                    viewDeal1.isHidden = false
                                    viewCon.productWarrantyWidth.constant = dealwidth
                                }
                                if viewCon.isReturnAvailable == true {
                                    viewDeal2.isHidden = false
                                    viewCon.productEasyReturnViewWidth.constant = dealwidth
                                }
                            }
                        }
                        if !(json.data!.product!.description.isNilOrEmpty) {
                            viewCon.about = json.data!.product!.description!
                            if !(viewCon.about.isEmpty) {
                                view4.isHidden = false
                                viewAbout0.isHidden = false
                                viewAbout1.isHidden = false
                                scrollSelectionStackView0.isHidden = false
                                viewCon.reloadWebView()
                            }
                        }
                        if !(json.data!.product!.demoVideo.isNilOrEmpty) {
                            let strVideoLink = json.data!.product!.demoVideo!
                            if !(strVideoLink.isEmpty) {
                                let strVideoLinkID = strVideoLink.extractYoutubeIDFromLink()
                                if !(strVideoLinkID.isNilOrEmpty) {
                                    view7.isHidden = false
                                    viewCon.canShowDemoVideo = true
                                    viewCon.dvYouTubePlayerView.loadVideoID("\(strVideoLinkID!)")
                                }
                            }
                        }
                        if !(json.data!.product!.cmVideo.isNilOrEmpty) {
                            let strVideoLink = json.data!.product!.cmVideo!
                            if !(strVideoLink.isEmpty) {
                                let strVideoLinkID = strVideoLink.extractYoutubeIDFromLink()
                                if !(strVideoLinkID.isNilOrEmpty) {
                                    view10.isHidden = false
                                    viewCon.canShowCMVideo = true
                                    viewCon.cmYouTubePlayerView.loadVideoID("\(strVideoLinkID!)")
                                }
                            }
                        }
                    }
                    viewCon.reloadProductImageCollectionView()
                    viewCon.changeLanguageFormat()
                    
                    if json.data!.productFeatures != nil {
                        viewCon.productFeatureArray = json.data!.productFeatures!
                    }
                    if viewCon.productFeatureArray.count > 0 {
                        view5.isHidden = false
                        scrollSelectionStackView1.isHidden = false
                    }
                    viewCon.reloadProductFeatureTableView()
                    
                    if json.data!.productSpecification != nil {
                        viewCon.productSpecificationArray = json.data!.productSpecification!
                    }
                    if viewCon.productSpecificationArray.count > 0 {
                        view6.isHidden = false
                        scrollSelectionStackView2.isHidden = false
                    }
                    viewCon.reloadProductSpecificationTableView()
                    
                    if json.data!.productBoxing != nil {
                        viewCon.productBoxArray = json.data!.productBoxing!
                    }
                    if viewCon.productBoxArray.count > 0 {
                        viewCon.canShowBox = true
                        view8.isHidden = false
                    }
                    viewCon.reloadProductBoxTableView()
                    
                    //                    viewCon.productAccessoriesArray = self.getProductAccessoriesList()// Accessories
                    //                    if viewCon.productAccessoriesArray.count > 0 {
                    //                        view10.isHidden = false
                    //                        view11.isHidden = false
                    //                        viewAccessories0.isHidden = false
                    //                        viewAccessories1.isHidden = false
                    //                        viewAccessories2.isHidden = false
                    //                        viewCon.productAccessoriesProduct1ImageView.isHidden = true
                    //                        viewCon.productAccessoriesProduct2ImageView.isHidden = true
                    //                        viewCon.productAccessoriesPlus1ImageView.isHidden = true
                    //                        viewCon.productAccessoriesProduct3ImageView.isHidden = true
                    //                        viewCon.productAccessoriesPlus2ImageView.isHidden = true
                    //
                    //                        if viewCon.productAccessoriesArray.count > 0 {
                    //                            viewCon.productAccessoriesProduct1ImageView.isHidden = false
                    //                        }
                    //                        if viewCon.productAccessoriesArray.count > 1 {
                    //                            viewCon.productAccessoriesProduct2ImageView.isHidden = false
                    //                            viewCon.productAccessoriesPlus1ImageView.isHidden = false
                    //                        }
                    //                        if viewCon.productAccessoriesArray.count > 2 {
                    //                            viewCon.productAccessoriesProduct3ImageView.isHidden = false
                    //                            viewCon.productAccessoriesPlus2ImageView.isHidden = false
                    //                        }
                    //                    }
                    //                    viewCon.reloadProductAccessoriesTableView()
                    
                    if json.data!.relatedProducts != nil {
                        viewCon.productSuggestionArray = json.data!.relatedProducts!
                    }
                    if viewCon.productSuggestionArray.count > 0 {
                        view13.isHidden = false
                        view14.isHidden = false
                    }
                    viewCon.reloadProductSuggestionCollectionView()
                    if retryAPIID == 2000 {
                        viewCon.showPopupScreen()
                    } else if retryAPIID == 2001 {
                        viewCon.checkCartVerifiedUserLogo()
                    } else if retryAPIID == 2002 {
                        if viewCon.isWishlist == true {
                            viewCon.showToastAlert(AppLocalizationString.wishListAdded.capitalized, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: viewCon)
                        } else {
                            viewCon.showToastAlert(AppLocalizationString.wishListRemoved.capitalized, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
