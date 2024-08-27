//
//  AddressListViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 16/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct AddressListViewModel {
    func getCustomerAddressList(canShowLoader: Bool, viewCon: AddressListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(AddressListModel.self, from: result as Data)
                
                if json.data != nil {
                    if json.data!.addressData != nil {
                        viewCon.listArray = json.data!.addressData!
                        viewCon.reloadTableView()
                        if viewCon.listArray.count == 0 {
                            viewCon.errorView.isHidden = false
                        } else {
                            viewCon.errorView.isHidden = true
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func deleteCustomerAddress(canShowLoader: Bool, viewCon: AddressListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(DeleteAddressModel.self, from: result as Data)
                print(json)
                viewCon.deleteID = ""
                viewCon.commonAPICALL(retryAPIID: 2000)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
