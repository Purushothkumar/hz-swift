//
//  BookAppointmentViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 23/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct ServiceSelected {
    var serviceId: String
    var listedDevice: [String]
    var isSelected: Bool
}

struct BookAppointmentViewModel {
    func getBookAppointmentList(canShowLoader: Bool, viewCon: BookAppointmentViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookAppointmentModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.serviceList != nil {
                        viewCon.selectedServiceArray.removeAll()
                        viewCon.serviceListArray = json.data!.serviceList!
                        if viewCon.serviceListArray.count > 0 {
                            for i in 0..<viewCon.serviceListArray.count {
                                print(i)
                                if viewCon.serviceListArray[i].id != nil {
                                    let id = String(format: "%d", viewCon.serviceListArray[i].id!)
                                    viewCon.selectedServiceArray.append(ServiceSelected(serviceId: id, listedDevice: [], isSelected: false))
                                }
                            }
                        }
                    }
                    viewCon.setUserInteractionButton()
                    viewCon.reloadTableView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getCustomerDeviceList(canShowLoader: Bool, viewCon: BookAppointmentViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(RegisterDeviceModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.deviceData != nil {
                        viewCon.deviceListArray = json.data!.deviceData!
                        viewCon.showAddDevicePopup(id: viewCon.id)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
