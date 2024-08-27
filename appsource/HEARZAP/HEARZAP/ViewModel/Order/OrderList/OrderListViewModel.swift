//
//  OrderListViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct OrderListViewModel {
    
    func getOrderList(canShowLoader: Bool, viewCon: OrderListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OrderListModel.self, from: result as Data)
                if json.data != nil {
                    if retryAPIID == 2000 {
                        viewCon.refreshControl.endRefreshing()
                    }
                    viewCon.isReturn = false
                    viewCon.setSelectedState()
                    if json.data!.orderList != nil {
                        viewCon.orderListArray = json.data!.orderList!
                        viewCon.reloadOrderTableView()
                        if viewCon.orderListArray.count > 0 {
                            viewCon.errorView.isHidden = true
                        } else {
                            viewCon.errorView.isHidden = false
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getReturnOrderList(canShowLoader: Bool, viewCon: OrderListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ReturnOrderListModel.self, from: result as Data)
                if json.data != nil {
                    if retryAPIID == 2001 {
                        viewCon.refreshControl.endRefreshing()
                    }
                    viewCon.isReturn = true
                    viewCon.setSelectedState()
                    if json.data!.orderList != nil {
                        viewCon.returnOrderListArray = json.data!.orderList!
                        viewCon.reloadOrderTableView()
                        if viewCon.returnOrderListArray.count > 0 {
                            viewCon.errorView.isHidden = true
                        } else {
                            viewCon.errorView.isHidden = false
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
