//
//  MyAlertViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct MyAlertViewModel {
    func getmyalert(canShowLoader: Bool, viewCon: MyAlertViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(MyAlertModel.self, from: result as Data)
                if json.data != nil {
                    if json.data! != nil {
                        viewCon.listArray = json.data!
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
