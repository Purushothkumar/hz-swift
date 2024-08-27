//
//  AccessoriesSubCategoryColorViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 10/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct AccessoriesSubCategoryColorViewModel {
    func getCartList(canShowLoader: Bool, viewCon: AccessoriesSubCategoryColorViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
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
    func postAccessoriesSubcategoryProductList(canShowLoader: Bool, viewCon: AccessoriesSubCategoryColorViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Subcategory title
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// product list
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// load more
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// error
        
        view0.isHidden = false
        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        
        viewCon.accessoriesProductListArray.removeAll()
        viewCon.reloadaccessoriesSubcategoryColorTableViewList()
        viewCon.reloadAccessoriesSubcategoryProductCollectionView()
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(AccessoriesSubCategoryColorModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.image.isNilOrEmpty){
                        viewCon.accessoriesSubcategoriesImage = json.data!.image!
                    }
                    viewCon.reloadaccessoriesSubcategoryColorTableViewList()
                    if json.data!.products != nil {
                        if json.data!.products!.count > 0 {
                            for item in json.data!.products! {
                                viewCon.accessoriesProductListArray.append(item)
                            }
                        }
                    }
                    if viewCon.accessoriesProductListArray.count > 0 {
                        viewCon.reloadAccessoriesSubcategoryProductCollectionView()
                        view2.isHidden = false
                        view4.isHidden = true
                        viewCon.pageNumber += 1
                        if json.data!.paginatedData != nil {
                            if json.data!.paginatedData!.next != nil {
                                viewCon.hasnext = (json.data!.paginatedData!.next)!
                            }
                        }
                        if viewCon.hasnext == true {
                            view3.isHidden = false
                        } else {
                            view3.isHidden = true
                        }
                    } else {
                        viewCon.reloadAccessoriesSubcategoryProductCollectionView()
                        view2.isHidden = true
                        view3.isHidden = true
                        view4.isHidden = false
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
