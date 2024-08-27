//
//  OnlineConsultationAppointmentViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 24/01/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct OnlineConsultationAppointmentViewModel {
    func getBookingDateSlotList(canShowLoader: Bool, viewCon: OnlineConsultationAppointmentViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// date
        view1.isHidden = true
        let slotStackview0 = viewCon.slotStackView.arrangedSubviews[0]// date title
        let slotStackview1 = viewCon.slotStackView.arrangedSubviews[1]// date slot
        let slotStackview2 = viewCon.slotStackView.arrangedSubviews[2]// time title
        let slotStackview3 = viewCon.slotStackView.arrangedSubviews[3]// time slot
        let slotStackview4 = viewCon.slotStackView.arrangedSubviews[4]// charge
        
        slotStackview0.isHidden = false
        slotStackview1.isHidden = false
        slotStackview2.isHidden = true
        slotStackview3.isHidden = true
        slotStackview4.isHidden = true
        viewCon.reloadSelectDateCollectionView()
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookingDateModel.self, from: result as Data)
                if json.data != nil {
                    view1.isHidden = false
                    slotStackview0.isHidden = false
                    slotStackview1.isHidden = false
                    viewCon.selectedDate = ""
                    viewCon.selectedTime = ""
                    viewCon.setUserInteractionButton()
                    if json.data!.dateSlot != nil {
                        viewCon.dateListArray = json.data!.dateSlot!
                    }
                    if viewCon.dateListArray.count > 0 {
                        view1.isHidden = false
                        slotStackview0.isHidden = false
                        slotStackview1.isHidden = false
                        viewCon.reloadSelectDateCollectionView()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postOnlineConsultationTimeSlotList(canShowLoader: Bool, viewCon: OnlineConsultationAppointmentViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// date
        view1.isHidden = false
        let slotStackview0 = viewCon.slotStackView.arrangedSubviews[0]// date title
        let slotStackview1 = viewCon.slotStackView.arrangedSubviews[1]// date slot
        let slotStackview2 = viewCon.slotStackView.arrangedSubviews[2]// time title
        let slotStackview3 = viewCon.slotStackView.arrangedSubviews[3]// time slot
        let slotStackview4 = viewCon.slotStackView.arrangedSubviews[4]// charge
        
        slotStackview0.isHidden = false
        slotStackview1.isHidden = false
        slotStackview2.isHidden = true
        slotStackview3.isHidden = true
        slotStackview4.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BookingTimeModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.selectedTime = ""
                    viewCon.setUserInteractionButton()
                    viewCon.scrolltoTimeSlot()
                    if json.data!.availableTimeSlots != nil {
                        viewCon.timeListArray = json.data!.availableTimeSlots!
                    }
                    if viewCon.timeListArray.count > 0 {
                        slotStackview2.isHidden = false
                        slotStackview3.isHidden = false
                        slotStackview4.isHidden = false
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
    func postOnlineConsultationCreateBooking(canShowLoader: Bool, viewCon: OnlineConsultationAppointmentViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CreateBookingModel.self, from: result as Data)
                if json.data != nil {
                    if !(json.data!.bookingUid.isNilOrEmpty) {
                        let bookinguid = json.data!.bookingUid!
                        if !(bookinguid.isEmpty) {
                            viewCon.navigateToOnlineConsultationPaymentViewController(isFrom: viewCon.isFrom, patientUid: viewCon.patientUid, bookingUid: bookinguid)
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
}
