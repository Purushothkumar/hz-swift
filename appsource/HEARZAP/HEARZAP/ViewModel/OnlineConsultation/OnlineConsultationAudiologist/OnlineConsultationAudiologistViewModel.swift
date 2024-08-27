//
//  OnlineConsultationAudiologistViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct OnlineConsultationAudiologistViewModel {
    func getOnlineConsultationaudiologistsList(canShowLoader: Bool, viewCon: OnlineConsultationAudiologistViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OnlineConsultationAudiologistModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.audiologistProfileList != nil {
                        viewCon.audiologistProfileList = json.data!.audiologistProfileList!
                    }
                    if viewCon.audiologistProfileList.count > 0 {
                        viewCon.errorView.isHidden = true
                    } else {
                        viewCon.errorView.isHidden = false
                    }
                    viewCon.reloadTableview()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
