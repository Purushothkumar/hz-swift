//
//  TipsListViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct TipsListViewModel {
    func getTipsList(canShowLoader: Bool, viewCon: TipsListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(TipsListModel.self, from: result as Data)
                if json.data != nil {
                    let view0 = viewCon.mainStackView.arrangedSubviews[0]// empty
                    let view1 = viewCon.mainStackView.arrangedSubviews[1]// grid
                    let view2 = viewCon.mainStackView.arrangedSubviews[2]// list
                    let view3 = viewCon.mainStackView.arrangedSubviews[3]// empty
                    view0.isHidden = false
                    view1.isHidden = true
                    view2.isHidden = true
                    view3.isHidden = true
                    
                    viewCon.listArray.removeAll()
                    viewCon.gridArray.removeAll()
                    if json.data!.tips != nil {
                        if json.data!.tips!.count > 0 {
                            for index in 0..<json.data!.tips!.count {
                                if index == 0 {
                                    viewCon.gridArray.append(json.data!.tips![index])
                                } else {
                                    viewCon.listArray.append(json.data!.tips![index])
                                }
                            }
                        }
                        if viewCon.listArray.count > 0 {
                            view1.isHidden = false
                        }
                        if viewCon.gridArray.count > 0 {
                            view2.isHidden = false
                            view3.isHidden = false
                        }
                        viewCon.reloadListTableView()
                        viewCon.reloadGridCollectionView()
                        if viewCon.listArray.count == 0  && viewCon.gridArray.count == 0 {
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
