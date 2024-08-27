//
//  ShopCategoryViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 08/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct ShopCategoryViewModel {
    func getHearingAidFilterList() -> [HearingAidsFilterList] {
        let array = [HearingAidsFilterList(title: AppLocalizationString.all, showImage: false, imageSelected: "", image: ""),
                     HearingAidsFilterList(title: AppLocalizationString.price, showImage: true, imageSelected: Asset.pricefilterblue, image: Asset.pricefiltergrey),
                     HearingAidsFilterList(title: AppLocalizationString.brands, showImage: false, imageSelected: "", image: ""),
                     HearingAidsFilterList(title: AppLocalizationString.filter, showImage: true, imageSelected: Asset.filterblue, image: Asset.filtergrey)
        ]
        return array
    }
    
    func getAccessoriesFilterList() -> [AccessoriesFilterList] {
        let array = [AccessoriesFilterList(title: AppLocalizationString.all, showImage: false, imageSelected: "", image: ""),
                     AccessoriesFilterList(title: AppLocalizationString.brands, showImage: false, imageSelected: "", image: ""),
                     AccessoriesFilterList(title: AppLocalizationString.filter, showImage: true, imageSelected: Asset.filterblue, image: Asset.filtergrey)
        ]
        return array
    }
    func getNotificationCount(canShowLoader: Bool, viewCon: ShopCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(NotificationCountModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.hasCart = false
                    viewCon.hasAlert = false
                    if json.data!.cart != nil {
                        viewCon.hasCart = json.data!.cart!
                    }
                    if json.data!.alert != nil {
                        viewCon.hasAlert = json.data!.alert!
                    }
                    viewCon.setNavigationBar()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getHearingAidList(canShowLoader: Bool, viewCon: ShopCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        viewCon.timerOffer.invalidate()
        
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// Shop title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Tab view
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// Hearing Aid view
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// Accessories view
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// Compare View
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// offers title View
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// offers View
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// Recently title View
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// Recently View
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// Hearzap Difference title View
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// Hearzap Difference View
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// Shopping guide view
        let view12 = viewCon.mainStackView.arrangedSubviews[12]// compare model view
        let view13 = viewCon.mainStackView.arrangedSubviews[13]// banner1 view
        let view14 = viewCon.mainStackView.arrangedSubviews[14]// banner2 view
        let view15 = viewCon.mainStackView.arrangedSubviews[15]// error view
        
        view0.isHidden = false
        view1.isHidden = false
        view2.isHidden = false
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
        view15.isHidden = true
        viewCon.setDefaultTabSelection()
        
        let hearingAidview0 = viewCon.hearingAidStackView.arrangedSubviews[0]// Tag view
        let hearingAidview1 = viewCon.hearingAidStackView.arrangedSubviews[1]// latest title view
        let hearingAidview2 = viewCon.hearingAidStackView.arrangedSubviews[2]// latest view
        let hearingAidview3 = viewCon.hearingAidStackView.arrangedSubviews[3]// hot deal title view
        let hearingAidview4 = viewCon.hearingAidStackView.arrangedSubviews[4]// hot deal view
        let hearingAidview5 = viewCon.hearingAidStackView.arrangedSubviews[5]// filter list view
        let hearingAidview6 = viewCon.hearingAidStackView.arrangedSubviews[6]// load more
        let hearingAidview7 = viewCon.hearingAidStackView.arrangedSubviews[7]// Price list view
        let hearingAidview8 = viewCon.hearingAidStackView.arrangedSubviews[8]// brand list view
        let hearingAidview9 = viewCon.hearingAidStackView.arrangedSubviews[9]// shop by price title view
        let hearingAidview10 = viewCon.hearingAidStackView.arrangedSubviews[10]// shop by price view
        let hearingAidview11 = viewCon.hearingAidStackView.arrangedSubviews[11]// shop by brand title view
        let hearingAidview12 = viewCon.hearingAidStackView.arrangedSubviews[12]// shop by brand view
        let hearingAidview13 = viewCon.hearingAidStackView.arrangedSubviews[13]// brand type view
        let hearingAidview14 = viewCon.hearingAidStackView.arrangedSubviews[14]// shop by model title view
        let hearingAidview15 = viewCon.hearingAidStackView.arrangedSubviews[15]// shop by model view
        
        hearingAidview0.isHidden = false
        hearingAidview1.isHidden = true
        hearingAidview2.isHidden = true
        hearingAidview3.isHidden = true
        hearingAidview4.isHidden = true
        hearingAidview5.isHidden = true
        hearingAidview6.isHidden = true
        hearingAidview7.isHidden = true
        hearingAidview8.isHidden = true
        hearingAidview9.isHidden = true
        hearingAidview10.isHidden = true
        hearingAidview11.isHidden = true
        hearingAidview12.isHidden = true
        hearingAidview13.isHidden = true
        hearingAidview14.isHidden = true
        hearingAidview15.isHidden = true
        
        viewCon.recentlyViewedArray.removeAll()
        viewCon.offerArray.removeAll()
        viewCon.hearzapDifferenceArray.removeAll()
        viewCon.hearingAidLatestArray.removeAll()
        viewCon.hearingAidHotDealsArray.removeAll()
        viewCon.hearingAidShopBrandarray.removeAll()
        viewCon.hearingAidPriceArray.removeAll()
        viewCon.hearingAidBrandArray.removeAll()
        viewCon.hearingAidShopModelArray.removeAll()
        viewCon.hearingAidPriceListArray.removeAll()
        viewCon.hearingAidBrandListArray.removeAll()
        viewCon.hearingAidFilterProductListArray.removeAll()
        viewCon.accessoriesShopModelArray.removeAll()
        viewCon.accessoriesGreatDealsArray.removeAll()
        viewCon.accessoriesBrandListArray.removeAll()
        viewCon.accessoriesFilterProductListArray.removeAll()
        viewCon.compareProductListArray.removeAll()
        
        viewCon.reloadHearingAidTagCollectionView()
        viewCon.reloadoffersCollectionView()
        viewCon.reloadHearingAidBrandCollectionview()
        viewCon.reloadHearingAidLatestCollectionView()
        viewCon.reloadHearingAidFilterProductCollectionView()
        viewCon.reloadHearingAidHotDealsCollectionView()
        viewCon.reloadHearingAidShopBrandCollectionView()
        viewCon.reloadHearingAidPriceCollectionView()
        viewCon.reloadHearingAidShopModelCollectionView()
        viewCon.reloadHearingAidPriceListTableView()
        viewCon.reloadHearingAidBrandListTableView()
        viewCon.reloadAccessoriesTagCollectionView()
        viewCon.reloadAccessoriesGreatDealsCollectionView()
        viewCon.reloadAccessoriesCategoryCollectionView()
        viewCon.reloadCompareProductTableViewList()
        viewCon.reloadHearzapDifferenceCollectionView()
        viewCon.reloadRecentlyViewedCollectionView()
        viewCon.reloadAccessoriesFilterProductCollectionView()
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HearingAidListModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.tabSelectedIndex = 0
                    viewCon.hearingAidFilterIndex = 0
                    viewCon.accessoriesFilterIndex = 0
                    viewCon.compareIndex = 0
                    viewCon.hearingAidLatestViewAllButton.isHidden = true
                    viewCon.hearingAidHotDealsViewAllButton.isHidden = true
                    viewCon.commonAPICALL(retryAPIID: 5000)
                    viewCon.setTabSelection()
                    viewCon.reloadHearingAidTagCollectionView()
                    viewCon.reloadAccessoriesTagCollectionView()
                    viewCon.styleArraySelected.removeAll()
                    viewCon.brandArraySelected.removeAll()
                    viewCon.featureArraySelected.removeAllObjects()
                    viewCon.specificationArraySelected.removeAllObjects()
                    viewCon.pageNumber = 1
                    viewCon.hasnext = false
                    
                    hearingAidview0.isHidden = false
                    view11.isHidden = false// Shopping guide
                    view13.isHidden = false
                    view14.isHidden = false
                    if !(json.data!.latestTitle.isNilOrEmpty) {
                        viewCon.latestTitle = json.data!.latestTitle!
                    }
                    if !(json.data!.latestDescription.isNilOrEmpty) {
                        viewCon.latestDescription = json.data!.latestDescription!
                    }
                    if !(json.data!.viewallLatest.isNilOrEmpty) {
                        viewCon.viewallLatest = json.data!.viewallLatest!
                        viewCon.hearingAidLatestViewAllButton.isHidden = false
                        viewCon.hearingAidLatestViewAllButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                        viewCon.hearingAidLatestViewAllButton.layer.borderWidth = 1.0
                    }
                    if !(json.data!.hotDealTitle.isNilOrEmpty) {
                        viewCon.hotDealTitle = json.data!.hotDealTitle!
                    }
                    if !(json.data!.hotDealDescription.isNilOrEmpty) {
                        viewCon.hotDealDescription = json.data!.hotDealDescription!
                    }
                    if !(json.data!.viewallHotdeal.isNilOrEmpty) {
                        viewCon.viewallHotdeal = json.data!.viewallHotdeal!
                        viewCon.hearingAidHotDealsViewAllButton.isHidden = false
                        viewCon.hearingAidHotDealsViewAllButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                        viewCon.hearingAidHotDealsViewAllButton.layer.borderWidth = 1.0
                    }
                    if !(json.data!.priceTitle.isNilOrEmpty) {
                        viewCon.priceTitle = json.data!.priceTitle!
                    }
                    if !(json.data!.priceDescription.isNilOrEmpty) {
                        viewCon.priceDescription = json.data!.priceDescription!
                    }
                    if !(json.data!.brandTitle.isNilOrEmpty) {
                        viewCon.brandTitle = json.data!.brandTitle!
                    }
                    if !(json.data!.brandDescription.isNilOrEmpty) {
                        viewCon.brandDescription = json.data!.brandDescription!
                    }
                    if !(json.data!.modelTitle.isNilOrEmpty) {
                        viewCon.modelTitle = json.data!.modelTitle!
                    }
                    if !(json.data!.modelDescription.isNilOrEmpty) {
                        viewCon.modelDescription = json.data!.modelDescription!
                    }
                    viewCon.changeLanguageFormat()
                    if json.data!.latestProducts != nil {
                        viewCon.hearingAidLatestArray = (json.data!.latestProducts)!
                        if viewCon.hearingAidLatestArray.count > 0 {
                            if !(viewCon.latestTitle.isEmpty) || !(viewCon.latestDescription.isEmpty) {
                                hearingAidview1.isHidden = false
                            }
                            hearingAidview2.isHidden = false
                            viewCon.reloadHearingAidLatestCollectionView()
                        }
                    }
                    if json.data!.hotDealProducts != nil {
                        viewCon.hearingAidHotDealsArray = (json.data!.hotDealProducts)!
                        if viewCon.hearingAidHotDealsArray.count > 0 {
                            if !(viewCon.hotDealTitle.isEmpty) || !(viewCon.hotDealDescription.isEmpty) {
                                hearingAidview3.isHidden = false
                            }
                            hearingAidview4.isHidden = false
                            viewCon.reloadHearingAidHotDealsCollectionView()
                        }
                    }
                    if json.data!.priceRangeList != nil {
                        viewCon.hearingAidPriceArray = (json.data!.priceRangeList)!
                        if viewCon.hearingAidPriceArray.count > 0 {
                            if !(viewCon.priceTitle.isEmpty) || !(viewCon.priceDescription.isEmpty) {
                                hearingAidview9.isHidden = false
                            }
                            hearingAidview10.isHidden = false
                            viewCon.reloadHearingAidPriceCollectionView()
                        }
                    }
                    if json.data!.brandList != nil {
                        viewCon.hearingAidBrandArray = (json.data!.brandList)!
                        if viewCon.hearingAidBrandArray.count > 0 {
                            if !(viewCon.brandTitle.isEmpty) || !(viewCon.brandDescription.isEmpty) {
                                hearingAidview11.isHidden = false
                                hearingAidview12.isHidden = false
                            }
                            hearingAidview13.isHidden = false
                            viewCon.reloadHearingAidBrandCollectionview()
                        }
                    }
                    if json.data!.brandList != nil {
                        viewCon.hearingAidShopModelArray = (json.data!.modelList)!
                        if viewCon.hearingAidShopModelArray.count > 0 {
                            if !(viewCon.modelTitle.isEmpty) || !(viewCon.modelDescription.isEmpty) {
                                hearingAidview14.isHidden = false
                            }
                            hearingAidview15.isHidden = false
                            viewCon.reloadHearingAidShopModelCollectionView()
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getHearingAidPriceRangeList(canShowLoader: Bool, viewCon: ShopCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        viewCon.timerOffer.invalidate()
        
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// Shop title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Tab view
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// Hearing Aid view
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// Accessories view
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// Compare View
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// offers title View
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// offers View
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// Recently title View
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// Recently View
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// Hearzap Difference title View
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// Hearzap Difference View
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// Shopping guide view
        let view12 = viewCon.mainStackView.arrangedSubviews[12]// compare model view
        let view13 = viewCon.mainStackView.arrangedSubviews[13]// banner1 view
        let view14 = viewCon.mainStackView.arrangedSubviews[14]// banner2 view
        let view15 = viewCon.mainStackView.arrangedSubviews[15]// error view
        
        view0.isHidden = false
        view1.isHidden = false
        view2.isHidden = false
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
        view15.isHidden = true
        viewCon.setDefaultTabSelection()
        
        let hearingAidview0 = viewCon.hearingAidStackView.arrangedSubviews[0]// Tag view
        let hearingAidview1 = viewCon.hearingAidStackView.arrangedSubviews[1]// latest title view
        let hearingAidview2 = viewCon.hearingAidStackView.arrangedSubviews[2]// latest view
        let hearingAidview3 = viewCon.hearingAidStackView.arrangedSubviews[3]// hot deal title view
        let hearingAidview4 = viewCon.hearingAidStackView.arrangedSubviews[4]// hot deal view
        let hearingAidview5 = viewCon.hearingAidStackView.arrangedSubviews[5]// filter list view
        let hearingAidview6 = viewCon.hearingAidStackView.arrangedSubviews[6]// load more
        let hearingAidview7 = viewCon.hearingAidStackView.arrangedSubviews[7]// Price list view
        let hearingAidview8 = viewCon.hearingAidStackView.arrangedSubviews[8]// brand list view
        let hearingAidview9 = viewCon.hearingAidStackView.arrangedSubviews[9]// shop by price title view
        let hearingAidview10 = viewCon.hearingAidStackView.arrangedSubviews[10]// shop by price view
        let hearingAidview11 = viewCon.hearingAidStackView.arrangedSubviews[11]// shop by brand title view
        let hearingAidview12 = viewCon.hearingAidStackView.arrangedSubviews[12]// shop by brand view
        let hearingAidview13 = viewCon.hearingAidStackView.arrangedSubviews[13]// brand type view
        let hearingAidview14 = viewCon.hearingAidStackView.arrangedSubviews[14]// shop by model title view
        let hearingAidview15 = viewCon.hearingAidStackView.arrangedSubviews[15]// shop by model view
        
        hearingAidview0.isHidden = false
        hearingAidview1.isHidden = true
        hearingAidview2.isHidden = true
        hearingAidview3.isHidden = true
        hearingAidview4.isHidden = true
        hearingAidview5.isHidden = true
        hearingAidview6.isHidden = true
        hearingAidview7.isHidden = true
        hearingAidview8.isHidden = true
        hearingAidview9.isHidden = true
        hearingAidview10.isHidden = true
        hearingAidview11.isHidden = true
        hearingAidview12.isHidden = true
        hearingAidview13.isHidden = true
        hearingAidview14.isHidden = true
        hearingAidview15.isHidden = true
        
        viewCon.recentlyViewedArray.removeAll()
        viewCon.offerArray.removeAll()
        viewCon.hearzapDifferenceArray.removeAll()
        viewCon.hearingAidLatestArray.removeAll()
        viewCon.hearingAidHotDealsArray.removeAll()
        viewCon.hearingAidShopBrandarray.removeAll()
        viewCon.hearingAidPriceArray.removeAll()
        viewCon.hearingAidBrandArray.removeAll()
        viewCon.hearingAidShopModelArray.removeAll()
        viewCon.hearingAidPriceListArray.removeAll()
        viewCon.hearingAidBrandListArray.removeAll()
        viewCon.hearingAidFilterProductListArray.removeAll()
        viewCon.accessoriesShopModelArray.removeAll()
        viewCon.accessoriesGreatDealsArray.removeAll()
        viewCon.accessoriesBrandListArray.removeAll()
        viewCon.accessoriesFilterProductListArray.removeAll()
        viewCon.compareProductListArray.removeAll()
        
        viewCon.reloadHearingAidTagCollectionView()
        viewCon.reloadoffersCollectionView()
        viewCon.reloadHearingAidBrandCollectionview()
        viewCon.reloadHearingAidLatestCollectionView()
        viewCon.reloadHearingAidFilterProductCollectionView()
        viewCon.reloadHearingAidHotDealsCollectionView()
        viewCon.reloadHearingAidShopBrandCollectionView()
        viewCon.reloadHearingAidPriceCollectionView()
        viewCon.reloadHearingAidShopModelCollectionView()
        viewCon.reloadHearingAidPriceListTableView()
        viewCon.reloadHearingAidBrandListTableView()
        viewCon.reloadAccessoriesTagCollectionView()
        viewCon.reloadAccessoriesGreatDealsCollectionView()
        viewCon.reloadAccessoriesCategoryCollectionView()
        viewCon.reloadCompareProductTableViewList()
        viewCon.reloadHearzapDifferenceCollectionView()
        viewCon.reloadRecentlyViewedCollectionView()
        viewCon.reloadAccessoriesFilterProductCollectionView()
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HearingAidPriceRangeListModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.tabSelectedIndex = 0
                    viewCon.hearingAidFilterIndex = 1
                    viewCon.accessoriesFilterIndex = 0
                    viewCon.compareIndex = 0
                    viewCon.commonAPICALL(retryAPIID: 5001)
                    viewCon.setTabSelection()
                    viewCon.reloadHearingAidTagCollectionView()
                    viewCon.reloadAccessoriesTagCollectionView()
                    viewCon.styleArraySelected.removeAll()
                    viewCon.brandArraySelected.removeAll()
                    viewCon.featureArraySelected.removeAllObjects()
                    viewCon.specificationArraySelected.removeAllObjects()
                    viewCon.pageNumber = 1
                    viewCon.hasnext = false
                    
                    hearingAidview0.isHidden = false
                    view11.isHidden = false// Shopping guide
                    view13.isHidden = false
                    view14.isHidden = false
                    if json.data!.priceRangeList != nil {
                        if json.data!.priceRangeList!.count > 0 {
                            for item in json.data!.priceRangeList! {
                                if item.products != nil {
                                    if item.products!.count > 0 {
                                        viewCon.hearingAidPriceListArray.append(item)
                                    }
                                }
                            }
                        }
                        if viewCon.hearingAidPriceListArray.count > 0 {
                            hearingAidview7.isHidden = false
                            viewCon.reloadHearingAidPriceListTableView()
                        }
                    }
                    if json.data!.brandList != nil {
                        viewCon.hearingAidBrandArray = (json.data!.brandList)!
                        if viewCon.hearingAidBrandArray.count > 0 {
                            if !(viewCon.brandTitle.isEmpty) || !(viewCon.brandDescription.isEmpty) {
                                hearingAidview11.isHidden = false
                                hearingAidview12.isHidden = false
                            }
                            hearingAidview13.isHidden = false
                            viewCon.reloadHearingAidBrandCollectionview()
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getHearingAidBrandList(canShowLoader: Bool, viewCon: ShopCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        viewCon.timerOffer.invalidate()
        
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// Shop title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Tab view
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// Hearing Aid view
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// Accessories view
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// Compare View
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// offers title View
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// offers View
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// Recently title View
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// Recently View
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// Hearzap Difference title View
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// Hearzap Difference View
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// Shopping guide view
        let view12 = viewCon.mainStackView.arrangedSubviews[12]// compare model view
        let view13 = viewCon.mainStackView.arrangedSubviews[13]// banner1 view
        let view14 = viewCon.mainStackView.arrangedSubviews[14]// banner2 view
        let view15 = viewCon.mainStackView.arrangedSubviews[15]// error view
        
        view0.isHidden = false
        view1.isHidden = false
        view2.isHidden = false
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
        view15.isHidden = true
        viewCon.setDefaultTabSelection()
        
        let hearingAidview0 = viewCon.hearingAidStackView.arrangedSubviews[0]// Tag view
        let hearingAidview1 = viewCon.hearingAidStackView.arrangedSubviews[1]// latest title view
        let hearingAidview2 = viewCon.hearingAidStackView.arrangedSubviews[2]// latest view
        let hearingAidview3 = viewCon.hearingAidStackView.arrangedSubviews[3]// hot deal title view
        let hearingAidview4 = viewCon.hearingAidStackView.arrangedSubviews[4]// hot deal view
        let hearingAidview5 = viewCon.hearingAidStackView.arrangedSubviews[5]// filter list view
        let hearingAidview6 = viewCon.hearingAidStackView.arrangedSubviews[6]// load more
        let hearingAidview7 = viewCon.hearingAidStackView.arrangedSubviews[7]// Price list view
        let hearingAidview8 = viewCon.hearingAidStackView.arrangedSubviews[8]// brand list view
        let hearingAidview9 = viewCon.hearingAidStackView.arrangedSubviews[9]// shop by price title view
        let hearingAidview10 = viewCon.hearingAidStackView.arrangedSubviews[10]// shop by price view
        let hearingAidview11 = viewCon.hearingAidStackView.arrangedSubviews[11]// shop by brand title view
        let hearingAidview12 = viewCon.hearingAidStackView.arrangedSubviews[12]// shop by brand view
        let hearingAidview13 = viewCon.hearingAidStackView.arrangedSubviews[13]// brand type view
        let hearingAidview14 = viewCon.hearingAidStackView.arrangedSubviews[14]// shop by model title view
        let hearingAidview15 = viewCon.hearingAidStackView.arrangedSubviews[15]// shop by model view
        
        hearingAidview0.isHidden = false
        hearingAidview1.isHidden = true
        hearingAidview2.isHidden = true
        hearingAidview3.isHidden = true
        hearingAidview4.isHidden = true
        hearingAidview5.isHidden = true
        hearingAidview6.isHidden = true
        hearingAidview7.isHidden = true
        hearingAidview8.isHidden = true
        hearingAidview9.isHidden = true
        hearingAidview10.isHidden = true
        hearingAidview11.isHidden = true
        hearingAidview12.isHidden = true
        hearingAidview13.isHidden = true
        hearingAidview14.isHidden = true
        hearingAidview15.isHidden = true
        
        viewCon.recentlyViewedArray.removeAll()
        viewCon.offerArray.removeAll()
        viewCon.hearzapDifferenceArray.removeAll()
        viewCon.hearingAidLatestArray.removeAll()
        viewCon.hearingAidHotDealsArray.removeAll()
        viewCon.hearingAidShopBrandarray.removeAll()
        viewCon.hearingAidPriceArray.removeAll()
        viewCon.hearingAidBrandArray.removeAll()
        viewCon.hearingAidShopModelArray.removeAll()
        viewCon.hearingAidPriceListArray.removeAll()
        viewCon.hearingAidBrandListArray.removeAll()
        viewCon.hearingAidFilterProductListArray.removeAll()
        viewCon.accessoriesShopModelArray.removeAll()
        viewCon.accessoriesGreatDealsArray.removeAll()
        viewCon.accessoriesBrandListArray.removeAll()
        viewCon.accessoriesFilterProductListArray.removeAll()
        viewCon.compareProductListArray.removeAll()
        
        viewCon.reloadHearingAidTagCollectionView()
        viewCon.reloadoffersCollectionView()
        viewCon.reloadHearingAidBrandCollectionview()
        viewCon.reloadHearingAidLatestCollectionView()
        viewCon.reloadHearingAidFilterProductCollectionView()
        viewCon.reloadHearingAidHotDealsCollectionView()
        viewCon.reloadHearingAidShopBrandCollectionView()
        viewCon.reloadHearingAidPriceCollectionView()
        viewCon.reloadHearingAidShopModelCollectionView()
        viewCon.reloadHearingAidPriceListTableView()
        viewCon.reloadHearingAidBrandListTableView()
        viewCon.reloadAccessoriesTagCollectionView()
        viewCon.reloadAccessoriesGreatDealsCollectionView()
        viewCon.reloadAccessoriesCategoryCollectionView()
        viewCon.reloadCompareProductTableViewList()
        viewCon.reloadHearzapDifferenceCollectionView()
        viewCon.reloadRecentlyViewedCollectionView()
        viewCon.reloadAccessoriesFilterProductCollectionView()
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HearingAidBrandListModel.self, from: result as Data)
                if json.data != nil {
                    
                    viewCon.tabSelectedIndex = 0
                    viewCon.hearingAidFilterIndex = 2
                    viewCon.accessoriesFilterIndex = 0
                    viewCon.compareIndex = 0
                    viewCon.commonAPICALL(retryAPIID: 5001)
                    viewCon.setTabSelection()
                    viewCon.reloadHearingAidTagCollectionView()
                    viewCon.reloadAccessoriesTagCollectionView()
                    viewCon.styleArraySelected.removeAll()
                    viewCon.brandArraySelected.removeAll()
                    viewCon.featureArraySelected.removeAllObjects()
                    viewCon.specificationArraySelected.removeAllObjects()
                    viewCon.pageNumber = 1
                    viewCon.hasnext = false
                    
                    hearingAidview0.isHidden = false
                    view11.isHidden = false// Shopping guide
                    view13.isHidden = false
                    view14.isHidden = false
                    if json.data!.brandList != nil {
                        if json.data!.brandList!.count > 0 {
                            for item in json.data!.brandList! {
                                if item.products != nil {
                                    if item.products!.count > 0 {
                                        viewCon.hearingAidBrandListArray.append(item)
                                    }
                                }
                            }
                        }
                        if viewCon.hearingAidBrandListArray.count > 0 {
                            hearingAidview8.isHidden = false
                            viewCon.reloadHearingAidBrandListTableView()
                        }
                    }
                    if json.data!.priceRangeList != nil {
                        viewCon.hearingAidPriceArray = json.data!.priceRangeList!
                        if viewCon.hearingAidPriceArray.count > 0 {
                            if !(viewCon.priceTitle.isEmpty) || !(viewCon.priceDescription.isEmpty) {
                                hearingAidview9.isHidden = false
                            }
                            hearingAidview10.isHidden = false
                            viewCon.reloadHearingAidPriceCollectionView()
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getAccessoriesList(canShowLoader: Bool, viewCon: ShopCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        viewCon.timerOffer.invalidate()
        
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// Shop title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Tab view
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// Hearing Aid view
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// Accessories view
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// Compare View
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// offers title View
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// offers View
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// Recently title View
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// Recently View
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// Hearzap Difference title View
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// Hearzap Difference View
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// Shopping guide view
        let view12 = viewCon.mainStackView.arrangedSubviews[12]// compare model view
        let view13 = viewCon.mainStackView.arrangedSubviews[13]// banner1 view
        let view14 = viewCon.mainStackView.arrangedSubviews[14]// banner2 view
        let view15 = viewCon.mainStackView.arrangedSubviews[15]// error view
        
        view0.isHidden = false
        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = false
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
        view15.isHidden = true
        viewCon.setDefaultTabSelection()
        
        let accessoriesview0 = viewCon.accessoriesStackView.arrangedSubviews[0]// Tag view
        let accessoriesview1 = viewCon.accessoriesStackView.arrangedSubviews[1]// great deals title view
        let accessoriesview2 = viewCon.accessoriesStackView.arrangedSubviews[2]// great deals view
        let accessoriesview3 = viewCon.accessoriesStackView.arrangedSubviews[3]// categories
        let accessoriesview4 = viewCon.accessoriesStackView.arrangedSubviews[4]// filter list view
        let accessoriesview5 = viewCon.accessoriesStackView.arrangedSubviews[5]// load more
        let accessoriesview6 = viewCon.accessoriesStackView.arrangedSubviews[6]// brandlist
        
        accessoriesview0.isHidden = false
        accessoriesview1.isHidden = true
        accessoriesview2.isHidden = true
        accessoriesview3.isHidden = true
        accessoriesview4.isHidden = true
        accessoriesview5.isHidden = true
        accessoriesview6.isHidden = true
        
        viewCon.recentlyViewedArray.removeAll()
        viewCon.offerArray.removeAll()
        viewCon.hearzapDifferenceArray.removeAll()
        viewCon.hearingAidLatestArray.removeAll()
        viewCon.hearingAidHotDealsArray.removeAll()
        viewCon.hearingAidShopBrandarray.removeAll()
        viewCon.hearingAidPriceArray.removeAll()
        viewCon.hearingAidBrandArray.removeAll()
        viewCon.hearingAidShopModelArray.removeAll()
        viewCon.hearingAidPriceListArray.removeAll()
        viewCon.hearingAidBrandListArray.removeAll()
        viewCon.hearingAidFilterProductListArray.removeAll()
        viewCon.accessoriesShopModelArray.removeAll()
        viewCon.accessoriesGreatDealsArray.removeAll()
        viewCon.accessoriesBrandListArray.removeAll()
        viewCon.accessoriesFilterProductListArray.removeAll()
        viewCon.compareProductListArray.removeAll()
        
        viewCon.reloadHearingAidTagCollectionView()
        viewCon.reloadoffersCollectionView()
        viewCon.reloadHearingAidBrandCollectionview()
        viewCon.reloadHearingAidLatestCollectionView()
        viewCon.reloadHearingAidFilterProductCollectionView()
        viewCon.reloadHearingAidHotDealsCollectionView()
        viewCon.reloadHearingAidShopBrandCollectionView()
        viewCon.reloadHearingAidPriceCollectionView()
        viewCon.reloadHearingAidShopModelCollectionView()
        viewCon.reloadHearingAidPriceListTableView()
        viewCon.reloadHearingAidBrandListTableView()
        viewCon.reloadAccessoriesTagCollectionView()
        viewCon.reloadAccessoriesGreatDealsCollectionView()
        viewCon.reloadAccessoriesCategoryCollectionView()
        viewCon.reloadCompareProductTableViewList()
        viewCon.reloadHearzapDifferenceCollectionView()
        viewCon.reloadRecentlyViewedCollectionView()
        viewCon.reloadAccessoriesFilterProductCollectionView()
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(AccessoriesListModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.tabSelectedIndex = 1
                    viewCon.hearingAidFilterIndex = 0
                    viewCon.accessoriesFilterIndex = 0
                    viewCon.compareIndex = 0
                    viewCon.setTabSelection()
                    viewCon.reloadHearingAidTagCollectionView()
                    viewCon.reloadAccessoriesTagCollectionView()
                    viewCon.styleArraySelected.removeAll()
                    viewCon.brandArraySelected.removeAll()
                    viewCon.featureArraySelected.removeAllObjects()
                    viewCon.specificationArraySelected.removeAllObjects()
                    viewCon.pageNumber = 1
                    viewCon.hasnext = false
                    viewCon.commonAPICALL(retryAPIID: 5001)
                    
                    if !(json.data!.hotDealTitle.isNilOrEmpty) {
                        viewCon.greatDealTitle = json.data!.hotDealTitle!
                    }
                    if !(json.data!.hotDealDescription.isNilOrEmpty) {
                        viewCon.greatDealDescription = json.data!.hotDealDescription!
                    }
                    if !(json.data!.viewallHotdeal.isNilOrEmpty) {
                        viewCon.viewallHotdealAccessories = json.data!.viewallHotdeal!
                        viewCon.accessoriesGreatDealsViewAllButton.isHidden = false
                        viewCon.accessoriesGreatDealsViewAllButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                        viewCon.accessoriesGreatDealsViewAllButton.layer.borderWidth = 1.0
                    }
                    viewCon.changeLanguageFormat()
                    if json.data!.hotDealProducts != nil {
                        viewCon.accessoriesGreatDealsArray = json.data!.hotDealProducts!
                        if viewCon.accessoriesGreatDealsArray.count > 0 {
                            if !(viewCon.greatDealTitle.isEmpty) || !(viewCon.greatDealDescription.isEmpty) {
                                accessoriesview1.isHidden = false
                            }
                            accessoriesview2.isHidden = false
                            viewCon.reloadAccessoriesGreatDealsCollectionView()
                        }
                    }
                    if json.data!.modelList != nil {
                        viewCon.accessoriesShopModelArray = json.data!.modelList!
                        if viewCon.accessoriesShopModelArray.count > 0 {
                            accessoriesview3.isHidden = false
                            viewCon.reloadAccessoriesCategoryCollectionView()
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getAccessoriesBrandList(canShowLoader: Bool, viewCon: ShopCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        viewCon.timerOffer.invalidate()
        
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// Shop title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Tab view
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// Hearing Aid view
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// Accessories view
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// Compare View
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// offers title View
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// offers View
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// Recently title View
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// Recently View
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// Hearzap Difference title View
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// Hearzap Difference View
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// Shopping guide view
        let view12 = viewCon.mainStackView.arrangedSubviews[12]// compare model view
        let view13 = viewCon.mainStackView.arrangedSubviews[13]// banner1 view
        let view14 = viewCon.mainStackView.arrangedSubviews[14]// banner2 view
        let view15 = viewCon.mainStackView.arrangedSubviews[15]// error view
        
        view0.isHidden = false
        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = false
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
        view15.isHidden = true
        viewCon.setDefaultTabSelection()
        
        let accessoriesview0 = viewCon.accessoriesStackView.arrangedSubviews[0]// Tag view
        let accessoriesview1 = viewCon.accessoriesStackView.arrangedSubviews[1]// great deals title view
        let accessoriesview2 = viewCon.accessoriesStackView.arrangedSubviews[2]// great deals view
        let accessoriesview3 = viewCon.accessoriesStackView.arrangedSubviews[3]// categories
        let accessoriesview4 = viewCon.accessoriesStackView.arrangedSubviews[4]// filter list view
        let accessoriesview5 = viewCon.accessoriesStackView.arrangedSubviews[5]// load more
        let accessoriesview6 = viewCon.accessoriesStackView.arrangedSubviews[6]// brandlist
        accessoriesview0.isHidden = false
        accessoriesview1.isHidden = true
        accessoriesview2.isHidden = true
        accessoriesview3.isHidden = true
        accessoriesview4.isHidden = true
        accessoriesview5.isHidden = true
        accessoriesview6.isHidden = true
        
        viewCon.recentlyViewedArray.removeAll()
        viewCon.offerArray.removeAll()
        viewCon.hearzapDifferenceArray.removeAll()
        viewCon.hearingAidLatestArray.removeAll()
        viewCon.hearingAidHotDealsArray.removeAll()
        viewCon.hearingAidShopBrandarray.removeAll()
        viewCon.hearingAidPriceArray.removeAll()
        viewCon.hearingAidBrandArray.removeAll()
        viewCon.hearingAidShopModelArray.removeAll()
        viewCon.hearingAidPriceListArray.removeAll()
        viewCon.hearingAidBrandListArray.removeAll()
        viewCon.hearingAidFilterProductListArray.removeAll()
        viewCon.accessoriesShopModelArray.removeAll()
        viewCon.accessoriesGreatDealsArray.removeAll()
        viewCon.accessoriesBrandListArray.removeAll()
        viewCon.accessoriesFilterProductListArray.removeAll()
        viewCon.compareProductListArray.removeAll()
        
        viewCon.reloadHearingAidTagCollectionView()
        viewCon.reloadoffersCollectionView()
        viewCon.reloadHearingAidBrandCollectionview()
        viewCon.reloadHearingAidLatestCollectionView()
        viewCon.reloadHearingAidFilterProductCollectionView()
        viewCon.reloadHearingAidHotDealsCollectionView()
        viewCon.reloadHearingAidShopBrandCollectionView()
        viewCon.reloadHearingAidPriceCollectionView()
        viewCon.reloadHearingAidShopModelCollectionView()
        viewCon.reloadHearingAidPriceListTableView()
        viewCon.reloadHearingAidBrandListTableView()
        viewCon.reloadAccessoriesTagCollectionView()
        viewCon.reloadAccessoriesGreatDealsCollectionView()
        viewCon.reloadAccessoriesCategoryCollectionView()
        viewCon.reloadCompareProductTableViewList()
        viewCon.reloadHearzapDifferenceCollectionView()
        viewCon.reloadRecentlyViewedCollectionView()
        viewCon.reloadAccessoriesFilterProductCollectionView()
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(AccessoriesBrandListModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.tabSelectedIndex = 1
                    viewCon.hearingAidFilterIndex = 0
                    viewCon.accessoriesFilterIndex = 1
                    viewCon.compareIndex = 0
                    viewCon.setTabSelection()
                    viewCon.reloadHearingAidTagCollectionView()
                    viewCon.reloadAccessoriesTagCollectionView()
                    viewCon.styleArraySelected.removeAll()
                    viewCon.brandArraySelected.removeAll()
                    viewCon.featureArraySelected.removeAllObjects()
                    viewCon.specificationArraySelected.removeAllObjects()
                    viewCon.pageNumber = 1
                    viewCon.hasnext = false
                    viewCon.commonAPICALL(retryAPIID: 5001)
                    viewCon.changeLanguageFormat()
                    if json.data!.brandList != nil {
                        viewCon.accessoriesBrandListArray = json.data!.brandList!
                        if viewCon.accessoriesBrandListArray.count > 0 {
                            accessoriesview6.isHidden = false
                            viewCon.reloadAccessoriesBrandListTableView()
                        } else {
                            accessoriesview5.isHidden = false
                            viewCon.reloadAccessoriesBrandListTableView()
                        }
                    }
                    
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getCompareList(canShowLoader: Bool, viewCon: ShopCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        viewCon.timerOffer.invalidate()
        
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// Shop title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Tab view
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// Hearing Aid view
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// Accessories view
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// Compare View
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// offers title View
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// offers View
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// Recently title View
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// Recently View
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// Hearzap Difference title View
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// Hearzap Difference View
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// Shopping guide view
        let view12 = viewCon.mainStackView.arrangedSubviews[12]// compare model view
        let view13 = viewCon.mainStackView.arrangedSubviews[13]// banner1 view
        let view14 = viewCon.mainStackView.arrangedSubviews[14]// banner2 view
        let view15 = viewCon.mainStackView.arrangedSubviews[15]// error view
        
        view0.isHidden = false
        view1.isHidden = false
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
        view15.isHidden = true
        viewCon.setDefaultTabSelection()
        
        let compareDeviceview0 = viewCon.compareStackView.arrangedSubviews[0]// compare device title view
        let compareDeviceview1 = viewCon.compareStackView.arrangedSubviews[1]// compare device view
        let compareDeviceview2 = viewCon.compareStackView.arrangedSubviews[2]// compare device by brand title view
        let compareDeviceview3 = viewCon.compareStackView.arrangedSubviews[3]// compare device by brand view
        
        compareDeviceview0.isHidden = true
        compareDeviceview1.isHidden = true
        compareDeviceview2.isHidden = true
        compareDeviceview3.isHidden = true
        
        let compareContentview0 = viewCon.compareContentStackView.arrangedSubviews[0]// compare add model/imageview
        let compareContentview1 = viewCon.compareContentStackView.arrangedSubviews[1]// compare productInfo
        let compareContentview2 = viewCon.compareContentStackView.arrangedSubviews[2]// compare add to compare
        
        compareContentview0.isHidden = true
        compareContentview1.isHidden = true
        compareContentview2.isHidden = true
        
        viewCon.recentlyViewedArray.removeAll()
        viewCon.offerArray.removeAll()
        viewCon.hearzapDifferenceArray.removeAll()
        viewCon.hearingAidLatestArray.removeAll()
        viewCon.hearingAidHotDealsArray.removeAll()
        viewCon.hearingAidShopBrandarray.removeAll()
        viewCon.hearingAidPriceArray.removeAll()
        viewCon.hearingAidBrandArray.removeAll()
        viewCon.hearingAidShopModelArray.removeAll()
        viewCon.hearingAidPriceListArray.removeAll()
        viewCon.hearingAidBrandListArray.removeAll()
        viewCon.hearingAidFilterProductListArray.removeAll()
        viewCon.accessoriesShopModelArray.removeAll()
        viewCon.accessoriesGreatDealsArray.removeAll()
        viewCon.accessoriesBrandListArray.removeAll()
        viewCon.accessoriesFilterProductListArray.removeAll()
        viewCon.compareProductListArray.removeAll()
        
        viewCon.reloadHearingAidTagCollectionView()
        viewCon.reloadoffersCollectionView()
        viewCon.reloadHearingAidBrandCollectionview()
        viewCon.reloadHearingAidLatestCollectionView()
        viewCon.reloadHearingAidFilterProductCollectionView()
        viewCon.reloadHearingAidHotDealsCollectionView()
        viewCon.reloadHearingAidShopBrandCollectionView()
        viewCon.reloadHearingAidPriceCollectionView()
        viewCon.reloadHearingAidShopModelCollectionView()
        viewCon.reloadHearingAidPriceListTableView()
        viewCon.reloadHearingAidBrandListTableView()
        viewCon.reloadAccessoriesTagCollectionView()
        viewCon.reloadAccessoriesGreatDealsCollectionView()
        viewCon.reloadAccessoriesCategoryCollectionView()
        viewCon.reloadCompareProductTableViewList()
        viewCon.reloadHearzapDifferenceCollectionView()
        viewCon.reloadRecentlyViewedCollectionView()
        viewCon.reloadAccessoriesFilterProductCollectionView()
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CompareListModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.tabSelectedIndex = 2
                    viewCon.hearingAidFilterIndex = 0
                    viewCon.accessoriesFilterIndex = 0
                    viewCon.compareIndex = 0
                    viewCon.changeLanguageFormat()
                    viewCon.setTabSelection()
                    viewCon.reloadHearingAidTagCollectionView()
                    viewCon.reloadAccessoriesTagCollectionView()
                    viewCon.styleArraySelected.removeAll()
                    viewCon.brandArraySelected.removeAll()
                    viewCon.featureArraySelected.removeAllObjects()
                    viewCon.specificationArraySelected.removeAllObjects()
                    viewCon.pageNumber = 1
                    viewCon.hasnext = false
                    viewCon.commonAPICALL(retryAPIID: 5001)
                    view4.isHidden = false
                    view11.isHidden = false// Shopping guide
                    view13.isHidden = false
                    view14.isHidden = false
                    viewCon.compareBannerImageViewHeight.constant = CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(AppConstantValue.screen160slash375)
                    compareDeviceview0.isHidden = false
                    compareDeviceview1.isHidden = false
                    viewCon.versusView.layer.cornerRadius = viewCon.versusView.frame.height / 2
                    viewCon.versusView.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
                    viewCon.versusView.layer.borderWidth = 1.0
                    viewCon.compareBackgroundView.layer.cornerRadius = AppConstantValue.cornerRadius4
                    viewCon.compareBackgroundView.clipsToBounds = true
                    viewCon.banner1ImageView.layer.cornerRadius = AppConstantValue.cornerRadius4
                    viewCon.banner1ImageView.clipsToBounds = true
                    viewCon.banner1ImageView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
                    viewCon.banner1ImageView.layer.borderWidth = 1.0
                    viewCon.addModel1View.layer.cornerRadius = AppConstantValue.cornerRadius4
                    viewCon.addModel1View.clipsToBounds = true
                    viewCon.addModel1View.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
                    viewCon.addModel1View.layer.borderWidth = 1.0
                    viewCon.banner2ImageView.layer.cornerRadius = AppConstantValue.cornerRadius4
                    viewCon.banner2ImageView.clipsToBounds = true
                    viewCon.banner2ImageView.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
                    viewCon.banner2ImageView.layer.borderWidth = 1.0
                    viewCon.addModel2View.layer.cornerRadius = AppConstantValue.cornerRadius4
                    viewCon.addModel2View.clipsToBounds = true
                    viewCon.addModel2View.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
                    viewCon.addModel2View.layer.borderWidth = 1.0
                    viewCon.bannerImageViewHeight.constant = 139 * (screenFrameHeight/AppConstantValue.defaultDesignScreenHeight)
                    viewCon.brandName1Label.text = ""
                    viewCon.brandName2Label.text = ""
                    viewCon.productName1Label.text = ""
                    viewCon.productName2Label.text = ""
                    viewCon.price1Label.text = ""
                    viewCon.price2Label.text = ""
                    compareDeviceview2.isHidden = false
                    compareContentview0.isHidden = false
                    
                    if json.data!.productComparisonHistory != nil {
                        viewCon.compareProductListArray = json.data!.productComparisonHistory!
                        if viewCon.compareProductListArray.count > 0 {
                            compareDeviceview3.isHidden = false
                        }
                    }
                    viewCon.reloadCompareProductTableViewList()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getShopOffersList(canShowLoader: Bool, viewCon: ShopCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// offers title View
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// offers View
        view5.isHidden = true
        view6.isHidden = true
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ShopOfferModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.offerArray.removeAll()
                    viewCon.hearzapDifferenceArray.removeAll()
                    viewCon.commonAPICALL(retryAPIID: 5001)
                    if !(json.data!.title.isNilOrEmpty) {
                        viewCon.offerTitle = json.data!.title!
                    }
                    if !(json.data!.dataDescription.isNilOrEmpty) {
                        viewCon.offerDescription = json.data!.dataDescription!
                    }
                    viewCon.changeLanguageFormat()
                    if json.data!.offerList != nil {
                        viewCon.offerArray = (json.data!.offerList)!
                        if viewCon.offerArray.count > 0 {
                            if !(viewCon.offerTitle.isEmpty) || !(viewCon.offerDescription.isEmpty) {
                                view5.isHidden = false
                            }
                            view6.isHidden = false
                            viewCon.reloadoffersCollectionView()
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getShopHearzapDifferenceList(canShowLoader: Bool, viewCon: ShopCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// Hearzap Difference title View
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// Hearzap Difference View
        view9.isHidden = true
        view10.isHidden = true
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ShopHearzapDifferenceModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.hearzapDifferenceArray.removeAll()
                    if !(json.data!.title.isNilOrEmpty) {
                        viewCon.hearzapDifferenceTitle = json.data!.title!
                    }
                    if !(json.data!.dataDescription.isNilOrEmpty) {
                        viewCon.hearzapDifferenceDescription = json.data!.dataDescription!
                    }
                    viewCon.changeLanguageFormat()
                    if json.data!.results != nil {
                        viewCon.hearzapDifferenceArray = (json.data!.results)!
                        if viewCon.hearzapDifferenceArray.count > 0 {
                            if !(viewCon.hearzapDifferenceTitle.isEmpty) || !(viewCon.hearzapDifferenceDescription.isEmpty) {
                                view9.isHidden = false
                            }
                            view10.isHidden = false
                            viewCon.reloadHearzapDifferenceCollectionView()
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postHearingAidProductFilterList(canShowLoader: Bool, viewCon: ShopCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        viewCon.timerOffer.invalidate()
        
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// Shop title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Tab view
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// Hearing Aid view
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// Accessories view
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// Compare View
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// offers title View
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// offers View
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// Recently title View
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// Recently View
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// Hearzap Difference title View
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// Hearzap Difference View
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// Shopping guide view
        let view12 = viewCon.mainStackView.arrangedSubviews[12]// compare model view
        let view13 = viewCon.mainStackView.arrangedSubviews[13]// banner1 view
        let view14 = viewCon.mainStackView.arrangedSubviews[14]// banner2 view
        let view15 = viewCon.mainStackView.arrangedSubviews[15]// error view
        
        view0.isHidden = false
        view1.isHidden = false
        view2.isHidden = false
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
        view15.isHidden = true
        viewCon.setDefaultTabSelection()
        
        let hearingAidview0 = viewCon.hearingAidStackView.arrangedSubviews[0]// Tag view
        let hearingAidview1 = viewCon.hearingAidStackView.arrangedSubviews[1]// latest title view
        let hearingAidview2 = viewCon.hearingAidStackView.arrangedSubviews[2]// latest view
        let hearingAidview3 = viewCon.hearingAidStackView.arrangedSubviews[3]// hot deal title view
        let hearingAidview4 = viewCon.hearingAidStackView.arrangedSubviews[4]// hot deal view
        let hearingAidview5 = viewCon.hearingAidStackView.arrangedSubviews[5]// filter list view
        let hearingAidview6 = viewCon.hearingAidStackView.arrangedSubviews[6]// load more
        let hearingAidview7 = viewCon.hearingAidStackView.arrangedSubviews[7]// Price list view
        let hearingAidview8 = viewCon.hearingAidStackView.arrangedSubviews[8]// brand list view
        let hearingAidview9 = viewCon.hearingAidStackView.arrangedSubviews[9]// shop by price title view
        let hearingAidview10 = viewCon.hearingAidStackView.arrangedSubviews[10]// shop by price view
        let hearingAidview11 = viewCon.hearingAidStackView.arrangedSubviews[11]// shop by brand title view
        let hearingAidview12 = viewCon.hearingAidStackView.arrangedSubviews[12]// shop by brand view
        let hearingAidview13 = viewCon.hearingAidStackView.arrangedSubviews[13]// brand type view
        let hearingAidview14 = viewCon.hearingAidStackView.arrangedSubviews[14]// shop by model title view
        let hearingAidview15 = viewCon.hearingAidStackView.arrangedSubviews[15]// shop by model view
        
        hearingAidview0.isHidden = false
        hearingAidview1.isHidden = true
        hearingAidview2.isHidden = true
        hearingAidview3.isHidden = true
        hearingAidview4.isHidden = true
        hearingAidview5.isHidden = true
        hearingAidview6.isHidden = true
        hearingAidview7.isHidden = true
        hearingAidview8.isHidden = true
        hearingAidview9.isHidden = true
        hearingAidview10.isHidden = true
        hearingAidview11.isHidden = true
        hearingAidview12.isHidden = true
        hearingAidview13.isHidden = true
        hearingAidview14.isHidden = true
        hearingAidview15.isHidden = true
        
        viewCon.recentlyViewedArray.removeAll()
        viewCon.offerArray.removeAll()
        viewCon.hearzapDifferenceArray.removeAll()
        viewCon.hearingAidLatestArray.removeAll()
        viewCon.hearingAidHotDealsArray.removeAll()
        viewCon.hearingAidShopBrandarray.removeAll()
        viewCon.hearingAidPriceArray.removeAll()
        viewCon.hearingAidBrandArray.removeAll()
        viewCon.hearingAidShopModelArray.removeAll()
        viewCon.hearingAidPriceListArray.removeAll()
        viewCon.hearingAidBrandListArray.removeAll()
        if viewCon.pageNumber == 1 {
            viewCon.hearingAidFilterProductListArray.removeAll()
        }
        viewCon.accessoriesShopModelArray.removeAll()
        viewCon.accessoriesGreatDealsArray.removeAll()
        viewCon.accessoriesBrandListArray.removeAll()
        viewCon.accessoriesFilterProductListArray.removeAll()
        viewCon.compareProductListArray.removeAll()
        
        viewCon.reloadHearingAidTagCollectionView()
        viewCon.reloadoffersCollectionView()
        viewCon.reloadHearingAidBrandCollectionview()
        viewCon.reloadHearingAidLatestCollectionView()
        viewCon.reloadHearingAidFilterProductCollectionView()
        viewCon.reloadHearingAidHotDealsCollectionView()
        viewCon.reloadHearingAidShopBrandCollectionView()
        viewCon.reloadHearingAidPriceCollectionView()
        viewCon.reloadHearingAidShopModelCollectionView()
        viewCon.reloadHearingAidPriceListTableView()
        viewCon.reloadHearingAidBrandListTableView()
        viewCon.reloadAccessoriesTagCollectionView()
        viewCon.reloadAccessoriesGreatDealsCollectionView()
        viewCon.reloadAccessoriesCategoryCollectionView()
        viewCon.reloadCompareProductTableViewList()
        viewCon.reloadHearzapDifferenceCollectionView()
        viewCon.reloadRecentlyViewedCollectionView()
        viewCon.reloadAccessoriesFilterProductCollectionView()
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HearingAidFilterProductModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.tabSelectedIndex = 0
                    viewCon.hearingAidFilterIndex = 3
                    viewCon.accessoriesFilterIndex = 0
                    viewCon.compareIndex = 0
                    viewCon.changeLanguageFormat()
                    viewCon.setTabSelection()
                    viewCon.reloadHearingAidTagCollectionView()
                    viewCon.reloadAccessoriesTagCollectionView()
                    if viewCon.pageNumber == 1 {
                        viewCon.hearingAidFilterProductListArray.removeAll()
                    }
                    if json.data!.products != nil {
                        if json.data!.products!.count > 0 {
                            for item in json.data!.products! {
                                viewCon.hearingAidFilterProductListArray.append(item)
                            }
                        }
                    }
                    if viewCon.hearingAidFilterProductListArray.count > 0 {
                        hearingAidview5.isHidden = false
                        viewCon.reloadHearingAidFilterProductCollectionView()
                        viewCon.pageNumber = viewCon.pageNumber + 1
                        if json.data!.paginatedData != nil {
                            if json.data!.paginatedData!.next != nil {
                                viewCon.hasnext = (json.data!.paginatedData!.next)!
                            }
                        }
                        if viewCon.hasnext == true {
                            hearingAidview6.isHidden = false
                        } else {
                            hearingAidview6.isHidden = true
                        }
                        view15.isHidden = true
                    } else {
                        viewCon.reloadHearingAidFilterProductCollectionView()
                        hearingAidview5.isHidden = true
                        hearingAidview6.isHidden = true
                        view15.isHidden = false
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postAccessoriesProductFilterList(canShowLoader: Bool, viewCon: ShopCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        viewCon.timerOffer.invalidate()
        
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// Shop title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Tab view
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// Hearing Aid view
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// Accessories view
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// Compare View
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// offers title View
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// offers View
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// Recently title View
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// Recently View
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// Hearzap Difference title View
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// Hearzap Difference View
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// Shopping guide view
        let view12 = viewCon.mainStackView.arrangedSubviews[12]// compare model view
        let view13 = viewCon.mainStackView.arrangedSubviews[13]// banner1 view
        let view14 = viewCon.mainStackView.arrangedSubviews[14]// banner2 view
        let view15 = viewCon.mainStackView.arrangedSubviews[15]// error view
        
        view0.isHidden = false
        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = false
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
        view15.isHidden = true
        viewCon.setDefaultTabSelection()
        
        let accessoriesview0 = viewCon.accessoriesStackView.arrangedSubviews[0]// Tag view
        let accessoriesview1 = viewCon.accessoriesStackView.arrangedSubviews[1]// great deals title view
        let accessoriesview2 = viewCon.accessoriesStackView.arrangedSubviews[2]// great deals view
        let accessoriesview3 = viewCon.accessoriesStackView.arrangedSubviews[3]// categories
        let accessoriesview4 = viewCon.accessoriesStackView.arrangedSubviews[4]// filter list view
        let accessoriesview5 = viewCon.accessoriesStackView.arrangedSubviews[5]// load more
        let accessoriesview6 = viewCon.accessoriesStackView.arrangedSubviews[6]// brandlist
        
        accessoriesview0.isHidden = false
        accessoriesview1.isHidden = true
        accessoriesview2.isHidden = true
        accessoriesview3.isHidden = true
        accessoriesview4.isHidden = true
        accessoriesview5.isHidden = true
        accessoriesview6.isHidden = true
        
        viewCon.recentlyViewedArray.removeAll()
        viewCon.offerArray.removeAll()
        viewCon.hearzapDifferenceArray.removeAll()
        viewCon.hearingAidLatestArray.removeAll()
        viewCon.hearingAidHotDealsArray.removeAll()
        viewCon.hearingAidShopBrandarray.removeAll()
        viewCon.hearingAidPriceArray.removeAll()
        viewCon.hearingAidBrandArray.removeAll()
        viewCon.hearingAidShopModelArray.removeAll()
        viewCon.hearingAidPriceListArray.removeAll()
        viewCon.hearingAidBrandListArray.removeAll()
        viewCon.hearingAidFilterProductListArray.removeAll()
        viewCon.accessoriesShopModelArray.removeAll()
        viewCon.accessoriesGreatDealsArray.removeAll()
        viewCon.accessoriesBrandListArray.removeAll()
        if viewCon.pageNumber == 1 {
            viewCon.accessoriesFilterProductListArray.removeAll()
        }
        viewCon.compareProductListArray.removeAll()
        
        viewCon.reloadHearingAidTagCollectionView()
        viewCon.reloadoffersCollectionView()
        viewCon.reloadHearingAidBrandCollectionview()
        viewCon.reloadHearingAidLatestCollectionView()
        viewCon.reloadHearingAidFilterProductCollectionView()
        viewCon.reloadHearingAidHotDealsCollectionView()
        viewCon.reloadHearingAidShopBrandCollectionView()
        viewCon.reloadHearingAidPriceCollectionView()
        viewCon.reloadHearingAidShopModelCollectionView()
        viewCon.reloadHearingAidPriceListTableView()
        viewCon.reloadHearingAidBrandListTableView()
        viewCon.reloadAccessoriesTagCollectionView()
        viewCon.reloadAccessoriesGreatDealsCollectionView()
        viewCon.reloadAccessoriesCategoryCollectionView()
        viewCon.reloadCompareProductTableViewList()
        viewCon.reloadHearzapDifferenceCollectionView()
        viewCon.reloadRecentlyViewedCollectionView()
        viewCon.reloadAccessoriesFilterProductCollectionView()
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HearingAidFilterProductModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.tabSelectedIndex = 1
                    viewCon.hearingAidFilterIndex = 0
                    viewCon.accessoriesFilterIndex = 2
                    viewCon.compareIndex = 0
                    viewCon.changeLanguageFormat()
                    viewCon.setTabSelection()
                    viewCon.reloadHearingAidTagCollectionView()
                    viewCon.reloadAccessoriesTagCollectionView()
                    if viewCon.pageNumber == 1 {
                        viewCon.accessoriesFilterProductListArray.removeAll()
                    }
                    if json.data!.products != nil {
                        if json.data!.products!.count > 0 {
                            for item in json.data!.products! {
                                viewCon.accessoriesFilterProductListArray.append(item)
                            }
                        }
                    }
                    if viewCon.accessoriesFilterProductListArray.count > 0 {
                        accessoriesview4.isHidden = false
                        viewCon.reloadAccessoriesFilterProductCollectionView()
                        viewCon.pageNumber = viewCon.pageNumber + 1
                        if json.data!.paginatedData != nil {
                            if json.data!.paginatedData!.next != nil {
                                viewCon.hasnext = (json.data!.paginatedData!.next)!
                            }
                        }
                        if viewCon.hasnext == true {
                            accessoriesview5.isHidden = false
                        } else {
                            accessoriesview5.isHidden = true
                        }
                        view15.isHidden = true
                    } else {
                        viewCon.reloadAccessoriesFilterProductCollectionView()
                        accessoriesview4.isHidden = true
                        accessoriesview5.isHidden = true
                        view15.isHidden = false
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
