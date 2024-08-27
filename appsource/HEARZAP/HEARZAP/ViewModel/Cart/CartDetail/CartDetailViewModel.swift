//
//  CartDetailViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 07/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct CartDetailViewModel {
    func postCheckout(canShowLoader: Bool, viewCon: CartDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CheckOutModel.self, from: result as Data)
                if json.data != nil {
                    var orderID = ""
                    var cartList = [OrderItem]()
                    if !(json.data!.orderID.isNilOrEmpty) {
                        orderID = json.data!.orderID!
                    }
                    if !(orderID.isEmpty) {
                        viewCon.navigateToCheckOutViewController(orderID: orderID)
                    } else {
                        viewCon.showToastAlert(AppLocalizationString.failedtogenerateOrderID, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getCartList(canShowLoader: Bool, viewCon: CartDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CartDetailModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.cartListArray = json.data!
                    viewCon.reloadCartTableView()
                    if viewCon.cartListArray.count > 0 {
                        viewCon.errorView.isHidden = true
                    } else {
                        viewCon.errorView.isHidden = false
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getCartItem(canShowLoader: Bool, viewCon: CartDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CartItemSpecificationModel.self, from: result as Data)
                if json.data != nil {
                    var quantity = ""
                    var categorySlug = ""
                    var productID = ""
                    var productSpecificationArray = [ProductSpecification]()
                    if !(json.data!.quantity.isNilOrEmpty) {
                        quantity = json.data!.quantity!
                    }
                    if json.data!.product != nil {
                        if json.data!.product!.category.isNilOrEmpty {
                            categorySlug = json.data!.product!.category!
                        }
                        if json.data!.product!.id != nil {
                            productID = String(format: "%d", json.data!.product!.id!)
                        }
                    }
                    if json.data!.productSpecification != nil {
                        productSpecificationArray = json.data!.productSpecification!
                    }
                    if retryAPIID == 2001 {
                        viewCon.showPopupScreen(isQuantityUpdate: false, isSpecificationUpdate: true, productID: productID, cartID: viewCon.cartID, quantity: quantity, productSpecficationArray: productSpecificationArray, categorySlug: categorySlug)
                    } else if retryAPIID == 2002 {
                        viewCon.showPopupScreen(isQuantityUpdate: true, isSpecificationUpdate: false, productID: productID, cartID: viewCon.cartID, quantity: quantity, productSpecficationArray: productSpecificationArray, categorySlug: categorySlug)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func removeCartItem(canShowLoader: Bool, viewCon: CartDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(RemoveCartItemModel.self, from: result as Data)
                print(json)
                viewCon.commonAPICALL(retryAPIID: 2000)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
