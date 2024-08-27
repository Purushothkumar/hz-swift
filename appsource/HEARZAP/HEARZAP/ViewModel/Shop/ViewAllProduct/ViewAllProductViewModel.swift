//
//  ViewAllProductViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 02/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct ViewAllProductViewModel {
    func getCartList(canShowLoader: Bool, viewCon: ViewAllProductViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
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
    func getHearingAidLatestProductlist(canShowLoader: Bool, viewCon: ViewAllProductViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// list View
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// load more View
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// error View
        
        if !(pageNumber.isNilOrEmpty) && (pageNumber == "\(1)") {
            view0.isHidden = true
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = true
            viewCon.listArray.removeAll()
            viewCon.reloadcollectionView()
        }
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ViewAllProductModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.title.isNilOrEmpty) {
                        viewCon.collectionListTitle = json.data!.title!
                    }
                    if !(json.data!.dataDescription.isNilOrEmpty) {
                        viewCon.collectionListDescription = json.data!.dataDescription!
                    }
                    viewCon.changeLanguageFormat()
                    
                    if !(viewCon.collectionListTitle.isEmpty) || !(viewCon.collectionListDescription.isEmpty) {
                        view0.isHidden = false
                    }
                    if json.data!.products != nil {
                        if json.data!.products!.count > 0 {
                            for item in json.data!.products! {
                                viewCon.listArray.append(item)
                            }
                        }
                    }
                    if viewCon.listArray.count > 0 {
                        viewCon.reloadcollectionView()
                        view1.isHidden = false
                        view3.isHidden = true
                        viewCon.pageNumber += 1
                        if json.data!.paginatedData != nil {
                            if json.data!.paginatedData!.next != nil {
                                viewCon.hasnext = (json.data!.paginatedData!.next)!
                            }
                        }
                        if viewCon.hasnext == true {
                            view2.isHidden = false
                        } else {
                            view2.isHidden = true
                        }
                    } else {
                        viewCon.reloadcollectionView()
                        view1.isHidden = true
                        view3.isHidden = false
                        view2.isHidden = true
                        
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getHearingAidHotDealsProductlist(canShowLoader: Bool, viewCon: ViewAllProductViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// list View
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// load more View
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// error View
        
        if !(pageNumber.isNilOrEmpty) && (pageNumber == "\(1)") {
            view0.isHidden = true
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = true
            
            viewCon.listArray.removeAll()
            viewCon.reloadcollectionView()
        }
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ViewAllProductModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.title.isNilOrEmpty) {
                        viewCon.collectionListTitle = json.data!.title!
                    }
                    if !(json.data!.dataDescription.isNilOrEmpty) {
                        viewCon.collectionListDescription = json.data!.dataDescription!
                    }
                    viewCon.changeLanguageFormat()
                    
                    if !(viewCon.collectionListTitle.isEmpty) || !(viewCon.collectionListDescription.isEmpty) {
                        view0.isHidden = false
                    }
                    if json.data!.products != nil {
                        if json.data!.products!.count > 0 {
                            for item in json.data!.products! {
                                viewCon.listArray.append(item)
                            }
                        }
                    }
                    if viewCon.listArray.count > 0 {
                        viewCon.reloadcollectionView()
                        view1.isHidden = false
                        view3.isHidden = true
                        viewCon.pageNumber += 1
                        if json.data!.paginatedData != nil {
                            if json.data!.paginatedData!.next != nil {
                                viewCon.hasnext = (json.data!.paginatedData!.next)!
                            }
                        }
                        if viewCon.hasnext == true {
                            view2.isHidden = false
                        } else {
                            view2.isHidden = true
                        }
                    } else {
                        viewCon.reloadcollectionView()
                        view1.isHidden = true
                        view3.isHidden = false
                        view2.isHidden = true
                        
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getHearingAidStyleProductlist(canShowLoader: Bool, viewCon: ViewAllProductViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// list View
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// load more View
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// error View
        
        if !(pageNumber.isNilOrEmpty) && (pageNumber == "\(1)") {
            view0.isHidden = true
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = true
            viewCon.listArray.removeAll()
            viewCon.reloadcollectionView()
        }
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ViewAllProductModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.title.isNilOrEmpty) {
                        viewCon.collectionListTitle = json.data!.title!
                    }
                    if !(json.data!.dataDescription.isNilOrEmpty) {
                        viewCon.collectionListDescription = json.data!.dataDescription!
                    }
                    viewCon.changeLanguageFormat()
                    
                    if !(viewCon.collectionListTitle.isEmpty) || !(viewCon.collectionListDescription.isEmpty) {
                        view0.isHidden = false
                    }
                    if json.data!.products != nil {
                        if json.data!.products!.count > 0 {
                            for item in json.data!.products! {
                                viewCon.listArray.append(item)
                            }
                        }
                    }
                    if viewCon.listArray.count > 0 {
                        viewCon.reloadcollectionView()
                        view1.isHidden = false
                        view3.isHidden = true
                        viewCon.pageNumber += 1
                        if json.data!.paginatedData != nil {
                            if json.data!.paginatedData!.next != nil {
                                viewCon.hasnext = (json.data!.paginatedData!.next)!
                            }
                        }
                        if viewCon.hasnext == true {
                            view2.isHidden = false
                        } else {
                            view2.isHidden = true
                        }
                    } else {
                        viewCon.reloadcollectionView()
                        view1.isHidden = true
                        view3.isHidden = false
                        view2.isHidden = true
                        
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getHearingAidPriceRangeList(canShowLoader: Bool, viewCon: ViewAllProductViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// list View
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// load more View
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// error View
        
        if !(pageNumber.isNilOrEmpty) && (pageNumber == "\(1)") {
            view0.isHidden = true
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = true
            viewCon.listArray.removeAll()
            viewCon.reloadcollectionView()
        }
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ViewAllPriceProductModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.priceRangeDict != nil {
                        if !(json.data!.priceRangeDict!.priceRangeDictDescription.isNilOrEmpty) {
                            viewCon.collectionListDescription = json.data!.priceRangeDict!.priceRangeDictDescription!
                        }
                        var priceStartRange = ""
                        var priceEndRange = ""
                        
                        if json.data!.priceRangeDict!.priceStartRange != nil {
                            if json.data!.priceRangeDict!.priceStartRange != 0 {
                                priceStartRange = String(format: "%@%d", AppConstantValue.rupeesymbol, json.data!.priceRangeDict!.priceStartRange!)
                            }
                        }
                        if json.data!.priceRangeDict!.priceEndRange != nil {
                            if json.data!.priceRangeDict!.priceEndRange != 0 {
                                priceEndRange = String(format: "%@%d", AppConstantValue.rupeesymbol, json.data!.priceRangeDict!.priceEndRange!)
                            }
                        }
                        if !(priceStartRange.isEmpty) && !(priceEndRange.isEmpty) {
                            viewCon.collectionListTitle = "\(priceStartRange) - \(priceEndRange)"
                        } else {
                            if !(priceStartRange.isEmpty) {
                                viewCon.collectionListTitle = "\(AppLocalizationString.above.capitalized) \(priceStartRange)"
                            } else if !(priceEndRange.isEmpty) {
                                viewCon.collectionListTitle = "\(AppLocalizationString.below.capitalized) \(priceEndRange)"
                            }
                        }
                        viewCon.changeLanguageFormat()
                        
                        if !(viewCon.collectionListTitle.isEmpty) || !(viewCon.collectionListDescription.isEmpty) {
                            view0.isHidden = false
                        }
                        if json.data!.priceRangeDict!.products != nil {
                            if json.data!.priceRangeDict!.products!.count > 0 {
                                for item in json.data!.priceRangeDict!.products! {
                                    viewCon.listArray.append(item)
                                }
                            }
                        }
                        if viewCon.listArray.count > 0 {
                            viewCon.reloadcollectionView()
                            view1.isHidden = false
                            view3.isHidden = true
                            viewCon.pageNumber += 1
                            if json.data!.priceRangeDict!.paginatedData != nil {
                                if json.data!.priceRangeDict!.paginatedData!.next != nil {
                                    viewCon.hasnext = (json.data!.priceRangeDict!.paginatedData!.next)!
                                }
                            }
                            if viewCon.hasnext == true {
                                view2.isHidden = false
                            } else {
                                view2.isHidden = true
                            }
                        } else {
                            viewCon.reloadcollectionView()
                            view1.isHidden = true
                            view3.isHidden = false
                            view2.isHidden = true
                            
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getHearingAidBrandList(canShowLoader: Bool, viewCon: ViewAllProductViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// list View
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// load more View
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// error View
        
        if !(pageNumber.isNilOrEmpty) && (pageNumber == "\(1)") {
            view0.isHidden = true
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = true
            viewCon.listArray.removeAll()
            viewCon.reloadcollectionView()
        }
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ViewAllBrandProductModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.brandDict != nil {
                        if !(json.data!.brandDict!.name.isNilOrEmpty) {
                            viewCon.collectionListTitle = json.data!.brandDict!.name!
                        }
                        viewCon.collectionListDescription = ""
                        if !(viewCon.collectionListTitle.isEmpty) || !(viewCon.collectionListDescription.isEmpty) {
                            view2.isHidden = false
                        }
                        viewCon.changeLanguageFormat()
                        view0.isHidden = false
                        view1.isHidden = false
                        if json.data!.brandDict!.products != nil {
                            if json.data!.brandDict!.products!.count > 0 {
                                for item in json.data!.brandDict!.products! {
                                    viewCon.listArray.append(item)
                                }
                            }
                        }
                        if viewCon.listArray.count > 0 {
                            viewCon.reloadcollectionView()
                            view1.isHidden = false
                            view3.isHidden = true
                            viewCon.pageNumber += 1
                            if json.data!.brandDict!.paginatedData != nil {
                                if json.data!.brandDict!.paginatedData!.next != nil {
                                    viewCon.hasnext = (json.data!.brandDict!.paginatedData!.next)!
                                }
                            }
                            if viewCon.hasnext == true {
                                view2.isHidden = false
                            } else {
                                view2.isHidden = true
                            }
                        } else {
                            viewCon.reloadcollectionView()
                            view1.isHidden = true
                            view3.isHidden = false
                            view2.isHidden = true
                            
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getAccessoriesFilterList(canShowLoader: Bool, viewCon: ViewAllProductViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// title View
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// list View
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// load more View
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// error View
        
        if !(pageNumber.isNilOrEmpty) && (pageNumber == "\(1)") {
            view0.isHidden = true
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = true
            viewCon.listArray.removeAll()
            viewCon.reloadcollectionView()
        }
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ViewAllAccessoriesProductModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.title.isNilOrEmpty) {
                        viewCon.collectionListTitle = json.data!.title!
                    }
                    if !(json.data!.description.isNilOrEmpty) {
                        viewCon.collectionListDescription = json.data!.description!
                    }
                    if !(viewCon.collectionListTitle.isEmpty) || !(viewCon.collectionListDescription.isEmpty) {
                        view2.isHidden = false
                    }
                    viewCon.changeLanguageFormat()
                    view0.isHidden = false
                    view1.isHidden = false
                    if json.data!.products != nil {
                        if json.data!.products!.count > 0 {
                            for item in json.data!.products! {
                                viewCon.listArray.append(item)
                            }
                        }
                    }
                    if viewCon.listArray.count > 0 {
                        viewCon.reloadcollectionView()
                        view1.isHidden = false
                        view3.isHidden = true
                        viewCon.pageNumber += 1
                        if json.data!.paginatedData != nil {
                            if json.data!.paginatedData!.next != nil {
                                viewCon.hasnext = (json.data!.paginatedData!.next)!
                            }
                        }
                        if viewCon.hasnext == true {
                            view2.isHidden = false
                        } else {
                            view2.isHidden = true
                        }
                    } else {
                        viewCon.reloadcollectionView()
                        view1.isHidden = true
                        view3.isHidden = false
                        view2.isHidden = true
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
