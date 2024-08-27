//
//  HomeStaticViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 12/04/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct HomeStaticViewModel {
    func getHomeVersionControl(canShowLoader: Bool, viewCon: HomeStaticViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HomeStaticModel.self, from: result as Data)
                if json.data != nil {
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func postHomequeries(canShowLoader: Bool, viewCon: HomeStaticViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HomeLPModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.customUI()
                    if !(json.data!.message.isNilOrEmpty){
                        viewCon.showToastAlert(json.data!.message!, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: viewCon)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postHomeGetInTouch(canShowLoader: Bool, viewCon: HomeStaticViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HomeLPModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.customUI()
                    if !(json.data!.message.isNilOrEmpty){
                        viewCon.showToastAlert(json.data!.message!, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: viewCon)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
