//
//  FindRightDeviceEarPreferenceViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 21/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct FindRightDeviceEarPreferenceViewModel {
    func getFindRightDeviceEarPreference(canShowLoader: Bool, viewCon: FindRightDeviceEarPreferenceViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(FindRightDeviceEarPreferenceModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.earInfo != nil {
                        if json.data!.earInfo!.count > 0 {
                            for i in 0..<json.data!.earInfo!.count {
                                if !(json.data!.earInfo![i].name.isNilOrEmpty) {
                                    if json.data!.earInfo![i].name!.lowercased() == FRDEarPreference.left.rawValue.lowercased() {
                                        viewCon.leftTitleMessage = json.data!.earInfo![i].name!
                                        if !(json.data!.earInfo![i].content.isNilOrEmpty) {
                                            viewCon.leftDecriptionMessage = json.data!.earInfo![i].content!
                                        }
                                        if json.data!.earInfo![i].id != nil {
                                            viewCon.leftEarpreferenceID = (json.data!.earInfo![i].id)!
                                        }
                                        if !(json.data!.earInfo![i].image.isNilOrEmpty) {
                                            viewCon.leftImage = json.data!.earInfo![i].image!
                                        }
                                    }
                                    if json.data!.earInfo![i].name!.lowercased() == FRDEarPreference.right.rawValue.lowercased() {
                                        viewCon.rightTitleMessage = json.data!.earInfo![i].name!
                                        if !(json.data!.earInfo![i].content.isNilOrEmpty) {
                                            viewCon.rightDecriptionMessage = json.data!.earInfo![i].content!
                                        }
                                        if json.data!.earInfo![i].id != nil {
                                            viewCon.rightEarpreferenceID = (json.data!.earInfo![i].id)!
                                        }
                                        if !(json.data!.earInfo![i].image.isNilOrEmpty) {
                                            viewCon.rightImage = json.data!.earInfo![i].image!
                                        }
                                    }
                                    if json.data!.earInfo![i].name!.lowercased() == FRDEarPreference.both.rawValue.lowercased() {
                                        viewCon.bothTitleMessage = json.data!.earInfo![i].name!
                                        if !(json.data!.earInfo![i].content.isNilOrEmpty) {
                                            viewCon.bothDecriptionMessage = json.data!.earInfo![i].content!
                                        }
                                        if json.data!.earInfo![i].id != nil {
                                            viewCon.bothEarpreferenceID = (json.data!.earInfo![i].id)!
                                        }
                                        if !(json.data!.earInfo![i].image.isNilOrEmpty) {
                                            viewCon.bothImage = json.data!.earInfo![i].image!
                                        }
                                    }
                                }
                            }
                            viewCon.bothEarTapped()
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
