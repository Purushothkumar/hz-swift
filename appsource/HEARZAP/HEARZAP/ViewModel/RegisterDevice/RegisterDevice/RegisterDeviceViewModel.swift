//
//  RegisterDeviceViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 23/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct RegisterDeviceViewModel {
    func getCustomerDeviceList(canShowLoader: Bool, viewCon: RegisterDeviceViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(RegisterDeviceModel.self, from: result as Data)
                let view0 = viewCon.mainStackView.arrangedSubviews[0]// list
                let view1 = viewCon.mainStackView.arrangedSubviews[1]// add button
                let view2 = viewCon.mainStackView.arrangedSubviews[2]// error
                let view3 = viewCon.mainStackView.arrangedSubviews[3]// title
                let view4 = viewCon.mainStackView.arrangedSubviews[4]// collection
                
                view0.isHidden = true
                view1.isHidden = false
                view2.isHidden = true
                view3.isHidden = true
                view3.isHidden = true
                
                if json.data != nil {
                    if json.data!.deviceData != nil {
                        viewCon.deviceListArray = json.data!.deviceData!
                        viewCon.reloadTableview()
                    }
                    if json.data!.accessories != nil {
                        viewCon.accessoriesProductListArray = json.data!.accessories!
                        viewCon.reloadProductCollectionView()
                        if viewCon.accessoriesProductListArray.count > 0 {
                            view3.isHidden = false
                            view4.isHidden = false
                        }
                    }
                    if viewCon.deviceListArray.count > 0 {
                        view0.isHidden = false
                        view1.isHidden = false
                        view2.isHidden = true
                    } else {
                        view0.isHidden = true
                        view1.isHidden = false
                        view2.isHidden = false
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func deleteCustomerDevice(canShowLoader: Bool, viewCon: RegisterDeviceViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(DeleteAddressModel.self, from: result as Data)
                print(json)
                if viewCon.selectedIndex == viewCon.deleteID {
                    viewCon.selectedIndex = ""
                }
                viewCon.deleteID = ""
                viewCon.commonAPICALL(retryAPIID: 2000)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
