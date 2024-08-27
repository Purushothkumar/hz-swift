//
//  BookAppointmentLocationViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct BookAppointmentLocationViewModel {
    func getBookAppointmentCityList(canShowLoader: Bool, viewCon: BookAppointmentLocationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookAppointmentLocationCityModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.cityData != nil {
                        viewCon.cityList.removeAll()
                        viewCon.cityListID.removeAll()
                        let cityData = json.data!.cityData!
                        if (cityData.count > 0){
                            for item in cityData {
                                if (item.id != nil) && !(item.name.isNilOrEmpty) {
                                    viewCon.cityList.append(item.name!)
                                    viewCon.cityListID.append(item.id!)
                                }
                            }
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postBookAppointmentSaveData(canShowLoader: Bool, viewCon: BookAppointmentLocationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookAppointmentLocationSaveDataModel.self, from: result as Data)
                if json.data != nil {
                    if (json.data!.concernID != nil) {
                        viewCon.concernID = "\(json.data!.concernID!)"
                        viewCon.setVisibility()
                        viewCon.navigateToBookAppointmentScheduleViewController(isFrom: viewCon.isFrom, visitType: viewCon.visitType, concernID: viewCon.concernID,newUser: viewCon.newUser, selectedCity: viewCon.selectedCity)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postBookAppointmentSendOTP(canShowLoader: Bool, viewCon: BookAppointmentLocationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookAppointmentLocationSendOTPModel.self, from: result as Data)
                if json.data != nil {
                    if (json.data!.newUser != nil){
                        viewCon.newUser = json.data!.newUser!
                    }
                    if !(json.data!.phoneToken.isNilOrEmpty){
                        viewCon.phoneToken = json.data!.phoneToken!
                    }
                    viewCon.isLoggedIn = true
                    viewCon.setVisibility()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postBookAppointmentLoginVerifyOTP(canShowLoader: Bool, viewCon: BookAppointmentLocationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookAppointmentLocationVerifyOTPModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.token.isNilOrEmpty) {
                        UserDefaults.standard.set(json.data!.token!, forKey: UserDefaultsPreferenceKeys.token)
                        UserDefaults.standard.synchronize()
                    }
                    if (json.data!.concernID != nil) {
                        viewCon.concernID = "\(json.data!.concernID!)"
                        viewCon.setVisibility()
                        viewCon.navigateToBookAppointmentScheduleViewController(isFrom: viewCon.isFrom, visitType: viewCon.visitType, concernID: viewCon.concernID,newUser: viewCon.newUser, selectedCity: viewCon.selectedCity)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
