//
//  CompareViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 10/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct CompareViewModel {
    func getCartList(canShowLoader: Bool, viewCon: CompareProductViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
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
    func getCompareList(canShowLoader: Bool, viewCon: CompareProductViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// product
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// product info
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// empty
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// selection view
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// empty
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// overview title
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// overview list
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// empty
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// specification title
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// specification list
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// empty
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// feature title
        let view12 = viewCon.mainStackView.arrangedSubviews[12]// feature list
        let view13 = viewCon.mainStackView.arrangedSubviews[13]// empty
        let view14 = viewCon.mainStackView.arrangedSubviews[14]// lifestyle title
        let view15 = viewCon.mainStackView.arrangedSubviews[15]// lifestyle list
        let view16 = viewCon.mainStackView.arrangedSubviews[16]// viewDetails
        
        view0.isHidden = false
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
        view15.isHidden = true
        view16.isHidden = true
        
        viewCon.productInfoStackView1.isHidden = true
        viewCon.viewDetailsStackView1.isHidden = true
        viewCon.productInfoStackView2.isHidden = true
        viewCon.viewDetailsStackView2.isHidden = true
        
        let scrollSelectionview0 = viewCon.scrollSelectionStackView.arrangedSubviews[0]// overview
        let scrollSelectionview1 = viewCon.scrollSelectionStackView.arrangedSubviews[1]// Specification
        let scrollSelectionview2 = viewCon.scrollSelectionStackView.arrangedSubviews[2]// features
        let scrollSelectionview3 = viewCon.scrollSelectionStackView.arrangedSubviews[3]// compatibility
        
        scrollSelectionview0.isHidden = true
        scrollSelectionview1.isHidden = true
        scrollSelectionview2.isHidden = true
        scrollSelectionview3.isHidden = true
        
        let selectionview0 = viewCon.selectionStackView.arrangedSubviews[0]// overview
        let selectionview1 = viewCon.selectionStackView.arrangedSubviews[1]// Specification
        let selectionview2 = viewCon.selectionStackView.arrangedSubviews[2]// features
        let selectionview3 = viewCon.selectionStackView.arrangedSubviews[3]// compatibility
        
        selectionview0.isHidden = true
        selectionview1.isHidden = true
        selectionview2.isHidden = true
        selectionview3.isHidden = true
        
        viewCon.addModel1View.isHidden = false
        viewCon.addModel1View.isHidden = false
        
        viewCon.brandNameLabel1.text = ""
        viewCon.brandNameLabel2.text = ""
        viewCon.productName1.text = ""
        viewCon.productName2.text = ""
        viewCon.priceLabel1.text = ""
        viewCon.priceLabel2.text = ""
        
        viewCon.addToBagButton1.isHidden = true
        viewCon.addToBagButton2.isHidden = true
        
        viewCon.viewDetailsButton1.isHidden = true
        viewCon.viewDetailsButton2.isHidden = true
        
        viewCon.overViewListarray.removeAll()
        viewCon.featureListarray.removeAll()
        viewCon.lifeStyleListarray.removeAll()
        viewCon.specificationListarray.removeAll()
        viewCon.product1Specification.removeAll()
        viewCon.product2Specification.removeAll()
        
        viewCon.reloadOverviewListTableView()
        viewCon.reloadFeatureListTableView()
        viewCon.reloadSpecificationListTableView()
        viewCon.reloadLifeStyleListTableView()
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CompareProductModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.addModel1View.isHidden = false
                    viewCon.addModel1View.isHidden = false
                    viewCon.isProductAvailable1 = false
                    viewCon.isProductAvailable2 = false
                    
                    if !(viewCon.product1.isEmpty) {
                        if json.data!.product1 != nil {
                            if json.data!.product1!.count > 0 {
                                viewCon.addModel1View.isHidden = true
                                view1.isHidden = false
                                view2.isHidden = false
                                view16.isHidden = false
                                if json.data!.product1![0].id != nil {
                                    viewCon.productID1 = String(format: "%d", json.data!.product1![0].id!)
                                }
                                var productImage = ""
                                if !(json.data!.product1![0].brand.isNilOrEmpty) {
                                    viewCon.brandNameLabel1.text = json.data!.product1![0].brand!
                                }
                                if json.data!.product1![0].name != nil {
                                    viewCon.productName1.text = json.data!.product1![0].name!
                                }
                                if json.data!.product1![0].isProductAvailable != nil {
                                    viewCon.isProductAvailable1 = json.data!.product1![0].isProductAvailable!
                                }
                                if !(json.data!.product1![0].unitSellingPrice.isNilOrEmpty) {
                                    viewCon.priceLabel1.text = String(format: "%@%@", AppConstantValue.rupeesymbol, json.data!.product1![0].unitSellingPrice!)
                                }
                                if json.data!.product1![0].mainImage != nil {
                                    productImage = json.data!.product1![0].mainImage!
                                }
                                viewCon.productImageView1.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
                                viewCon.addToBagButton1.isHidden = false
                                viewCon.viewDetailsButton1.isHidden = false
                                viewCon.addModel1View.isHidden = true
                                viewCon.productInfoStackView1.isHidden = false
                                viewCon.viewDetailsStackView1.isHidden = false
                                viewCon.setAddtoCartButton1Color()
                                if !(json.data!.product1![0].slug.isNilOrEmpty) {
                                    viewCon.product1slug = json.data!.product1![0].slug!
                                }
                                if !(json.data!.product1![0].category.isNilOrEmpty) {
                                    viewCon.category1Slug = json.data!.product1![0].category!
                                }
                            }
                        }
                    }
                    if !(viewCon.product2.isEmpty) {
                        if json.data!.product2 != nil {
                            if json.data!.product2!.count > 0 {
                                viewCon.addModel2View.isHidden = true
                                view1.isHidden = false
                                view2.isHidden = false
                                view16.isHidden = false
                                var productImage = ""
                                if json.data!.product2![0].brand != nil {
                                    viewCon.brandNameLabel2.text = json.data!.product2![0].brand
                                }
                                if json.data!.product2![0].name != nil {
                                    viewCon.productName2.text = json.data!.product2![0].name
                                }
                                if json.data!.product2![0].isProductAvailable != nil {
                                    viewCon.isProductAvailable2 = json.data!.product2![0].isProductAvailable!
                                }
                                if !(json.data!.product2![0].unitSellingPrice.isNilOrEmpty) {
                                    viewCon.priceLabel2.text = String(format: "%@%@", AppConstantValue.rupeesymbol, json.data!.product2![0].unitSellingPrice!)
                                }
                                if json.data!.product2![0].mainImage != nil {
                                    productImage = json.data!.product2![0].mainImage!
                                }
                                viewCon.productImageView2.setImage(imageUrl: productImage, placeHolderImage: hearzapPlaceholder)
                                viewCon.addToBagButton2.isHidden = false
                                viewCon.viewDetailsButton2.isHidden = false
                                viewCon.addModel2View.isHidden = true
                                viewCon.productInfoStackView2.isHidden = false
                                viewCon.viewDetailsStackView2.isHidden = false
                                viewCon.setAddtoCartButton2Color()
                                if !(json.data!.product2![0].slug.isNilOrEmpty) {
                                    viewCon.product2slug = json.data!.product2![0].slug!
                                }
                                if !(json.data!.product2![0].category.isNilOrEmpty) {
                                    viewCon.category2Slug = json.data!.product2![0].category!
                                }
                            }
                        }
                    }
                    if json.data!.productOverview != nil {
                        viewCon.overViewListarray = json.data!.productOverview!
                        viewCon.reloadOverviewListTableView()
                        if viewCon.overViewListarray.count > 0 {
                            view3.isHidden = false
                            view4.isHidden = false
                            view5.isHidden = false
                            view6.isHidden = false
                            view7.isHidden = false
                            scrollSelectionview0.isHidden = false
                            selectionview0.isHidden = false
                        }
                    }
                    if json.data!.productSpecification != nil {
                        viewCon.specificationListarray = json.data!.productSpecification!
                        viewCon.reloadSpecificationListTableView()
                        if viewCon.specificationListarray.count > 0 {
                            view3.isHidden = false
                            view4.isHidden = false
                            view8.isHidden = false
                            view9.isHidden = false
                            view10.isHidden = false
                            scrollSelectionview1.isHidden = false
                            selectionview1.isHidden = false
                        }
                    }
                    if json.data!.productFeatures != nil {
                        viewCon.featureListarray = json.data!.productFeatures!
                        viewCon.reloadFeatureListTableView()
                        if viewCon.featureListarray.count > 0 {
                            view3.isHidden = false
                            view4.isHidden = false
                            view11.isHidden = false
                            view12.isHidden = false
                            view13.isHidden = false
                            scrollSelectionview2.isHidden = false
                            selectionview2.isHidden = false
                        }
                    }
                    if json.data!.productCompatability != nil {
                        viewCon.lifeStyleListarray = json.data!.productCompatability!
                        viewCon.reloadLifeStyleListTableView()
                        if viewCon.lifeStyleListarray.count > 0 {
                            view3.isHidden = false
                            view4.isHidden = false
                            view14.isHidden = false
                            view15.isHidden = false
                            scrollSelectionview3.isHidden = false
                            selectionview3.isHidden = false
                        }
                    }
                    if json.data!.product1Specification != nil {
                        viewCon.product1Specification = json.data!.product1Specification!
                    }
                    if json.data!.product2Specification != nil {
                        viewCon.product2Specification = json.data!.product2Specification!
                    }
                    viewCon.setDefaultScrollHeight()
                    viewCon.setDefaultScrollLabelColor()
                    viewCon.initialOverviewListTableView()
                    viewCon.initialSpecificationListTableView()
                    viewCon.initialFeatureListTableView()
                    viewCon.initialLifeStyleListTableView()
                    
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
