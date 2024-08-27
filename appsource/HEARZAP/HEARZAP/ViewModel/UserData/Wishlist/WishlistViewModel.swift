//
//  WishlistViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 11/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct WishlistViewModel {
    func getWishlist(canShowLoader: Bool, viewCon: WishlistViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(WishlistModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.wishlistArray = json.data!
                }
                if viewCon.wishlistArray.count > 0 {
                    viewCon.errorView.isHidden = true
                } else {
                    viewCon.errorView.isHidden = false
                }
                viewCon.reloadWishlistCollectionView()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postWishlist(canShowLoader: Bool, viewCon: WishlistViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(EditWishlistModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.commonAPICALL(retryAPIID: 2000)
                    viewCon.showToastAlert(AppLocalizationString.wishListRemoved.capitalized, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
