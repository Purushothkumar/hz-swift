//
//  ProfileInformationViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct ProfileInformationViewModel {
    
    func getProfileInformation(canShowLoader: Bool, viewCon: ProfileInformationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let profileview7 = viewCon.profileInformationStackView.arrangedSubviews[7]// customer city
        let profileview8 = viewCon.profileInformationStackView.arrangedSubviews[8]// customer state
        
        profileview7.isHidden = true
        profileview8.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ProfileInformationModel.self, from: result as Data)
                viewCon.mobile = "-"
                viewCon.email = "-"
                viewCon.name = "-"
                viewCon.uid = "-"
                viewCon.status = "-"
                viewCon.gender = "-"
                viewCon.dob = "-"
                viewCon.userStatus = "-"
                viewCon.photo = ""
                
                viewCon.accountID = "-"
                viewCon.accountName = "-"
                viewCon.accountType = "-"
                viewCon.createdOn = "-"
                viewCon.managedBy = "-"
                viewCon.status = "-"
                
                if json.data != nil {
                    if json.data!.profileData != nil {
                        if !(json.data!.profileData!.name.isNilOrEmpty) {
                            viewCon.name = json.data!.profileData!.name!
                        }
                        if !(json.data!.profileData!.mobile.isNilOrEmpty) {
                            viewCon.mobile = json.data!.profileData!.mobile!
                        }
                        if !(json.data!.profileData!.email.isNilOrEmpty) {
                            viewCon.email = json.data!.profileData!.email!
                        }
                        if !(json.data!.profileData!.dob.isNilOrEmpty) {
                            viewCon.dob = json.data!.profileData!.dob!
                        }
                        if !(json.data!.profileData!.gender.isNilOrEmpty) {
                            viewCon.gender = json.data!.profileData!.gender!
                        }
                        if !(json.data!.profileData!.photo.isNilOrEmpty) {
                            viewCon.photo = json.data!.profileData!.photo!
                        }
                        if !(json.data!.profileData!.userStatus.isNilOrEmpty) {
                            viewCon.userStatus = json.data!.profileData!.userStatus!
                        }
                        if !(json.data!.profileData!.uid.isNilOrEmpty) {
                            viewCon.uid = json.data!.profileData!.uid!
                        }
                        if json.data!.profileData!.patientList != nil {
                            viewCon.patientList = json.data!.profileData!.patientList!
                        }
                        if json.data!.profileData!.accountDetials != nil {
                            if !(json.data!.profileData!.accountDetials!.accountID.isNilOrEmpty) {
                                viewCon.accountID = json.data!.profileData!.accountDetials!.accountID!
                            }
                            if !(json.data!.profileData!.accountDetials!.accountName.isNilOrEmpty) {
                                viewCon.accountName = json.data!.profileData!.accountDetials!.accountName!
                            }
                            if !(json.data!.profileData!.accountDetials!.accountType.isNilOrEmpty) {
                                viewCon.accountType = json.data!.profileData!.accountDetials!.accountType!
                            }
                            if !(json.data!.profileData!.accountDetials!.createdOn.isNilOrEmpty) {
                                viewCon.createdOn = json.data!.profileData!.accountDetials!.createdOn!
                            }
                            if !(json.data!.profileData!.accountDetials!.managedBy.isNilOrEmpty) {
                                viewCon.managedBy = json.data!.profileData!.accountDetials!.managedBy!
                            }
                            if !(json.data!.profileData!.accountDetials!.status.isNilOrEmpty) {
                                viewCon.status = json.data!.profileData!.accountDetials!.status!
                            }
                        }
                    }
                    viewCon.userName.text = viewCon.name.capitalized
                    viewCon.userCustomerIDLabel.text = viewCon.uid
                    viewCon.userCustomerFullNameLabel.text = viewCon.name.capitalized
                    viewCon.userCustomerGenderLabel.text = viewCon.gender.capitalized
                    viewCon.userCustomerDobLabel.text = viewCon.dob.capitalized
                    viewCon.userCustomerCityLabel.text = "-"
                    viewCon.userCustomerStateLabel.text = "-"
                    viewCon.userCustomerStatusLabel.text = viewCon.userStatus
                    viewCon.emailLabel.text = viewCon.email
                    viewCon.mobileNumberLabel.text = viewCon.mobile
                    viewCon.accountIDLabel.text = viewCon.accountID
                    viewCon.accountNameLabel.text = viewCon.accountName.capitalized
                    viewCon.accountTypeLabel.text = viewCon.accountType.capitalized
                    viewCon.accountManagedLabel.text = viewCon.managedBy.capitalized
                    viewCon.accountCreatedLabel.text = viewCon.createdOn.capitalized
                    viewCon.accountStatusLabel.text = viewCon.status.capitalized
                    viewCon.userImageView.setImage(imageUrl: viewCon.photo, placeHolderImage: profileBlue)
                    
                    UserDefaults.standard.set(viewCon.name.capitalized, forKey: UserDefaultsPreferenceKeys.customerName)
                    UserDefaults.standard.set(viewCon.mobile, forKey: UserDefaultsPreferenceKeys.customerMobile)
                    UserDefaults.standard.set(viewCon.email, forKey: UserDefaultsPreferenceKeys.customerEmail)
                    UserDefaults.standard.set(viewCon.uid, forKey: UserDefaultsPreferenceKeys.customerUID)
                    UserDefaults.standard.set(viewCon.photo, forKey: UserDefaultsPreferenceKeys.profilePicture)
                    UserDefaults.standard.synchronize()
                    viewCon.reloadTableView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func deleteAccount(canShowLoader: Bool, viewCon: ProfileInformationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(DeletePatientModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.signout()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func deletePatient(canShowLoader: Bool, viewCon: ProfileInformationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(DeleteAccountModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.commonAPICALL(retryAPIID: 2000)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func disableAccount(canShowLoader: Bool, viewCon: ProfileInformationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(DeleteAccountModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.signout()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
