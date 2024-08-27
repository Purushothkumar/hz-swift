//
//  Enumeration.swift
//  HEARZAP
//
//  Created by Purushoth on 09/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

/*
 enum BaseUrl: String {
 // MARK: - BaseURL
 /*akshaya
  case Dev                                        = "http://192.168.29.23:8001/"
  */
 /*santhosh
  case Dev                                        = "http://192.168.29.175:8000/"
  */
 /*local*/
 case Dev                                        = "http://192.168.29.23:8001/"
 case Testing                                    = "https://tst.hearzap.com/"
 case Staging                                    = "https://uat.hearzap.com/"
 case Production                                 = "https://app.hearzap.com/"
 }
 enum RazorPayID: String {
 // MARK: - BaseURL
 case Dev, Testing, Staging                      = "rzp_test_S9j5JNqSRJVaKA"
 case Production                                 = "rzp_live_fYsPTMeFYKSMGn"
 }
 enum BuildVersion: String {
 // MARK: - API Version
 case Dev                                        = "0.0.1"
 case Testing                                    = "1.0.3"
 case Staging                                    = "1.0.17"
 case Production                                 = "1.0.8"
 }
 */

enum StatusBarTheme: Int {
    // MARK: - Compare Product Header
    case darkContent                                = 1
    case lightContent                               = 0
}
enum CompareProductHeader: String {
    // MARK: - Compare Product Header
    case brand                                      = "Brand"
    case style                                      = "Style"
    case price                                      = "Price"
    case model                                      = "Model"
}
//enum CompareProductLifeStyleStatus: String {
//    // MARK: - Compare Product Header
//    case idealfit                                   = "IDEAL FIT"
//    case goodfit                                    = "GOOD FIT"
//    case okfit                                      = "OK FIT"
//    case poorfit                                    = "POOR FIT"
//}

//enum ProductLifeStyleStatus: String {
//    // MARK: - Product Life Style
//    case idealfit                                   = "IDEAL FIT"
//    case goodfit                                    = "GOOD FIT"
//    case okfit                                      = "OK FIT"
//    case poorfit                                    = "POOR FIT"
//}
enum StoreOpenCloseStatus: String {
    // MARK: - Compare Product Header
    case open                                       = "OPEN"
    case close                                      = "CLOSE"
}

enum FRDEarPreference: String {
    // MARK: - Find Right Device
    case left                                       = "LEFT"
    case right                                      = "RIGHT"
    case both                                       = "BOTH"
    case earpreference                              = ""
}
enum FRDLifeStyle: String {
    // MARK: - Find Right Device
    case relaxed                                    = "RELAXED"
    case quiet                                      = "QUIET"
    case functional                                 = "FUNCTIONAL"
    case active                                     = "ACTIVE"
    case busy                                       = "BUSY"
}
enum SurveyType: String {
    // MARK: - SurveyType
    case awarness                                   = "AWARENESS"
    case productShoppingHearingAids                 = "PRODUCT_SHOPPING_HEARING_AIDS"
    case productShoppingAccessories                 = "PRODUCT_SHOPPING_ACCESSORIES"
    case feedbackservice                            = "FEEDBACK_SERVICES"
    // Awareness - Home
    // shopping - hearing-aids - My Order
    // shopping - accessories - My Order
    // Feedback Service - My device
}
enum DeliveryType: String {
    case home                                       = "HOME"
    case store                                      = "STORE"
}
enum VisitType: String {
    case home                                       = "HOME"
    case store                                      = "STORE"

}
enum AddressType: String {
    case home                                       = "HOME"
    case work                                       = "WORK"
    case others                                     = "OTHERS"
    
}
enum OrderStatus: String {
    case inprogress                                 = "In Progress"
    case delivered                                  = "Delivered"
    case cancelled                                  = "Cancelled"
    
}
enum GenderType: String {
    case male                                       = "MALE"
    case female                                     = "FEMALE"
    case others                                     = "OTHERS"
    case addnew                                     = "ADDNEW"
}
enum StaticRelationType: String {
    case invitefriend                               = "INVITEFRIEND"
    case addnew                                     = "ADDNEW"    
}
//enum AppointmentType: String {
//    case HASR                                       = "HASR"  // service request
//    case HADT                                       = "HADT"  // device tuning
//    case HADR                                       = "HADR"  // device return
//    case HTA                                        = "HTA"    // book appointment
//    case HAT                                        = "HAT"    // free trial
//}
enum EarType: String {
    case right                                      = "RIGHT"
    case left                                       = "LEFT"
    case both                                       = "BOTH"
    case earpreference                              = ""
}
enum vendorType: String {
    case hearzap                                    = "HEARZAP"
    case othervendor                                = "OTHER VENDOR"
}
enum SupportDeskType: String {
    case call                                       = "CALL"
    case whatsapp                                   = "WHATSAPP"
    case email                                      = "EMAIL"
}
enum ViewAllProductFilter: String {
    case latest                                     = "LATEST"
    case hotDeals                                   = "HOTDEALS"
    case style                                      = "STYLE"
    case price                                      = "PRICE"
    case brand                                      = "BRAND"
    case accessories                                = "ACCESSORIES"
}

// enum UserRelationShip: String {
//    case selfuser                                   = "SELF"
//    case familymember                               = "FAMILY_MEMBERS"
//    case friendsrelatives                           = "FRIENDS_RELATIVES"
// }
enum CouponType: String { // 'FLAT','PERCENTAGE' and 'PROMO'
    case flat                                       = "FLAT"
    case percentage                                 = "PERCENTAGE"
}
enum CouponOfferedFor: String { // 'SHOPPING','BOOKING'
    case shopping                                   = "SHOPPING"
    case booking                                    = "BOOKING"
}
enum MyAlertFor: String { // 'REGISTERED_DEVICE','BOOKING','ORDER_RETURN','ORDER'
    case registereddevice                           = "REGISTERED_DEVICE"
    case order                                      = "ORDER"
    case orderreturn                                = "ORDER_RETURN"
    case booking                                    = "BOOKING"
    
}
enum IsNavigateFrom: String {
    
    /* Login*/
    
    case loginCartHearingCare                       = "loginCartHearingCare"
    case loginCartStore                             = "loginCartStore"
    
    case loginCartShop                              = "loginCartShop"
    
    case loginCartAccessoriesSubcategrory           = "loginCartAccessoriesSubcategrory"
    case loginCartAccessoriesSubcategroryColor      = "loginCartAccessoriesSubcategroryColor"
    case loginCartCompare                           = "loginCartCompare"
    case loginCartViewAll                           = "loginCartViewAll"
    case loginCartCompare1                          = "loginCartCompare1"
    case loginCartCompare2                          = "loginCartCompare2"
    
    case loginCartProductDetail                     = "loginCartProductDetail"
    case loginCartHAProductDetail                   = "loginCartHAProductDetail"
    case loginWishlistProductDetail                 = "loginWishlistProductDetail"
    case loginWishlistHAProductDetail               = "loginWishlistHAProductDetail"
    case loginCartProductDetailLogo                 = "loginCartProductDetailLogo"
    case loginCartHAProductDetailLogo               = "loginCartHAProductDetailLogo"
    
    case loginMenu                                  = "loginMenu"
    case loginSurveyMenu                            = "loginSurveyMenu"
    case loginReferFriendMenu                       = "loginReferFriendMenu"
    case loginRegisterDeviceMenu                    = "loginRegisterDeviceMenu"
    case loginCouponMenu                            = "loginCouponMenu"
    case loginRewardsMenu                           = "loginRewardsMenu"
    case loginProfileMenu                           = "loginProfileMenu"
    case loginAddressMenu                           = "loginAddressMenu"
    case loginBuyBackMenu                           = "loginBuyBackMenu"
    case loginWishlistMenu                          = "loginWishlistMenu"
    case loginOrderListMenu                         = "loginOrderListMenu"
    case loginAudiogramReportMenu                   = "loginAudiogramReportMenu"
    case loginServiceRequestMenu                    = "loginServiceRequestMenu"
    case loginCartMenu                              = "loginCartMenu"
    
    case loginMyAlertHearingCare                    = "loginMyAlertHearingCare"
    case loginMyAlertStore                          = "loginMyAlertStore"
    case loginMyAlertShop                           = "loginMyAlertShop"
    case loginMyAlertMenu                           = "loginMyAlertMenu"
    
    case loginFHA                                   = "loginFHA"
    case loginQuickCheck                            = "loginQuickCheck"
    case loginBookAppointment                       = "loginBookAppointment"
    case loginStoreDetail                           = "loginStoreDetail"
    case loginOnlineConsultation                    = "loginOnlineConsultation"

    case loginFRDViewReportQuickCheck               = "loginFRDViewReportQuickCheck"
    case loginViewReportQuickCheck                  = "loginViewReportQuickCheck"

    /*productDetail*/
    case productDetailShopHA                        = "productDetailShopHA"
    case productDetailShopAccessories               = "productDetailShopAccessories"
    case productDetailAccessoriesSubcategory        = "productDetailAccessoriesSubcategory"
    case productDetailAccessoriesColor              = "productDetailAccessoriesColor"
    case productDetailViewAll                       = "productDetailViewAll"
    case productDetailRegisterDevice                = "productDetailRegisterDevice"
    case productDetail                              = "productDetail"
    case productCompareDetail                       = "productCompareDetail"
    
    case productDetailFHA                           = "productDetailFHA"
    case productDetailWishlist                      = "productDetailWishlist"
    case productDetailShopFHA                       = "productDetailShopFHA"
    case productDetailShopOffer                     = "productDetailShopOffer"
    
    /*cart*/
    case cartHearingCare                            = "cartHearingCare"
    case cartStore                                  = "cartStore"
    case cartShop                                   = "cartShop"
    case cartMenu                                   = "cartMenu"
    //    case cartProduct                                = "cartProduct"
    case cartCompare                                = "cartCompare"
    case cartAccessoriesSubcategrory                = "cartAccessoriesSubcategrory"
    case cartAccessoriesSubcategroryColor           = "cartAccessoriesSubcategroryColor"
    case cartViewAll                                = "cartViewAll"
    case cartProductDetailLogo                      = "cartProductDetailLogo"
    case cartHAProductDetailLogo                    = "cartHAProductDetailLogo"
    
    /* QuickCheck */
    case qcHomeStatic                               = "qcHomeStatic"
    case qcHearingCare                              = "qcHearingCare"
    case qcMenuReport                               = "qcMenuReport"
    case qcFRDReport                                = "qcFRDReport"
    case qcFRDUploadReport                          = "qcFRDUploadReport"

    /* BookAppointment */
    case baHomeStatic                               = "baHomeStatic"
    case baHearingCare                              = "baHearingCare"
    case baStore                                    = "baStore"
    case baShop                                     = "baShop"
    case baMenu                                     = "baMenu"
    case baStoreDetail                              = "baStoreDetail"
    case baHAProductDetail                          = "baHAProductDetail"
    case baFHA                                      = "baFHA"
    case baQuickCheck                               = "baQuickCheck"
    case baSurveySuccess                            = "baSurveySuccess"
    case baSurveyRegisterDevice                     = "baSurveyRegisterDevice"
    case baFRDUploadReport                          = "baFRDUploadReport"
    
    /* FHA */
    case fhaHomeStatic                              = "fhaHomeStatic"
    case fhaHearingCare                             = "fhaHearingCare"
    case fhaShop                                    = "fhaShop"
    case fhaSurveySuccess                           = "fhaSurveySuccess"
    
    /* OnlineConsulation */
    case ocHomeStatic                               = "ocHomeStatic"
    case ocHearingCare                              = "ocHearingCare"
    case ocQuickCheck                               = "ocQuickCheck"
    case ocSurveySuccess                            = "ocSurveySuccess"
    
    /*service request*/
    case srMenu                                     = "srMenu"
    
    /*service request detail*/
    case srd                                        = "srd"
    case srdAlert                                   = "srdAlert"
    case srdOnlineConsulationSuccess                = "srdOnlineConsulationSuccess"
    case srdBookAppointmentSuccess                  = "srdBookAppointmentSuccess"
    
    /*audiogram report*/
    case audiogramReportMenu                        = "audiogramReportMenu"
    
    /*MyAlert report*/
    case myalertHearingCare                         = "myalertHearingCare"
    case myalertStore                               = "myalertStore"
    case myalertShop                                = "myalertShop"
    case myalertMenu                                = "myalertMenu"
    
    /*Compare*/
    case compareShop                                = "compareShop"
    case compareView                                = "compareView"
    case compareFHA                                 = "compareFHA"
    case compareProductDetail                       = "compareProductDetail"
    
    /*order*/
    case orderMenu                                  = "orderMenu"
    case orderSuccess                               = "orderSuccess"
    
    /*orderdetail*/
    case od                                         = "od"
    case odAlert                                    = "odAlert"
    case odSuccess                                  = "odSuccess"
    
    /*orderdetail*/
    case rod                                        = "rod"
    case rodAlert                                   = "rodAlert"
    
    /*wishlist*/
    case wishlistMenu                               = "wishlistMenu"
    case wishlistCart                               = "wishlistCart"
    
    /*add user*/
    case addUser                                    = "addUser"
    case addUserQuickCheck                          = "addUserQuickCheck"
    case addUserProfile                             = "addUserProfile"
    
    /*aupport*/
    case supportStore                               = "supportStore"
    case supportShop                                = "supportShop"
    case supportMenu                                = "supportMenu"
    case supportBuyBack                             = "supportBuyBack"
    case supportSurvey                              = "supportSurvey"
    case supportOrder                               = "supportOrder"
    case supportSRD                                 = "supportSRD"
    
    /*About*/
    case aboutMenu                                  = "aboutMenu"
    
    /*PrivacyPolicy*/
    case privacyPolicyMenu                          = "privacyPolicyMenu"
    
    /*TermsofUse*/
    case termsofUseMenu                             = "termsofUseMenu"
    case termsofUseOnlineConsultation               = "termsofUseOnlineConsultation"
    case termsofUseSRD                              = "termsofUseSRD"
    case termsofUseCancelRequest                    = "termsofUseCancelRequest"
    case termsofUseCheckoutSummary                  = "termsofUseCheckoutSummary"
    case termsofUseOCPayment                        = "termsofUseOCPayment"
    case termsofUseBASummary                        = "termsofUseBASummary"
    case termsofUseBookAppointment                  = "termsofUseBookAppointment"
    case termsofUseQuickCheck                       = "termsofUseQuickCheck"
    case termsofUseOCConfirmation                   = "termsofUseOCConfirmation"
    case termsofUseBAConfirmation                   = "termsofUseBAConfirmation"
    
    /*Legal*/
    case legalMenu                                  = "legalMenu"
    
    /*faq*/
    case faqShop                                    = "faqShop"
    case faqMenu                                    = "faqMenu"
    /*buy back*/
    case buybackMenu                                = "buybackMenu"
    case buybackRegisterDevice                      = "buybackRegisterDevice"
    
    /*survey*/
    case surveyMenu                                 = "surveyMenu"
    
    /*addresslist*/
    case addresslist                                = "addresslist"
    case addressCheckOut                            = "addressCheckOut"
    case addressBookAppointment                     = "addressBookAppointment"
    
    //    case surveyMenu                                 = "surveyMenu"
    //    case surveyHearingAids                          = "surveyHearingAids"
    
    /*referaFriend*/
    case reffrMenu                                  = "reffrMenu"
    
    /*registerdevice*/
    case rdMenu                                     = "rdMenu"
    case rdalert                                    = "rdAlert"
    
    /*add registered Device*/
    case ard                                        = "ard"
    case ardBooking                                 = "ardBooking"
    
    /*coupon*/
    case cartCoupon                                 = "cartCoupon"
    
    /*View All*/
    case viewAllShop                                = "viewAllShop"

    /*Blogs*/
    case blogslist                                  = "blogslist"
    case blogssearch                                = "blogssearch"
    case blogsdetailrecent                          = "blogsdetailrecent"
    case blogsdetailrelated                         = "blogsdetailrelated"

}
enum State: String, CaseIterable {
    case andhraPradesh = "ANDHRA PRADESH"
    case arunachalPradesh = "ARUNACHAL PRADESH"
    case assam = "ASSAM"
    case bihar = "BIHAR"
    case chhattisgarh = "CHHATTISGARH"
    case goa = "GOA"
    case gujarat = "GUJARAT"
    case haryana = "HARYANA"
    case himachalPradesh = "HIMACHAL PRADESH"
    case jammuAndKashmir = "JAMMU AND KASHMIR"
    case jharkhand = "JHARKHAND"
    case karnataka = "KARNATAKA"
    case kerala = "KERALA"
    case madhyaPradesh = "MADHYA PRADESH"
    case maharashtra = "MAHARASHTRA"
    case manipur = "MANIPUR"
    case meghalaya = "MEGHALAYA"
    case mizoram = "MIZORAM"
    case nagaland = "NAGALAND"
    case odishaOrissa = "ODISHA(ORISSA)"
    case puducherry = "PUDUCHERRY"
    case punjab = "PUNJAB"
    case rajasthan = "RAJASTHAN"
    case sikkim = "SIKKIM"
    case tamilNadu = "TAMIL NADU"
    case telangana = "TELANGANA"
    case tripura = "TRIPURA"
    case uttarPradesh = "UTTAR PRADESH"
    case uttarakhand = "UTTARAKHAND"
    case westBengal = "WEST BENGAL"

    // Static method to return an array of all raw values
    static func allRawValues() -> [String] {
        return State.allCases.map { $0.rawValue }
    }
}
