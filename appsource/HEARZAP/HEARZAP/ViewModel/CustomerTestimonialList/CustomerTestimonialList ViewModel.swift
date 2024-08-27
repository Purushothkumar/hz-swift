//
//  CustomerTestimonialListViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 03/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit
struct CustomerTestimonialListViewModel {
    func getCustomerTestimonialsList(canShowLoader: Bool, viewCon: CustomerTestimonialListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CustomerTestimonialListModel.self, from: result as Data)
                if json.data != nil {
                    let view0 = viewCon.mainStackView.arrangedSubviews[0]// title
                    let view1 = viewCon.mainStackView.arrangedSubviews[1]// grid
                    let view2 = viewCon.mainStackView.arrangedSubviews[2]// list
                    view0.isHidden = false
                    view1.isHidden = true
                    view2.isHidden = true
                    viewCon.listArray.removeAll()
                    viewCon.gridArray.removeAll()
                    if json.data!.testimonial != nil {
                        if json.data!.testimonial!.count > 0 {
                            for i in 0..<json.data!.testimonial!.count {
                                if i == 0 {
                                    viewCon.gridArray.append(json.data!.testimonial![i])
                                } else {
                                    viewCon.listArray.append(json.data!.testimonial![i])
                                }
                            }
                        }
                        if viewCon.listArray.count > 0 {
                            view1.isHidden = false
                        }
                        if viewCon.gridArray.count > 0 {
                            view2.isHidden = false
                        }
                        viewCon.reloadListTableView()
                        viewCon.reloadGridCollectionView()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
