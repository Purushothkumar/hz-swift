//
//  CompareProductBrandViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct CompareProductViewModel {
    func getCompareList(canShowLoader: Bool, viewCon: CompareProductBrandViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CompareListModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.brandList != nil {
                        viewCon.brandListArray = json.data!.brandList!
                    }
                    if json.data!.priceRangeList != nil {
                        viewCon.priceRangeListArray = json.data!.priceRangeList!
                    }
                    if json.data!.modelList != nil {
                        viewCon.modelListArray = json.data!.modelList!
                    }
                    viewCon.reloadBrandCollectionview()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
