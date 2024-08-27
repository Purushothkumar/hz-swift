//
//  AudiogramReportViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 28/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct AudiogramReportViewModel {
    func getAudiogramReportList(canShowLoader: Bool, viewCon: AudiogramReportViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(AudiogramReportModel.self, from: result as Data)
                if json.data != nil {
                    if json.data != nil {
                        viewCon.isQuickCheck = false
                        viewCon.setSelectedState()
                        viewCon.errorView.isHidden = false
                        if json.data!.audiogramTestReports != nil {
                            viewCon.audiogramReportListArray = json.data!.audiogramTestReports!
                            viewCon.reloadTableView()
                            if viewCon.audiogramReportListArray.count == 0 {
                                viewCon.errorView.isHidden = false
                            } else {
                                viewCon.errorView.isHidden = true
                            }
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getQuickTestReportList(canShowLoader: Bool, viewCon: AudiogramReportViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(QuickCheckReportModel.self, from: result as Data)
                if json.data != nil {
                    if json.data != nil {
                        viewCon.isQuickCheck = true
                        viewCon.setSelectedState()
                        viewCon.errorView.isHidden = false
                        if json.data!.quickTestReports != nil {
                            viewCon.quickCheckReportListArray = json.data!.quickTestReports!
                            viewCon.reloadTableView()
                            if viewCon.quickCheckReportListArray.count == 0 {
                                viewCon.errorView.isHidden = false
                            } else {
                                viewCon.errorView.isHidden = true
                            }
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
