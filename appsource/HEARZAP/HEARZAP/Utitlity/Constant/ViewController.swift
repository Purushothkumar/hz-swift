//
// ViewController.swift
// HEARZAP
//
// Created by Purushoth on 01/07/22.
// Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct ViewController {
    // MARK: - Tabbar
    static let CustomTabbarController                               = "CustomTabbarController"
    // MARK: - Login
    static let LoginViewController                                  = "LoginViewController"
    static let SignupViewController                                 = "SignupViewController"
    static let OTPVerificationViewController                        = "OTPVerificationViewController"
    static let OTPSuccessViewController                             = "OTPSuccessViewController"
    // MARK: - Common
    static let VersionControlViewController                         = "VersionControlViewController"
    static let NetworkRechabilityViewController                     = "NetworkRechabilityViewController"
    static let ErrorViewController                                  = "ErrorViewController"
    // MARK: - Home
    static let HomeDynamicViewController                                   = "HomeDynamicViewController"
    static let HomeStaticViewController                             = "HomeStaticViewController"
    // MARK: - HearingCare
    static let HearingCareViewController                            = "HearingCareViewController"
    // MARK: - Menu
    static let MenuViewController                                   = "MenuViewController"
    // MARK: - Shop
    static let ShopCategoryViewController                           = "ShopCategoryViewController"
    static let AccessoriesFilterViewController                      = "AccessoriesFilterViewController"
    static let HearingAidFilterViewController                       = "HearingAidFilterViewController"
    static let AccessoriesSubCategoryViewController                 = "AccessoriesSubCategoryViewController"
    static let AccessoriesSubCategoryColorViewController            = "AccessoriesSubCategoryColorViewController"
    static let ViewAllProductViewController                         = "ViewAllProductViewController"
    static let ProductDetailViewController                          = "ProductDetailViewController"
    static let HAProductDetailViewController                        = "HAProductDetailViewController"
    // MARK: - Cart
    static let CartDetailViewController                             = "CartDetailViewController"
    static let CheckOutViewController                               = "CheckOutViewController"
    static let CheckOutSummaryViewController                        = "CheckOutSummaryViewController"
    static let CheckOutConfirmationViewController                   = "CheckOutConfirmationViewController"
    // MARK: - Order
    static let OrderListViewController                              = "OrderListViewController"
    static let OrderDetailViewController                            = "OrderDetailViewController"
    static let ReturnReasonViewController                           = "ReturnReasonViewController"
    static let CancelOrderViewController                            = "CancelOrderViewController"
    // MARK: - CompareProduct
    static let CompareProductBrandViewController                    = "CompareProductBrandViewController"
    static let CompareProductPriceViewController                    = "CompareProductPriceViewController"
    static let CompareProductStyleViewController                    = "CompareProductStyleViewController"
    static let CompareProductModelViewController                    = "CompareProductModelViewController"
    static let CompareProductViewController                         = "CompareProductViewController"
    // MARK: - Store
    static let StoreFinderViewController                            = "StoreFinderViewController"
    static let StoreFilterViewController                            = "StoreFilterViewController"
    static let StoreDetailViewController                            = "StoreDetailViewController"
    static let StoreReviewViewController                            = "StoreReviewViewController"
    // MARK: - BlogContainer
    static let BlogContainerViewController                          = "BlogContainerViewController"
    // MARK: - Tips
    static let TipsListViewController                               = "TipsListViewController"
    static let TipsDetailViewController                             = "TipsDetailViewController"
    // MARK: - Blogs
    static let BlogsListViewController                              = "BlogsListViewController"
    static let BlogsDetailViewController                            = "BlogsDetailViewController"
    static let BlogsSearchViewController                            = "BlogsSearchViewController"
    // MARK: - Care and Maintenance
    static let CareMaintenanceListViewController                    = "CareMaintenanceListViewController"
    static let CareMaintenanceDetailViewController                  = "CareMaintenanceDetailViewController"
    // MARK: - Customer Testimonial
    static let CustomerTestimonialListViewController                = "CustomerTestimonialListViewController"
    static let CustomerTestimonialDetailViewController              = "CustomerTestimonialDetailViewController"
    // MARK: - QuickTest
    static let QuickTestAddUserViewController                       = "QuickTestAddUserViewController"
    static let QuickTestUserInfoViewController                      = "QuickTestUserInfoViewController"
    static let QuickTestUserVerificationViewController              = "QuickTestUserVerificationViewController"
    static let QuickTestProfileViewController                       = "QuickTestProfileViewController"
    static let QuickTestHeadsetConnectivityViewController           = "QuickTestHeadsetConnectivityViewController"
    static let QuickTestNoiseLevelViewController                    = "QuickTestNoiseLevelViewController"
    static let QuickTestEarCheckViewController                      = "QuickTestEarCheckViewController"
    static let QuickTestSelectEarViewController                     = "QuickTestSelectEarViewController"
    static let QuickTestViewController                              = "QuickTestViewController"
    static let QuickTestSuccessViewController                       = "QuickTestSuccessViewController"
    static let QuickTestResultViewController                        = "QuickTestResultViewController"
    
    // MARK: - Bottom Sheet
    static let BottomSheetLifeStyleViewController                   = "BottomSheetLifeStyleViewController"
    static let BottomSheetFeatureViewController                     = "BottomSheetFeatureViewController"
    static let BottomSheetProfileViewController                     = "BottomSheetProfileViewController"
    static let BottomSheetAddDeviceDetailViewController             = "BottomSheetAddDeviceDetailViewController"
    static let BottomSheetAddDeviceViewController                   = "BottomSheetAddDeviceViewController"
    static let BottomSheetCommonDeleteViewController                = "BottomSheetCommonDeleteViewController"
    static let BottomSheetCartViewController                        = "BottomSheetCartViewController"
    static let BottomSheetReturnProductViewController               = "BottomSheetReturnProductViewController"
    // MARK: - Find Right Device
    static let FindRightDeviceIntroductionViewController            = "FindRightDeviceIntroductionViewController"
    static let FindRightDeviceStyleViewController                   = "FindRightDeviceStyleViewController"
    static let FindRightDeviceFeatureViewController                 = "FindRightDeviceFeatureViewController"
    static let FindRightDeviceEarPreferenceViewController           = "FindRightDeviceEarPreferenceViewController"
    static let FindRightDeviceUploadReportViewController            = "FindRightDeviceUploadReportViewController"
    static let FindRightDeviceRecommendViewController               = "FindRightDeviceRecommendViewController"
    // MARK: - Userdata
    static let WishlistViewController                               = "WishlistViewController"
    static let CouponListViewController                             = "CouponListViewController"
    static let RewardPointsViewController                           = "RewardPointsViewController"
    static let RedeemCoinsViewController                            = "RedeemCoinsViewController"
    static let RewardPointsDetailViewController                     = "RewardPointsDetailViewController"
    static let ReferFriendViewController                            = "ReferFriendViewController"
    static let SurveyViewController                                 = "SurveyViewController"
    static let ShareExperienceViewController                        = "ShareExperienceViewController"
    static let SurveySuccessViewController                          = "SurveySuccessViewController"
    static let ServiceCouponListViewController                      = "ServiceCouponListViewController"
    static let MyAlertViewController                                = "MyAlertViewController"
    static let AudiogramReportViewController                        = "AudiogramReportViewController"
    // MARK: - Profile
    static let ProfileInformationViewController                     = "ProfileInformationViewController"
    static let ChangeInformationViewController                      = "ChangeInformationViewController"
    static let ChangeInformationOTPVerificationViewController       = "ChangeInformationOTPVerificationViewController"
    static let EditProfileViewController                            = "EditProfileViewController"
    static let AddressListViewController                            = "AddressListViewController"
    static let AddressonMapViewController                           = "AddressonMapViewController"
    static let EnterAddressViewController                           = "EnterAddressViewController"
    static let AddressAutoCompleteViewController                    = "AddressAutoCompleteViewController"
    // MARK: - BookAppointment
    static let BookAppointmentDemoViewController                    = "BookAppointmentDemoViewController"
    static let BookAppointmentViewController                        = "BookAppointmentViewController"
    static let BookAppointmentAddressViewController                 = "BookAppointmentAddressViewController"
    static let BookAppointmentSummaryViewController                 = "BookAppointmentSummaryViewController"
    static let BookAppointmentConfirmationViewController            = "BookAppointmentConfirmationViewController"

    static let BookAppointmentLocationViewController                = "BookAppointmentLocationViewController"
    static let BookAppointmentScheduleViewController                = "BookAppointmentScheduleViewController"
    static let BookAppointmentUserInfoViewController                = "BookAppointmentUserInfoViewController"
    static let BookAppointmentSuccessViewController                 = "BookAppointmentSuccessViewController"


    // MARK: - AddUser
    static let AddUserViewController                                = "AddUserViewController"
    static let SelectUserViewController                             = "SelectUserViewController"
    // MARK: - RegisterDevice
    static let RegisterDeviceViewController                         = "RegisterDeviceViewController"
    static let AddRegisterDeviceViewController                      = "AddRegisterDeviceViewController"
    // MARK: - OnlineConsultation
    static let OnlineConsultationDemoViewController                 = "OnlineConsultationDemoViewController"
    static let OnlineConsultationConcernViewController              = "OnlineConsultationConcernViewController"
    static let OnlineConsultationAudiologistViewController          = "OnlineConsultationAudiologistViewController"
    static let OnlineConsultationAppointmentViewController          = "OnlineConsultationAppointmentViewController"
    static let OnlineConsultationPaymentViewController              = "OnlineConsultationPaymentViewController"
    static let OnlineConsultationConfirmationViewController         = "OnlineConsultationConfirmationViewController"

    static let OnlineConsultationLocationViewController             = "OnlineConsultationLocationViewController"
    static let OnlineConsultationScheduleViewController             = "OnlineConsultationScheduleViewController"
    static let OnlineConsultationUserInfoViewController             = "OnlineConsultationUserInfoViewController"
    static let OnlineConsultationSuccessViewController              = "OnlineConsultationSuccessViewController"

    // MARK: - ServiceRequest
    static let ServiceRequestListViewController                     = "ServiceRequestListViewController"
    static let ServiceRequestDetailViewController                   = "ServiceRequestDetailViewController"
    static let ServiceRequestStaffRatingViewController              = "ServiceRequestStaffRatingViewController"
    static let CancelServiceRequestViewController                   = "CancelServiceRequestViewController"
    // MARK: - Information
    static let SupportViewController                                = "SupportViewController"
    static let FAQViewController                                    = "FAQViewController"
    static let TermsConditionsViewController                        = "TermsConditionsViewController"
    static let AboutUsViewController                                = "AboutUsViewController"
    static let PrivacyPolicyViewController                          = "PrivacyPolicyViewController"
    static let BuyBackViewController                                = "BuyBackViewController"
    static let LegalViewController                                  = "LegalViewController"
    // MARK: - Common
    static let YoutubePlayerViewController                          = "YoutubePlayerViewController"
}
