//
//  StoreFilterViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 27/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct StoreFilterViewModel {
    func getStoreFilterStateList(canShowLoader: Bool, viewCon: StoreFilterViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreFilterStateModel.self, from: result as Data)
                if json.data != nil {
                    if viewCon.pageNumber == 1 {
                        viewCon.filterStoreArray.removeAll()
                    }
                    viewCon.isState = true
                    viewCon.isCity = false
                    viewCon.isZipCode = false
                    if json.data!.paginatedData != nil {
                        if json.data!.paginatedData?.next != nil {
                            viewCon.hasnext = json.data!.paginatedData!.next!
                        }
                        if json.data!.paginatedData?.totalPages != nil {
                            viewCon.totalPages = json.data!.paginatedData!.totalPages!
                        }
                        viewCon.pageNumber = viewCon.pageNumber + 1
                    }
                    if json.data!.stateObj != nil {
                        if !(json.data!.stateObj!.name.isNilOrEmpty) {
                            self.setFilterText(viewCon: viewCon, query: json.data!.stateObj!.name!)
                        } else {
                            self.setFilterText(viewCon: viewCon, query: viewCon.queryString)
                        }
                    } else {
                        self.setFilterText(viewCon: viewCon, query: viewCon.queryString)
                    }
                    if json.data!.storeList != nil {
                        let filterStoreArray = json.data!.storeList!
                        for item in filterStoreArray {
                            viewCon.filterStoreArray.append(item)
                        }
                        viewCon.reloadTableView()
                    } else {
                        viewCon.reloadTableView()
                    }
                    self.showhideView(viewCon: viewCon)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getStoreFilterCityList(canShowLoader: Bool, viewCon: StoreFilterViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreFilterCityModel.self, from: result as Data)
                if json.data != nil {
                    if viewCon.pageNumber == 1 {
                        viewCon.filterStoreArray.removeAll()
                    }
                    viewCon.isState = false
                    viewCon.isCity = true
                    viewCon.isZipCode = false
                    if json.data!.paginatedData != nil {
                        if json.data!.paginatedData?.next != nil {
                            viewCon.hasnext = json.data!.paginatedData!.next!
                        }
                        if json.data!.paginatedData?.totalPages != nil {
                            viewCon.totalPages = json.data!.paginatedData!.totalPages!
                        }
                        viewCon.pageNumber = viewCon.pageNumber + 1
                    }
                    if json.data!.cityObj != nil {
                        if !(json.data!.cityObj!.name.isNilOrEmpty) {
                            self.setFilterText(viewCon: viewCon, query: json.data!.cityObj!.name!)
                        } else {
                            self.setFilterText(viewCon: viewCon, query: viewCon.queryString)
                        }
                    } else {
                        self.setFilterText(viewCon: viewCon, query: viewCon.queryString)
                    }
                    if json.data!.storeList != nil {
                        let filterStoreArray = json.data!.storeList!
                        for item in filterStoreArray {
                            viewCon.filterStoreArray.append(item)
                        }
                        viewCon.reloadTableView()
                    } else {
                        viewCon.reloadTableView()
                    }
                    self.showhideView(viewCon: viewCon)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getStoreFilterZipcodeList(canShowLoader: Bool, viewCon: StoreFilterViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreFilterZipcodeModel.self, from: result as Data)
                if json.data != nil {
                    if viewCon.pageNumber == 1 {
                        viewCon.filterStoreArray.removeAll()
                    }
                    viewCon.isState = false
                    viewCon.isCity = false
                    viewCon.isZipCode = true
                    if !(json.data!.zipcode.isNilOrEmpty) {
                        self.setFilterText(viewCon: viewCon, query: json.data!.zipcode!)
                    } else {
                        self.setFilterText(viewCon: viewCon, query: viewCon.queryString)
                    }
                    
                    if json.data!.storeList != nil {
                        let filterStoreArray = (json.data?.storeList)!
                        for item in filterStoreArray {
                            viewCon.filterStoreArray.append(item)
                        }
                        viewCon.reloadTableView()
                    } else {
                        viewCon.reloadTableView()
                    }
                    self.showhideView(viewCon: viewCon)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func showhideView(viewCon: StoreFilterViewController) {
        if viewCon.filterStoreArray.count > 0 {
            viewCon.tableView.isHidden = false
            viewCon.filterTextView.isHidden = false
            viewCon.errorView.isHidden =  true
        } else {
            viewCon.tableView.isHidden = true
            viewCon.filterTextView.isHidden = true
            viewCon.errorView.isHidden =  false
        }
    }
    
    func setFilterText(viewCon: StoreFilterViewController, query: String) {
        let regularString = AppLocalizationString.storesnearbyhypen
        let queryString = "\"\(query)\""
        
        let titleFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_black_333333, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let descriptionFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_black_333333, NSAttributedString.Key.font: AppFont.medium.size(13)]
        
        let title = NSMutableAttributedString(string: String(format: "%@ ", regularString), attributes: titleFontAttributes as [NSAttributedString.Key: Any])
        let description = NSMutableAttributedString(string: String(format: "%@", queryString), attributes: descriptionFontAttributes as [NSAttributedString.Key: Any])
        let combination = NSMutableAttributedString()
        combination.append(title)
        combination.append(description)
        viewCon.filterStateLabel.attributedText = combination
    }
}
