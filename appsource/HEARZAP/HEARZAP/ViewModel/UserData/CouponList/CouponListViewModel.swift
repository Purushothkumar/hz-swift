//
//  CouponListViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct CouponListViewModel {
    func getCouponList(canShowLoader: Bool, viewCon: CouponListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CouponListModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.customerCoupon != nil {
                        viewCon.listArray = json.data!.customerCoupon!
                        viewCon.reloadTableView()
                        if viewCon.listArray.count == 0 {
                            viewCon.errorView.isHidden = false
                        } else {
                            viewCon.errorView.isHidden = true
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
