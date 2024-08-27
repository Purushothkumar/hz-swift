//
//  StoreReviewViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 02/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct StoreReviewViewModel {
    func getStoreReview(canShowLoader: Bool, viewCon: StoreReviewViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreReviewModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.storeReview != nil {
                        if json.data!.storeReview!.count > 0 {
                            if json.data!.storeReview![0] != nil {
                                if !(json.data!.storeReview![0].rating.isNilOrEmpty) {
                                    viewCon.rating = Int(json.data!.storeReview![0].rating!)!
                                    viewCon.ratingView.rating = Double(viewCon.rating)
                                }
                                if !(json.data!.storeReview![0].review.isNilOrEmpty) {
                                    viewCon.reviewTextView.text = json.data!.storeReview![0].review!
                                }
                            }
                        }
                    }
                    viewCon.setUserInteractionPostButton()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func postStoreReview(canShowLoader: Bool, viewCon: StoreReviewViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreReviewModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.postButtonAlert()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
