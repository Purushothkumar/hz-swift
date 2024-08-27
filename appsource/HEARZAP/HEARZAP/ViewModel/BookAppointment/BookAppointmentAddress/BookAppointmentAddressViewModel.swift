//
//  BookAppointmentAddressViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 24/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct BookAppointmentAddressViewModel {
    func getBookAppointmentDateList(canShowLoader: Bool, viewCon: BookAppointmentAddressViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// selection
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// home
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// store
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// date
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// time
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// empty
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = false
        
        let selectionview0 = viewCon.selectionStackView.arrangedSubviews[0]// delivery address title stackview
        let selectionview1 = viewCon.selectionStackView.arrangedSubviews[1]// Pincode title
        let selectionview2 = viewCon.selectionStackView.arrangedSubviews[2]// text field
        
        selectionview0.isHidden = true
        selectionview1.isHidden = true
        selectionview2.isHidden = true
        
        viewCon.reloadSelectDateCollectionView()
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookingDateModel.self, from: result as Data)
                if json.data != nil {
                    view0.isHidden = false
                    selectionview0.isHidden = false
                    
                    viewCon.selectedDate = ""
                    viewCon.selectedTime = ""
                    if json.data!.dateSlot != nil {
                        viewCon.dateListArray = json.data!.dateSlot!
                    }
                    if viewCon.dateListArray.count > 0 {
                        viewCon.reloadSelectDateCollectionView()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postBookAppointmentTimeList(canShowLoader: Bool, viewCon: BookAppointmentAddressViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookingTimeModel.self, from: result as Data)
                if json.data != nil {
                    let view4 = viewCon.mainStackView.arrangedSubviews[4]// time stackview
                    view4.isHidden = true
                    viewCon.selectedTime = ""
                    if json.data!.availableTimeSlots != nil {
                        viewCon.timeListArray = json.data!.availableTimeSlots!
                    }
                    if viewCon.timeListArray.count > 0 {
                        view4.isHidden = false
                        viewCon.reloadSelectTimeCollectionView()
                    } else {
                        viewCon.showToastAlert(AppLocalizationString.timesloterror, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                    }
                    
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postCreateBooking(canShowLoader: Bool, viewCon: BookAppointmentAddressViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CreateBookingModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.bookingUid.isNilOrEmpty) {
                        let bookinguid = json.data!.bookingUid!
                        if !(bookinguid.isEmpty) {
                            viewCon.navigateToBookAppointmentSummaryViewControllerController(isFrom: viewCon.isFrom, patientUid: viewCon.patientUid, bookingUid: bookinguid)
                        } else {
                            viewCon.showToastAlert(AppLocalizationString.failedtoCreateBookingID, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                        }
                    } else {
                        viewCon.showToastAlert(AppLocalizationString.failedtoCreateBookingID, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func postZipcodeServiceRequestsStoreAddress(canShowLoader: Bool, viewCon: BookAppointmentAddressViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreDeliveryAddressModel.self, from: result as Data)
                if json.data != nil {
                    let view0 = viewCon.mainStackView.arrangedSubviews[0]// selection
                    let view1 = viewCon.mainStackView.arrangedSubviews[1]// home
                    let view2 = viewCon.mainStackView.arrangedSubviews[2]// store
                    let view3 = viewCon.mainStackView.arrangedSubviews[3]// date
                    let view4 = viewCon.mainStackView.arrangedSubviews[4]// time
                    let view5 = viewCon.mainStackView.arrangedSubviews[5]// empty
                    
                    view0.isHidden = false
                    view1.isHidden = true
                    view2.isHidden = true
                    view3.isHidden = true
                    view4.isHidden = true
                    view5.isHidden = true
                    
                    let selectionview0 = viewCon.selectionStackView.arrangedSubviews[0]// delivery address title stackview
                    let selectionview1 = viewCon.selectionStackView.arrangedSubviews[1]// Pincode title
                    let selectionview2 = viewCon.selectionStackView.arrangedSubviews[2]// text field
                    
                    selectionview0.isHidden = false
                    selectionview1.isHidden = false
                    selectionview2.isHidden = false
                    
                    viewCon.setDefaultButtonSelected(deliveryType: viewCon.deliveryType)
                    
                    let storeview0 = viewCon.storeStackView.arrangedSubviews[0]// title
                    let storeview1 = viewCon.storeStackView.arrangedSubviews[1]// list stackview
                    let storeview2 = viewCon.storeStackView.arrangedSubviews[2]// error
                    
                    storeview0.isHidden = false
                    storeview1.isHidden = true
                    storeview2.isHidden = true
                    view2.isHidden = false
                    
                    viewCon.storeListArray.removeAll()
                    viewCon.storeUID = ""
                    if json.data!.storeList != nil {
                        viewCon.storeListArray = json.data!.storeList!
                    }
                    viewCon.reloadstoreAddressTableView()
                    if viewCon.storeListArray.count > 0 {
                        view2.isHidden = false
                        storeview1.isHidden = false
                    } else {
                        view2.isHidden = false
                        storeview2.isHidden = false
                    }
                    if (viewCon.deliveryType == DeliveryType.home.rawValue) && (retryAPIID == 1003) {
                        viewCon.commonAPICALL(retryAPIID: 1001)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getZipcodeCustomerAddress(canShowLoader: Bool, viewCon: BookAppointmentAddressViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(HomeDeliveryAddressModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.addressData != nil {
                        viewCon.addressListArray = json.data!.addressData!
                    }
                    viewCon.setDefaultButtonSelected(deliveryType: viewCon.deliveryType)
                    let view0 = viewCon.mainStackView.arrangedSubviews[0]// selection
                    let view1 = viewCon.mainStackView.arrangedSubviews[1]// home
                    let view2 = viewCon.mainStackView.arrangedSubviews[2]// store
                    let view3 = viewCon.mainStackView.arrangedSubviews[3]// date
                    let view4 = viewCon.mainStackView.arrangedSubviews[4]// time
                    let view5 = viewCon.mainStackView.arrangedSubviews[5]// empty
                    
                    view0.isHidden = false
                    view1.isHidden = true
                    view2.isHidden = true
                    view3.isHidden = true
                    view4.isHidden = true
                    view5.isHidden = true
                    
                    let selectionview0 = viewCon.selectionStackView.arrangedSubviews[0]// delivery address title stackview
                    let selectionview1 = viewCon.selectionStackView.arrangedSubviews[1]// Pincode title
                    let selectionview2 = viewCon.selectionStackView.arrangedSubviews[2]// text field
                    
                    selectionview0.isHidden = false
                    selectionview1.isHidden = false
                    selectionview2.isHidden = false
                    
                    viewCon.setDefaultButtonSelected(deliveryType: viewCon.deliveryType)
                    
                    let homeview0 = viewCon.homeStackView.arrangedSubviews[0]// title
                    let homeview1 = viewCon.homeStackView.arrangedSubviews[1]// list stackview
                    let homeview2 = viewCon.homeStackView.arrangedSubviews[2]// add
                    
                    homeview0.isHidden = true
                    homeview1.isHidden = true
                    homeview2.isHidden = true
                    
                    let storeview0 = viewCon.storeStackView.arrangedSubviews[0]// title
                    let storeview1 = viewCon.storeStackView.arrangedSubviews[1]// list stackview
                    let storeview2 = viewCon.storeStackView.arrangedSubviews[2]// error
                    
                    storeview0.isHidden = true
                    storeview1.isHidden = true
                    storeview2.isHidden = true
                    
                    if viewCon.storeListArray.count > 0 {
                        view1.isHidden = false
                        view2.isHidden = false
                        storeview0.isHidden = false
                        storeview1.isHidden = false
                        homeview0.isHidden = false
                        if viewCon.addressListArray.count > 0 {
                            homeview1.isHidden = false
                        } else {
                            homeview1.isHidden = true
                        }
                        homeview2.isHidden = false
                    } else {
                        view2.isHidden = false
                        storeview2.isHidden = false
                    }
                    viewCon.reloadstoreAddressTableView()
                    viewCon.reloadHomeAddressTableView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
