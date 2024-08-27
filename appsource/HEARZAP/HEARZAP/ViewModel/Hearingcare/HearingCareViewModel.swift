//
//  HearingCareViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 24/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct HearingCareViewModel {
    func getNotificationCount(canShowLoader: Bool, viewCon: HearingCareViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(NotificationCountModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.hasCart = false
                    viewCon.hasAlert = false
                    if json.data!.cart != nil {
                        viewCon.hasCart = json.data!.cart!
                    }
                    if json.data!.alert != nil {
                        viewCon.hasAlert = json.data!.alert!
                    }
                    viewCon.setNavigationBar()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getHearingCareData(canShowLoader: Bool, viewCon: HearingCareViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HearingcareModel.self, from: result as Data)
                if json.data != nil {
                    let view2 = viewCon.mainStackView.arrangedSubviews[2]// cardlist
                    let view3 = viewCon.mainStackView.arrangedSubviews[3]// Rating
                    view3.isHidden = true
                    view2.isHidden = true
                    viewCon.cardArray.removeAll()
                    viewCon.reviewRatingArray.removeAll()
                    if json.data!.customerTestimonial != nil {
                        viewCon.reviewRatingArray = json.data!.customerTestimonial!
                        if viewCon.reviewRatingArray.count > 0 {
                            view3.isHidden = false
                            viewCon.reloadCollectionView()
                        }
                    }
                    if json.data!.services != nil {
                        viewCon.cardArray = json.data!.services!
                        if viewCon.cardArray.count > 0 {
                            view2.isHidden = false
                            viewCon.reloadCardTableView()
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
