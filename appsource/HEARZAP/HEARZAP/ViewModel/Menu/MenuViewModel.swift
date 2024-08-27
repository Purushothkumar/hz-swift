//
//  MenuViewModel.swift
//  hearzap
//
//  Created by Purushoth on 23/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct MenuViewModel {
    func getNotificationCount(canShowLoader: Bool, viewCon: MenuViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(NotificationCountModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.hasCart = false
                    viewCon.hasAlert = false
                    if json.data!.cart != nil {
                        viewCon.hasCart = json.data!.cart!
                    }
                    if json.data!.alert != nil {
                        viewCon.hasAlert = json.data!.alert!
                    }
                    viewCon.setNavigationBar()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getCustomerDetail(canShowLoader: Bool, viewCon: MenuViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CustomerDetailModel.self, from: result as Data)
                viewCon.customerMobile = ""
                viewCon.customerEmail = ""
                viewCon.customerName = ""
                viewCon.customerUID = ""
                if json.data != nil {
                    if !(json.data!.customerName.isNilOrEmpty) {
                        viewCon.customerName = json.data!.customerName!
                    }
                    if !(json.data!.customerMobile.isNilOrEmpty) {
                        viewCon.customerMobile = json.data!.customerMobile!
                    }
                    if !(json.data!.customerEmail.isNilOrEmpty) {
                        viewCon.customerEmail = json.data!.customerEmail!
                    }
                    if !(json.data!.customerUid.isNilOrEmpty) {
                        viewCon.customerUID = json.data!.customerUid!
                    }
                    if !(json.data!.profilePicture.isNilOrEmpty) {
                        viewCon.profilePicture = json.data!.profilePicture!
                    }
                    UserDefaults.standard.set(viewCon.customerName.capitalized, forKey: UserDefaultsPreferenceKeys.customerName)
                    UserDefaults.standard.set(viewCon.customerMobile, forKey: UserDefaultsPreferenceKeys.customerMobile)
                    UserDefaults.standard.set(viewCon.customerEmail, forKey: UserDefaultsPreferenceKeys.customerEmail)
                    UserDefaults.standard.set(viewCon.customerUID, forKey: UserDefaultsPreferenceKeys.customerUID)
                    UserDefaults.standard.set(viewCon.profilePicture, forKey: UserDefaultsPreferenceKeys.profilePicture)
                    UserDefaults.standard.synchronize()
                    viewCon.reloadTableView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func accountInformationModel() -> [MenuModel] {
        return [MenuModel(title: "", description: "", image: "")]
    }
    func userDataModel() -> [MenuModel] {
        return [MenuModel(title: AppLocalizationString.myBookings, description: AppLocalizationString.yourupcomingappointments, image: Asset.servicerequestblue),
                MenuModel(title: AppLocalizationString.testReports, description: AppLocalizationString.viewallyourhearingtestreports, image: Asset.audiogramtestblue),
                MenuModel(title: AppLocalizationString.registeredDevices, description: AppLocalizationString.viewallyourregistereddevices, image: Asset.registereddeviceblue),
                MenuModel(title: AppLocalizationString.orders, description: AppLocalizationString.trackyourorders, image: Asset.orderblue),
                MenuModel(title: AppLocalizationString.wishlist, description: AppLocalizationString.yoursaveditems, image: Asset.heartblue),
                MenuModel(title: AppLocalizationString.coupons, description: AppLocalizationString.managecouponsformorediscounts, image: Asset.couponblue),
                MenuModel(title: AppLocalizationString.myRewards, description: AppLocalizationString.earnrewardsasyoushopandutilizethemincheckout, image: Asset.rewardslightblue)]
    }
    func profileDataModel() -> [MenuModel] {
        return [MenuModel(title: AppLocalizationString.myProfile, description: AppLocalizationString.changeyourprofiledetails, image: Asset.profileblue),
                MenuModel(title: AppLocalizationString.myAddresses, description: AppLocalizationString.saveaddressesforquickcheckouts, image: Asset.addressblue),
                MenuModel(title: AppLocalizationString.myAlerts, description: AppLocalizationString.allyournotificationsandpromotions, image: Asset.alertblue)
        ]
    }
    func couponDataModel() -> [MenuModel] {
        return [MenuModel(title: AppLocalizationString.referandEarn, description: AppLocalizationString.invitefriendsandearnrewards, image: Asset.referearnblue)]
    }
    func hearzapDataModel() -> [MenuModel] {
        return [MenuModel(title: AppLocalizationString.blogs, description: "", image: ""),
                MenuModel(title: AppLocalizationString.tips, description: "", image: ""),
                MenuModel(title: AppLocalizationString.faqs, description: "", image: ""),
                MenuModel(title: AppLocalizationString.careandMaintenance, description: "", image: ""),
                MenuModel(title: AppLocalizationString.customerTestimonials, description: "", image: ""),
                MenuModel(title: AppLocalizationString.buyBackOffers, description: "", image: "")
        ]
    }
    func hearzapPolicyModel() -> [MenuModel] {
        return [MenuModel(title: AppLocalizationString.aboutUs, description: "", image: ""),
                MenuModel(title: AppLocalizationString.support, description: "", image: ""),
                MenuModel(title: AppLocalizationString.privacy, description: "", image: ""),
                MenuModel(title: AppLocalizationString.termsofUse, description: "", image: ""),
                MenuModel(title: AppLocalizationString.legal, description: "", image: "")
        ]
    }
    func logoutModel() -> [MenuModel] {
        return [MenuModel(title: AppLocalizationString.logout, description: "", image: "")]
    }
    func loggedInModel() -> [[MenuModel]] {
        let accountInfoArray = accountInformationModel()
        let userDataArray = userDataModel()
        let profileDataArray = profileDataModel()
        let couponDataArray = couponDataModel()
        let hearzapDataArray = hearzapDataModel()
        let hearzapPolicyArray = hearzapPolicyModel()
        let logout = logoutModel()
        return [accountInfoArray, userDataArray, profileDataArray, couponDataArray, hearzapDataArray, hearzapPolicyArray, logout]
    }
    func guestUserModel() -> [[MenuModel]] {
        let accountInfoArray = accountInformationModel()
        let userDataArray = userDataModel()
        let profileDataArray = profileDataModel()
        let couponDataArray = couponDataModel()
        let hearzapDataArray = hearzapDataModel()
        let hearzapPolicyArray = hearzapPolicyModel()
        return [accountInfoArray, userDataArray, profileDataArray, couponDataArray, hearzapDataArray, hearzapPolicyArray]
    }
}
