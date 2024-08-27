//
//  CompareProductModelViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct CompareProductModelViewModel {
    func getCompareModelProductList(canShowLoader: Bool, viewCon: CompareProductModelViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CompareModelProductListModel.self, from: result as Data)
                viewCon.mainBackgroundView.isHidden = true
                viewCon.errorView.isHidden = true
                if json.data != nil {
                    if json.data!.products != nil {
                        viewCon.productListarray = json.data!.products!
                    }
                    viewCon.reloadProductListTableView()
                    if viewCon.productListarray.count > 0 {
                        viewCon.mainBackgroundView.isHidden = false
                    } else {
                        viewCon.errorView.isHidden = false
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
