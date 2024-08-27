//
//  OnlineConsultationLocationVieModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct OnlineConsultationLocationViewModel {
    func getOnlineConsultationCityList(canShowLoader: Bool, viewCon: OnlineConsultationLocationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OnlineConsultationLocationCityModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.city != nil {
                        viewCon.cityList.removeAll()
                        viewCon.cityListID.removeAll()
                        let cityData = json.data!.city!
                        if (cityData.count > 0){
                            for item in cityData {
                                if (item.id != nil) && !(item.name.isNilOrEmpty) {
                                    viewCon.cityList.append(item.name!)
                                    viewCon.cityListID.append(item.id!)
                                }
                            }
                        }
                    }
                    if json.data!.languageList != nil {
                        viewCon.languageList.removeAll()
                        viewCon.languageListCode.removeAll()
                        let languageData = json.data!.languageList!
                        if (languageData.count > 0){
                            for item in languageData {
                                if !(item.code.isNilOrEmpty) && !(item.name.isNilOrEmpty) {
                                    viewCon.languageList.append(item.name!)
                                    viewCon.languageListCode.append(item.code!)
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
    func postOnlineConsultationSaveData(canShowLoader: Bool, viewCon: OnlineConsultationLocationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OnlineConsultationLocationSaveDataModel.self, from: result as Data)
                if json.data != nil {
                    if (json.data!.concernID != nil) {
                        viewCon.concernID = "\(json.data!.concernID!)"
                        viewCon.setVisibility()
                        viewCon.navigateToOnlineConsultationScheduleViewController(isFrom: viewCon.isFrom, concernID: viewCon.concernID,newUser: viewCon.newUser)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postOnlineConsultationSendOTP(canShowLoader: Bool, viewCon: OnlineConsultationLocationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OnlineConsultationLocationSendOTPModel.self, from: result as Data)
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
    func postOnlineConsultationLoginVerifyOTP(canShowLoader: Bool, viewCon: OnlineConsultationLocationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OnlineConsultationLocationVerifyOTPModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.token.isNilOrEmpty) {
                        UserDefaults.standard.set(json.data!.token!, forKey: UserDefaultsPreferenceKeys.token)
                        UserDefaults.standard.synchronize()
                    }
                    if (json.data!.concernID != nil) {
                        viewCon.concernID = "\(json.data!.concernID!)"
                        viewCon.setVisibility()
                        viewCon.navigateToOnlineConsultationScheduleViewController(isFrom: viewCon.isFrom, concernID: viewCon.concernID,newUser: viewCon.newUser)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
