//
//  BottomSheetCartViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 16/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct BottomSheetCartViewModel {
    func postAddToCart(canShowLoader: Bool, viewCon: BottomSheetCartViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BottomSheetCartModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.dismiss(animated: true) {
                        viewCon.delegate!.updateBottomSheetCartViewController()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postCartItem(canShowLoader: Bool, viewCon: BottomSheetCartViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CartDetailModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.dismiss(animated: true) {
                        viewCon.delegate!.updateBottomSheetCartViewController()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postCartItemQuantity(canShowLoader: Bool, viewCon: BottomSheetCartViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// titleView
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// collectionview
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// errorview
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BottomSheetCartQuantityModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.specificationMsg = ""
                    if !(json.data!.specificationMsg.isNilOrEmpty) {
                        viewCon.specificationMsg = json.data!.specificationMsg!
                    }
                    if json.data!.totalQuantity != nil {
                        viewCon.quantityArray = json.data!.totalQuantity!
                        view1.isHidden = false
                        if viewCon.quantityArray.count > 0 {
                            view2.isHidden = false
                        } else {
                            view3.isHidden = false
                            viewCon.changeLanguageFormat()
                        }
                        viewCon.collectionView.reloadData()
                        viewCon.setUserInteractionButton()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
