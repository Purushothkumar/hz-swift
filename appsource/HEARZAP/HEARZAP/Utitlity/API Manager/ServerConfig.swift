//
//  ServerConfig.swift
//  HEARZAP
//
//  Created by Purushoth on 07/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

class ServerConfig {
    // MARK: - Server Configuration Setup
    static let shared: ServerConfig = ServerConfig()
    var baseUrl: String?
    var version: String?
    var razorPayID: String?
    var headers: String {
        if UserDefaults.standard.value(forKey: UserDefaultsPreferenceKeys.token) != nil {
            if !(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty) {
                return "Token \(UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token)!)"
            } else {
                UserDefaults.standard.set("", forKey: UserDefaultsPreferenceKeys.token)
                return ""
            }
        } else {
            UserDefaults.standard.set("", forKey: UserDefaultsPreferenceKeys.token)
            return ""
        }
    }
    
    /*
     // MARK: - Base URL
     func getBaseUrl() -> String {
     #if Dev
     self.baseUrl = BaseUrl.Dev.rawValue
     #elseif Testing
     self.baseUrl = BaseUrl.Testing.rawValue
     #elseif Staging
     self.baseUrl = BaseUrl.Staging.rawValue
     #elseif Production
     self.baseUrl = BaseUrl.Production.rawValue
     #endif
     return self.baseUrl.isNilOrEmpty ? "" : self.baseUrl!
     }
     // MARK: - Razor Pay ID
     func getRazorPayID() -> String {
     #if Dev
     self.razorPayID = RazorPayID.Dev.rawValue
     #elseif Testing
     self.razorPayID = RazorPayID.Testing.rawValue
     #elseif Staging
     self.razorPayID = RazorPayID.Staging.rawValue
     #elseif Production
     self.razorPayID = RazorPayID.Production.rawValue
     #endif
     return self.razorPayID.isNilOrEmpty ? "" : self.razorPayID!
     }
     // MARK: - Version
     func getVersion() -> String {
     #if Dev
     self.version = BuildVersion.Dev.rawValue
     #elseif Testing
     self.version = BuildVersion.Testing.rawValue
     #elseif Staging
     self.version = BuildVersion.Staging.rawValue
     #elseif Production
     self.version = BuildVersion.Production.rawValue
     #endif
     return self.version.isNilOrEmpty ? "" : self.version!
     }
     */
}
