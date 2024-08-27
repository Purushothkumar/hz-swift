//
//  BlogsSearchViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 05/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct BlogsSearchViewModel {
    func getBlogsSearchList(canShowLoader: Bool, viewCon: BlogsSearchViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BlogsListModel.self, from: result as Data)
                if json.data != nil {
                    let stackView0 = viewCon.mainStackView.arrangedSubviews[0]// grid
                    let stackView1 = viewCon.mainStackView.arrangedSubviews[1]// pagination
                    stackView0.isHidden = true
                    stackView1.isHidden = true
                    viewCon.gridArray.removeAll()
                    viewCon.canHideShimmering = true
                    viewCon.mainScrollView.isScrollEnabled = true
                    if (json.data!.articles != nil){
                        if (json.data!.articles!.count > 0){
                            viewCon.gridArray = json.data!.articles!
                            viewCon.reloadGridCollectionView()
                            stackView0.isHidden = false
                            stackView1.isHidden = false
                            viewCon.errorView.isHidden = true
                        }
                        else{
                            viewCon.errorView.isHidden = false
                            viewCon.reloadGridCollectionView()
                        }
                    }
                    if json.data!.paginatedData != nil {
                        if json.data!.paginatedData?.next != nil {
                            viewCon.hasnext = json.data!.paginatedData!.next!
                        }
                        if json.data!.paginatedData?.next != nil {
                            viewCon.hasprevious = json.data!.paginatedData!.previous!
                        }
                        if json.data!.paginatedData?.totalPages != nil {
                            viewCon.totalPages = json.data!.paginatedData!.totalPages!
                        }
                        if (viewCon.totalPages > 1){
                            stackView1.isHidden = false
                        }
                        viewCon.pageNumber = viewCon.pageNumber
                        viewCon.previousPageButton.isUserInteractionEnabled = viewCon.hasprevious
                        viewCon.nextPageButton.isUserInteractionEnabled = viewCon.hasnext
                    }
                    viewCon.setButtonTitle()
                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                        viewCon.mainScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
                    }, completion: nil)

                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
