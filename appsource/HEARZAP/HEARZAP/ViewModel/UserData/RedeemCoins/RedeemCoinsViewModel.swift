//
//  RedeemCoinsViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct RedeemCoinsViewModel {
    func getRedeemCoin(canShowLoader: Bool, viewCon: RedeemCoinsViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(RedeemCoinsModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.redeemCoins != nil {
                        viewCon.rewardPointsArray = json.data!.redeemCoins!
                        viewCon.reloadTableView()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
