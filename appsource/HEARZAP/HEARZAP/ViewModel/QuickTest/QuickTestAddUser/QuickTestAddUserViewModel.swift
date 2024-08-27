//
//  QuickTestQuickTestAddUserViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 13/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct QuickTestAddUserViewModel {
    func postCustomerRelationAddPerson(canShowLoader: Bool, viewCon: QuickTestAddUserViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(AddUserModel.self, from: result as Data)
                print(json)
                viewCon.navigateBackToQuickTestProfileViewController()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func postCustomerRelationGetPerson(canShowLoader: Bool, viewCon: QuickTestAddUserViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(GetPersonModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.patientData != nil {
                        if !(json.data!.patientData!.name.isNilOrEmpty) {
                            viewCon.selectNameTextField.text = json.data!.patientData!.name!
                        }
                        if !(json.data!.patientData!.gender.isNilOrEmpty) {
                            viewCon.genderSlug = json.data!.patientData!.gender!
                            viewCon.reloadGenderCollectionView()
                        }
                        if !(json.data!.patientData!.dob.isNilOrEmpty) {
                            viewCon.selectDOBTextField.text = json.data!.patientData!.dob!
                        }
                        if !(json.data!.patientData!.relationshipType.isNilOrEmpty) {
                            viewCon.selectRelationshipTypeTextField.text = json.data!.patientData!.relationshipType!
                        }
                        if !(json.data!.patientData!.relationship.isNilOrEmpty) {
                            viewCon.selectRelationshipTextField.text = json.data!.patientData!.relationship!
                        }
                        viewCon.setUserInteractionButton()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getCustomerRelationAddPerson(canShowLoader: Bool, viewCon: QuickTestAddUserViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]
        view0.isHidden = true

        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(GenderRelationModel.self, from: result as Data)
                viewCon.relationShipArray.removeAll()
                viewCon.genderArray.removeAll()
                if json.data!.gender != nil {
                    viewCon.genderArray = json.data!.gender!
                }
                if json.data!.relationType != nil {
                    viewCon.relationShipArray = json.data!.relationType!
                }
                if viewCon.relationShipArray.count > 0 {
                    if viewCon.isEdit == false {
                        if !(viewCon.selectRelationshipTypeLabel.text.isNilOrEmpty) && viewCon.relationShipArray.count > 0 {
                            if !(viewCon.relationShipArray[0].key.isNilOrEmpty) {
                                viewCon.relationShipSlug = viewCon.relationShipArray[0].key!
                            }
                            if !(viewCon.relationShipArray[0].value.isNilOrEmpty) {
                                viewCon.selectRelationshipTypeTextField.text = viewCon.relationShipArray[0].value!
                            }
                        }
                    } else {
                        for item in viewCon.relationShipArray {
                            var itemkey = ""
                            var itemvalue = ""

                            if !(item.key.isNilOrEmpty) {
                                itemkey = item.key!
                            }
                            if !(item.value.isNilOrEmpty) {
                                itemvalue = item.value!
                            }
                            if viewCon.relationShipSlug.lowercased() == itemvalue.lowercased() {
                                viewCon.relationShipSlug = itemkey
                                viewCon.selectRelationshipTypeTextField.text = itemvalue
                            }
                        }
                    }
                }
                viewCon.changeLanguageFormat()
                viewCon.reloadGenderCollectionView()
                if (viewCon.relationShipArray.count > 0) && (viewCon.genderArray.count > 0) {
                    view0.isHidden = false
                }
                viewCon.setUserInteractionButton()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
