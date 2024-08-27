//
//  AddRegisterDeviceViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 23/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct AddRegisterDeviceViewModel {
    func postCustomerDeviceList(canShowLoader: Bool, viewCon: AddRegisterDeviceViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(AddRegisterDeviceModel.self, from: result as Data)
                print(json)
                if viewCon.isFrom == IsNavigateFrom.ardBooking.rawValue {
                    viewCon.navigateBackToBookAppointmentViewController()
                } else {
                    viewCon.navigateBackToRegisterDeviceViewControllerUpdated()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getCustomerDeviceDropdownList(canShowLoader: Bool, viewCon: AddRegisterDeviceViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(RegisterDeviceDropDownModel.self, from: result as Data)
                print(json)
                
                if json.data != nil {
                    if json.data!.patientData != nil {
                        let patientData = json.data!.patientData!
                        for item in patientData {
                            if !(item.id.isNilOrEmpty) && !(item.name.isNilOrEmpty) {
                                viewCon.patientList.append(item.name!)
                                viewCon.patientSlugList.append(item.id!)
                                if !(viewCon.deviceUserUID.isEmpty) && (viewCon.deviceUserUID == item.id!) {
                                    viewCon.deviceUserName = item.name!
                                }
                            }
                        }
                    }
                    
                    if json.data!.brandData != nil {
                        let brandData = json.data!.brandData!
                        for item in brandData {
                            if !(item.id.isNilOrEmpty) && !(item.name.isNilOrEmpty) {
                                viewCon.brandList.append(item.name!)
                                viewCon.brandSlugList.append(item.id!)
                                if !(viewCon.deviceBrandUID.isEmpty) && (viewCon.deviceBrandUID == item.id!) {
                                    viewCon.deviceBrand = item.name!
                                }
                            }
                        }
                    }
                    if json.data!.earPreference != nil {
                        let earPreference = json.data!.earPreference!
                        for item in earPreference {
                            if !(item.id.isNilOrEmpty) && !(item.name.isNilOrEmpty) {
                                viewCon.earPreferenceList.append(item.name!)
                                viewCon.earPreferenceSlugList.append(item.id!)
                                if !(viewCon.deviceEarPreference.isEmpty) && (viewCon.deviceEarPreference == item.id!) {
                                    viewCon.deviceEarPreferenceValue = item.name!
                                }
                            }
                        }
                    }
                    if json.data!.purchasedFrom != nil {
                        let purchasedFrom = json.data!.purchasedFrom!
                        for item in purchasedFrom {
                            if !(item.id.isNilOrEmpty) && !(item.name.isNilOrEmpty) {
                                viewCon.purchasedFromList.append(item.name!)
                                viewCon.purchasedFromSlugList.append(item.id!)
                                if !(viewCon.devicePurchasedFrom.isEmpty) && (viewCon.devicePurchasedFrom == item.id!) {
                                    viewCon.devicePurchasedFromValue = item.name!
                                }
                            }
                        }
                    }
                    if json.data!.warranty != nil {
                        let warranty = json.data!.warranty!
                        for item in warranty {
                            if !(item.id.isNilOrEmpty) && !(item.name.isNilOrEmpty) {
                                viewCon.warrantyList.append(item.name!)
                                viewCon.warrantySlugList.append(item.id!)
                                if !(viewCon.deviceWarrantyDetails.isEmpty) && (viewCon.deviceWarrantyDetails == item.id!) {
                                    viewCon.deviceWarrantyDetailsValue = item.name!
                                }
                            }
                        }
                    }
                }
                viewCon.updateUI()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
