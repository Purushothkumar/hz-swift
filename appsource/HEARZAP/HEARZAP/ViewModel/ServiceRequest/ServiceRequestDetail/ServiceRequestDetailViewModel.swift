//
//  ServiceRequestDetailViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 05/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct ServiceRequestDetailViewModel {
    func getHAServiceRequestApprove(canShowLoader: Bool, viewCon: ServiceRequestDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(ApproveHAServiceRequestModel.self, from: result as Data)
                print(json)
                viewCon.commonAPICALL(retryAPIID: 2000)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getServiceRequestDetail(canShowLoader: Bool, viewCon: ServiceRequestDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(SRDModel.self, from: result as Data)
                if json.data != nil {
                    
                    if retryAPIID == 2001 {
                        viewCon.refreshControl.endRefreshing()
                    }
                    
                    let view0 = viewCon.mainStackView.arrangedSubviews[0] // title
                    let view1 = viewCon.mainStackView.arrangedSubviews[1] // address
                    let view2 = viewCon.mainStackView.arrangedSubviews[2] // info
                    let view3 = viewCon.mainStackView.arrangedSubviews[3] // stafftitle
                    let view4 = viewCon.mainStackView.arrangedSubviews[4] // staff
                    let view5 = viewCon.mainStackView.arrangedSubviews[5] // servicetitle
                    let view6 = viewCon.mainStackView.arrangedSubviews[6] // service
                    let view7 = viewCon.mainStackView.arrangedSubviews[7] // payment
                    
                    view0.isHidden = true
                    view1.isHidden = true
                    view2.isHidden = true
                    view3.isHidden = true
                    view4.isHidden = true
                    view5.isHidden = true
                    view6.isHidden = true
                    view7.isHidden = true
                    
                    let bookingdetailsview0 = viewCon.AddressInfoStackView.arrangedSubviews[0] // title/date/status
                    let bookingdetailsview1 = viewCon.AddressInfoStackView.arrangedSubviews[1] // address/online
                    let bookingdetailsview2 = viewCon.AddressInfoStackView.arrangedSubviews[2] // otp
                    let bookingdetailsview3 = viewCon.AddressInfoStackView.arrangedSubviews[3] // meeting
                    let bookingdetailsview4 = viewCon.AddressInfoStackView.arrangedSubviews[4] // cancel
                    
                    bookingdetailsview0.isHidden = true
                    bookingdetailsview1.isHidden = true
                    bookingdetailsview2.isHidden = true
                    bookingdetailsview3.isHidden = true
                    bookingdetailsview4.isHidden = true
                    
                    let bookingbuttonview0 = viewCon.buttonStackView.arrangedSubviews[0] // button1
                    let bookingbuttonview1 = viewCon.buttonStackView.arrangedSubviews[1] // line
                    let bookingbuttonview2 = viewCon.buttonStackView.arrangedSubviews[2] // button2
                    
                    bookingbuttonview0.isHidden = true
                    bookingbuttonview1.isHidden = true
                    bookingbuttonview2.isHidden = true
                    
                    let informationview0 = viewCon.informationStackView.arrangedSubviews[0] // booking
                    let informationview1 = viewCon.informationStackView.arrangedSubviews[1] // line
                    let informationview2 = viewCon.informationStackView.arrangedSubviews[2] // service
                    let informationview3 = viewCon.informationStackView.arrangedSubviews[3] // line
                    let informationview4 = viewCon.informationStackView.arrangedSubviews[4] // patient
                    
                    informationview0.isHidden = true
                    informationview1.isHidden = true
                    informationview2.isHidden = true
                    informationview3.isHidden = true
                    informationview4.isHidden = true
                    
                    let bookingInformationview0 = viewCon.bookingInformationStackView.arrangedSubviews[0] // title
                    let bookingInformationview1 = viewCon.bookingInformationStackView.arrangedSubviews[1] // id
                    let bookingInformationview2 = viewCon.bookingInformationStackView.arrangedSubviews[2] // appointment date
                    let bookingInformationview3 = viewCon.bookingInformationStackView.arrangedSubviews[3] // booking date
                    let bookingInformationview4 = viewCon.bookingInformationStackView.arrangedSubviews[4] // amount
                    let bookingInformationview5 = viewCon.bookingInformationStackView.arrangedSubviews[5] // status
                    let bookingInformationview6 = viewCon.bookingInformationStackView.arrangedSubviews[6] // cancel date
                    let bookingInformationview7 = viewCon.bookingInformationStackView.arrangedSubviews[7] // cancel reason
                    let bookingInformationview8 = viewCon.bookingInformationStackView.arrangedSubviews[8] // refund status
                    let bookingInformationview9 = viewCon.bookingInformationStackView.arrangedSubviews[9] // refund status
                    let bookingInformationview10 = viewCon.bookingInformationStackView.arrangedSubviews[10] // refund amount
                    
                    bookingInformationview0.isHidden = true
                    bookingInformationview1.isHidden = true
                    bookingInformationview2.isHidden = true
                    bookingInformationview3.isHidden = true
                    bookingInformationview4.isHidden = true
                    bookingInformationview5.isHidden = true
                    bookingInformationview6.isHidden = true
                    bookingInformationview7.isHidden = true
                    bookingInformationview8.isHidden = true
                    bookingInformationview9.isHidden = true
                    bookingInformationview10.isHidden = true
                    
                    let patientview0 = viewCon.patientStackView.arrangedSubviews[0] // title
                    let patientview1 = viewCon.patientStackView.arrangedSubviews[1] // name
                    let patientview2 = viewCon.patientStackView.arrangedSubviews[2] // age
                    let patientview3 = viewCon.patientStackView.arrangedSubviews[3] // gender
                    let patientview4 = viewCon.patientStackView.arrangedSubviews[4] // relationship
                    
                    patientview0.isHidden = true
                    patientview1.isHidden = true
                    patientview2.isHidden = true
                    patientview3.isHidden = true
                    patientview4.isHidden = true
                    
                    let staffDetailsview0 = viewCon.staffDetailsStackView.arrangedSubviews[0] // executive
                    let staffDetailsview1 = viewCon.staffDetailsStackView.arrangedSubviews[1] // audiologist
                    
                    staffDetailsview0.isHidden = true
                    staffDetailsview1.isHidden = true
                    
                    let executiveview0 = viewCon.executiveStackView.arrangedSubviews[0] // title
                    let executiveview1 = viewCon.executiveStackView.arrangedSubviews[1] // separator
                    let executiveview2 = viewCon.executiveStackView.arrangedSubviews[2] // info
                    let executiveview3 = viewCon.executiveStackView.arrangedSubviews[3] // specialization
                    let executiveview4 = viewCon.executiveStackView.arrangedSubviews[4] // vaccinated/rating
                    let executiveview5 = viewCon.executiveStackView.arrangedSubviews[5] // language
                    let executiveview6 = viewCon.executiveStackView.arrangedSubviews[6] // buttonstack
                    
                    executiveview0.isHidden = true
                    executiveview1.isHidden = true
                    executiveview2.isHidden = true
                    executiveview3.isHidden = true
                    executiveview4.isHidden = true
                    executiveview5.isHidden = true
                    executiveview6.isHidden = true
                    
                    let executiveinfoview0 = viewCon.executiveinfoStackview.arrangedSubviews[0] // rating
                    let executiveinfoview1 = viewCon.executiveinfoStackview.arrangedSubviews[1] // vaccinated
                    executiveinfoview0.isHidden = true
                    executiveinfoview1.isHidden = true
                    
                    let audiologistview0 = viewCon.audiologistStackView.arrangedSubviews[0] // title
                    let audiologistview1 = viewCon.audiologistStackView.arrangedSubviews[1] // separator
                    let audiologistview2 = viewCon.audiologistStackView.arrangedSubviews[2] // info
                    let audiologistview3 = viewCon.audiologistStackView.arrangedSubviews[3] // specialization
                    let audiologistview4 = viewCon.audiologistStackView.arrangedSubviews[4] // vaccinated/rating
                    let audiologistview5 = viewCon.audiologistStackView.arrangedSubviews[5] // language
                    let audiologistview6 = viewCon.audiologistStackView.arrangedSubviews[6] // buttonstack
                    
                    audiologistview0.isHidden = true
                    audiologistview1.isHidden = true
                    audiologistview2.isHidden = true
                    audiologistview3.isHidden = true
                    audiologistview4.isHidden = true
                    audiologistview5.isHidden = true
                    audiologistview6.isHidden = true
                    
                    let audiologistinfoview0 = viewCon.audiologistInfoStackview.arrangedSubviews[0] // rating
                    let audiologistinfoview1 = viewCon.audiologistInfoStackview.arrangedSubviews[1] // vaccinated
                    audiologistinfoview0.isHidden = true
                    audiologistinfoview1.isHidden = true
                    
                    let paymentview0 = viewCon.paymentStackView.arrangedSubviews[0] // amount
                    let paymentview1 = viewCon.paymentStackView.arrangedSubviews[1] // amount
                    let paymentview2 = viewCon.paymentStackView.arrangedSubviews[2] // mode
                    let paymentview3 = viewCon.paymentStackView.arrangedSubviews[3] // id
                    let paymentview4 = viewCon.paymentStackView.arrangedSubviews[4] // date
                    let paymentview5 = viewCon.paymentStackView.arrangedSubviews[5] // receipt/invoice button
                    let paymentview6 = viewCon.paymentStackView.arrangedSubviews[6] // space
                    
                    paymentview0.isHidden = true
                    paymentview1.isHidden = true
                    paymentview2.isHidden = true
                    paymentview3.isHidden = true
                    paymentview4.isHidden = true
                    paymentview5.isHidden = true
                    paymentview6.isHidden = true
                    
                    let downloadbuttonview0 = viewCon.downloadButtonStackView.arrangedSubviews[0] // left
                    let downloadbuttonview1 = viewCon.downloadButtonStackView.arrangedSubviews[1] // line
                    let downloadbuttonview2 = viewCon.downloadButtonStackView.arrangedSubviews[2] // right
                    
                    downloadbuttonview0.isHidden = true
                    downloadbuttonview1.isHidden = true
                    downloadbuttonview2.isHidden = true
                    
                    let serviceview0 = viewCon.SRStackView.arrangedSubviews[0] // audiogram
                    let serviceview1 = viewCon.SRStackView.arrangedSubviews[1] // trial
                    let serviceview2 = viewCon.SRStackView.arrangedSubviews[2] // trail pickup
                    let serviceview3 = viewCon.SRStackView.arrangedSubviews[3] // fine tuning
                    let serviceview4 = viewCon.SRStackView.arrangedSubviews[4] // service
                    let serviceview5 = viewCon.SRStackView.arrangedSubviews[5] // service return
                    let serviceview6 = viewCon.SRStackView.arrangedSubviews[6] // online consultation
                    
                    serviceview0.isHidden = true
                    serviceview1.isHidden = true
                    serviceview2.isHidden = true
                    serviceview3.isHidden = true
                    serviceview4.isHidden = true
                    serviceview5.isHidden = true
                    serviceview6.isHidden = true
                    
                    let audiogramview0 = viewCon.audiogramStackView.arrangedSubviews[0] // title
                    let audiogramview1 = viewCon.audiogramStackView.arrangedSubviews[1] // line
                    let audiogramview2 = viewCon.audiogramStackView.arrangedSubviews[2] // timeline
                    let audiogramview3 = viewCon.audiogramStackView.arrangedSubviews[3] // button
                    
                    audiogramview0.isHidden = true
                    audiogramview1.isHidden = true
                    audiogramview2.isHidden = true
                    audiogramview3.isHidden = true
                    
                    let trialdeviceview0 = viewCon.trialDeviceStackView.arrangedSubviews[0] // left
                    let trialdeviceview1 = viewCon.trialDeviceStackView.arrangedSubviews[1] // right
                    let trialdeviceview2 = viewCon.trialDeviceStackView.arrangedSubviews[2] // end date
                    let trialdeviceview3 = viewCon.trialDeviceStackView.arrangedSubviews[3] // security deposit
                    
                    trialdeviceview0.isHidden = true
                    trialdeviceview1.isHidden = true
                    trialdeviceview2.isHidden = true
                    trialdeviceview3.isHidden = true
                    
                    let trialview0 = viewCon.trialStackView.arrangedSubviews[0] // title
                    let trialview1 = viewCon.trialStackView.arrangedSubviews[1] // line
                    let trialview2 = viewCon.trialStackView.arrangedSubviews[2] // devicelist
                    let trialview3 = viewCon.trialStackView.arrangedSubviews[3] // separator
                    let trialview4 = viewCon.trialStackView.arrangedSubviews[4] // deposit
                    let trialview5 = viewCon.trialStackView.arrangedSubviews[5] // separator
                    let trialview6 = viewCon.trialStackView.arrangedSubviews[6] // timeline
                    let trialview7 = viewCon.trialStackView.arrangedSubviews[7] // button
                    
                    trialview0.isHidden = true
                    trialview1.isHidden = true
                    trialview2.isHidden = true
                    trialview3.isHidden = true
                    trialview4.isHidden = true
                    trialview5.isHidden = true
                    trialview6.isHidden = true
                    trialview7.isHidden = true
                    
                    
                    let trialpickdeviceview0 = viewCon.trialPickDeviceStackView.arrangedSubviews[0] // left
                    let trialpickdeviceview1 = viewCon.trialPickDeviceStackView.arrangedSubviews[1] // right
                    let trialpickdeviceview2 = viewCon.trialPickDeviceStackView.arrangedSubviews[2] // end date
                    let trialpickdeviceview3 = viewCon.trialPickDeviceStackView.arrangedSubviews[3] // security deposit
                    
                    trialpickdeviceview0.isHidden = true
                    trialpickdeviceview1.isHidden = true
                    trialpickdeviceview2.isHidden = true
                    trialpickdeviceview3.isHidden = true
                    
                    let trialPickview0 = viewCon.trialPickStackView.arrangedSubviews[0] // title
                    let trialPickview1 = viewCon.trialPickStackView.arrangedSubviews[1] // line
                    let trialPickview2 = viewCon.trialPickStackView.arrangedSubviews[2] // devicelist
                    let trialPickview3 = viewCon.trialPickStackView.arrangedSubviews[3] // separator
                    let trialPickview4 = viewCon.trialPickStackView.arrangedSubviews[4] // deposit
                    let trialPickview5 = viewCon.trialPickStackView.arrangedSubviews[5] // separator
                    let trialPickview6 = viewCon.trialPickStackView.arrangedSubviews[6] // timeline
                    let trialPickview7 = viewCon.trialPickStackView.arrangedSubviews[7] // button
                    
                    trialPickview0.isHidden = true
                    trialPickview1.isHidden = true
                    trialPickview2.isHidden = true
                    trialPickview3.isHidden = true
                    trialPickview4.isHidden = true
                    trialPickview5.isHidden = true
                    trialPickview6.isHidden = true
                    trialPickview7.isHidden = true
                    
                    let tuningview0 = viewCon.tuningStackView.arrangedSubviews[0] // title
                    let tuningview1 = viewCon.tuningStackView.arrangedSubviews[1] // line
                    let tuningview2 = viewCon.tuningStackView.arrangedSubviews[2] // device list
                    let tuningview3 = viewCon.tuningStackView.arrangedSubviews[3] // separator
                    let tuningview4 = viewCon.tuningStackView.arrangedSubviews[4] // summary list
                    let tuningview5 = viewCon.tuningStackView.arrangedSubviews[5] // separator
                    let tuningview6 = viewCon.tuningStackView.arrangedSubviews[6] // timeline
                    
                    tuningview0.isHidden = true
                    tuningview1.isHidden = true
                    tuningview2.isHidden = true
                    tuningview3.isHidden = true
                    tuningview4.isHidden = true
                    tuningview5.isHidden = true
                    tuningview6.isHidden = true
                    
                    let haserviceview0 = viewCon.serviceStackView.arrangedSubviews[0] // title
                    let haserviceview1 = viewCon.serviceStackView.arrangedSubviews[1] // line
                    let haserviceview2 = viewCon.serviceStackView.arrangedSubviews[2] // device list
                    let haserviceview3 = viewCon.serviceStackView.arrangedSubviews[3] // separator
                    let haserviceview4 = viewCon.serviceStackView.arrangedSubviews[4] // summary list
                    let haserviceview5 = viewCon.serviceStackView.arrangedSubviews[5] // Photo list
                    let haserviceview6 = viewCon.serviceStackView.arrangedSubviews[6] // inital quote
                    let haserviceview7 = viewCon.serviceStackView.arrangedSubviews[7] // revised quote
                    let haserviceview8 = viewCon.serviceStackView.arrangedSubviews[8] // device quote list
                    let haserviceview9 = viewCon.serviceStackView.arrangedSubviews[9] // service charge
                    let haserviceview10 = viewCon.serviceStackView.arrangedSubviews[10] // remark
                    let haserviceview11 = viewCon.serviceStackView.arrangedSubviews[11] // policy
                    let haserviceview12 = viewCon.serviceStackView.arrangedSubviews[12] // button
                    let haserviceview13 = viewCon.serviceStackView.arrangedSubviews[13] // separator
                    let haserviceview14 = viewCon.serviceStackView.arrangedSubviews[14] // tracking list
                    
                    haserviceview0.isHidden = true
                    haserviceview1.isHidden = true
                    haserviceview2.isHidden = true
                    haserviceview3.isHidden = true
                    haserviceview4.isHidden = true
                    haserviceview5.isHidden = true
                    haserviceview6.isHidden = true
                    haserviceview7.isHidden = true
                    haserviceview8.isHidden = true
                    haserviceview9.isHidden = true
                    haserviceview10.isHidden = true
                    haserviceview11.isHidden = true
                    haserviceview12.isHidden = true
                    haserviceview13.isHidden = true
                    haserviceview14.isHidden = true
                    
                    let haservicereturnview0 = viewCon.serviceReturnStackView.arrangedSubviews[0] // title
                    let haservicereturnview1 = viewCon.serviceReturnStackView.arrangedSubviews[1] // line
                    let haservicereturnview2 = viewCon.serviceReturnStackView.arrangedSubviews[2] // device list
                    let haservicereturnview3 = viewCon.serviceReturnStackView.arrangedSubviews[3] // separator
                    let haservicereturnview4 = viewCon.serviceReturnStackView.arrangedSubviews[4] // summary list
                    let haservicereturnview5 = viewCon.serviceReturnStackView.arrangedSubviews[5] // photo list
                    let haservicereturnview6 = viewCon.serviceReturnStackView.arrangedSubviews[6] // inital quote
                    let haservicereturnview7 = viewCon.serviceReturnStackView.arrangedSubviews[7] // revised quote
                    let haservicereturnview8 = viewCon.serviceReturnStackView.arrangedSubviews[8] // device quote list
                    let haservicereturnview9 = viewCon.serviceReturnStackView.arrangedSubviews[9] // servicecharge
                    let haservicereturnview10 = viewCon.serviceReturnStackView.arrangedSubviews[10] // remark
                    let haservicereturnview11 = viewCon.serviceReturnStackView.arrangedSubviews[11] // separator
                    let haservicereturnview12 = viewCon.serviceReturnStackView.arrangedSubviews[12] // tracking list
                    
                    haservicereturnview0.isHidden = true
                    haservicereturnview1.isHidden = true
                    haservicereturnview2.isHidden = true
                    haservicereturnview3.isHidden = true
                    haservicereturnview4.isHidden = true
                    haservicereturnview5.isHidden = true
                    haservicereturnview6.isHidden = true
                    haservicereturnview7.isHidden = true
                    haservicereturnview8.isHidden = true
                    haservicereturnview9.isHidden = true
                    haservicereturnview10.isHidden = true
                    haservicereturnview11.isHidden = true
                    haservicereturnview12.isHidden = true
                    
                    let ocview0 = viewCon.onlineConsultationStackView.arrangedSubviews[0] // title
                    let ocview1 = viewCon.onlineConsultationStackView.arrangedSubviews[1] // line
                    let ocview2 = viewCon.onlineConsultationStackView.arrangedSubviews[2] // concerns
                    let ocview3 = viewCon.onlineConsultationStackView.arrangedSubviews[3] // concerns
                    let ocview4 = viewCon.onlineConsultationStackView.arrangedSubviews[4] // meeting
                    let ocview5 = viewCon.onlineConsultationStackView.arrangedSubviews[5] // separator
                    let ocview6 = viewCon.onlineConsultationStackView.arrangedSubviews[6] // summary
                    let ocview7 = viewCon.onlineConsultationStackView.arrangedSubviews[7] // separator
                    let ocview8 = viewCon.onlineConsultationStackView.arrangedSubviews[8] // tracking
                    
                    ocview0.isHidden = true
                    ocview1.isHidden = true
                    ocview2.isHidden = true
                    ocview3.isHidden = true
                    ocview4.isHidden = true
                    ocview5.isHidden = true
                    ocview6.isHidden = true
                    ocview7.isHidden = true
                    ocview8.isHidden = true
                    
                    let ocinfoview0 = viewCon.onlineConsultationInfoStackView.arrangedSubviews[0] // title
                    let ocinfoview1 = viewCon.onlineConsultationInfoStackView.arrangedSubviews[1] // button
                    let ocinfoview2 = viewCon.onlineConsultationInfoStackView.arrangedSubviews[2] // link
                    ocinfoview0.isHidden = true
                    ocinfoview1.isHidden = true
                    ocinfoview2.isHidden = true
                    
                    self.setintialldata(viewCon: viewCon)
                    // MARK: bookingDetails
                    if json.data!.bookingDetails != nil {
                        var masterServiceName = ""
                        var serviceDate = ""
                        var meetingLink = ""
                        var statusName = ""
                        var otpCode = ""
                        var serviceLocation = ""
                        var statusColor = UIColor.colorLiteral.theme_blue_2AACEF
                        
                        var serviceLocationType = ""
                        
                        var canShowMeetingLink = false
                        var canShowAgentOtp = false
                        var canCancelBooking = false
                        
                        view0.isHidden = false
                        view1.isHidden = false
                        
                        if json.data!.cancelReasonList != nil {
                            viewCon.cancelReasonList = json.data!.cancelReasonList!
                        }
                        if json.data!.canCancelBooking != nil {
                            canCancelBooking = json.data!.canCancelBooking!
                        }
                        if json.data!.bookingDetails != nil {
                            if json.data!.bookingDetails!.canShowMeetingLink != nil {
                                canShowMeetingLink = json.data!.bookingDetails!.canShowMeetingLink!
                            }
                            if json.data!.bookingDetails!.canShowAgentOtp != nil {
                                canShowAgentOtp = json.data!.bookingDetails!.canShowAgentOtp!
                            }
                            if !(json.data!.bookingDetails!.masterServiceName.isNilOrEmpty) {
                                masterServiceName = json.data!.bookingDetails!.masterServiceName!
                            }
                            if !(json.data!.bookingDetails!.serviceDate.isNilOrEmpty) {
                                serviceDate = json.data!.bookingDetails!.serviceDate!
                            }
                            if !(json.data!.bookingDetails!.meetingLink.isNilOrEmpty) {
                                meetingLink = json.data!.bookingDetails!.meetingLink!
                            }
                            if !(json.data!.bookingDetails!.statusName.isNilOrEmpty) {
                                statusName = json.data!.bookingDetails!.statusName!
                            }
                            if !(json.data!.bookingDetails!.otpCode.isNilOrEmpty) {
                                otpCode = json.data!.bookingDetails!.otpCode!
                            }
                            if !(json.data!.bookingDetails!.serviceLocation.isNilOrEmpty) {
                                serviceLocation = json.data!.bookingDetails!.serviceLocation!
                            }
                            if !(json.data!.bookingDetails!.serviceLocationType.isNilOrEmpty) {
                                serviceLocationType = json.data!.bookingDetails!.serviceLocationType!
                            }
                            if !(json.data!.bookingDetails!.statusColor.isNilOrEmpty) {
                                statusColor = UIColor(hexString: json.data!.bookingDetails!.statusColor!, alpha: 1.0)
                            }
                            
                            if !(masterServiceName.isEmpty) {
                                bookingdetailsview0.isHidden = false
                                viewCon.serviceTypeLabel.text = masterServiceName.capitalized
                            }
                            if !(statusName.isEmpty) || !(serviceDate.isEmpty) {
                                bookingdetailsview0.isHidden = false
                                if !(serviceDate.isEmpty) && !(statusName.isEmpty) {
                                    bookingdetailsview0.isHidden = false
                                    let combination = NSMutableAttributedString()
                                    let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let statusFontAttributes = [NSAttributedString.Key.foregroundColor: statusColor, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let date = NSMutableAttributedString(string: String(format: "%@ | ", serviceDate), attributes: dateFontAttributes as [NSAttributedString.Key: Any])
                                    let status = NSMutableAttributedString(string: String(format: "%@", statusName), attributes: statusFontAttributes as [NSAttributedString.Key: Any])
                                    combination.append(date)
                                    combination.append(status)
                                    viewCon.serviceDateStatusLabel.attributedText = combination
                                } else if !(serviceDate.isEmpty) {
                                    bookingdetailsview0.isHidden = false
                                    let combination = NSMutableAttributedString()
                                    let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let date = NSMutableAttributedString(string: String(format: "%@", serviceDate), attributes: dateFontAttributes as [NSAttributedString.Key: Any])
                                    combination.append(date)
                                    viewCon.serviceDateStatusLabel.attributedText = combination
                                } else if !(statusName.isEmpty) {
                                    bookingdetailsview0.isHidden = false
                                    let combination = NSMutableAttributedString()
                                    let statusFontAttributes = [NSAttributedString.Key.foregroundColor: statusColor, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let status = NSMutableAttributedString(string: String(format: "%@", statusName), attributes: statusFontAttributes as [NSAttributedString.Key: Any])
                                    combination.append(status)
                                    viewCon.serviceDateStatusLabel.attributedText = combination
                                }
                            }
                            if !(serviceLocation.isEmpty) {
                                bookingdetailsview1.isHidden = false
                                viewCon.AddressInfoLabel.text = serviceLocation.capitalized
                            }
                            if !(serviceLocationType.isEmpty) {
                                bookingdetailsview1.isHidden = false
                                viewCon.serviceLocationTypeLabel.text = serviceLocationType
                            }
                            if !(otpCode.isEmpty) && (canShowAgentOtp == true) {
                                bookingdetailsview2.isHidden = false
                                viewCon.otpButton.setTitle("\(AppLocalizationString.otpcolon) \(otpCode)", for: .normal)
                            }
                            if !(meetingLink.isEmpty) && (canShowMeetingLink == true) {
                                bookingdetailsview3.isHidden = false
                                viewCon.meetinglinkLabel.text = meetingLink
                            }
                            if !(meetingLink.isEmpty) && (canShowMeetingLink == true) {
                                bookingdetailsview3.isHidden = false
                                viewCon.meetinglinkLabel.text = meetingLink
                            }
                            if (canCancelBooking == true) && (viewCon.cancelReasonList.count > 0) {
                                bookingdetailsview4.isHidden = false
                                bookingbuttonview0.isHidden = false
                                bookingbuttonview1.isHidden = false
                                bookingbuttonview2.isHidden = false
                            } else {
                                bookingdetailsview4.isHidden = false
                                bookingbuttonview2.isHidden = false
                            }
                        }
                    }
                    
                    // MARK: bookingInformation
                    if json.data!.bookingInformation != nil {
                        var bookingID = ""
                        var bookingDate = ""
                        var appointmentDate = ""
                        var bookingAmount = ""
                        var bookingStatusName = ""
                        var cancelledDate = ""
                        var cancellationReason = ""
                        var cancellationComments = ""
                        var refundStatus = ""
                        var refundReqAmount = ""
                        var canShowCancellationDetails = false
                        var canShowRefundDetails = false
                        var bookingStatusColor = UIColor.colorLiteral.theme_blue_2AACEF
                        
                        var customerPatientName = ""
                        var customerPatientAge = ""
                        var customerPatientGender = ""
                        var customerPatientRelationship = ""
                        
                        if json.data!.bookingInformation!.serviceRequestsList != nil {
                            viewCon.serviceRequestsList = json.data!.bookingInformation!.serviceRequestsList!
                        }
                        if json.data!.bookingInformation!.canShowCancellationDetails != nil {
                            canShowCancellationDetails = json.data!.bookingInformation!.canShowCancellationDetails!
                        }
                        if json.data!.bookingInformation!.canShowRefundDetails != nil {
                            canShowRefundDetails = json.data!.bookingInformation!.canShowRefundDetails!
                        }
                        if !(json.data!.bookingInformation!.bookingID.isNilOrEmpty) {
                            bookingID = json.data!.bookingInformation!.bookingID!
                        }
                        if !(json.data!.bookingInformation!.appointmentDate.isNilOrEmpty) {
                            appointmentDate = json.data!.bookingInformation!.appointmentDate!
                        }
                        if !(json.data!.bookingInformation!.bookingDate.isNilOrEmpty) {
                            bookingDate = json.data!.bookingInformation!.bookingDate!
                        }
                        if !(json.data!.bookingInformation!.bookingAmount.isNilOrEmpty) {
                            bookingAmount = json.data!.bookingInformation!.bookingAmount!
                        }
                        if !(json.data!.bookingInformation!.bookingStatusName.isNilOrEmpty) {
                            bookingStatusName = json.data!.bookingInformation!.bookingStatusName!
                        }
                        if !(json.data!.bookingInformation!.bookingStatusColor.isNilOrEmpty) {
                            bookingStatusColor = UIColor(hexString: json.data!.bookingInformation!.bookingStatusColor!, alpha: 1.0)
                        }
                        if !(json.data!.bookingInformation!.cancelledDate.isNilOrEmpty) {
                            cancelledDate = json.data!.bookingInformation!.cancelledDate!
                        }
                        if !(json.data!.bookingInformation!.cancellationReason.isNilOrEmpty) {
                            cancellationReason = json.data!.bookingInformation!.cancellationReason!
                        }
                        if !(json.data!.bookingInformation!.cancellationComments.isNilOrEmpty) {
                            cancellationComments = json.data!.bookingInformation!.cancellationComments!
                        }
                        if !(json.data!.bookingInformation!.refundStatus.isNilOrEmpty) {
                            refundStatus = json.data!.bookingInformation!.refundStatus!
                        }
                        if !(json.data!.bookingInformation!.refundReqAmount.isNilOrEmpty) {
                            refundReqAmount = json.data!.bookingInformation!.refundReqAmount!
                        }
                        if !(json.data!.bookingInformation!.customerPatientName.isNilOrEmpty) {
                            customerPatientName = json.data!.bookingInformation!.customerPatientName!
                        }
                        if !(json.data!.bookingInformation!.customerPatientAge.isNilOrEmpty) {
                            customerPatientAge = json.data!.bookingInformation!.customerPatientAge!
                        }
                        if !(json.data!.bookingInformation!.customerPatientGender.isNilOrEmpty) {
                            customerPatientGender = json.data!.bookingInformation!.customerPatientGender!
                        }
                        if !(json.data!.bookingInformation!.customerPatientRelationship.isNilOrEmpty) {
                            customerPatientRelationship = json.data!.bookingInformation!.customerPatientRelationship!
                        }
                        
                        if !(bookingID.isEmpty) {
                            view2.isHidden = false
                            informationview0.isHidden = false
                            bookingInformationview0.isHidden = false
                            bookingInformationview1.isHidden = false
                            viewCon.bookingIDLabel.text = bookingID
                        }
                        if !(appointmentDate.isEmpty) {
                            view2.isHidden = false
                            informationview0.isHidden = false
                            bookingInformationview0.isHidden = false
                            bookingInformationview2.isHidden = false
                            viewCon.appointmentDateTimeLabel.text = appointmentDate
                        }
                        if !(bookingDate.isEmpty) {
                            view2.isHidden = false
                            informationview0.isHidden = false
                            bookingInformationview0.isHidden = false
                            bookingInformationview3.isHidden = false
                            viewCon.bookingDateLabel.text = bookingDate
                        }
                        if !(bookingAmount.isEmpty) {
                            view2.isHidden = false
                            informationview0.isHidden = false
                            bookingInformationview0.isHidden = false
                            bookingInformationview4.isHidden = false
                            viewCon.bookingAmountLabel.text = bookingAmount
                        }
                        if !(bookingStatusName.isEmpty) {
                            view2.isHidden = false
                            informationview0.isHidden = false
                            bookingInformationview0.isHidden = false
                            bookingInformationview5.isHidden = false
                            let combination = NSMutableAttributedString()
                            let statusFontAttributes = [NSAttributedString.Key.foregroundColor: bookingStatusColor, NSAttributedString.Key.font: AppFont.regular.size(13)]
                            let status = NSMutableAttributedString(string: String(format: "%@", bookingStatusName), attributes: statusFontAttributes as [NSAttributedString.Key: Any])
                            combination.append(status)
                            viewCon.bookingStatusLabel.attributedText = combination
                        }
                        if !(cancelledDate.isEmpty) && (canShowCancellationDetails == true) {
                            view2.isHidden = false
                            informationview0.isHidden = false
                            bookingInformationview0.isHidden = false
                            bookingInformationview6.isHidden = false
                            viewCon.cancellationDateLabel.text = cancelledDate
                        }
                        if !(cancellationReason.isEmpty) && (canShowCancellationDetails == true) {
                            view2.isHidden = false
                            informationview0.isHidden = false
                            bookingInformationview0.isHidden = false
                            bookingInformationview7.isHidden = false
                            viewCon.cancellationReasonLabel.text = cancellationReason
                        }
                        /*Comment is passed by staff not by customer*/
                        //                        if !(cancellationComments.isEmpty) && (canShowCancellationDetails == true) {
                        //                            view2.isHidden = false
                        //                            informationview0.isHidden = false
                        //                            bookingInformationview0.isHidden = false
                        //                            bookingInformationview8.isHidden = false
                        //                            viewCon.cancellationCommentLabel.text = cancellationComments
                        //                        }
                        if !(refundStatus.isEmpty) && (canShowRefundDetails == true) {
                            view2.isHidden = false
                            informationview0.isHidden = false
                            bookingInformationview0.isHidden = false
                            bookingInformationview9.isHidden = false
                            viewCon.refundStatusLabel.text = refundStatus
                        }
                        if !(refundReqAmount.isEmpty) && (canShowRefundDetails == true) {
                            view2.isHidden = false
                            informationview0.isHidden = false
                            bookingInformationview0.isHidden = false
                            bookingInformationview10.isHidden = false
                            viewCon.refundAmountLabel.text = refundReqAmount
                        }
                        if viewCon.serviceRequestsList.count > 0 {
                            view2.isHidden = false
                            informationview1.isHidden = false
                            informationview2.isHidden = false
                            viewCon.reloadServiceQuantityTableView()
                        }
                        if !(customerPatientName.isEmpty) {
                            view2.isHidden = false
                            informationview3.isHidden = false
                            informationview4.isHidden = false
                            patientview0.isHidden = false
                            patientview1.isHidden = false
                            viewCon.patientNameLabel.text = customerPatientName
                        }
                        if !(customerPatientAge.isEmpty) {
                            view2.isHidden = false
                            informationview3.isHidden = false
                            informationview4.isHidden = false
                            patientview0.isHidden = false
                            patientview2.isHidden = false
                            viewCon.patientAgeLabel.text = customerPatientAge
                        }
                        if !(customerPatientGender.isEmpty) {
                            view2.isHidden = false
                            informationview3.isHidden = false
                            informationview4.isHidden = false
                            patientview0.isHidden = false
                            patientview3.isHidden = false
                            viewCon.patientGenderLabel.text = customerPatientGender
                        }
                        if !(customerPatientRelationship.isEmpty) {
                            view2.isHidden = false
                            informationview3.isHidden = false
                            informationview4.isHidden = false
                            patientview0.isHidden = false
                            patientview4.isHidden = false
                            viewCon.patientRelationshipLabel.text = customerPatientRelationship
                        }
                    }
                    
                    if json.data!.serviceStaff != nil {
                        var canShowAgentStaff = false
                        var canShowAudiologistStaff = false
                        if json.data!.serviceStaff!.canShowAgentStaff != nil {
                            canShowAgentStaff = json.data!.serviceStaff!.canShowAgentStaff!
                        }
                        if json.data!.serviceStaff!.canShowAudiologistStaff != nil {
                            canShowAudiologistStaff = json.data!.serviceStaff!.canShowAudiologistStaff!
                        }
                        // MARK: agentDetails
                        
                        if canShowAgentStaff == true {
                            var photo = ""
                            var name = ""
                            var experience = ""
                            var designationName = ""
                            var specialization = ""
                            var specializationDesc = ""
                            var averageRating = ""
                            
                            viewCon.trackLink = ""
                            viewCon.callNumber = ""
                            
                            var isVaccinated = false
                            var canRate = false
                            var canCall = false
                            var canTrack = false
                            
                            if json.data!.serviceStaff!.agentDetails != nil {
                                var agentDetails = json.data!.serviceStaff!.agentDetails!
                                if agentDetails.isVaccinated != nil {
                                    isVaccinated = agentDetails.isVaccinated!
                                }
                                if agentDetails.canRate != nil {
                                    canRate = agentDetails.canRate!
                                }
                                if agentDetails.canTrack != nil {
                                    canTrack = agentDetails.canTrack!
                                }
                                if agentDetails.canCall != nil {
                                    canCall = agentDetails.canCall!
                                }
                                if agentDetails.langPreference != nil {
                                    viewCon.executiveLangPreferenceArray = agentDetails.langPreference!
                                }
                                if !(agentDetails.photo.isNilOrEmpty) {
                                    photo = agentDetails.photo!
                                    viewCon.staffimage = photo
                                    
                                }
                                if !(agentDetails.name.isNilOrEmpty) {
                                    name = agentDetails.name!
                                }
                                if !(agentDetails.designationName.isNilOrEmpty) {
                                    designationName = agentDetails.designationName!
                                }
                                if !(agentDetails.staffID.isNilOrEmpty) {
                                    viewCon.staffid = agentDetails.staffID!
                                }
                                //                                    if (agentDetails.experience.isNilOrEmpty){
                                //                                        experience = agentDetails.experience!
                                //                                    }
                                if !(agentDetails.specialization.isNilOrEmpty) {
                                    specialization = agentDetails.specialization!
                                }
                                if !(agentDetails.designationName.isNilOrEmpty) {
                                    designationName = agentDetails.designationName!
                                }
                                if !(agentDetails.specializationDesc.isNilOrEmpty) {
                                    specializationDesc = agentDetails.specializationDesc!
                                }
                                if !(agentDetails.averageRating.isNilOrEmpty) {
                                    averageRating = agentDetails.averageRating!
                                }
                                if !(agentDetails.trackLink.isNilOrEmpty) {
                                    viewCon.trackLink = agentDetails.trackLink!
                                }
                                if !(agentDetails.callNumber.isNilOrEmpty) {
                                    viewCon.callNumber = agentDetails.callNumber!
                                }
                                
                                viewCon.executiveImageView.setImage(imageUrl: photo, placeHolderImage: profileBlue)
                                self.setExecutiveButton(canRate: canRate, canCall: canCall, canTrack: canTrack, callNumber: viewCon.callNumber, trackLink: viewCon.trackLink, viewCon: viewCon)
                                
                                if !(name.isEmpty) {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview0.isHidden = false
                                    executiveview0.isHidden = false
                                    executiveview1.isHidden = false
                                    executiveview2.isHidden = false
                                    executiveview6.isHidden = false
                                    viewCon.executiveNameLabel.text = name
                                    viewCon.staffname = name
                                }
                                if !(designationName.isEmpty) {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview0.isHidden = false
                                    executiveview0.isHidden = false
                                    executiveview1.isHidden = false
                                    executiveview2.isHidden = false
                                    executiveview6.isHidden = false
                                    viewCon.executiveExperienceLabel.text = designationName
                                    viewCon.staffexperience = designationName
                                }
                                if !(specialization.isEmpty) {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview0.isHidden = false
                                    executiveview0.isHidden = false
                                    executiveview1.isHidden = false
                                    executiveview2.isHidden = false
                                    executiveview6.isHidden = false
                                    viewCon.executiveSpecialisationLabel.text = specialization
                                    viewCon.staffspecialisation = specialization
                                }
                                if !(specializationDesc.isEmpty) {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview0.isHidden = false
                                    executiveview0.isHidden = false
                                    executiveview1.isHidden = false
                                    executiveview3.isHidden = false
                                    executiveview6.isHidden = false
                                    viewCon.executiveContentLabel.text = specializationDesc
                                }
                                executiveinfoview0.isHidden = true
                                executiveinfoview1.isHidden = true
                                
                                if !(averageRating.isEmpty) {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview0.isHidden = false
                                    executiveview0.isHidden = false
                                    executiveview1.isHidden = false
                                    executiveview4.isHidden = false
                                    executiveview6.isHidden = false
                                    executiveinfoview0.isHidden = false
                                    viewCon.executiveRatingLabel.text = averageRating
                                }
                                if isVaccinated == true {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview0.isHidden = false
                                    executiveview0.isHidden = false
                                    executiveview1.isHidden = false
                                    executiveview4.isHidden = false
                                    executiveview6.isHidden = false
                                    executiveinfoview1.isHidden = false
                                }
                                if viewCon.executiveLangPreferenceArray.count > 0 {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview0.isHidden = false
                                    executiveview0.isHidden = false
                                    executiveview1.isHidden = false
                                    executiveview5.isHidden = false
                                    executiveview6.isHidden = false
                                    viewCon.reloadExecutiveTagCollectionView()
                                }
                            }
                        }
                        // MARK: audiologistDetails
                        
                        if canShowAudiologistStaff == true {
                            var photo = ""
                            var name = ""
                            var experience = ""
                            var designationName = ""
                            var specialization = ""
                            var specializationDesc = ""
                            var averageRating = ""
                            var staffID = ""
                            var specializationDegree = ""
                            
                            var isVaccinated = false
                            var canRate = false
                            var canCall = false
                            var canTrack = false
                            
                            if json.data!.serviceStaff!.audiologistDetails != nil {
                                var audiologistDetails = json.data!.serviceStaff!.audiologistDetails!
                                if audiologistDetails.isVaccinated != nil {
                                    isVaccinated = audiologistDetails.isVaccinated!
                                }
                                if audiologistDetails.canRate != nil {
                                    canRate = audiologistDetails.canRate!
                                }
                                if audiologistDetails.canTrack != nil {
                                    canTrack = audiologistDetails.canTrack!
                                }
                                if audiologistDetails.canCall != nil {
                                    canCall = audiologistDetails.canCall!
                                }
                                if audiologistDetails.langPreference != nil {
                                    viewCon.audiologistLangPreferenceArray = audiologistDetails.langPreference!
                                }
                                if !(audiologistDetails.name.isNilOrEmpty) {
                                    name = audiologistDetails.name!
                                }
                                if !(audiologistDetails.staffID.isNilOrEmpty) {
                                    viewCon.audiologistid = audiologistDetails.staffID!
                                }
                                if !(audiologistDetails.photo.isNilOrEmpty) {
                                    photo = audiologistDetails.photo!
                                    viewCon.audiologistimage = audiologistDetails.photo!
                                }
                                if !(audiologistDetails.designationName.isNilOrEmpty) {
                                    designationName = audiologistDetails.designationName!
                                }
                                if !(audiologistDetails.experience.isNilOrEmpty) {
                                    experience = audiologistDetails.experience!
                                }
                                if !(audiologistDetails.specialization.isNilOrEmpty) {
                                    specialization = audiologistDetails.specialization!
                                }
                                if !(audiologistDetails.specializationDesc.isNilOrEmpty) {
                                    specializationDesc = audiologistDetails.specializationDesc!
                                }
                                if !(audiologistDetails.averageRating.isNilOrEmpty) {
                                    averageRating = audiologistDetails.averageRating!
                                }
                                if !(audiologistDetails.specializationDegree.isNilOrEmpty) {
                                    specializationDegree = audiologistDetails.specializationDegree!
                                }
                                var experiencemess = ""
                                
                                if !(specializationDegree.isEmpty) && !(experience.isEmpty) {
                                    experiencemess = "\(specializationDegree) (\(experience))"
                                } else if !(specializationDegree.isEmpty) {
                                    experiencemess = specializationDegree
                                } else if !(experience.isEmpty) {
                                    experiencemess = experience
                                }
                                viewCon.audiologistImageView.setImage(imageUrl: photo, placeHolderImage: profileBlue)
                                self.setAudiologistButton(canRate: canRate, canCall: canCall, canTrack: canTrack, callNumber: viewCon.callNumber, trackLink: viewCon.trackLink, viewCon: viewCon)
                                
                                if !(name.isEmpty) {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview1.isHidden = false
                                    audiologistview0.isHidden = false
                                    audiologistview1.isHidden = false
                                    audiologistview2.isHidden = false
                                    audiologistview6.isHidden = false
                                    viewCon.audiologistNameLabel.text = name
                                    viewCon.audiologistname = name
                                }
                                if !(experiencemess.isEmpty) {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview1.isHidden = false
                                    audiologistview0.isHidden = false
                                    audiologistview1.isHidden = false
                                    audiologistview2.isHidden = false
                                    audiologistview6.isHidden = false
                                    viewCon.audiologistExperienceLabel.text = experiencemess
                                    viewCon.audiologistexperience = experiencemess
                                }
                                if !(specialization.isEmpty) {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview1.isHidden = false
                                    audiologistview0.isHidden = false
                                    audiologistview1.isHidden = false
                                    audiologistview2.isHidden = false
                                    audiologistview6.isHidden = false
                                    viewCon.audiologistSpecialisationLabel.text = specialization
                                    viewCon.audiologistspecialisation = specialization
                                }
                                if !(specializationDesc.isEmpty) {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview1.isHidden = false
                                    audiologistview0.isHidden = false
                                    audiologistview1.isHidden = false
                                    audiologistview3.isHidden = false
                                    audiologistview6.isHidden = false
                                    viewCon.audiologistContentLabel.text = specializationDesc
                                }
                                audiologistinfoview0.isHidden = true
                                audiologistinfoview1.isHidden = true
                                
                                if !(averageRating.isEmpty) {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview1.isHidden = false
                                    audiologistview0.isHidden = false
                                    audiologistview1.isHidden = false
                                    audiologistview4.isHidden = false
                                    audiologistview6.isHidden = false
                                    audiologistinfoview0.isHidden = false
                                    viewCon.audiologistRatingLabel.text = averageRating
                                }
                                if isVaccinated == true {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview1.isHidden = false
                                    audiologistview0.isHidden = false
                                    audiologistview1.isHidden = false
                                    audiologistview4.isHidden = false
                                    audiologistview6.isHidden = false
                                    audiologistinfoview1.isHidden = false
                                }
                                if viewCon.audiologistLangPreferenceArray.count > 0 {
                                    view3.isHidden = false
                                    view4.isHidden = false
                                    staffDetailsview1.isHidden = false
                                    audiologistview0.isHidden = false
                                    audiologistview1.isHidden = false
                                    audiologistview5.isHidden = false
                                    audiologistview6.isHidden = false
                                    viewCon.reloadAudiologistTagCollectionView()
                                }
                            }
                        }
                    }
                    if json.data!.serviceRequestList != nil {
                        
                        var canShowOnlineConsultation = false
                        var canShowTrial = false
                        var canShowTunning = false
                        var canShowHearingAidService = false
                        var canShowHearingAidServiceReturn = false
                        var canShowAudiogramTest = false
                        var canShowTrialpickup = false
                        var canShowOrderDelivery = false
                        
                        if json.data!.serviceRequestList!.canShowOnlineConsultation != nil {
                            canShowOnlineConsultation = json.data!.serviceRequestList!.canShowOnlineConsultation!
                        }
                        if json.data!.serviceRequestList!.canShowTrial != nil {
                            canShowTrial = json.data!.serviceRequestList!.canShowTrial!
                        }
                        if json.data!.serviceRequestList!.canShowTunning != nil {
                            canShowTunning = json.data!.serviceRequestList!.canShowTunning!
                        }
                        if json.data!.serviceRequestList!.canShowHearingAidService != nil {
                            canShowHearingAidService = json.data!.serviceRequestList!.canShowHearingAidService!
                        }
                        if json.data!.serviceRequestList!.canShowHearingAidServiceReturn != nil {
                            canShowHearingAidServiceReturn = json.data!.serviceRequestList!.canShowHearingAidServiceReturn!
                        }
                        if json.data!.serviceRequestList!.canShowAudiogramTest != nil {
                            canShowAudiogramTest = json.data!.serviceRequestList!.canShowAudiogramTest!
                        }
                        if json.data!.serviceRequestList!.canShowTrialpickup != nil {
                            canShowTrialpickup = json.data!.serviceRequestList!.canShowTrialpickup!
                        }
                        if json.data!.serviceRequestList!.canShowOnlineConsultation != nil {
                            canShowOnlineConsultation = json.data!.serviceRequestList!.canShowOnlineConsultation!
                        }
                        
                        // MARK: audiogramTest
                        if canShowAudiogramTest == true {
                            var audiogramTest = SRDModelAudiogramTest()
                            if json.data!.serviceRequestList!.audiogramTest != nil {
                                audiogramTest = json.data!.serviceRequestList!.audiogramTest!
                                var serviceName = ""
                                var serviceStatus = ""
                                viewCon.downloadReportLink = ""
                                var serviceColor = UIColor.colorLiteral.theme_blue_2AACEF
                                
                                var canShowDownloadReport = false
                                
                                viewCon.audiogramStatus.setTitle(serviceStatus, for: .normal)
                                viewCon.audiogramStatus.isHidden = true
                                if !(audiogramTest.serviceName.isNilOrEmpty) {
                                    serviceName = audiogramTest.serviceName!
                                }
                                if !(audiogramTest.serviceStatus.isNilOrEmpty) {
                                    serviceStatus = audiogramTest.serviceStatus!
                                }
                                if !(audiogramTest.serviceColor.isNilOrEmpty) {
                                    serviceColor = UIColor.init(hexString: audiogramTest.serviceColor!, alpha: 1.0)
                                }
                                if !(audiogramTest.downloadReportLink.isNilOrEmpty) {
                                    viewCon.downloadReportLink = audiogramTest.downloadReportLink!
                                }
                                if audiogramTest.canShowDownloadReport != nil {
                                    canShowDownloadReport = audiogramTest.canShowDownloadReport!
                                }
                                if audiogramTest.serviceTimeline != nil {
                                    viewCon.audiogramTimelineList = audiogramTest.serviceTimeline!
                                }
                                
                                if !(serviceName.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview0.isHidden = false
                                    audiogramview0.isHidden = false
                                    viewCon.audiogramTitleLabel.text = serviceName
                                }
                                if !(serviceStatus.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview0.isHidden = false
                                    audiogramview0.isHidden = false
                                    viewCon.audiogramStatus.setTitle(serviceStatus, for: .normal)
                                    viewCon.audiogramStatus.setTitleColor(serviceColor, for: .normal)
                                    viewCon.audiogramStatus.isHidden = false
                                }
                                if viewCon.audiogramTimelineList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview0.isHidden = false
                                    audiogramview1.isHidden = false
                                    audiogramview2.isHidden = false
                                    viewCon.reloadAudiogramTimelineTableView()
                                }
                                if (canShowDownloadReport == true) && !(viewCon.downloadReportLink.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview0.isHidden = false
                                    audiogramview1.isHidden = false
                                    audiogramview3.isHidden = false
                                }
                            }
                        }
                        
                        // MARK: trial
                        if canShowTrial == true {
                            var trial = SRDModelTrial()
                            if json.data!.serviceRequestList!.trial != nil {
                                trial = json.data!.serviceRequestList!.trial!
                                var serviceName = ""
                                var serviceStatus = ""
                                var serviceColor = UIColor.colorLiteral.theme_blue_2AACEF
                                
                                var securityDeposit = ""
                                var trialLeftDevice = "-"
                                var trialRightDevice = "-"
                                var trialEndsOn = ""
                                var trialEndsOnDays = ""
                                
                                viewCon.trialStatus.setTitle(serviceStatus, for: .normal)
                                viewCon.trialStatus.isHidden = true
                                
                                if !(trial.serviceName.isNilOrEmpty) {
                                    serviceName = trial.serviceName!
                                }
                                if !(trial.serviceStatus.isNilOrEmpty) {
                                    serviceStatus = trial.serviceStatus!
                                }
                                if !(trial.securityDeposit.isNilOrEmpty) {
                                    securityDeposit = trial.securityDeposit!
                                }
                                if !(trial.trialLeftDevice.isNilOrEmpty) {
                                    trialLeftDevice = trial.trialLeftDevice!
                                }
                                if !(trial.trialRightDevice.isNilOrEmpty) {
                                    trialRightDevice = trial.trialRightDevice!
                                }
                                if !(trial.trialEndsOn.isNilOrEmpty) {
                                    trialEndsOn = trial.trialEndsOn!
                                }
                                if !(trial.trialEndsOnDays.isNilOrEmpty) {
                                    let EndsOnDays = trial.trialEndsOnDays!
                                    if EndsOnDays.contains("-") {
                                        trialEndsOnDays = ""
                                    } else if EndsOnDays == "0" {
                                        trialEndsOnDays = String(format: "%@", AppLocalizationString.today)
                                    } else if  EndsOnDays == "1" {
                                        trialEndsOnDays = String(format: "%@ %@", EndsOnDays, AppLocalizationString.day)
                                    } else {
                                        trialEndsOnDays = String(format: "%@ %@", EndsOnDays, AppLocalizationString.days)
                                    }
                                }
                                if !(trial.serviceColor.isNilOrEmpty) {
                                    serviceColor = UIColor.init(hexString: trial.serviceColor!, alpha: 1.0)
                                }
                                
                                if trial.serviceTimeline != nil {
                                    viewCon.trialTimelineList = trial.serviceTimeline!
                                }
                                
                                if !(serviceName.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview1.isHidden = false
                                    trialview0.isHidden = false
                                    viewCon.trialTitleLabel.text = serviceName
                                }
                                if !(serviceStatus.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview1.isHidden = false
                                    trialview0.isHidden = false
                                    viewCon.trialStatus.setTitle(serviceStatus, for: .normal)
                                    viewCon.trialStatus.setTitleColor(serviceColor, for: .normal)
                                    viewCon.trialStatus.isHidden = false
                                }
                                view5.isHidden = false
                                view6.isHidden = false
                                serviceview1.isHidden = false
                                trialview1.isHidden = false
                                trialview2.isHidden = false
                                
                                viewCon.trialLeftDeviceLabel.text = trialLeftDevice
                                viewCon.trialRightDeviceLabel.text = trialRightDevice
                                
                                trialdeviceview0.isHidden = false
                                trialdeviceview1.isHidden = false
                                trialdeviceview2.isHidden = false
                                
                                if !(trialEndsOn.isEmpty) && !(trialEndsOnDays.isEmpty) {
                                    let combination = NSMutableAttributedString()
                                    let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_black_333333, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let statusFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_red_FF6961, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let date = NSMutableAttributedString(string: String(format: "%@ ", trialEndsOn), attributes: dateFontAttributes as [NSAttributedString.Key: Any])
                                    let status = NSMutableAttributedString(string: String(format: "(%@)", trialEndsOnDays), attributes: statusFontAttributes as [NSAttributedString.Key: Any])
                                    combination.append(date)
                                    combination.append(status)
                                    viewCon.trialEndDateLabel.attributedText = combination
                                } else if !(trialEndsOn.isEmpty) {
                                    let combination = NSMutableAttributedString()
                                    let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_black_333333, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let date = NSMutableAttributedString(string: String(format: "%@ ", trialEndsOn), attributes: dateFontAttributes as [NSAttributedString.Key: Any])
                                    combination.append(date)
                                    viewCon.trialEndDateLabel.attributedText = combination
                                    
                                } else if !(trialEndsOnDays.isEmpty) {
                                    let combination = NSMutableAttributedString()
                                    let statusFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_red_FF6961, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let status = NSMutableAttributedString(string: String(format: "%@", trialEndsOnDays), attributes: statusFontAttributes as [NSAttributedString.Key: Any])
                                    combination.append(status)
                                    viewCon.trialEndDateLabel.attributedText = combination
                                } else {
                                    viewCon.trialEndDateLabel.text = "-"
                                }
                                
                                if !(securityDeposit.isEmpty) {
                                    viewCon.trialSecurityDepositLabel.text = securityDeposit
                                } else {
                                    viewCon.trialSecurityDepositLabel.text = "-"
                                }
                                if !(securityDeposit.isEmpty) {
                                    if (securityDeposit != "0.00") && (securityDeposit != "0") && (securityDeposit != "Rs. 0.00") && (securityDeposit != "Rs.0.00") {
                                        view5.isHidden = false
                                        view6.isHidden = false
                                        serviceview1.isHidden = false
                                        trialdeviceview3.isHidden = false
                                        if (securityDeposit != "-"){
                                            trialview3.isHidden = false
                                            trialview4.isHidden = false
                                            viewCon.trialDepositMessageLabel.text = String(format: "A security deposit of %@ will be collected during the trial period which will be refunded after the trial pick-up.", securityDeposit)
                                        }
                                    }
                                } else {
                                    viewCon.trialDepositMessageLabel.text = ""
                                }
                                
                                if viewCon.trialTimelineList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview1.isHidden = false
                                    trialview5.isHidden = false
                                    trialview6.isHidden = false
                                    viewCon.reloadTrialTimelineTableView()
                                }
                                view5.isHidden = false
                                view6.isHidden = false
                                serviceview1.isHidden = false
                                trialview5.isHidden = false
                                trialview7.isHidden = false
                            }
                        }
                        
                        // MARK: trialpickup
                        if canShowTrialpickup == true {
                            var trialpickup = SRDModelTrialpickup()
                            
                            if json.data!.serviceRequestList!.trialpickup != nil {
                                trialpickup = json.data!.serviceRequestList!.trialpickup!
                                var serviceName = ""
                                var serviceStatus = ""
                                var serviceColor = UIColor.colorLiteral.theme_blue_2AACEF
                                
                                var securityDeposit = ""
                                var trialLeftDevice = "-"
                                var trialRightDevice = "-"
                                var trialEndsOn = ""
                                var trialEndsOnDays = ""
                                
                                viewCon.trialPickStatus.setTitle(serviceStatus, for: .normal)
                                viewCon.trialPickStatus.isHidden = true
                                
                                if !(trialpickup.serviceName.isNilOrEmpty) {
                                    serviceName = trialpickup.serviceName!
                                }
                                if !(trialpickup.serviceStatus.isNilOrEmpty) {
                                    serviceStatus = trialpickup.serviceStatus!
                                }
                                if !(trialpickup.securityDeposit.isNilOrEmpty) {
                                    securityDeposit = trialpickup.securityDeposit!
                                }
                                if !(trialpickup.trialLeftDevice.isNilOrEmpty) {
                                    trialLeftDevice = trialpickup.trialLeftDevice!
                                }
                                if !(trialpickup.trialRightDevice.isNilOrEmpty) {
                                    trialRightDevice = trialpickup.trialRightDevice!
                                }
                                if !(trialpickup.trialEndsOn.isNilOrEmpty) {
                                    trialEndsOn = trialpickup.trialEndsOn!
                                }
                                if !(trialpickup.trialEndsOnDays.isNilOrEmpty) {
                                    let EndsOnDays = trialpickup.trialEndsOnDays!
                                    if EndsOnDays.contains("-") {
                                        trialEndsOnDays = ""
                                    } else if EndsOnDays == "0" {
                                        trialEndsOnDays = String(format: "%@", AppLocalizationString.today)
                                    } else if  EndsOnDays == "1" {
                                        trialEndsOnDays = String(format: "%@ %@", EndsOnDays, AppLocalizationString.day)
                                    } else {
                                        trialEndsOnDays = String(format: "%@ %@", EndsOnDays, AppLocalizationString.days)
                                    }
                                }
                                if !(trialpickup.serviceColor.isNilOrEmpty) {
                                    serviceColor = UIColor.init(hexString: trialpickup.serviceColor!, alpha: 1.0)
                                }
                                
                                if trialpickup.serviceTimeline != nil {
                                    viewCon.trialPickTimelineList = trialpickup.serviceTimeline!
                                }
                                
                                if !(serviceName.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview2.isHidden = false
                                    trialPickview0.isHidden = false
                                    viewCon.trialPickTitleLabel.text = serviceName
                                }
                                if !(serviceStatus.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview2.isHidden = false
                                    trialPickview0.isHidden = false
                                    viewCon.trialPickStatus.setTitle(serviceStatus, for: .normal)
                                    viewCon.trialPickStatus.setTitleColor(serviceColor, for: .normal)
                                    viewCon.trialPickStatus.isHidden = false
                                }
                                view5.isHidden = false
                                view6.isHidden = false
                                serviceview2.isHidden = false
                                trialPickview1.isHidden = false
                                trialPickview2.isHidden = false
                                
                                viewCon.trialPickLeftDeviceLabel.text = trialLeftDevice
                                viewCon.trialPickRightDeviceLabel.text = trialRightDevice
                                trialpickdeviceview0.isHidden = false
                                trialpickdeviceview1.isHidden = false
                                trialpickdeviceview2.isHidden = false
                                
                                
                                if !(trialEndsOn.isEmpty) && !(trialEndsOnDays.isEmpty) {
                                    let combination = NSMutableAttributedString()
                                    let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_black_333333, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let statusFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_red_FF6961, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let date = NSMutableAttributedString(string: String(format: "%@ ", trialEndsOn), attributes: dateFontAttributes as [NSAttributedString.Key: Any])
                                    let status = NSMutableAttributedString(string: String(format: "(%@)", trialEndsOnDays), attributes: statusFontAttributes as [NSAttributedString.Key: Any])
                                    combination.append(date)
                                    combination.append(status)
                                    viewCon.trialPickEndDateLabel.attributedText = combination
                                } else if !(trialEndsOn.isEmpty) {
                                    let combination = NSMutableAttributedString()
                                    let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_black_333333, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let date = NSMutableAttributedString(string: String(format: "%@ ", trialEndsOn), attributes: dateFontAttributes as [NSAttributedString.Key: Any])
                                    combination.append(date)
                                    viewCon.trialPickEndDateLabel.attributedText = combination
                                    
                                } else if !(trialEndsOnDays.isEmpty) {
                                    let combination = NSMutableAttributedString()
                                    let statusFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_red_FF6961, NSAttributedString.Key.font: AppFont.regular.size(13)]
                                    let status = NSMutableAttributedString(string: String(format: "%@", trialEndsOnDays), attributes: statusFontAttributes as [NSAttributedString.Key: Any])
                                    combination.append(status)
                                    viewCon.trialPickEndDateLabel.attributedText = combination
                                } else {
                                    viewCon.trialPickEndDateLabel.text = "-"
                                }
                                
                                if !(securityDeposit.isEmpty) {
                                    viewCon.trialPickSecurityDepositLabel.text = securityDeposit
                                } else {
                                    viewCon.trialPickSecurityDepositLabel.text = "-"
                                }
                                if !(securityDeposit.isEmpty) {
                                    if (securityDeposit != "0.00") && (securityDeposit != "0") && (securityDeposit != "Rs. 0.00") && (securityDeposit != "Rs.0.00"){
                                        view5.isHidden = false
                                        view6.isHidden = false
                                        serviceview2.isHidden = false
                                        trialpickdeviceview3.isHidden = false
                                        if (securityDeposit != "-"){
                                            trialPickview3.isHidden = false
                                            trialPickview4.isHidden = false
                                            viewCon.trialPickDepositMessageLabel.text = String(format: "A Security deposit amount of %@ will be refunded by our staff after collecting the Hearing aids.", securityDeposit)
                                        }
                                    }
                                } else {
                                    viewCon.trialPickDepositMessageLabel.text = ""
                                }
                                
                                if viewCon.trialPickTimelineList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview2.isHidden = false
                                    trialPickview5.isHidden = false
                                    trialPickview6.isHidden = false
                                    viewCon.reloadTrialPickTimelineTableView()
                                }
                                view5.isHidden = false
                                view6.isHidden = false
                                serviceview2.isHidden = false
                                trialPickview5.isHidden = false
                                trialPickview7.isHidden = false
                            }
                        }
                        
                        // MARK: tuning
                        if canShowTunning == true {
                            var tuning = SRDModelTunning()
                            if json.data!.serviceRequestList!.tunning != nil {
                                tuning = json.data!.serviceRequestList!.tunning!
                                
                                var serviceName = ""
                                var serviceStatus = ""
                                var serviceColor = UIColor.colorLiteral.theme_blue_2AACEF
                                
                                var canShowSummary = false
                                
                                viewCon.tuningStatus.setTitle(serviceStatus, for: .normal)
                                viewCon.tuningStatus.isHidden = true
                                
                                if !(tuning.serviceName.isNilOrEmpty) {
                                    serviceName = tuning.serviceName!
                                }
                                if !(tuning.serviceStatus.isNilOrEmpty) {
                                    serviceStatus = tuning.serviceStatus!
                                }
                                if !(tuning.serviceColor.isNilOrEmpty) {
                                    serviceColor = UIColor.init(hexString: tuning.serviceColor!, alpha: 1.0)
                                }
                                if tuning.serviceTimeline != nil {
                                    viewCon.tuningTimelineList = tuning.serviceTimeline!
                                }
                                if tuning.tuningComplaint != nil {
                                    viewCon.tuningSummaryList = tuning.tuningComplaint!
                                    viewCon.tuningDeviceList = tuning.tuningComplaint!
                                }
                                if tuning.canShowSummary != nil {
                                    canShowSummary = tuning.canShowSummary!
                                }
                                if !(serviceName.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview3.isHidden = false
                                    tuningview0.isHidden = false
                                    viewCon.tuningTitleLabel.text = serviceName
                                }
                                if !(serviceStatus.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview3.isHidden = false
                                    tuningview0.isHidden = false
                                    viewCon.tuningStatus.setTitle(serviceStatus, for: .normal)
                                    viewCon.tuningStatus.setTitleColor(serviceColor, for: .normal)
                                    viewCon.tuningStatus.isHidden = false
                                }
                                
                                if viewCon.tuningDeviceList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview3.isHidden = false
                                    tuningview1.isHidden = false
                                    tuningview2.isHidden = false
                                    viewCon.reloadTuningDeviceListTableView()
                                }
                                
                                if canShowSummary == true {
                                    if viewCon.tuningSummaryList.count > 0 {
                                        if !(serviceName.isEmpty) {
                                            viewCon.tuningSummaryLabel.text = String(format: "%@ %@", serviceName, AppLocalizationString.summary)
                                        } else {
                                            viewCon.tuningSummaryLabel.text = AppLocalizationString.summary
                                        }
                                        view5.isHidden = false
                                        view6.isHidden = false
                                        serviceview3.isHidden = false
                                        tuningview3.isHidden = false
                                        tuningview4.isHidden = false
                                        viewCon.reloadTuningSummaryTableView()
                                    }
                                }
                                if viewCon.tuningTimelineList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview3.isHidden = false
                                    tuningview5.isHidden = false
                                    tuningview6.isHidden = false
                                    viewCon.reloadtuningTimelineTableView()
                                }
                            }
                        }
                        
                        // MARK: haservice
                        if canShowHearingAidService == true {
                            var haservice = SRDModelHearingAidService()
                            if json.data!.serviceRequestList!.hearingAidService != nil {
                                haservice = json.data!.serviceRequestList!.hearingAidService!
                                
                                var serviceName = ""
                                var serviceStatus = ""
                                var serviceColor = UIColor.colorLiteral.theme_blue_2AACEF
                                var serviceCharge = ""
                                var initialQuote = ""
                                var revisedQuote = ""
                                var remarks = ""
                                var canShowSummary = false
                                var canShowApproval = false
                                var canShowRemarks = false
                                var canShowRevisedQuote = false
                                viewCon.hearingAidServicePhotoList.removeAll()
                                viewCon.serviceuid = ""
                                
                                viewCon.serviceStatus.setTitle(serviceStatus, for: .normal)
                                viewCon.serviceStatus.isHidden = true
                                
                                if haservice.canShowSummary != nil {
                                    canShowSummary = haservice.canShowSummary!
                                }
                                if haservice.canShowApproval != nil {
                                    canShowApproval = haservice.canShowApproval!
                                }
                                if haservice.canShowRemarks != nil {
                                    canShowRemarks = haservice.canShowRemarks!
                                }
                                if haservice.canShowRevisedQuote != nil {
                                    canShowRevisedQuote = haservice.canShowRevisedQuote!
                                }
                                if !(haservice.serviceName.isNilOrEmpty) {
                                    serviceName = haservice.serviceName!
                                }
                                if !(haservice.serviceStatus.isNilOrEmpty) {
                                    serviceStatus = haservice.serviceStatus!
                                }
                                if !(haservice.serviceColor.isNilOrEmpty) {
                                    serviceColor = UIColor.init(hexString: haservice.serviceColor!, alpha: 1.0)
                                }
                                if !(haservice.serviceCharge.isNilOrEmpty) {
                                    serviceCharge = haservice.serviceCharge!
                                }
                                if !(haservice.serviceUid.isNilOrEmpty) {
                                    viewCon.serviceuid = haservice.serviceUid!
                                }
                                if !(haservice.initialQuote.isNilOrEmpty) {
                                    initialQuote = haservice.initialQuote!
                                }
                                if !(haservice.revisedQuote.isNilOrEmpty) {
                                    revisedQuote = haservice.revisedQuote!
                                }
                                if !(haservice.remarks.isNilOrEmpty) {
                                    remarks = haservice.remarks!
                                }
                                
                                if haservice.serviceTimeline != nil {
                                    viewCon.hearingAidServiceTimelineList = haservice.serviceTimeline!
                                }
                                if haservice.serviceDevices != nil {
                                    viewCon.hearingAidServiceDeviceList = haservice.serviceDevices!
                                }
                                if haservice.canShowSummary != nil {
                                    canShowSummary = haservice.canShowSummary!
                                    if canShowSummary == true {
                                        if haservice.serviceDevices != nil {
                                            viewCon.hearingAidServiceSummaryList = haservice.serviceDevices!
                                        }
                                    }
                                }
                                if haservice.photoList != nil {
                                    viewCon.hearingAidServicePhotoList = haservice.photoList!
                                }
                                if !(serviceName.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview4.isHidden = false
                                    haserviceview0.isHidden = false
                                    viewCon.serviceTitleLabel.text = serviceName
                                }
                                if !(serviceStatus.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview4.isHidden = false
                                    haserviceview0.isHidden = false
                                    viewCon.serviceStatus.setTitle(serviceStatus, for: .normal)
                                    viewCon.serviceStatus.setTitleColor(serviceColor, for: .normal)
                                    viewCon.serviceStatus.isHidden = false
                                }
                                if viewCon.hearingAidServiceDeviceList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview4.isHidden = false
                                    haserviceview1.isHidden = false
                                    haserviceview2.isHidden = false
                                    viewCon.reloadServiceDeviceListTableView()
                                }
                                if viewCon.hearingAidServicePhotoList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview4.isHidden = false
                                    haserviceview3.isHidden = false
                                    haserviceview4.isHidden = false
                                    haserviceview5.isHidden = false
                                    viewCon.reloadServicePhotoCollectionView()
                                }
                                if !(initialQuote.isEmpty) {
                                    if (initialQuote != "0.00") && (initialQuote != "0") && (initialQuote != "Rs. 0.00") && (initialQuote != "Rs.0.00"){
                                        view5.isHidden = false
                                        view6.isHidden = false
                                        serviceview4.isHidden = false
                                        haserviceview3.isHidden = false
                                        haserviceview6.isHidden = false
                                        if initialQuote.contains("Rs.") {
                                            viewCon.intialQuoteLabel.text = initialQuote
                                        } else {
                                            viewCon.intialQuoteLabel.text = String(format: "%@ %@", AppConstantValue.rupeesymbol, initialQuote)
                                        }
                                    }
                                }
                                if !(revisedQuote.isEmpty) && (canShowRevisedQuote == true){
                                    if (revisedQuote != "0.00") && (revisedQuote != "0") && (revisedQuote != "Rs. 0.00") && (revisedQuote != "Rs.0.00"){
                                        view5.isHidden = false
                                        view6.isHidden = false
                                        serviceview4.isHidden = false
                                        haserviceview3.isHidden = false
                                        haserviceview7.isHidden = false
                                        if revisedQuote.contains("Rs.") {
                                            viewCon.revisedQuoteLabel.text = revisedQuote
                                        } else {
                                            viewCon.revisedQuoteLabel.text = String(format: "%@ %@", AppConstantValue.rupeesymbol, revisedQuote)
                                        }
                                    }
                                }
                                
                                if (viewCon.hearingAidServiceSummaryList.count > 0) && canShowSummary == true {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview4.isHidden = false
                                    haserviceview3.isHidden = false
                                    haserviceview8.isHidden = false
                                    viewCon.reloadServiceDeviceQuoteTableView()
                                    if !(serviceName.isEmpty) {
                                        viewCon.serviceSummaryTitleLabel.text = String(format: "%@ %@", serviceName, AppLocalizationString.summary)
                                    } else {
                                        viewCon.serviceSummaryTitleLabel.text = AppLocalizationString.summary
                                    }
                                }
                                
                                if !(serviceCharge.isEmpty) {
                                    if (serviceCharge != "0.00") && (serviceCharge != "0") && (serviceCharge != "Rs. 0.00") && (serviceCharge != "Rs.0.00"){
                                        view5.isHidden = false
                                        view6.isHidden = false
                                        serviceview4.isHidden = false
                                        haserviceview3.isHidden = false
                                        haserviceview9.isHidden = false
                                        if revisedQuote.contains("Rs.") {
                                            viewCon.serviceChargeLabel.text = serviceCharge
                                        } else {
                                            viewCon.serviceChargeLabel.text = String(format: "%@ %@", AppConstantValue.rupeesymbol, serviceCharge)
                                        }
                                    }
                                }
                                if !(remarks.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview4.isHidden = false
                                    haserviceview3.isHidden = false
                                    haserviceview10.isHidden = false
                                    viewCon.remarkLabel.text = remarks
                                }
                                if canShowApproval == true {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview4.isHidden = false
                                    haserviceview3.isHidden = false
                                    haserviceview11.isHidden = false
                                    haserviceview12.isHidden = false
                                    
                                    if viewCon.isTermsSelected == false {
                                        viewCon.setButtonDisable()
                                    } else {
                                        viewCon.setButtonEnable()
                                    }
                                } else {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview4.isHidden = false
                                    haserviceview3.isHidden = false
                                    haserviceview12.isHidden = false
                                    viewCon.setButtonDisable()
                                }
                                
                                if viewCon.hearingAidServiceTimelineList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview4.isHidden = false
                                    haserviceview14.isHidden = false
                                    haserviceview14.isHidden = false
                                    viewCon.reloadServiceTimelineTableView()
                                }
                            }
                        }
                        
                        // MARK: haserviceReturn
                        if canShowHearingAidServiceReturn == true {
                            var haservice = SRDModelHearingAidServiceReturn()
                            if json.data!.serviceRequestList!.hearingAidServiceReturn != nil {
                                haservice = json.data!.serviceRequestList!.hearingAidServiceReturn!
                                
                                var serviceName = ""
                                var serviceStatus = ""
                                var serviceColor = UIColor.colorLiteral.theme_blue_2AACEF
                                var serviceCharge = ""
                                var initialQuote = ""
                                var revisedQuote = ""
                                var serviceFeedback = ""
                                var canShowSummary = false
                                var canShowFeedback = false
                                
                                viewCon.serviceReturnStatus.setTitle(serviceStatus, for: .normal)
                                viewCon.serviceReturnStatus.isHidden = true
                                viewCon.hearingAidServiceReturnPhotoList.removeAll()
                                
                                if haservice.canShowFeedback != nil {
                                    canShowFeedback = haservice.canShowFeedback!
                                }
                                
                                if !(haservice.serviceName.isNilOrEmpty) {
                                    serviceName = haservice.serviceName!
                                }
                                if !(haservice.serviceStatus.isNilOrEmpty) {
                                    serviceStatus = haservice.serviceStatus!
                                }
                                if !(haservice.serviceColor.isNilOrEmpty) {
                                    serviceColor = UIColor.init(hexString: haservice.serviceColor!, alpha: 1.0)
                                }
                                if !(haservice.serviceFeedback.isNilOrEmpty) {
                                    serviceFeedback = haservice.serviceFeedback!
                                }
                                
                                if haservice.serviceTimeline != nil {
                                    viewCon.hearingAidServiceReturnTimelineList = haservice.serviceTimeline!
                                }
                                if haservice.serviceDevices != nil {
                                    viewCon.hearingAidServiceReturnDeviceList = haservice.serviceDevices!
                                }
                                
                                if !(serviceName.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview5.isHidden = false
                                    haservicereturnview0.isHidden = false
                                    viewCon.serviceReturnTitleLabel.text = serviceName
                                }
                                if !(serviceStatus.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview5.isHidden = false
                                    haservicereturnview0.isHidden = false
                                    viewCon.serviceReturnStatus.setTitle(serviceStatus, for: .normal)
                                    viewCon.serviceReturnStatus.setTitleColor(serviceColor, for: .normal)
                                    viewCon.serviceReturnStatus.isHidden = false
                                }
                                if viewCon.hearingAidServiceReturnDeviceList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview5.isHidden = false
                                    haservicereturnview1.isHidden = false
                                    haservicereturnview2.isHidden = false
                                    viewCon.reloadServiceReturnDeviceListTableView()
                                }
                                
                                if viewCon.hearingAidServiceReturnPhotoList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview5.isHidden = false
                                    haservicereturnview3.isHidden = false
                                    haservicereturnview4.isHidden = false
                                    haservicereturnview5.isHidden = false
                                    viewCon.reloadServiceReturnPhotoCollectionView()
                                }
                                if !(initialQuote.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview5.isHidden = false
                                    haservicereturnview3.isHidden = false
                                    haservicereturnview6.isHidden = false
                                    viewCon.intialQuoteReturnLabel.text = initialQuote
                                }
                                if !(revisedQuote.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview5.isHidden = false
                                    haservicereturnview3.isHidden = false
                                    haservicereturnview7.isHidden = false
                                    viewCon.revisedQuoteReturnLabel.text = revisedQuote
                                }
                                if viewCon.hearingAidServiceSummaryList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview5.isHidden = false
                                    haservicereturnview3.isHidden = false
                                    haservicereturnview8.isHidden = false
                                    viewCon.reloadServiceDeviceQuoteTableView()
                                    if !(serviceName.isEmpty) {
                                        viewCon.serviceSummaryTitleLabel.text = String(format: "%@ %@", serviceName, AppLocalizationString.summary)
                                    } else {
                                        viewCon.serviceSummaryTitleLabel.text = AppLocalizationString.summary
                                    }
                                }
                                if !(serviceCharge.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview5.isHidden = false
                                    haservicereturnview3.isHidden = false
                                    haservicereturnview9.isHidden = false
                                    viewCon.serviceChargeReturnLabel.text = serviceCharge
                                }
                                if !(serviceFeedback.isEmpty) && (canShowFeedback == true) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview5.isHidden = false
                                    haservicereturnview3.isHidden = false
                                    haservicereturnview10.isHidden = false
                                    viewCon.remarkReturnLabel.text = serviceFeedback
                                }
                                if viewCon.hearingAidServiceReturnTimelineList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview5.isHidden = false
                                    haservicereturnview11.isHidden = false
                                    haservicereturnview12.isHidden = false
                                    viewCon.reloadServiceReturnTimelineTableView()
                                }
                            }
                        }
                        
                        // MARK: OnlineConsultation
                        if canShowOnlineConsultation == true {
                            var oc = SRDModelOnlineConsultation()
                            if json.data!.serviceRequestList!.onlineConsultation != nil {
                                oc = json.data!.serviceRequestList!.onlineConsultation!
                                
                                var serviceName = ""
                                var serviceStatus = ""
                                var serviceColor = UIColor.colorLiteral.theme_blue_2AACEF
                                //                                var meetingLink = "" viewCon.ocmeetingLink
                                var summary = ""
                                var summaryCreatedOn = ""
                                var enableJoinBtn = false
                                var canShowJoinBtn = false
                                var canShowSummary = false
                                
                                viewCon.onlineConsultationConcernsList.removeAll()
                                viewCon.onlineConsultationTimelineList.removeAll()
                                
                                viewCon.serviceReturnStatus.setTitle(serviceStatus, for: .normal)
                                viewCon.serviceReturnStatus.isHidden = true
                                
                                if oc.canShowSummary != nil {
                                    canShowSummary = oc.canShowSummary!
                                }
                                if oc.enableJoinBtn != nil {
                                    enableJoinBtn = oc.enableJoinBtn!
                                }
                                if oc.canShowJoinBtn != nil {
                                    canShowJoinBtn = oc.canShowJoinBtn!
                                }
                                if !(oc.serviceName.isNilOrEmpty) {
                                    serviceName = oc.serviceName!
                                }
                                if !(oc.serviceStatus.isNilOrEmpty) {
                                    serviceStatus = oc.serviceStatus!
                                }
                                if !(oc.serviceColor.isNilOrEmpty) {
                                    serviceColor = UIColor.init(hexString: oc.serviceColor!, alpha: 1.0)
                                }
                                if !(oc.meetingLink.isNilOrEmpty) {
                                    viewCon.ocmeetingLink = oc.meetingLink!
                                }
                                if !(oc.summaryCreatedOn.isNilOrEmpty) {
                                    summaryCreatedOn = oc.summaryCreatedOn!
                                }
                                if !(oc.summary.isNilOrEmpty) {
                                    summary = oc.summary!
                                }
                                
                                if oc.serviceTimeline != nil {
                                    viewCon.onlineConsultationTimelineList = oc.serviceTimeline!
                                }
                                if oc.questions != nil {
                                    viewCon.onlineConsultationConcernsList = oc.questions!
                                }
                                
                                if !(serviceName.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview6.isHidden = false
                                    ocview0.isHidden = false
                                    viewCon.onlineConsultationTitleLabel.text = serviceName
                                }
                                if !(serviceStatus.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview6.isHidden = false
                                    ocview0.isHidden = false
                                    viewCon.onlineConsultationStatus.setTitle(serviceStatus, for: .normal)
                                    viewCon.onlineConsultationStatus.setTitleColor(serviceColor, for: .normal)
                                    viewCon.onlineConsultationStatus.isHidden = false
                                }
                                if viewCon.onlineConsultationConcernsList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview6.isHidden = false
                                    ocview1.isHidden = false
                                    ocview2.isHidden = false
                                    
                                    viewCon.reloadOnlineConsultationConcersTableView()
                                }
                                if !(viewCon.ocmeetingLink.isEmpty) {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview6.isHidden = false
                                    viewCon.linkLabel.text = viewCon.ocmeetingLink
                                    viewCon.linkView.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
                                    viewCon.linkView.layer.borderWidth = 2.0
                                    
                                    if canShowJoinBtn == true {
                                        ocview3.isHidden = false
                                        ocview4.isHidden = false
                                        ocinfoview0.isHidden = false
                                        ocinfoview1.isHidden = false
                                        ocinfoview2.isHidden = false
                                        if enableJoinBtn == false {
                                            viewCon.ocjoinNowButton.isUserInteractionEnabled = false
                                            viewCon.ocjoinNowButton.backgroundColor = UIColor.colorLiteral.theme_orange_FFE5D8
                                            viewCon.ocjoinNowButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
                                            viewCon.ocjoinNowButton.setNeedsDisplay()
                                            viewCon.ocjoinNowButton.layoutIfNeeded()
                                            viewCon.view.setNeedsLayout()
                                            viewCon.view.layoutIfNeeded()
                                        } else {
                                            viewCon.ocjoinNowButton.isUserInteractionEnabled = true
                                            viewCon.ocjoinNowButton.backgroundColor = UIColor.colorLiteral.theme_orange_F7732F
                                            viewCon.ocjoinNowButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
                                            viewCon.ocjoinNowButton.setNeedsDisplay()
                                            viewCon.ocjoinNowButton.layoutIfNeeded()
                                            viewCon.view.setNeedsLayout()
                                            viewCon.view.layoutIfNeeded()
                                        }
                                    }
                                }
                                if canShowSummary == true {
                                    if !(summary.isEmpty) || !(summaryCreatedOn.isEmpty) {
                                        view5.isHidden = false
                                        view6.isHidden = false
                                        serviceview6.isHidden = false
                                        ocview5.isHidden = false
                                        ocview6.isHidden = false
                                        viewCon.onlineConsultationSummarydatelabel.text = summaryCreatedOn
                                        viewCon.onlineConsultationSummaryMessagelabel.text = summary
                                        if !(serviceName.isEmpty) {
                                            viewCon.onlineConsultationSummaryTitleLabel.text = String(format: "%@ %@", serviceName, AppLocalizationString.summary)
                                        } else {
                                            viewCon.onlineConsultationSummaryTitleLabel.text = AppLocalizationString.summary
                                        }
                                    }
                                }
                                if viewCon.onlineConsultationTimelineList.count > 0 {
                                    view5.isHidden = false
                                    view6.isHidden = false
                                    serviceview6.isHidden = false
                                    ocview7.isHidden = false
                                    ocview8.isHidden = false
                                    viewCon.reloadOnlineConsultationTimelineTableView()
                                }
                            }
                        }
                    }
                    
                    // MARK: paymentDetails
                    if json.data!.paymentDetails != nil {
                        var paymentAmount = ""
                        var paymentMode = ""
                        var paymentTxnID = ""
                        var paymentDate = ""
                        
                        var canShowInvoice = false
                        var canShowReceipt = false
                        var canShowPaymentDetails = false
                        
                        if !(json.data!.paymentDetails!.paymentAmount.isNilOrEmpty) {
                            paymentAmount = json.data!.paymentDetails!.paymentAmount!
                        }
                        if !(json.data!.paymentDetails!.paymentMode.isNilOrEmpty) {
                            paymentMode = json.data!.paymentDetails!.paymentMode!
                        }
                        if !(json.data!.paymentDetails!.paymentTxnID.isNilOrEmpty) {
                            paymentTxnID = json.data!.paymentDetails!.paymentTxnID!
                        }
                        if !(json.data!.paymentDetails!.paymentDate.isNilOrEmpty) {
                            paymentDate = json.data!.paymentDetails!.paymentDate!
                        }
                        if !(json.data!.paymentDetails!.invoiceDocument.isNilOrEmpty) {
                            viewCon.invoiceDocument = json.data!.paymentDetails!.invoiceDocument!
                        }
                        if !(json.data!.paymentDetails!.paymentReceipt.isNilOrEmpty) {
                            viewCon.paymentReceipt = json.data!.paymentDetails!.paymentReceipt!
                        }
                        if json.data!.paymentDetails!.canShowInvoice != nil {
                            canShowInvoice = json.data!.paymentDetails!.canShowInvoice!
                        }
                        if json.data!.paymentDetails!.canShowReceipt != nil {
                            canShowReceipt = json.data!.paymentDetails!.canShowReceipt!
                        }
                        if json.data!.paymentDetails!.canShowPaymentDetails != nil {
                            canShowPaymentDetails = json.data!.paymentDetails!.canShowPaymentDetails!
                        }
                        if canShowPaymentDetails == true {
                            paymentview0.isHidden = false
                            paymentview6.isHidden = false
                            if !(paymentAmount.isEmpty) {
                                view7.isHidden = false
                                paymentview1.isHidden = false
                                viewCon.paymentAmountLabel.text = paymentAmount
                            }
                            if !(paymentMode.isEmpty) {
                                view7.isHidden = false
                                paymentview2.isHidden = false
                                viewCon.paymentModeLabel.text = paymentMode
                            }
                            if !(paymentTxnID.isEmpty) {
                                view7.isHidden = false
                                paymentview3.isHidden = false
                                viewCon.paymentIdLabel.text = paymentTxnID
                            }
                            if !(paymentDate.isEmpty) {
                                view7.isHidden = false
                                paymentview4.isHidden = false
                                viewCon.paymentDateLabel.text = paymentDate
                            }
                            if (canShowInvoice == true) && !(viewCon.paymentReceipt.isEmpty) && (canShowReceipt == true) && !(viewCon.invoiceDocument.isEmpty) {
                                view7.isHidden = false
                                paymentview5.isHidden = false
                                downloadbuttonview0.isHidden = false
                                downloadbuttonview1.isHidden = false
                                downloadbuttonview2.isHidden = false
                            } else if (canShowInvoice == true) && !(viewCon.invoiceDocument.isEmpty) {
                                view7.isHidden = false
                                paymentview5.isHidden = false
                                downloadbuttonview2.isHidden = false
                            } else if (canShowReceipt == true) && !(viewCon.paymentReceipt.isEmpty) {
                                view7.isHidden = false
                                paymentview5.isHidden = false
                                downloadbuttonview0.isHidden = false
                            }
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func setExecutiveButton(canRate: Bool, canCall: Bool, canTrack: Bool, callNumber: String, trackLink: String, viewCon: ServiceRequestDetailViewController) {
        
        viewCon.executiveCallButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        viewCon.executiveCallButton.layer.borderWidth = 1.0
        viewCon.executiveCallButton.layer.borderColor = UIColor.colorLiteral.theme_blue_DCF3FF.cgColor
        viewCon.executiveCallButton.setTitleColor(UIColor.colorLiteral.theme_blue_DCF3FF, for: .normal)
        viewCon.executiveCallButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        
        viewCon.executiveRateButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        viewCon.executiveRateButton.layer.borderWidth = 1.0
        viewCon.executiveRateButton.layer.borderColor = UIColor.colorLiteral.theme_blue_DCF3FF.cgColor
        viewCon.executiveRateButton.setTitleColor(UIColor.colorLiteral.theme_blue_DCF3FF, for: .normal)
        viewCon.executiveRateButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        
        viewCon.executiveTrackButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        viewCon.executiveTrackButton.layer.borderWidth = 1.0
        viewCon.executiveTrackButton.layer.borderColor = UIColor.colorLiteral.theme_blue_DCF3FF.cgColor
        viewCon.executiveTrackButton.setTitleColor(UIColor.colorLiteral.theme_blue_DCF3FF, for: .normal)
        viewCon.executiveTrackButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        
        if (canCall == true) && !(callNumber.isEmpty) {
            viewCon.executiveCallButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            viewCon.executiveCallButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        }
        if (canTrack == true) && !(trackLink.isEmpty) {
            viewCon.executiveTrackButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            viewCon.executiveTrackButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        }
        if canRate == true {
            viewCon.executiveRateButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            viewCon.executiveRateButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        }
    }
    func setAudiologistButton(canRate: Bool, canCall: Bool, canTrack: Bool, callNumber: String, trackLink: String, viewCon: ServiceRequestDetailViewController) {
        
        viewCon.audiologistRateButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        viewCon.audiologistRateButton.layer.borderWidth = 1.0
        viewCon.audiologistRateButton.layer.borderColor = UIColor.colorLiteral.theme_blue_DCF3FF.cgColor
        viewCon.audiologistRateButton.setTitleColor(UIColor.colorLiteral.theme_blue_DCF3FF, for: .normal)
        viewCon.audiologistRateButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        if canRate == true {
            viewCon.audiologistRateButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            viewCon.audiologistRateButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        }
    }
    func setintialldata(viewCon: ServiceRequestDetailViewController) {
        viewCon.cancelReasonList.removeAll()
        viewCon.trialTimelineList.removeAll()
        viewCon.hearingAidServiceTimelineList.removeAll()
        viewCon.hearingAidServiceSummaryList.removeAll()
        viewCon.hearingAidServicePhotoList.removeAll()
        viewCon.hearingAidServiceDeviceList.removeAll()
        viewCon.tuningTimelineList.removeAll()
        viewCon.tuningSummaryList.removeAll()
        viewCon.tuningDeviceList.removeAll()
        viewCon.trialPickTimelineList.removeAll()
        viewCon.audiogramTimelineList.removeAll()
        viewCon.audiologistLangPreferenceArray.removeAll()
        viewCon.executiveLangPreferenceArray.removeAll()
        viewCon.serviceRequestsList.removeAll()
        viewCon.onlineConsultationTimelineList.removeAll()
        viewCon.onlineConsultationConcernsList.removeAll()
        viewCon.hearingAidServiceReturnTimelineList.removeAll()
        viewCon.hearingAidServiceReturnSummaryList.removeAll()
        viewCon.hearingAidServiceReturnPhotoList.removeAll()
        viewCon.hearingAidServiceReturnDeviceList.removeAll()
        
        viewCon.reloadServiceQuantityTableView()
        viewCon.reloadAudiogramTimelineTableView()
        viewCon.reloadTrialTimelineTableView()
        viewCon.reloadTrialPickTimelineTableView()
        viewCon.reloadTuningDeviceListTableView()
        viewCon.reloadTuningSummaryTableView()
        viewCon.reloadtuningTimelineTableView()
        viewCon.reloadServiceDeviceQuoteTableView()
        viewCon.reloadServiceTimelineTableView()
        viewCon.reloadServiceDeviceListTableView()
        viewCon.reloadServiceReturnDeviceQuoteTableView()
        viewCon.reloadServiceReturnTimelineTableView()
        viewCon.reloadServiceReturnDeviceListTableView()
        viewCon.reloadExecutiveTagCollectionView()
        viewCon.reloadAudiologistTagCollectionView()
        viewCon.reloadServicePhotoCollectionView()
        viewCon.reloadServiceReturnPhotoCollectionView()
        viewCon.reloadOnlineConsultationConcersTableView()
        viewCon.reloadOnlineConsultationTimelineTableView()
        
        viewCon.otpButton.isUserInteractionEnabled = false
        viewCon.serviceTypeLabel.text = ""
        viewCon.otpButton.setTitle("", for: .normal)
        viewCon.AddressInfoLabel.text = ""
        viewCon.serviceLocationTypeLabel.text = ""
        
        viewCon.bookingIDLabel.text = ""
        viewCon.meetinglinkLabel.text = ""
        viewCon.appointmentDateTimeLabel.text = ""
        viewCon.bookingDateLabel.text = ""
        viewCon.bookingAmountLabel.text = ""
        viewCon.bookingStatusLabel.text = ""
        viewCon.cancellationDateLabel.text = ""
        viewCon.cancellationReasonLabel.text = ""
        viewCon.refundStatusLabel.text = ""
        viewCon.refundAmountLabel.text = ""
        viewCon.patientNameLabel.text = ""
        viewCon.patientAgeLabel.text = ""
        viewCon.patientGenderLabel.text = ""
        viewCon.patientRelationshipLabel.text = ""
        viewCon.serviceDateStatusLabel.text = ""
        
        viewCon.executiveNameLabel.text = ""
        viewCon.executiveExperienceLabel.text = ""
        viewCon.executiveSpecialisationLabel.text = ""
        viewCon.executiveContentLabel.text = ""
        viewCon.executiveRatingLabel.text = ""
        viewCon.audiologistNameLabel.text = ""
        viewCon.audiologistExperienceLabel.text = ""
        viewCon.audiologistSpecialisationLabel.text = ""
        viewCon.audiologistContentLabel.text = ""
        viewCon.audiologistRatingLabel.text = ""
        viewCon.trackLink = ""
        
        viewCon.tuningTitleLabel.text = ""
        viewCon.tuningStatus.setTitle("", for: .normal)
        viewCon.tuningSummaryLabel.text = ""
        
        viewCon.trialTitleLabel.text = ""
        viewCon.trialStatus.setTitle("", for: .normal)
        
        viewCon.trialLeftDeviceLabel.text = ""
        viewCon.trialRightDeviceLabel.text = ""
        viewCon.trialEndDateLabel.text = ""
        viewCon.trialSecurityDepositLabel.text = ""
        
        viewCon.trialDepositMessageLabel.text = ""
        
        viewCon.trialPickTitleLabel.text = ""
        viewCon.trialPickStatus.setTitle("", for: .normal)
        
        viewCon.trialPickLeftDeviceLabel.text = ""
        viewCon.trialPickRightDeviceLabel.text = ""
        viewCon.trialPickEndDateLabel.text = ""
        viewCon.trialPickSecurityDepositLabel.text = ""
        
        viewCon.trialPickDepositMessageLabel.text = ""
        
        viewCon.serviceTitleLabel.text = ""
        viewCon.serviceSummaryTitleLabel.text = ""
        viewCon.intialQuoteLabel.text = ""
        viewCon.revisedQuoteLabel.text = ""
        viewCon.remarkLabel.text = ""
        viewCon.serviceChargeLabel.text = ""
        
        viewCon.serviceReturnTitleLabel.text = ""
        viewCon.serviceReturnSummaryTitleLabel.text = ""
        viewCon.intialQuoteReturnLabel.text = ""
        viewCon.revisedQuoteReturnLabel.text = ""
        viewCon.remarkReturnLabel.text = ""
        viewCon.serviceChargeReturnLabel.text = ""
        
        viewCon.onlineConsultationSummaryTitleLabel.text = ""
        viewCon.onlineConsultationSummaryMessagelabel.text = ""
        viewCon.onlineConsultationSummarydatelabel.text = ""
        
        viewCon.staffname = ""
        viewCon.staffexperience = ""
        viewCon.staffspecialisation = ""
        viewCon.staffimage = ""
        
        viewCon.audiologistname = ""
        viewCon.audiologistexperience = ""
        viewCon.audiologistspecialisation = ""
        viewCon.audiologistimage = ""
    }
}
