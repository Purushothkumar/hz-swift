//
//  ServiceRequestStaffRatingViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 07/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct ServiceRequestStaffRatingViewModel {
    func postAudiologistRating(canShowLoader: Bool, viewCon: ServiceRequestStaffRatingViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ServiceRequestStaffRatingModel.self, from: result as Data)
                print(json)
                viewCon.postButtonAlert()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
