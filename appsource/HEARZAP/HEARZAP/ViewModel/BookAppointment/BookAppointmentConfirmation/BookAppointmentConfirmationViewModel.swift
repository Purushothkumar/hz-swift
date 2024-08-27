//
//  BookAppointmentConfirmationViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 30/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct BookAppointmentConfirmationViewModel {
    func getBookingConfirmation(canShowLoader: Bool, viewCon: BookAppointmentConfirmationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// banner Image
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Title
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// empty
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// booking
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// address stack title
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// policy title
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// policy button
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        view6.isHidden = true
        
        let bookingInfoview0 = viewCon.bookingInfoStackView.arrangedSubviews[0]// booking title
        let bookingInfoview1 = viewCon.bookingInfoStackView.arrangedSubviews[1]// ID
        let bookingInfoview2 = viewCon.bookingInfoStackView.arrangedSubviews[2]// date
        let bookingInfoview3 = viewCon.bookingInfoStackView.arrangedSubviews[3]// list
        let bookingInfoview4 = viewCon.bookingInfoStackView.arrangedSubviews[4]// line
        let bookingInfoview5 = viewCon.bookingInfoStackView.arrangedSubviews[5]// scheduled date
        let bookingInfoview6 = viewCon.bookingInfoStackView.arrangedSubviews[6]// timeSlot
        let bookingInfoview7 = viewCon.bookingInfoStackView.arrangedSubviews[7]// viewDetails/addtocalendar
        let bookingInfoview8 = viewCon.bookingInfoStackView.arrangedSubviews[6]// empty
        
        bookingInfoview0.isHidden = false
        bookingInfoview1.isHidden = true
        bookingInfoview2.isHidden = true
        bookingInfoview3.isHidden = true
        bookingInfoview4.isHidden = true
        bookingInfoview5.isHidden = true
        bookingInfoview6.isHidden = true
        bookingInfoview7.isHidden = true
        bookingInfoview8.isHidden = true
        
        let infoview0 = viewCon.onlineConsultationInfoStackView.arrangedSubviews[0]// title
        let infoview1 = viewCon.onlineConsultationInfoStackView.arrangedSubviews[1]// line
        let infoview2 = viewCon.onlineConsultationInfoStackView.arrangedSubviews[2]// homeaddress
        let infoview3 = viewCon.onlineConsultationInfoStackView.arrangedSubviews[3]// line
        let infoview4 = viewCon.onlineConsultationInfoStackView.arrangedSubviews[4]// storeaddress
        let infoview5 = viewCon.onlineConsultationInfoStackView.arrangedSubviews[5]// lineaddress
        let infoview6 = viewCon.onlineConsultationInfoStackView.arrangedSubviews[6]// desc
        
        infoview0.isHidden = true
        infoview1.isHidden = true
        infoview2.isHidden = true
        infoview3.isHidden = true
        infoview4.isHidden = true
        infoview5.isHidden = true
        infoview6.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookingConfirmationModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.meetingLink = ""
                    viewCon.scheduleDate = ""
                    viewCon.timeSlot = ""
                    viewCon.bookedDate = ""
                    viewCon.serviceDate = ""
                    viewCon.serviceLocation = ""
                    view0.isHidden = false
                    viewCon.descriptionLabel.text = ""
                    viewCon.bookingIDLabel.text = ""
                    viewCon.bookingDateLabel.text = "-"
                    viewCon.bookingTimeLabel.text = ""
                    viewCon.scheduleDateLabel.text = ""
                    viewCon.homeAddressNameLabel.text = ""
                    viewCon.homeAddressLabel.text = ""
                    viewCon.storeAddressNameLabel.text = ""
                    viewCon.storeAddressLabel.text = ""
                    viewCon.startTime = ""
                    viewCon.endTime = ""
                    
                    if !(json.data!.bookingUid.isNilOrEmpty) {
                        view1.isHidden = false
                        viewCon.bookingUid = json.data!.bookingUid!
                        viewCon.descriptionLabel.text = "\(AppLocalizationString.bookingID) \(viewCon.bookingUid)"
                        
                        view2.isHidden = false
                        view3.isHidden = false
                        bookingInfoview1.isHidden = false
                        bookingInfoview0.isHidden = false
                        bookingInfoview7.isHidden = false
                        bookingInfoview8.isHidden = false
                        
                        viewCon.bookingIDLabel.text = viewCon.bookingUid
                    }
                    if !(json.data!.bookedDate.isNilOrEmpty) {
                        view2.isHidden = false
                        view3.isHidden = false
                        bookingInfoview2.isHidden = false
                        bookingInfoview0.isHidden = false
                        bookingInfoview7.isHidden = false
                        bookingInfoview8.isHidden = false
                        
                        viewCon.bookedDate = json.data!.bookedDate!
                        viewCon.bookingDateLabel.text = viewCon.bookedDate
                    }
                    if json.data!.serviceRequestsList != nil {
                        viewCon.serviceRequestsListArray = json.data!.serviceRequestsList!
                        viewCon.reloadServiceDetailsQtyTableView()
                        if viewCon.serviceRequestsListArray.count > 0 {
                            view2.isHidden = false
                            view3.isHidden = false
                            bookingInfoview3.isHidden = false
                            bookingInfoview0.isHidden = false
                            bookingInfoview7.isHidden = false
                            bookingInfoview8.isHidden = false
                        }
                    }
                    if !(json.data!.scheduleDate.isNilOrEmpty) {
                        viewCon.scheduleDate = json.data!.scheduleDate!
                    }
                    if !(json.data!.startTime.isNilOrEmpty) {
                        viewCon.startTime = json.data!.startTime!
                    }
                    if !(json.data!.endTime.isNilOrEmpty) {
                        viewCon.endTime = json.data!.endTime!
                    }
                    if !(json.data!.timeSlot.isNilOrEmpty) {
                        viewCon.timeSlot = json.data!.timeSlot!
                    }
                    if json.data!.bookingDetails != nil {
                        if json.data!.bookingDetails!.enableJoinBtn != nil {
                            viewCon.enableJoinBtn = json.data!.bookingDetails!.enableJoinBtn!
                        }
                        if json.data!.bookingDetails!.canShowJoinBtn != nil {
                            viewCon.canShowJoinBtn = json.data!.bookingDetails!.canShowJoinBtn!
                        }
                        if !(json.data!.bookingDetails!.meetingLink.isNilOrEmpty) {
                            viewCon.meetingLink = json.data!.bookingDetails!.meetingLink!
                        }
                    }
                    if !(viewCon.scheduleDate.isEmpty) {
                        view2.isHidden = false
                        view3.isHidden = false
                        bookingInfoview4.isHidden = false
                        bookingInfoview5.isHidden = false
                        bookingInfoview0.isHidden = false
                        bookingInfoview7.isHidden = false
                        bookingInfoview8.isHidden = false
                        viewCon.scheduleDateLabel.text = viewCon.scheduleDate.capitalized
                    }
                    
                    if !(viewCon.timeSlot.isEmpty) {
                        view2.isHidden = false
                        view3.isHidden = false
                        bookingInfoview4.isHidden = false
                        bookingInfoview6.isHidden = false
                        bookingInfoview0.isHidden = false
                        bookingInfoview7.isHidden = false
                        bookingInfoview8.isHidden = false
                        viewCon.bookingTimeLabel.text = viewCon.timeSlot.lowercased()
                    }
                    
                    if json.data!.canShowHomeAddress != nil {
                        if json.data!.canShowHomeAddress == true {
                            if json.data!.homeAddress != nil {
                                var name = ""
                                var address = ""
                                if !(json.data!.homeAddress!.name.isNilOrEmpty) {
                                    name = json.data!.homeAddress!.name!
                                }
                                if !(json.data!.homeAddress!.serviceLocation.isNilOrEmpty) {
                                    address = json.data!.homeAddress!.serviceLocation!
                                }
                                
                                if !(address.isEmpty) || (name.isEmpty) {
                                    view4.isHidden = false
                                    infoview0.isHidden = false
                                    infoview1.isHidden = false
                                    infoview2.isHidden = false
                                    infoview5.isHidden = false
                                    infoview6.isHidden = false
                                    viewCon.homeAddressNameLabel.text = name
                                    viewCon.homeAddressLabel.text = address
                                    
                                }
                            }
                        }
                    }
                    if json.data!.canShowStoreAddress != nil {
                        if json.data!.canShowStoreAddress == true {
                            if json.data!.storeAddress != nil {
                                var name = ""
                                var address = ""
                                if !(json.data!.storeAddress!.name.isNilOrEmpty) {
                                    name = json.data!.storeAddress!.name!
                                }
                                if !(json.data!.storeAddress!.serviceLocation.isNilOrEmpty) {
                                    address = json.data!.storeAddress!.serviceLocation!
                                }
                                if !(address.isEmpty) || (name.isEmpty) {
                                    view4.isHidden = false
                                    infoview0.isHidden = false
                                    infoview3.isHidden = false
                                    infoview4.isHidden = false
                                    viewCon.storeAddressNameLabel.text = name
                                    viewCon.storeAddressLabel.text = address
                                    
                                }
                            }
                        }
                    }
                    view5.isHidden = false
                    view6.isHidden = false
                    viewCon.changeLanguageFormat()
                    
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
