//
//  CheckOutViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 07/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct CheckOutViewModel {
    func postCheckoutDelivery(canShowLoader: Bool, viewCon: CheckOutViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CheckOutModel.self, from: result as Data)
                if json.data != nil {
                    var orderID = viewCon.orderID
                    if !(json.data!.orderID.isNilOrEmpty) {
                        orderID = json.data!.orderID!
                    }
                    viewCon.navigateToCheckOutSummaryViewController(orderID: orderID)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getOrderedItems(canShowLoader: Bool, viewCon: CheckOutViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// selection
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// home
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// store
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// list
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// empty
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = false
        
        let selectionview0 = viewCon.selectionStackView.arrangedSubviews[0]// title
        let selectionview1 = viewCon.selectionStackView.arrangedSubviews[1]// separator
        let selectionview2 = viewCon.selectionStackView.arrangedSubviews[2]// delivery address title stackview
        let selectionview3 = viewCon.selectionStackView.arrangedSubviews[3]// Pincode title
        let selectionview4 = viewCon.selectionStackView.arrangedSubviews[4]// text field
        
        selectionview0.isHidden = true
        selectionview1.isHidden = true
        selectionview2.isHidden = true
        selectionview3.isHidden = true
        selectionview4.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CheckOutItemModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.orderItems != nil {
                        viewCon.cartListArray = json.data!.orderItems!
                    }
                    viewCon.reloadItemsTableView()
                    view0.isHidden = false
                    selectionview0.isHidden = false
                    selectionview1.isHidden = false
                    selectionview2.isHidden = false
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func postZipcodeServiceRequestsStoreAddress(canShowLoader: Bool, viewCon: CheckOutViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreDeliveryAddressModel.self, from: result as Data)
                if json.data != nil {
                    let view0 = viewCon.mainStackView.arrangedSubviews[0]// selection
                    let view1 = viewCon.mainStackView.arrangedSubviews[1]// home
                    let view2 = viewCon.mainStackView.arrangedSubviews[2]// store
                    let view3 = viewCon.mainStackView.arrangedSubviews[3]// list
                    let view4 = viewCon.mainStackView.arrangedSubviews[4]// empty
                    
                    view0.isHidden = false
                    view1.isHidden = true
                    view2.isHidden = true
                    view3.isHidden = true
                    view4.isHidden = true
                    
                    let selectionview0 = viewCon.selectionStackView.arrangedSubviews[0]// title
                    let selectionview1 = viewCon.selectionStackView.arrangedSubviews[1]// separator
                    let selectionview2 = viewCon.selectionStackView.arrangedSubviews[2]// delivery address title stackview
                    let selectionview3 = viewCon.selectionStackView.arrangedSubviews[3]// Pincode title
                    let selectionview4 = viewCon.selectionStackView.arrangedSubviews[4]// text field
                    
                    selectionview0.isHidden = false
                    selectionview1.isHidden = false
                    selectionview2.isHidden = false
                    selectionview3.isHidden = false
                    selectionview4.isHidden = false
                    
                    viewCon.setDefaultButtonSelected(deliveryType: viewCon.deliveryType)
                    
                    let storeview0 = viewCon.storeStackView.arrangedSubviews[0]// title
                    let storeview1 = viewCon.storeStackView.arrangedSubviews[1]// list stackview
                    let storeview2 = viewCon.storeStackView.arrangedSubviews[2]// error
                    
                    storeview0.isHidden = false
                    storeview1.isHidden = true
                    storeview2.isHidden = true
                    view2.isHidden = false
                    
                    viewCon.storeListArray.removeAll()
                    viewCon.storeID = ""
                    if json.data!.storeList != nil {
                        viewCon.storeListArray = json.data!.storeList!
                    }
                    viewCon.reloadstoreAddressTableView()
                    if viewCon.storeListArray.count > 0 {
                        view2.isHidden = false
                        storeview1.isHidden = false
                    } else {
                        view2.isHidden = false
                        storeview2.isHidden = false
                    }
                    if (viewCon.deliveryType == DeliveryType.home.rawValue) && (retryAPIID == 1003) {
                        viewCon.commonAPICALL(retryAPIID: 1001)
                    } else if (viewCon.deliveryType == DeliveryType.store.rawValue) && (viewCon.storeListArray.count > 0) {
                        view2.isHidden = false
                        view3.isHidden = false
                        view4.isHidden = false
                        viewCon.reloadItemsTableView()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getZipcodeCustomerAddress(canShowLoader: Bool, viewCon: CheckOutViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HomeDeliveryAddressModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.addressData != nil {
                        viewCon.addressListArray = json.data!.addressData!
                    }
                    viewCon.setDefaultButtonSelected(deliveryType: viewCon.deliveryType)
                    let view0 = viewCon.mainStackView.arrangedSubviews[0]// selection
                    let view1 = viewCon.mainStackView.arrangedSubviews[1]// home
                    let view2 = viewCon.mainStackView.arrangedSubviews[2]// store
                    let view3 = viewCon.mainStackView.arrangedSubviews[3]// list
                    let view4 = viewCon.mainStackView.arrangedSubviews[4]// empty
                    
                    view0.isHidden = false
                    view1.isHidden = true
                    view2.isHidden = true
                    view3.isHidden = true
                    view4.isHidden = true
                    
                    let selectionview0 = viewCon.selectionStackView.arrangedSubviews[0]// title
                    let selectionview1 = viewCon.selectionStackView.arrangedSubviews[1]// separator
                    let selectionview2 = viewCon.selectionStackView.arrangedSubviews[2]// delivery address title stackview
                    let selectionview3 = viewCon.selectionStackView.arrangedSubviews[3]// Pincode title
                    let selectionview4 = viewCon.selectionStackView.arrangedSubviews[4]// text field
                    
                    selectionview0.isHidden = false
                    selectionview1.isHidden = false
                    selectionview2.isHidden = false
                    selectionview3.isHidden = false
                    selectionview4.isHidden = false
                    
                    viewCon.setDefaultButtonSelected(deliveryType: viewCon.deliveryType)
                    
                    let homeview0 = viewCon.homeStackView.arrangedSubviews[0]// title
                    let homeview1 = viewCon.homeStackView.arrangedSubviews[1]// list stackview
                    let homeview2 = viewCon.homeStackView.arrangedSubviews[2]// add
                    
                    homeview0.isHidden = true
                    homeview1.isHidden = true
                    homeview2.isHidden = true
                    
                    let storeview0 = viewCon.storeStackView.arrangedSubviews[0]// title
                    let storeview1 = viewCon.storeStackView.arrangedSubviews[1]// list stackview
                    let storeview2 = viewCon.storeStackView.arrangedSubviews[2]// error
                    
                    storeview0.isHidden = true
                    storeview1.isHidden = true
                    storeview2.isHidden = true
                    
                    if viewCon.storeListArray.count > 0 {
                        view1.isHidden = false
                        view2.isHidden = false
                        storeview0.isHidden = false
                        storeview1.isHidden = false
                        homeview0.isHidden = false
                        if viewCon.addressListArray.count > 0 {
                            homeview1.isHidden = false
                        } else {
                            homeview1.isHidden = true
                        }
                        homeview2.isHidden = false
                    } else {
                        view2.isHidden = false
                        storeview2.isHidden = false
                    }
                    viewCon.reloadstoreAddressTableView()
                    viewCon.reloadHomeAddressTableView()
                    if (viewCon.deliveryType == DeliveryType.home.rawValue) && (viewCon.storeListArray.count > 0) && (viewCon.addressListArray.count > 0) {
                        view3.isHidden = false
                        view4.isHidden = false
                        viewCon.reloadItemsTableView()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
