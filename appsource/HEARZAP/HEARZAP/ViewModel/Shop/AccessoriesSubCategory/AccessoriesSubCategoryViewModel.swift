//
//  AccessoriesSubCategoryViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 01/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct AccessoriesSubCategoryViewModel {
    func getCartList(canShowLoader: Bool, viewCon: AccessoriesSubCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
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
    func getAccessoriesSubcategoryList(canShowLoader: Bool, viewCon: AccessoriesSubCategoryViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Subcategory title
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// subcategory list
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// product list
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// load more
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// error
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        
        viewCon.accessoriesSubcategoriesArray.removeAll()
        viewCon.accessoriesProductListArray.removeAll()
        
        viewCon.reloadaccessoriesSubcategoryColorTableViewList()
        viewCon.reloadAccessoriesSubcategoryProductCollectionView()
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(AccessoriesSubCategoryModel.self, from: result as Data)
                if json.data != nil {
                    
                    if !(json.data!.title.isNilOrEmpty) {
                        viewCon.accessoriesSubcategoriesTitle = json.data!.title!
                    }
                    if !(json.data!.description.isNilOrEmpty) {
                        viewCon.accessoriesSubcategoriesDescription = json.data!.description!
                    }
                    viewCon.changeLanguageFormat()
                    if !(viewCon.accessoriesSubcategoriesTitle.isEmpty) ||  !(viewCon.accessoriesSubcategoriesDescription.isEmpty) {
                        view0.isHidden = false
                    }
                    if viewCon.accessoriesSubcategoriesSlug.lowercased() == AppLocalizationString.batteries.lowercased() {
                        if json.data!.subCategorySpec != nil {
                            viewCon.accessoriesSubcategoriesArray = json.data!.subCategorySpec!
                        }
                        if viewCon.accessoriesSubcategoriesArray.count > 0 {
                            view1.isHidden = false
                            view2.isHidden = false
                        }
                        viewCon.reloadaccessoriesSubcategoryColorTableViewList()
                    }
                    if json.data!.products != nil {
                        if json.data!.products!.count > 0 {
                            for item in json.data!.products! {
                                viewCon.accessoriesProductListArray.append(item)
                            }
                        }
                    }
                    if viewCon.accessoriesProductListArray.count > 0 {
                        viewCon.reloadAccessoriesSubcategoryProductCollectionView()
                        view3.isHidden = false
                        view5.isHidden = true
                        viewCon.pageNumber += 1
                        if json.data!.paginatedData != nil {
                            if json.data!.paginatedData!.next != nil {
                                viewCon.hasnext = (json.data!.paginatedData!.next)!
                            }
                        }
                        if viewCon.hasnext == true {
                            view4.isHidden = false
                        } else {
                            view4.isHidden = true
                        }
                    } else {
                        viewCon.reloadAccessoriesSubcategoryProductCollectionView()
                        view3.isHidden = true
                        view4.isHidden = true
                        view5.isHidden = false
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
