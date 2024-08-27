//
//  FindRightDeviceUploadReportViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 19/07/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct FindRightDeviceUploadReportViewModel {
    func getFindRightDeviceUploadReportList(canShowLoader: Bool, viewCon: FindRightDeviceUploadReportViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(FindRightDeviceReportModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.audiogramTestReports != nil {
                        viewCon.reportList = json.data!.audiogramTestReports!
                        viewCon.reloadTableView()
                    }
                    
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func postUploadReport(canShowLoader: Bool, viewCon: FindRightDeviceUploadReportViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(FindRightDeviceUploadReportModel.self, from: result as Data)
                if json.data !=  nil {
                    if !(json.data!.reportId.isNilOrEmpty){
                        viewCon.sessionUID = json.data!.reportId!
                        viewCon.sessionKey = "report_uploaded"
                        viewCon.navigateToNext(session_UID: viewCon.sessionUID, session_Key: viewCon.sessionKey)
                    }
                    else{
                        viewCon.showToastAlert(AppLocalizationString.failedtoCreateSessionID, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                    }
                }
                else{
                    viewCon.showToastAlert(AppLocalizationString.pleasetryagainuploadreportfailed, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: viewCon)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
