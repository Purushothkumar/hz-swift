//
//  EditProfileViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 22/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct EditProfileViewModel {
    func getCustomerRelationAddPerson(canShowLoader: Bool, viewCon: EditProfileViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(GenderRelationModel.self, from: result as Data)
                viewCon.genderArray.removeAll()
                if json.data!.gender != nil {
                    viewCon.genderArray = json.data!.gender!
                }
                viewCon.changeLanguageFormat()
                viewCon.reloadGenderCollectionView()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postProfileInformation(canShowLoader: Bool, viewCon: EditProfileViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(EditProfileModel.self, from: result as Data)
                if json.data !=  nil {
                    viewCon.navigateBackToProfileInformationViewController()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postProfilePhoto(canShowLoader: Bool, viewCon: EditProfileViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(EditProfileModel.self, from: result as Data)
                if json.data !=  nil {
                    if json.data!.profileData != nil {
                        if !(json.data!.profileData!.photo.isNilOrEmpty) {
                            viewCon.profileImageView.setImage(imageUrl: json.data!.profileData!.photo!, placeHolderImage: profileBlue)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
