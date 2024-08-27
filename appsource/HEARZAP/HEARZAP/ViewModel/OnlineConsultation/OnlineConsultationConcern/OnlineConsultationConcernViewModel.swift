//
//  OnlineConsultationConcernViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct OnlineConsultationConcernViewModel {
    func getOnlineConsultationConcernList(canShowLoader: Bool, viewCon: OnlineConsultationConcernViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        viewCon.concernArray.removeAll()
        viewCon.reloadTableview()
        viewCon.nextButtonView.isHidden = true
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OnlineConsultationConcernModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.customerConcernQuestions != nil {
                        viewCon.concernArraySelected.removeAllObjects()
                        viewCon.concernArray = json.data!.customerConcernQuestions!
                        if viewCon.concernArray.count > 0 {
                            for item in viewCon.concernArray {
                                var keyCode = ""
                                if item.id != nil {
                                    keyCode = String(format: "%d", item.id!)
                                }
                                if !(keyCode.isEmpty) {
                                    let dictTemp = NSMutableDictionary()
                                    dictTemp.setValue([], forKey: keyCode)
                                    viewCon.concernArraySelected.add(dictTemp)
                                }
                            }
                        }
                        viewCon.reloadTableview()
                        viewCon.nextButtonView.isHidden = false
                        viewCon.setUserInteractionButton()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
