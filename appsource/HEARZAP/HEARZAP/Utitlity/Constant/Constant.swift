//
//  Constant.swift
//  HEARZAP
//
//  Created by Purushoth on 28/06/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Social account redirection URL
struct SocialRedirectURL {
    static let fbRedirect_url                               = "https://hearzap.com/external/source/facebook/"
    static let instaRedirect_url                            = "https://hearzap.com/external/source/instagram/"
    static let youtubeRedirect_url                          = "https://hearzap.com/external/source/youtube/"
    static let twitterRedirect_url                          = "https://hearzap.com/external/source/twitter/"
}

// MARK: - App Base Keys
struct BaseKey {
    static let appsource                                    = "iOS_Customer_Mobile_Application"
    static let googleAPIKey                                 = "AIzaSyAUGwwQ0OWwM7lS0wjCKnHfW8FrCuS4jGs"
    //    static let firebaseAPIKey                               = "AIzaSyAaaMV5xpeSrP9o9t_o73jOiYG5G9mMiAA"
    // AIzaSyAUGwwQ0OWwM7lS0wjCKnHfW8FrCuS4jGs //AIzaSyAaaMV5xpeSrP9o9t_o73jOiYG5G9mMiAA //AIzaSyAdhzFYZZ6YJKsEYtogejAFR5kOK4l7UuM
}

struct AlertDialogueMessage {
    
}

struct AppConstantValue {
    
    static let defaultDesignScreenWidth                     = 375.0
    static let defaultDesignScreenHeight                    = 812.0
    
    static let screenWidthminus32                           = screenFrameWidth - 32
    
    static let screen125dot6slash375                        = Double(125.6/375.0)
    static let screen138slash375                            = Double(138.5/375.0)
    static let screen160slash375                            = Double(160/375.0)
    static let screen163slash375                            = Double(163/375.0)
    static let screen165slash375                            = Double(165/375.0)
    static let screen172slash375                            = Double(172.5/375.0)
    static let screen187slash375                            = Double(187/375.0)
    static let screen192slash375                            = Double(192.36/375.0)
    static let screen192dot94slash375                       = Double(192.94/375.0)
    static let screen206slash375                            = Double(206/375.0)
    static let screen211slash375                            = Double(211.94/375.0)
    static let screen212slash375                            = Double(212/375.0)
    static let screen215slash375                            = Double(215/375.0)
    static let screen222slash375                            = Double(222/375.0)
    static let screen226slash375                            = Double(226/375.0)
    static let screen252slash375                            = Double(252/375.0)
    static let screen259slash375                            = Double(259/375.0)
    static let screen269slash375                            = Double(259/375.0)
    static let screen265slash375                            = Double(265.37/375.0)
    static let screen291slash375                            = Double(291/375.0)
    static let screen302slash375                            = Double(302/375.0)
    static let screen306slash375                            = Double(306/375.0)
    static let screen308slash375                            = Double(308/375.0)
    static let screen328slash375                            = Double(328/375.0)
    static let screen345slash375                            = Double(345/375.0)
    static let screen390slash375                            = Double(390/375.0)
    static let screen467slash375                            = Double(467/375.0)
    
    static let productInfoHeight                            = 108.0
    
    static let navigationBarHeight                          = 44
    static let navigationBarButtonHeight                    = 44
    
    static let ratingViewnHeight                            = 302
    static let timerInterval                                = 3
    static let reviewTimerInterval                          = 10
    static let timerIntervalSimilarProducts                 = 5
    static let timerIntervalOffer                           = 0.015
    static let toastdisplayduration                         = 6.0
    static let toastdelayduration                           = 0.1
    
    static let fontGrey777777                               = "rgba(119, 119, 119, 1.0)"
    static let fontBlue112F70                               = "rgba(17, 47, 112, 1.0)"
    
    static let alphaNumericRegEx                            = "[a-zA-Z 0-9]"
    static let numericRegEx                                 = "[0-9]"
    static let nameRegEx                                    = "[a-zA-Z .'0-9]"
    static let alphaNumericSymbolRegEx                      = "[a-zA-Z 0-9 !*'();:@&=+$,/?%#. ]"
    
    static let cornerRadius4                                = 4.0
    static let cornerRadius8                                = 8.0
    static let cornerRadius16                               = 16.0

    static let maxAplha                                     = 1.0
    static let minAlpha                                     = 0.0
    
    static let defaultlatlong                               = 0.0
    static let defaultOutlineborderWidth                    = 1.0
    
    static let storedetaildatetimeformat                    = "dd MMM yyyy'T'h:mm a"
    static let storedetaildateformat                        = "yyyy-MM-dd"
    static let storedetailtimeformat                        = "h:mm a"
    static let storedetaildatetimeformatsplitter            = "T"
    
    static let poppinsbold                                  = "Poppins-Bold"
    static let poppinsmedium                                = "Poppins-Medium"
    static let poppinsregular                               = "Poppins-Regular"
    static let poppinssemibold                              = "Poppins-SemiBold"
    
    //    static let rupeesymbol                                  = "₹"
    static let rupeesymbol                                  = "Rs. "
    
    static let regularDateFormat                            = "yyyy-MM-dd"
    static let apiDateFormat                                = "MMM dd, yyyy"
    static let bookingDateFormat                            = "dd/MM/yyyy"

    static let wishlist                                     = "wishlist"
    
}
