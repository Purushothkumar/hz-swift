//
//  SupportViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 25/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct SupportViewModel {
    func getSupportData(canShowLoader: Bool, viewCon: SupportViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(SupportAPIModel.self, from: result as Data)
                if json.data != nil {
                    //                    if !(json.data!.contactNumber.isNilOrEmpty) {
                    //                        let phonenumber = json.data!.contactNumber!.replacingOccurrences(of: " ", with: "")
                    //                        viewCon.supportArray.append(SupportModel(title: AppLocalizationString.callUs, description: "\(AppLocalizationString.pleasecalluson) \(phonenumber.toPhoneNumberFormate())", buttonTitle: AppLocalizationString.callnow, image: Asset.supportfemale, supportdata: phonenumber, supportDeskType: SupportDeskType.call.rawValue))
                    //                    }
                    viewCon.changeLanguageFormat()
                    if !(json.data!.contactNumber.isNilOrEmpty) {
                        let phonenumber = json.data!.contactNumber!.replacingOccurrences(of: " ", with: "")
                        viewCon.supportArray.append(SupportModel(title: AppLocalizationString.callUs, description: AppLocalizationString.pleasecalluson, buttonTitle: AppLocalizationString.callnow, image: Asset.supportfemale, supportdata: phonenumber, supportDeskType: SupportDeskType.call.rawValue))
                        
                    }
                    if  !(json.data!.whatsappNumber.isNilOrEmpty) {
                        viewCon.supportArray.append(SupportModel(title: AppLocalizationString.whatsApp, description: AppLocalizationString.talktousthroughourwhatsapp, buttonTitle: AppLocalizationString.chatnow, image: Asset.supportwhatsapp, supportdata: (json.data!.whatsappNumber)!, supportDeskType: SupportDeskType.whatsapp.rawValue))
                    }
                    if !(json.data!.emailAddress.isNilOrEmpty) {
                        viewCon.supportArray.append(SupportModel(title: AppLocalizationString.supportDesk, description: AppLocalizationString.wewillrespondbackwithin24hours, buttonTitle: AppLocalizationString.emailus, image: Asset.supportchat, supportdata: (json.data!.emailAddress)!, supportDeskType: SupportDeskType.email.rawValue))
                    }
                    if viewCon.supportArray.count > 0 {
                        viewCon.reloadTableview()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
