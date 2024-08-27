//
//  APIService.swift
//  HEARZAP
//
//  Created by Purushoth on 30/06/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct Headers {
    // MARK: - REST API Header
    static let headerContentType                        = "Content-type"
    static let headerAccept                             = "Accept"
    static let headerAuthorization                      = "Authorization"
    static let headerContent                            = "application/json"
    static let headerBearer                             = "Bearer "
}

struct HTTPMethods {
    // MARK: - REST API Methods
    static let get                                      = "GET" // Retrieve information about the REST API resource
    static let put                                      = "PUT" // Update a REST API resource
    static let post                                     = "POST" // Create a REST API resource
    static let delete                                   = "DELETE" // Delete a REST API resource or related component
}

struct SubAPIUrl {
    // MARK: - Notification
    static let getNotificationCount                     = "api/notifications/"
    
    // MARK: - UserCredential
    static let postLogin                                = "api/auth/sign-in/"
    static let postSignup                               = "api/auth/sign-up/"
    static let postLoginVerification                    = "api/auth/verify-otp/"
    static let postSignupVerification                   = "api/auth/verify-otp/"
    static let postResendOTP                            = "api/auth/resend-otp/"
    
    // MARK: - Home
    static let getHomeData                              = "api/home/"
    static let getHomeVersionControl                    = "api/version-control/"
    static let postHomequeries                          = "api/lp/queries/"
    static let postHomeGetInTouch                       = "api/lp/get-in-touch/"
    
    
    // Social Media URL
    static let fbRedirectUrl                            = "external/source/facebook/"
    static let instaRedirectUrl                         = "external/source/instagram/"
    static let youtubeRedirectUrl                       = "external/source/youtube/"
    static let twitterRedirectUrl                       = "external/source/twitter/"
    static let whatsappRedirectUrl                      = "external/source/whatsapp/"
    
    // MARK: - HearingCare
    static let getHearingCareData                       = "api/master/hearing-care/"
    
    // MARK: - Store
    static let getStoreFinderList                       = "api/store-finder/"
    static let getStoreFinderHearzapDifferenceList      = "api/store-finder/ajax/difference/"
    static let getStoreFinderCustomerTestimonialList    = "api/store-finder/ajax/customer-testimonial/"
    static let getStoreFAQList                          = "api/store-finder/ajax/faq/"
    static let getStoreFilterStateList                  = "api/store-finder/by-state/"
    static let getStoreFilterCityList                   = "api/store-finder/by-city/"
    static let getStoreFilterZipcodeList                = "api/store-finder/by-zipcode/"
    static let getStoreDetailList                       = "api/store-finder/store/"
    static let getStoreReview                           = "api/store-finder/store-review/"
    
    // MARK: - Shop
    static let getHearingAidList                        = "api/eshop/hearing-aids/"
    static let getHearingAidPriceRangeList              = "api/eshop/hearing-aids/price/"
    static let getHearingAidBrandList                   = "api/eshop/hearing-aids/brand/"
    
    static let getHearingAidFilterList                  = "api/eshop/hearing-aids/filter/"
    static let postHearingAidProductFilterList          = "api/eshop/hearing-aids/ajax/filter/"
    
    static let getAccessoriesList                       = "api/eshop/accessories/"
    
    static let getAccessoriesBrandList                  = "api/eshop/accessories/brand/"
    
    static let getAccessoriesFilterList                 = "api/eshop/accessories/filter/"
    static let postAccessoriesProductFilterList         = "api/eshop/accessories/ajax/filter/"

    static let getShopHearzapDifferenceList             = "api/eshop/hearzap/difference/"
    static let getShopOffersList                        = "api/eshop/offers/"

    // MARK: - CompareProduct
    static let getCompareList                           = "api/eshop/compare/"
    static let getCompareModelProductList               = "api/eshop/add-to-compare/product/ajax/"
    

    // MARK: - View All Product
    static let getHearingAidViewAllList                 = "api/eshop/hearing-aids/filter/"
    
    // MARK: - Accessories Subcategory
    static let getAccessoriesSubcategoryList            = "api/eshop/accessories/sub-category/"
    static let postAccessoriesSubcategoryProductList    = "api/eshop/accessories/sub-category/spec-type/ajax/"
    
    // MARK: - Menu
    static let getCustomerDetail                        = "api/master/get-customer-detail/"
    
    // MARK: - QuickTest
    //    static let getQuickCheckupStepsList                 = "api/quick-checkup/"
    static let postQuickCheckupPersonList               = "api/quick-checkup/select-person/"
    static let postQuickCheckupdata                     = "api/quick-checkup/take-test/"
    static let getQuickCheckupData                      = "api/quick-checkup/report/"
    static let getQuickCheckupGuestUserList             = "api/quick-checkup/load/patient/guest/"
    static let postQuickCheckSignIn                     = "api/quick-checkup/signin/"
    static let postQuickCheckVerifyOTP                  = "api/quick-checkup/login/verify/otp/"
//    static let getQuickCheckupGuestUserList             = "api/quick-checkup/load/patient/guest/"


//    Get - /api/quick-checkup/load/patient/guest/
//    Post - /api/quick-checkup/signin/
//         - first_name
//         - phone_number
//         - email_address
//    Post -/api/quick-checkup/login/verify/otp/
//          - token
//          - otp
//          - left_field_value
//          - right_field_value
//          - profile_name
//          - dob
//          - gender
//          - relationship
//          - relationship_type



    // MARK: - BookAppointment
    static let getBookAppointmentStepsList              = "api/service-requests/booking/"
    static let getBookAppointmentList                   = "api/service-requests/booking/service-request/"
    static let getBookAppointmentDateList               = "api/service-requests/booking-date-slot/"
    static let postBookAppointmentTimeList              = "api/service-requests/booking/booking-time-slots/"
    static let createBookAppointmentList                = "api/service-requests/booking/service-request/"
    static let postCreateBooking                        = "api/service-requests/booking/create-booking/"
    static let postBookingMakePayment                   = "api/service-requests/booking/make-payment/"
    static let postBookingVerifyPayment                 = "api/service-requests/booking/verify-payment/"

    static let getBookAppointmentCityList               = "api/service-requests/book/appointment/"
    static let postBookAppointmentSaveData              = "api/service-requests/book/appointment/save/data/"
    static let postBookAppointmentSendOTP               = "api/service-requests/book/appointment/send/otp/"
    static let postBookAppointmentLoginVerifyOTP        = "api/service-requests/login/verify/otp/"
    static let getBookAppointmentSelectDate             = "api/service-requests/book/appointment/select/date/"
    static let postBookAppointmentSelectDate            = "api/service-requests/book/appointment/select/date/"
    static let postBookAppointmentCustomerDetail        = "api/service-requests/book/appointment/customer/details/"

    // MARK: - FindRightDevice
    static let getFindRightDeviceDemoList               = "api/hearing-aid-finder/"
    static let getFindRightDeviceUploadReportList       = "api/hearing-aid-finder/step1/report/"
    static let getFindRightDeviceLifestyleList          = "api/hearing-aid-finder/step2/lifestyle/"
    static let getFindRightDeviceModelList              = "api/hearing-aid-finder/step3/model/"
    static let getFindRightDeviceEarPreference          = "api/hearing-aid-finder/step4/ear_info/"
    static let postUploadReport                         = "api/hearing-aid-finder/upload/report/"
    static let postFindRightDeviceRecomendedList        = "api/hearing-aid-finder/recommendations/"
    static let getFindRightDeviceRecomendedList         = "api/hearing-aid-finder/recommendations/"
    
    // MARK: - OnlineConsultation
    static let getOnlineConsultationStepsList           = "api/service-requests/online-consultation/"
    static let getOnlineConsultationConcernList         = "api/service-requests/online-consultation/concerns/"
    static let getOnlineConsultationaudiologistsList    = "api/service-requests/online-consultation/audiologists/"
    static let getBookingDateSlotList                   = "api/service-requests/booking-date-slot/"
    static let postOnlineConsultationTimeSlotList       = "api/service-requests/online-consultation/booking-time-slots/"
    static let getBookingSummary                        = "api/service-requests/online-consultation/booking-summary/"
    static let postOnlineConsultationCreateBooking      = "api/service-requests/online-consultation/create-booking/"
    static let postOnlineConsultationMakePayment        = "api/service-requests/online-consultation/make-payment/"
    static let postOnlineConsultationVerifyPayment      = "api/service-requests/online-consultation/verify-payment/"
    static let getBookingConfirmation                   = "api/service-requests/booking/confirmation/"

    static let getOnlineConsultationCityList            = "api/service-requests/online/consultation/"
    static let postOnlineConsultationSaveData           = "api/service-requests/online/consultation/save/data/"
    static let postOnlineConsultationSendOTP            = "api/service-requests/online/consultation/send/otp/"
    static let postOnlineConsultationLoginVerifyOTP     = "api/service-requests/login/verify/otp/"
    static let getOnlineConsultationSelectDate          = "api/service-requests/online/consultation/select/date/"
    static let postOnlineConsultationSelectDate         = "api/service-requests/online/consultation/select/date/"
    static let postOnlineConsultationCustomerDetail     = "api/service-requests/online/consultation/customer/details/"

    // MARK: - ServiceRequest
    static let getServiceRequestList                    = "api/service-requests/list/"
    static let getServiceRequestDetail                  = "api/service-requests/detail/"
    static let postStaffRating                          = "api/service-requests/rate-audiologist/"
    static let postAudiologistRating                    = "api/service-requests/rate-audiologist/"
    static let postCancelBooking                        = "api/service-requests/cancel/"
    static let getHAServiceRequestApprove               = "api/service-requests/booking/ha-service/quote/approval/"
    
    // MARK: - Cart
    static let getCartList                              = "api/eshop/cart/"
    static let postAddToCart                            = "api/eshop/add-to-cart/"
    static let getCartItem                              = "api/eshop/cart/"
    static let postCartItem                             = "api/eshop/cart/"
    static let postCartItemQuantity                     = "api/eshop/get-product-quantity/"
    
    static let removeCartItem                           = "api/eshop/remove-from-cart/"
    static let postCheckout                             = "api/eshop/checkout/"
    
    static let getZipcodeCustomerAddress                = "api/customer-relation/customer-addresss/"
    static let postZipcodeServiceRequestsStoreAddress   = "api/service-requests/store-address/"
    static let getOrderedItems                          = "api/eshop/ordered-items/"
    static let postCheckoutDelivery                     = "api/eshop/order/checkout/delivery/"
    static let getCheckoutSummary                       = "api/eshop/order/checkout/overview/"
    static let postCheckoutMakePayment                  = "api/eshop/order/checkout/payment-create/ajax/"
    static let postCheckoutVerifyPayment                = "api/eshop/order/checkout/payment/"
    
    // MARK: - Order
    static let getOrderList                             = "api/eshop/order/list/"
    static let getReturnOrderList                       = "api/eshop/order/list/return/"
    
    static let getOrderDetail                           = "api/eshop/order/detail/"
    static let getReturnOrderDetail                     = "api/eshop/order/return/"
    
    static let postReturnReason                         = "api/eshop/order/return/"
    static let postCancelReason                         = "api/eshop/order/cancel/"
    
    // MARK: - AddUser
    static let getCustomerRelationPersonList            = "api/customer-relation/select-person/"
    static let getCustomerRelationAddPerson             = "api/customer-relation/add-update-person/"
    static let postCustomerRelationAddPerson            = "api/customer-relation/add-update-person/"
    static let postFindTheRightDevicePersonList         = "api/hearing-aid-finder/select-person/"
    static let postCustomerRelationPersonList           = "api/customer-relation/select-person/"
    static let postCustomerRelationGetPerson            = "api/customer-relation/get-person/"
    
    // MARK: - RegisterDevice
    static let getCustomerDeviceList                    = "api/customer-relation/customer-device/"
    static let deleteCustomerDevice                     = "api/customer-relation/customer-device/delete/"
    static let postCustomerDeviceList                   = "api/customer-relation/customer-device/"
    static let getCustomerDeviceDropdownList            = "api/customer-relation/customer-device/dropdown/"
    
    // MARK: - Profile
    static let getProfileInformation                    = "api/customer-relation/profile/"
    static let getCustomerAddressList                   = "api/customer-relation/customer-address/"
    static let deleteCustomerAddress                    = "api/customer-relation/customer-address/delete/"
    static let saveCustomerAddress                      = "api/customer-relation/customer-address/"
    static let deleteAccount                            = "api/customer-relation/delete-account/"
    static let disableAccount                           = "api/customer-relation/disable-account/"
    static let postChangeEmail                          = "api/auth/change-email/"
    static let postChangePhone                          = "api/auth/change-phone/"
    static let postMobileVerification                   = "api/auth/verify-otp/"
    static let postEmailVerification                    = "api/auth/verify-email-otp/"
    static let deletePatient                            = "api/customer-relation/delete-person/"
    
    static let postProfileInformation                   = "api/customer-relation/profile/"
    static let postProfilePhoto                         = "api/customer-relation/profile/photo/"
    
    // MARK: - UserData
    static let getCouponList                            = "api/loyalty-manager/coupons/"
    //    static let applyBookingCoupon                       = "api/service-requests/online-consultation/coupon/"/api/service-requests/booking/coupon/
    static let applyBookingCoupon                       = "api/service-requests/booking/coupon/"
    static let applyShoppingCoupon                      = "api/eshop/coupon/apply-or-remove/"
    static let getRewardsList                           = "api/loyalty-manager/rewards/"
    static let getRewardsToCouponList                   = "api/loyalty-manager/rewards-to-coupon/"
    static let getRedeemCoin                            = "api/loyalty-manager/redeem/coins/"
    static let getSurveyList                            = "api/resources/survey/"
    static let getReferAFriend                          = "api/loyalty-manager/refer-a-friend/"
    static let getWishlist                              = "api/eshop/customer-wishlist/"
    static let postWishlist                             = "api/eshop/customer-wishlist/"
    static let getmyalert                               = "api/alerts/my-alerts/"
    static let getAudiogramReportList                   = "api/service-requests/audiogram-test-reports/"
    static let getQuickTestReportList                   = "api/service-requests/quick-test-reports/"
    
    // MARK: - Blog
    static let getBlogsList                             = "api/resources/blogs/"
    static let getBlogsCategoryList                     = "api/resources/blogs-category/"
    static let postBlogsQueries                         = "api/resources/blog/queries/"
    static let postBlogsNewsletter                      = "api/resources/blog/newsletter/"
    static let getBlogsSearchList                       = "api/resources/blogs/"
    static let getBlogsDetail                           = "api/resources/blogs/"

    // MARK: - Blog
    static let getTipsList                              = "api/resources/tips/"

    // MARK: - Care Maintenance

    static let getCareMaintenanceList                   = "api/resources/care-and-maintenance-videos/"
    static let getCareMaintenanceDetailList             = "api/resources/cm-videos/"

    // MARK: - Customer Testimonials
    static let getCustomerTestimonialsList              = "api/resources/customer-testimonials/"
    
    // MARK: - Information
    static let getFAQList                               = "api/resources/faq/"
    static let getAboutUsData                           = "api/master/about-us/"
    static let getPrivacyPolicyData                     = "api/master/privacy-policy/"
    static let getTermsConditionsData                   = "api/master/terms-of-use/"
    static let getSupportData                           = "api/master/support/"
    static let getBuybackData                           = "api/master/buyback/"
    static let getLegalData                             = "api/master/legal/"
    
    // MARK: - Common
    
    // MARK: - BottomSheet
    
}
