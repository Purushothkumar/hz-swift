//
//  ShareExperienceViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 06/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct ShareExperienceViewModel {
    func getSurveyList(canShowLoader: Bool, viewCon: ShareExperienceViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(SurveyModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.questions != nil {
                        viewCon.questionArray = json.data!.questions!
                        viewCon.reloadTableView()
                        for item in viewCon.questionArray {
                            var keyCode = ""
                            if item.id != nil {
                                keyCode = String(format: "%d", item.id!)
                            }
                            if !(keyCode.isEmpty) {
                                let dictTemp = NSMutableDictionary()
                                dictTemp.setValue("", forKey: keyCode)
                                viewCon.selectArray.add(dictTemp)
                            }
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postSurveyList(canShowLoader: Bool, viewCon: ShareExperienceViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(SurveyResponseModel.self, from: result as Data)
                if json.data != nil {
                    var message = ""
                    if !(json.data!.responseText.isNilOrEmpty) {
                        message = json.data!.responseText!
                    }
                    viewCon.navigateToSurveySuccessViewController(isFrom: viewCon.isFrom, message: message)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
