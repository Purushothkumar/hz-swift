//
//  SRDModel.swift
//  HEARZAP
//
//  Created by Purushoth on 02/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct SRDModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: SRDModelDataClass?
    var errors: Errors?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message, data, errors
    }
}

// MARK: - DataClass
struct SRDModelDataClass: Codable {
    var cancelReasonList: [SRDModelCancelReasonList]?
    var canCancelBooking: Bool?
    var bookingDetails: SRDModelBookingDetails?
    var bookingInformation: SRDModelBookingInformation?
    var serviceStaff: SRDModelServiceStaff?
    var paymentDetails: SRDModelPaymentDetails?
    var serviceRequestList: SRDModelServiceRequestList?
    
    enum CodingKeys: String, CodingKey {
        case cancelReasonList = "cancel_reason_list"
        case canCancelBooking = "can_cancel_booking"
        case bookingDetails = "booking_details"
        case bookingInformation = "booking_information"
        case serviceStaff = "service_staff"
        case paymentDetails = "payment_details"
        case serviceRequestList = "service_request_list"
    }
}

// MARK: - BookingDetails
struct SRDModelBookingDetails: Codable {
    var bookingUid, masterServiceName, masterServiceCode, serviceDate: String?
    var serviceStartTime, serviceEndTime, statusName, statusCode: String?
    var statusColor: String?
    var canShowMeetingLink: Bool?
    var meetingLink: String?
    var canShowAgentOtp: Bool?
    var otpCode, serviceLocation: String?
    var serviceLocationType: String?
    
    enum CodingKeys: String, CodingKey {
        case bookingUid = "booking_uid"
        case masterServiceName = "master_service_name"
        case masterServiceCode = "master_service_code"
        case serviceDate = "service_date"
        case serviceStartTime = "service_start_time"
        case serviceEndTime = "service_end_time"
        case statusName = "status_name"
        case statusCode = "status_code"
        case statusColor = "status_color"
        case canShowMeetingLink = "can_show_meeting_link"
        case meetingLink = "meeting_link"
        case canShowAgentOtp = "can_show_agent_otp"
        case otpCode = "otp_code"
        case serviceLocation = "service_location"
        case serviceLocationType = "service_location_type"
    }
}

// MARK: - BookingInformation
struct SRDModelBookingInformation: Codable {
    var bookingID, appointmentDate, bookingDate, bookingAmount: String?
    var bookingStatusName, bookingStatusCode, bookingStatusColor, customerPatientUid: String?
    var customerPatientName, customerPatientAge, customerPatientGender, customerPatientRelationshipType: String?
    var customerPatientRelationship: String?
    var serviceRequestsList: [SRDModelServiceRequestsList]?
    var canShowCancellationDetails, canShowRefundDetails: Bool?
    var cancelledDate, cancellationReason, cancellationComments, refundStatus: String?
    var refundReqAmount: String?
    
    enum CodingKeys: String, CodingKey {
        case bookingID = "booking_id"
        case appointmentDate = "appointment_date"
        case bookingDate = "booking_date"
        case bookingAmount = "booking_amount"
        case bookingStatusName = "booking_status_name"
        case bookingStatusCode = "booking_status_code"
        case bookingStatusColor = "booking_status_color"
        case customerPatientUid = "customer_patient_uid"
        case customerPatientName = "customer_patient_name"
        case customerPatientAge = "customer_patient_age"
        case customerPatientGender = "customer_patient_gender"
        case customerPatientRelationshipType = "customer_patient_relationship_type"
        case customerPatientRelationship = "customer_patient_relationship"
        case serviceRequestsList = "service_requests_list"
        case canShowCancellationDetails = "can_show_cancellation_details"
        case canShowRefundDetails = "can_show_refund_details"
        case cancelledDate = "cancelled_date"
        case cancellationReason = "cancellation_reason"
        case cancellationComments = "cancellation_comments"
        case refundStatus = "refund_status"
        case refundReqAmount = "refund_req_amount"
    }
}

// MARK: - ServiceRequestsList
struct SRDModelServiceRequestsList: Codable {
    var name, code: String?
    var qty: Int?
}

// MARK: - CancelReasonList
struct SRDModelCancelReasonList: Codable {
    var id: Int?
    var value: String?
}

// MARK: - PaymentDetails
struct SRDModelPaymentDetails: Codable {
    var paymentAmount, paymentMode, paymentTxnID, paymentDate: String?
    var canShowReceipt: Bool?
    var paymentReceipt: String?
    var canShowInvoice: Bool?
    var invoiceDocument: String?
    var canShowPaymentDetails: Bool?
    
    enum CodingKeys: String, CodingKey {
        case paymentAmount = "payment_amount"
        case paymentMode = "payment_mode"
        case paymentTxnID = "payment_txn_id"
        case paymentDate = "payment_date"
        case canShowReceipt = "can_show_receipt"
        case paymentReceipt = "payment_receipt"
        case canShowInvoice = "can_show_invoice"
        case invoiceDocument = "invoice_document"
        case canShowPaymentDetails = "can_show_payment_details"
    }
}

// MARK: - ServiceRequestList
struct SRDModelServiceRequestList: Codable {
    var canShowOnlineConsultation, canShowTrial, canShowTunning, canShowHearingAidService: Bool?
    var canShowHearingAidServiceReturn, canShowAudiogramTest, canShowTrialpickup, canShowOrderDelivery: Bool?
    var canShowOrderReturn: Bool?
    var onlineConsultation: SRDModelOnlineConsultation?
    var trial: SRDModelTrial?
    var tunning: SRDModelTunning?
    var hearingAidService: SRDModelHearingAidService?
    var hearingAidServiceReturn: SRDModelHearingAidServiceReturn?
    var audiogramTest: SRDModelAudiogramTest?
    var trialpickup: SRDModelTrialpickup?
    var orderDelivery: Errors?
    var orderReturn: Errors?
    
    enum CodingKeys: String, CodingKey {
        case canShowOnlineConsultation = "can_show_online_consultation"
        case canShowTrial = "can_show_trial"
        case canShowTunning = "can_show_tunning"
        case canShowHearingAidService = "can_show_hearing_aid_service"
        case canShowHearingAidServiceReturn = "can_show_hearing_aid_service_return"
        case canShowAudiogramTest = "can_show_audiogram_test"
        case canShowTrialpickup = "can_show_trialpickup"
        case canShowOrderDelivery = "can_show_order_delivery"
        case canShowOrderReturn = "can_show_order_return"
        case onlineConsultation = "online_consultation"
        case trial, tunning
        case hearingAidService = "hearing_aid_service"
        case hearingAidServiceReturn = "hearing_aid_service_return"
        case audiogramTest = "audiogram_test"
        case trialpickup
        case orderDelivery = "order_delivery"
        case orderReturn = "order_return"
    }
}
// MARK: - Trial
struct SRDModelTrial: Codable {
    var serviceName, serviceStatus, serviceCode, serviceColor: String?
    var serviceTimeline: [SRDModelServiceTimeline]?
    var trialLeftDevice, trialRightDevice: String?
    var trialDeviceGivenToCustomer: Bool?
    var trialStartPeriod, trialEndsOn, trialEndsOnDays, securityDeposit: String?
    
    enum CodingKeys: String, CodingKey {
        case serviceName = "service_name"
        case serviceStatus = "service_status"
        case serviceCode = "service_code"
        case serviceColor = "service_color"
        case serviceTimeline = "service_timeline"
        case trialLeftDevice = "trial_left_device"
        case trialRightDevice = "trial_right_device"
        case trialDeviceGivenToCustomer = "trial_device_given_to_customer"
        case trialStartPeriod = "trial_start_period"
        case trialEndsOn = "trial_ends_on"
        case trialEndsOnDays = "trial_ends_on_days"
        case securityDeposit = "security_deposit"
    }
}
// MARK: - Trialpickup
struct SRDModelTrialpickup: Codable {
    var serviceName, serviceStatus, serviceCode, serviceColor: String?
    var serviceTimeline: [SRDModelServiceTimeline]?
    var trialLeftDevice, trialRightDevice: String?
    var trialDeviceGivenToCustomer: Bool?
    var trialStartPeriod, trialEndsOn, trialEndsOnDays, securityDeposit: String?
    
    enum CodingKeys: String, CodingKey {
        case serviceName = "service_name"
        case serviceStatus = "service_status"
        case serviceCode = "service_code"
        case serviceColor = "service_color"
        case serviceTimeline = "service_timeline"
        case trialLeftDevice = "trial_left_device"
        case trialRightDevice = "trial_right_device"
        case trialDeviceGivenToCustomer = "trial_device_given_to_customer"
        case trialStartPeriod = "trial_start_period"
        case trialEndsOn = "trial_ends_on"
        case trialEndsOnDays = "trial_ends_on_days"
        case securityDeposit = "security_deposit"
    }
}
// MARK: - OnlineConsultation
struct SRDModelOnlineConsultation: Codable {
    var serviceName, serviceStatus, serviceCode, serviceColor: String?
    var questions: [SRDModelQuestion]?
    var enableJoinBtn, canShowJoinBtn: Bool?
    var meetingLink: String?
    var serviceTimeline: [SRDModelServiceTimeline]?
    var canShowSummary: Bool?
    var summary, summaryCreatedOn: String?
    
    enum CodingKeys: String, CodingKey {
        case serviceName = "service_name"
        case serviceStatus = "service_status"
        case serviceCode = "service_code"
        case serviceColor = "service_color"
        case questions
        case enableJoinBtn = "enable_join_btn"
        case canShowJoinBtn = "can_show_join_btn"
        case meetingLink = "meeting_link"
        case serviceTimeline = "service_timeline"
        case canShowSummary = "can_show_summary"
        case summary
        case summaryCreatedOn = "summary_created_on"
    }
}
// MARK: - Tunning
struct SRDModelTunning: Codable {
    var serviceName, serviceStatus, serviceCode, serviceColor: String?
    var serviceTimeline: [SRDModelServiceTimeline]?
    var canShowSummary: Bool?
    var remarks: String?
    var tuningComplaint: [SRDModelTuningComplaint]?
    
    enum CodingKeys: String, CodingKey {
        case serviceName = "service_name"
        case serviceStatus = "service_status"
        case serviceCode = "service_code"
        case serviceColor = "service_color"
        case serviceTimeline = "service_timeline"
        case canShowSummary = "can_show_summary"
        case remarks
        case tuningComplaint = "tuning_complaint"
    }
}
// MARK: - HearingAidService
struct SRDModelHearingAidService: Codable {
    var serviceUid, serviceName, serviceStatus, serviceCode: String?
    var serviceColor: String?
    var serviceTimeline: [SRDModelServiceTimeline]?
    var serviceDevices: [SRDModelServiceDevice]?
    var serviceCharge: String?
    var photoList: [String]?
    var canShowSummary: Bool?
    var initialQuote: String?
    var canShowRevisedQuote: Bool?
    var revisedQuote: String?
    var canShowApproval, canShowRemarks: Bool?
    var remarks: String?
    
    enum CodingKeys: String, CodingKey {
        case serviceUid = "service_uid"
        case serviceName = "service_name"
        case serviceStatus = "service_status"
        case serviceCode = "service_code"
        case serviceColor = "service_color"
        case serviceTimeline = "service_timeline"
        case serviceDevices = "service_devices"
        case serviceCharge = "service_charge"
        case photoList = "photo_list"
        case canShowSummary = "can_show_summary"
        case initialQuote = "initial_quote"
        case canShowRevisedQuote = "can_show_revised_quote"
        case revisedQuote = "revised_quote"
        case canShowApproval = "can_show_approval"
        case canShowRemarks = "can_show_remarks"
        case remarks
    }
}
// MARK: - AudiogramTest
struct SRDModelAudiogramTest: Codable {
    var serviceName, serviceStatus, serviceCode, serviceColor: String?
    var serviceTimeline: [SRDModelServiceTimeline]?
    var canShowDownloadReport: Bool?
    var downloadReportLink: String?
    
    enum CodingKeys: String, CodingKey {
        case serviceName = "service_name"
        case serviceStatus = "service_status"
        case serviceCode = "service_code"
        case serviceColor = "service_color"
        case serviceTimeline = "service_timeline"
        case canShowDownloadReport = "can_show_download_report"
        case downloadReportLink = "download_report_link"
    }
}
// MARK: - HearingAidServiceReturn
struct SRDModelHearingAidServiceReturn: Codable {
    var serviceUid, serviceName, serviceStatus, serviceCode: String?
    var serviceColor: String?
    var serviceTimeline: [SRDModelServiceTimeline]?
    var serviceDevices: [SRDModelServiceDevice]?
    var canShowFeedback: Bool?
    var serviceFeedback: String?
    
    enum CodingKeys: String, CodingKey {
        case serviceUid = "service_uid"
        case serviceName = "service_name"
        case serviceStatus = "service_status"
        case serviceCode = "service_code"
        case serviceColor = "service_color"
        case serviceTimeline = "service_timeline"
        case serviceDevices = "service_devices"
        case canShowFeedback = "can_show_feedback"
        case serviceFeedback = "service_feedback"
    }
}

// MARK: - TuningComplaint
struct SRDModelTuningComplaint: Codable {
    var deviceIndex, deviceName, complaint, actionTaken: String?
    var nextTuningDate, clientResponse: String?
    
    enum CodingKeys: String, CodingKey {
        case deviceIndex = "device_index"
        case deviceName = "device_name"
        case complaint
        case actionTaken = "action_taken"
        case nextTuningDate = "next_tuning_date"
        case clientResponse = "client_response"
    }
}
// MARK: - AgentDetails
struct SRDModelAgentDetails: Codable {
    var photo: String?
    var name, designationName, specialization, specializationDesc: String?
    var averageRating: String?
    var isVaccinated: Bool?
    var langPreference: [String]?
    var canRate, canCall, canTrack: Bool?
    var callNumber, trackLink: String?
    var staffID: String?
    
    enum CodingKeys: String, CodingKey {
        case photo, name
        case designationName = "designation_name"
        case specialization
        case specializationDesc = "specialization_desc"
        case averageRating = "average_rating"
        case isVaccinated = "is_vaccinated"
        case langPreference = "lang_preference"
        case canRate = "can_rate"
        case canCall = "can_call"
        case canTrack = "can_track"
        case callNumber = "call_number"
        case trackLink = "track_link"
        case staffID = "staff_id"
    }
}
// MARK: - AudiologistDetails
struct SRDModelAudiologistDetails: Codable {
    var photo: String?
    var name, experience, designationName, specialization: String?
    var specializationDesc, averageRating: String?
    var isVaccinated: Bool?
    var langPreference: [String]?
    var canRate, canCall, canTrack: Bool?
    var callNumber, trackLink: String?
    var staffID: String?
    var specializationDegree: String?
    
    enum CodingKeys: String, CodingKey {
        case photo, name, experience
        case designationName = "designation_name"
        case specialization
        case specializationDesc = "specialization_desc"
        case averageRating = "average_rating"
        case isVaccinated = "is_vaccinated"
        case langPreference = "lang_preference"
        case canRate = "can_rate"
        case canCall = "can_call"
        case canTrack = "can_track"
        case callNumber = "call_number"
        case trackLink = "track_link"
        case staffID = "staff_id"
        case specializationDegree = "specialization_degree"
        
    }
}
// MARK: - Question
struct SRDModelQuestion: Codable {
    var question, answer: String?
}
// MARK: - ServiceStaff
struct SRDModelServiceStaff: Codable {
    var agentDetails: SRDModelAgentDetails?
    var audiologistDetails: SRDModelAudiologistDetails?
    var canShowAgentStaff, canShowAudiologistStaff: Bool?
    
    enum CodingKeys: String, CodingKey {
        case agentDetails = "agent_details"
        case audiologistDetails = "audiologist_details"
        case canShowAgentStaff = "can_show_agent_staff"
        case canShowAudiologistStaff = "can_show_audiologist_staff"
    }
}
// MARK: - ServiceDevice
struct SRDModelServiceDevice: Codable {
    var deviceIndex, deviceName, deviceRevisedQuoteAmount, deviceCollectionStatus: String?
    //    var deviceNextServiceDate: Int?
    
    enum CodingKeys: String, CodingKey {
        case deviceIndex = "device_index"
        case deviceName = "device_name"
        case deviceRevisedQuoteAmount = "device_revised_quote_amount"
        case deviceCollectionStatus = "device_collection_status"
        //        case deviceNextServiceDate = "device_next_service_date"
    }
}
// MARK: - ServiceTimeline
struct SRDModelServiceTimeline: Codable {
    var status: Bool?
    var createdOn, statusName, description: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case createdOn = "created_on"
        case statusName = "status_name"
        case description
    }
}
