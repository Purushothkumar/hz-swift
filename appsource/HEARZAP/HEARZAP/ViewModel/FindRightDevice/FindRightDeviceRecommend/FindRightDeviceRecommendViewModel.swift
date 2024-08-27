//
//  FindRightDeviceRecommendViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 22/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct FindRightDeviceRecommendViewModel {
    
    func postWishlist(canShowLoader: Bool, viewCon: FindRightDeviceRecommendViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(EditWishlistModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.showToastAlert(AppLocalizationString.wishListAdded.capitalized, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: viewCon)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func postFindRightDeviceRecommendList(canShowLoader: Bool, viewCon: FindRightDeviceRecommendViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(FindRightDeviceRecommendModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.selectedrecommendedArray.removeAll()
                    if json.data!.output != nil {
                        viewCon.recommendedArray = json.data!.output!
                    }
                    if viewCon.recommendedArray.count > 0 {
                        viewCon.errorView.isHidden = true
                    } else {
                        viewCon.errorView.isHidden = false
                    }
                    viewCon.reloadCollectionView()
                    viewCon.changeLanguageFormat()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getFindRightDeviceRecomendedList(canShowLoader: Bool, viewCon: FindRightDeviceRecommendViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(FindRightDeviceRecommendModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.selectedrecommendedArray.removeAll()
                    if json.data!.output != nil {
                        viewCon.recommendedArray = json.data!.output!
                    }
                    if viewCon.recommendedArray.count > 0 {
                        viewCon.errorView.isHidden = true
                    } else {
                        viewCon.errorView.isHidden = false
                        viewCon.changeLanguageFormat()
                    }
                    viewCon.reloadCollectionView()
                    viewCon.changeLanguageFormat()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
