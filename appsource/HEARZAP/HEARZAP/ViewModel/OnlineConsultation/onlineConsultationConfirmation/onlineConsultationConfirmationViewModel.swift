//
//  onlineConsultationConfirmationViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct OnlineConsultationConfirmationViewModel {
    func getBookingConfirmation(canShowLoader: Bool, viewCon: OnlineConsultationConfirmationViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// banner Image
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// Title
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// booking title
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// booking
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// online consultation title
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// list
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// policy title
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// policy button
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        view6.isHidden = true
        view7.isHidden = true
        
        let bookingInfoview0 = viewCon.bookingInfoStackView.arrangedSubviews[0]// booking title
        let bookingInfoview1 = viewCon.bookingInfoStackView.arrangedSubviews[1]// ID
        let bookingInfoview2 = viewCon.bookingInfoStackView.arrangedSubviews[2]// date
        let bookingInfoview3 = viewCon.bookingInfoStackView.arrangedSubviews[3]// list
        let bookingInfoview4 = viewCon.bookingInfoStackView.arrangedSubviews[4]// line
        let bookingInfoview5 = viewCon.bookingInfoStackView.arrangedSubviews[5]// scheduled date
        let bookingInfoview6 = viewCon.bookingInfoStackView.arrangedSubviews[6]// timeSlot
        let bookingInfoview7 = viewCon.bookingInfoStackView.arrangedSubviews[7]// viewDetails/Addtocalendar
        let bookingInfoview8 = viewCon.bookingInfoStackView.arrangedSubviews[8]// empty
        
        bookingInfoview0.isHidden = false
        bookingInfoview1.isHidden = true
        bookingInfoview2.isHidden = true
        bookingInfoview3.isHidden = true
        bookingInfoview4.isHidden = true
        bookingInfoview5.isHidden = true
        bookingInfoview6.isHidden = true
        bookingInfoview7.isHidden = true
        bookingInfoview8.isHidden = true
        
        let onlineConsultationInfoview0 = viewCon.onlineConsultationInfoStackView.arrangedSubviews[0]// banner Image
        let onlineConsultationInfoview1 = viewCon.mainStackView.arrangedSubviews[1]// Title
        
        onlineConsultationInfoview0.isHidden = true
        onlineConsultationInfoview1.isHidden = true
        
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
                    viewCon.enableJoinBtn = false
                    viewCon.canShowJoinBtn = false
                    view0.isHidden = false
                    viewCon.descriptionLabel.text = ""
                    viewCon.bookingIDLabel.text = ""
                    viewCon.bookingDateLabel.text = "-"
                    viewCon.bookingTimeLabel.text = ""
                    viewCon.scheduleDateLabel.text = ""
                    viewCon.linkLabel.text = ""
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
                    if !(json.data!.startTime.isNilOrEmpty) {
                        viewCon.startTime = json.data!.startTime!
                    }
                    if !(json.data!.endTime.isNilOrEmpty) {
                        viewCon.endTime = json.data!.endTime!
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
                    
                    //                    if !(viewCon.bookingUid.isEmpty) {
                    //                        view2.isHidden = false
                    //                        view3.isHidden = false
                    //                        bookingInfoview4.isHidden = false
                    //                        bookingInfoview7.isHidden = false
                    //                    bookingInfoview0.isHidden = false
                    //                    bookingInfoview8.isHidden = false
                    //                    }
                    if !(viewCon.meetingLink.isEmpty) {
                        view4.isHidden = false
                        view5.isHidden = false
                        onlineConsultationInfoview1.isHidden = false
                        viewCon.linkLabel.text = viewCon.meetingLink
                        if viewCon.canShowJoinBtn == true {
                            onlineConsultationInfoview0.isHidden = false
                            if viewCon.enableJoinBtn == false {
                                viewCon.joinNowButton.isUserInteractionEnabled = false
                                viewCon.joinNowButton.backgroundColor = UIColor.colorLiteral.theme_orange_FFE5D8
                                viewCon.joinNowButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
                                viewCon.joinNowButton.setNeedsDisplay()
                                viewCon.joinNowButton.layoutIfNeeded()
                                viewCon.view.setNeedsLayout()
                                viewCon.view.layoutIfNeeded()
                            } else {
                                viewCon.joinNowButton.isUserInteractionEnabled = true
                                viewCon.joinNowButton.backgroundColor = UIColor.colorLiteral.theme_orange_F7732F
                                viewCon.joinNowButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
                                viewCon.joinNowButton.setNeedsDisplay()
                                viewCon.joinNowButton.layoutIfNeeded()
                                viewCon.view.setNeedsLayout()
                                viewCon.view.layoutIfNeeded()
                            }
                        }
                    }
                    
                    view6.isHidden = false
                    view7.isHidden = false
                    viewCon.changeLanguageFormat()
                    
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
