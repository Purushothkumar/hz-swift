//
//  APIManager.swift
//  HEARZAP
//
//  Created by Purushoth on 30/06/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

/*
 HTTP_REST_MESSAGES = {"200": _("Success"),
 "400": _("Failed"),
 "401": _("Authentication Failed"),
 "426": _("Version Mismatch"),
 "429": _("Too many requests"),
 "500": _("Internal server error")}
 */

import Foundation
import UIKit


class APIManager {
    // MARK: - Vars & Lets
    static let shared = APIManager()
    var indicator =  UIActivityIndicatorView()
    var bezelView = UIView()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    // show/Hide Loader
    func showIndicator(viewCon: UIViewController) {
        self.hideIndicator(viewCon: viewCon)// to hide for multiple api call
        self.indicator.isHidden = true
        self.indicator.willRemoveSubview(viewCon.view)
        self.indicator.style = UIActivityIndicatorView.Style.large
        self.indicator.color = UIColor.colorLiteral.theme_white_FFFFFF
        self.indicator.frame = CGRect(x: 0, y: 0, width: 60.0, height: 60.0)
        self.indicator.center = viewCon.view.center
        self.bezelView.frame = viewCon.view.frame
        self.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        viewCon.view.addSubview(self.bezelView)
        viewCon.view.addSubview(self.indicator)
        self.bezelView.bringSubviewToFront(viewCon.view)
        self.indicator.bringSubviewToFront(viewCon.view)
        self.indicator.startAnimating()
    }
    
    func hideIndicator(viewCon: UIViewController) {
        self.indicator.stopAnimating()
        self.bezelView.removeFromSuperview()
        self.indicator.hidesWhenStopped = true
        self.indicator.isHidden = true
    }
    
    // MARK: - API Call with loader
    func request(canShowLoader: Bool, viewCon: UIViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?, callback: @escaping (_ result: NSData) -> Void) {
        
        if canShowLoader == true {
            self.hideIndicator(viewCon: viewCon)
            self.showIndicator(viewCon: viewCon)
        } else {
            self.hideIndicator(viewCon: viewCon)
        }
        
        var strURLQuery: String
        var strURL: String
        
        guard let baseUrl: String = Bundle.main.infoDictionary?["BASE_URL"] as? String else { return }
        guard let version: String = Bundle.main.infoDictionary?["APP_VERSION"] as? String else { return }
        
        // to add query
        if strQuery.isNilOrEmpty {
            strURLQuery = "\(baseUrl)\(subAPIUrl)?ver=\(version)"
        } else {
            strURLQuery = "\(baseUrl)\(subAPIUrl)?ver=\(version)\(String(describing: strQuery!))"
        }
        // to append source
        let strURLSource = "\(strURLQuery)&source=\(BaseKey.appsource)"
        
        // to add pagenumber
        if pageNumber.isNilOrEmpty {
            strURL = "\(strURLSource)"
        } else {
            strURL = "\(strURLSource)&page_number=\(pageNumber ?? "1")"
        }
        // create the url with baseurl
        print("..............................")
        print("API URL: ", strURL)
        print("API Parameter: ", parameter ?? "nil")
        print("API Method: ", methodName)
        print("..............................")
        var request = URLRequest(url: URL(string: strURL)!)
        request.httpMethod = methodName
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        // set http method for POST with parameter
        if methodName == HTTPMethods.post {
            request.httpBody = parameter!.data(using: String.Encoding.utf8)
        }
        // HTTP Headers
        if !(ServerConfig.shared.headers.isEmpty) {
            let token = "\(ServerConfig.shared.headers)"
            print("Authorization \(token)")
            request.addValue(token, forHTTPHeaderField: Headers.headerAuthorization)
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        if let httpResponse = response as? HTTPURLResponse {
                            print("statusCode: \(httpResponse.statusCode)")
                            if httpResponse.statusCode == 401 || httpResponse.statusCode == 429 {
                                self.hideIndicator(viewCon: viewCon)
                                viewCon.view.endEditing(true)
                                viewCon.signout()
                                return
                            }
                        }
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print("..............................")
                        print("Date and time \(DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .full))")
                        print(json)
                        print("..............................")
                        let dic = json as? NSDictionary
                        if dic != nil {
                            var msg = ""
                            if let message = dic!["message"] as? String {
                                msg = message
                            }
                            let code = dic!["status_code"] as! Int
                            if code == 200 {
                                callback(data! as NSData)
                                self.hideIndicator(viewCon: viewCon)
                                viewCon.view.endEditing(true)
                            } else if code == 400 || code == 500 {
                                self.hideIndicator(viewCon: viewCon)
                                viewCon.view.endEditing(true)
                                viewCon.showToastAlert(msg, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                            } else if code == 401 || code == 429 {
                                self.hideIndicator(viewCon: viewCon)
                                viewCon.view.endEditing(true)
                                viewCon.signout()
                            } else if code == 426 {
                                self.hideIndicator(viewCon: viewCon)
                                if let dataDict = dic!.value(forKey: "data") as? NSDictionary {
                                    var canShowPrimaryMsg = false
                                    var canShowSecondaryMsg = false
                                    var canShowBtn = false
                                    var isHavingAction = false
                                    var iosBtnLink = ""
                                    var btnText = ""
                                    var primaryMsgText = ""
                                    var secondaryMsgText = ""
                                    var androidBtnLink = ""
                                    
                                    if !(dataDict.value(forKey: "can_show_primary_msg") is NSNull) {
                                        canShowPrimaryMsg = dataDict.value(forKey: "can_show_primary_msg") as! Bool
                                    }
                                    if !(dataDict.value(forKey: "can_show_secondary_msg") is NSNull) {
                                        canShowSecondaryMsg = dataDict.value(forKey: "can_show_secondary_msg") as! Bool
                                    }
                                    if !(dataDict.value(forKey: "can_show_btn") is NSNull) {
                                        canShowBtn = dataDict.value(forKey: "can_show_btn") as! Bool
                                    }
                                    if !(dataDict.value(forKey: "is_having_action") is NSNull) {
                                        isHavingAction = dataDict.value(forKey: "is_having_action") as! Bool
                                    }
                                    if !(dataDict.value(forKey: "ios_btn_link") is NSNull) {
                                        iosBtnLink = String(format: "%@", (dataDict.value(forKey: "ios_btn_link") as! CVarArg))
                                    }
                                    if !(dataDict.value(forKey: "btn_text") is NSNull) {
                                        btnText = String(format: "%@", (dataDict.value(forKey: "btn_text") as! CVarArg))
                                    }
                                    if !(dataDict.value(forKey: "primary_msg_text") is NSNull) {
                                        primaryMsgText = String(format: "%@", (dataDict.value(forKey: "primary_msg_text") as! CVarArg))
                                    }
                                    if !(dataDict.value(forKey: "secondary_msg_text") is NSNull) {
                                        secondaryMsgText = String(format: "%@", (dataDict.value(forKey: "secondary_msg_text") as! CVarArg))
                                    }
                                    if !(dataDict.value(forKey: "android_btn_link") is NSNull) {
                                        androidBtnLink = String(format: "%@", (dataDict.value(forKey: "android_btn_link") as! CVarArg))
                                    }
                                    viewCon.VersionControlViewController(canShowPrimaryMsg: canShowPrimaryMsg, canShowSecondaryMsg: canShowSecondaryMsg, canShowBtn: canShowBtn, isHavingAction: isHavingAction, btnText: btnText, androidBtnLink: androidBtnLink, iosBtnLink: iosBtnLink, primaryMsgText: primaryMsgText, secondaryMsgText: secondaryMsgText)
                                }
                            } else {
                                self.hideIndicator(viewCon: viewCon)
                                viewCon.view.endEditing(true)
                                viewCon.showToastAlert("Oops..Something went wrong please try again later", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                            }
                        } else {
                            self.hideIndicator(viewCon: viewCon)
                            viewCon.view.endEditing(true)
                            viewCon.showToastAlert("Oops..Something went wrong please try again later", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                        }
                    } catch {
                        self.hideIndicator(viewCon: viewCon)
                        viewCon.view.endEditing(true)
                        viewCon.showToastAlert("Oops..Something went wrong please try again later", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                    }
                } else {
                    self.hideIndicator(viewCon: viewCon)
                    viewCon.view.endEditing(true)
                    viewCon.showToastAlert("Oops..Something went wrong please try again later", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                }
            }
        })
        task.resume()
    }
    // MARK: - Multipart API Call with loader
    
    func requestMultipart(canShowLoader: Bool, viewCon: UIViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?, mimeType: String, mediaData: Data?, fileName: String, callback: @escaping (_ result: NSData) -> Void) {
        
        if canShowLoader == true {
            self.hideIndicator(viewCon: viewCon)
            self.showIndicator(viewCon: viewCon)
        } else {
            self.hideIndicator(viewCon: viewCon)
        }
        
        var strURLQuery: String
        var strURL: String
        
        guard let baseUrl: String = Bundle.main.infoDictionary?["BASE_URL"] as? String else { return }
        guard let version: String = Bundle.main.infoDictionary?["APP_VERSION"] as? String else { return }
        
        // to add query
        if strQuery.isNilOrEmpty {
            strURLQuery = "\(baseUrl)\(subAPIUrl)?ver=\(version)"
        } else {
            strURLQuery = "\(baseUrl)\(subAPIUrl)?ver=\(version)\(String(describing: strQuery!))"
        }
        // to append source
        let strURLSource = "\(strURLQuery)&source=\(BaseKey.appsource)"
        
        // to add pagenumber
        if pageNumber.isNilOrEmpty {
            strURL = "\(strURLSource)"
        } else {
            strURL = "\(strURLSource)&page_number=\(pageNumber ?? "1")"
        }
        // create the url with baseurl
        print("..............................")
        print("API URL: ", strURL)
        print("API Parameter: ", parameter ?? "nil")
        print("API Method: ", methodName)
        print("..............................")
        var request = URLRequest(url: URL(string: strURL)!)
        request.httpMethod = methodName
        request.addValue("application/json", forHTTPHeaderField: "accept")
        //        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let boundary = self.generateBoundaryString()
        let body = NSMutableData()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // set http method for POST with parameter
        if methodName == HTTPMethods.post {
            //            request.httpBody = parameter!.data(using: String.Encoding.utf8)
            if mediaData == nil {
                return
            } else {
                body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: String.Encoding.utf8)!)
                body.append(mediaData!)
                body.append("\r\n".data(using: String.Encoding.utf8)!)
                body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
                request.httpBody = body as Data
            }
        }
        // HTTP Headers
        if !(ServerConfig.shared.headers.isEmpty) {
            let token = "\(ServerConfig.shared.headers)"
            print("Authorization \(token)")
            request.addValue(token, forHTTPHeaderField: Headers.headerAuthorization)
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        if let httpResponse = response as? HTTPURLResponse {
                            print("statusCode: \(httpResponse.statusCode)")
                            if httpResponse.statusCode == 401 || httpResponse.statusCode == 429 {
                                self.hideIndicator(viewCon: viewCon)
                                viewCon.view.endEditing(true)
                                viewCon.signout()
                            }
                        }
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print("..............................")
                        print("Date and time \(DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .full))")
                        print(json)
                        print("..............................")
                        let dic = json as? NSDictionary
                        if dic != nil {
                            var msg = ""
                            if let message = dic!["message"] as? String {
                                msg = message
                            }
                            let code = dic!["status_code"] as! Int
                            if code == 200 {
                                callback(data! as NSData)
                                self.hideIndicator(viewCon: viewCon)
                                viewCon.view.endEditing(true)
                            } else if code == 400 || code == 500 {
                                self.hideIndicator(viewCon: viewCon)
                                viewCon.view.endEditing(true)
                                viewCon.showToastAlert(msg, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                            } else if code == 401 || code == 429 {
                                self.hideIndicator(viewCon: viewCon)
                                viewCon.view.endEditing(true)
                                viewCon.signout()
                            } else if code == 426 {
                                self.hideIndicator(viewCon: viewCon)
                                if let dataDict = dic!.value(forKey: "data") as? NSDictionary {
                                    var canShowPrimaryMsg = false
                                    var canShowSecondaryMsg = false
                                    var canShowBtn = false
                                    var isHavingAction = false
                                    var iosBtnLink = ""
                                    var btnText = ""
                                    var primaryMsgText = ""
                                    var secondaryMsgText = ""
                                    var androidBtnLink = ""
                                    
                                    if !(dataDict.value(forKey: "can_show_primary_msg") is NSNull) {
                                        canShowPrimaryMsg = dataDict.value(forKey: "can_show_primary_msg") as! Bool
                                    }
                                    if !(dataDict.value(forKey: "can_show_secondary_msg") is NSNull) {
                                        canShowSecondaryMsg = dataDict.value(forKey: "can_show_secondary_msg") as! Bool
                                    }
                                    if !(dataDict.value(forKey: "can_show_btn") is NSNull) {
                                        canShowBtn = dataDict.value(forKey: "can_show_btn") as! Bool
                                    }
                                    if !(dataDict.value(forKey: "is_having_action") is NSNull) {
                                        isHavingAction = dataDict.value(forKey: "is_having_action") as! Bool
                                    }
                                    if !(dataDict.value(forKey: "ios_btn_link") is NSNull) {
                                        iosBtnLink = String(format: "%@", (dataDict.value(forKey: "ios_btn_link") as! CVarArg))
                                    }
                                    if !(dataDict.value(forKey: "btn_text") is NSNull) {
                                        btnText = String(format: "%@", (dataDict.value(forKey: "btn_text") as! CVarArg))
                                    }
                                    if !(dataDict.value(forKey: "primary_msg_text") is NSNull) {
                                        primaryMsgText = String(format: "%@", (dataDict.value(forKey: "primary_msg_text") as! CVarArg))
                                    }
                                    if !(dataDict.value(forKey: "secondary_msg_text") is NSNull) {
                                        secondaryMsgText = String(format: "%@", (dataDict.value(forKey: "secondary_msg_text") as! CVarArg))
                                    }
                                    if !(dataDict.value(forKey: "android_btn_link") is NSNull) {
                                        androidBtnLink = String(format: "%@", (dataDict.value(forKey: "android_btn_link") as! CVarArg))
                                    }
                                    viewCon.VersionControlViewController(canShowPrimaryMsg: canShowPrimaryMsg, canShowSecondaryMsg: canShowSecondaryMsg, canShowBtn: canShowBtn, isHavingAction: isHavingAction, btnText: btnText, androidBtnLink: androidBtnLink, iosBtnLink: iosBtnLink, primaryMsgText: primaryMsgText, secondaryMsgText: secondaryMsgText)
                                }
                            } else {
                                self.hideIndicator(viewCon: viewCon)
                                viewCon.view.endEditing(true)
                                viewCon.showToastAlert("Oops..Something went wrong please try again later", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                            }
                        } else {
                            self.hideIndicator(viewCon: viewCon)
                            viewCon.view.endEditing(true)
                            viewCon.showToastAlert("Oops..Something went wrong please try again later", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                        }
                    } catch {
                        self.hideIndicator(viewCon: viewCon)
                        viewCon.view.endEditing(true)
                        viewCon.showToastAlert("Oops..Something went wrong please try again later", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                    }
                } else {
                    self.hideIndicator(viewCon: viewCon)
                    viewCon.view.endEditing(true)
                    viewCon.showToastAlert("Oops..Something went wrong please try again later", txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                }
            }
        })
        task.resume()
    }
    func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
}
