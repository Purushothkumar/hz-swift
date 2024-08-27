//
//  ServiceRequestListViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 31/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct ServiceRequestListViewModel {
    func getServiceRequestList(canShowLoader: Bool, viewCon: ServiceRequestListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ServiceRequestListModel.self, from: result as Data)
                if json.data != nil {
                    if retryAPIID == 2000 {
                        viewCon.refreshControl.endRefreshing()
                    }
                    if json.data!.bookingList != nil {
                        if json.data!.bookingList!.bookingList != nil {
                            viewCon.bookingListArray = json.data!.bookingList!.bookingList!
                            viewCon.reloadTableview()
                            
                            if viewCon.bookingListArray.count > 0 {
                                viewCon.errorView.isHidden = true
                            } else {
                                viewCon.errorView.isHidden = false
                            }
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
