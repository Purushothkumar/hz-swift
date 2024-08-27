//
//  QuickTestResultViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 08/12/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct QuickTestResultViewModel {
    func getWarningDescription() -> [QuickTestResultModel] {
        let array = [QuickTestResultModel(title: AppLocalizationString.goodHearing, message: AppLocalizationString.goodHearingDesc, colorcode: UIColor.colorLiteral.theme_green_27AE60, bgcolorcode: UIColor.colorLiteral.theme_green_E5FFF0),
                     QuickTestResultModel(title: AppLocalizationString.mildHearingConcern, message: AppLocalizationString.mildHearingLossDesc, colorcode: UIColor.colorLiteral.theme_yellow_FFD426, bgcolorcode: UIColor.colorLiteral.theme_yellow_FFFCEC),
                     QuickTestResultModel(title: AppLocalizationString.moderateHearingConcern, message: AppLocalizationString.moderateHearingLossDesc, colorcode: UIColor.colorLiteral.theme_orange_F7732F, bgcolorcode: UIColor.colorLiteral.theme_orange_FFE5D8),
                     QuickTestResultModel(title: AppLocalizationString.severeHearingConcern, message: AppLocalizationString.severeHearingLossDesc, colorcode: UIColor.colorLiteral.theme_red_FF6961, bgcolorcode: UIColor.colorLiteral.theme_red_FFE6E4)]
        return array
    }
    func getQuickCheckupData(canShowLoader: Bool, viewCon: QuickTestResultViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(QuickTestResultDataModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.testLeftAverage = ""
                    viewCon.testLeftImpression = ""
                    viewCon.testRightAverage = ""
                    viewCon.testRightImpression = ""
                    viewCon.descriptionmess = ""
                    viewCon.recommendation = ""
                    viewCon.reportLink = ""
                    
                    if json.data!.patientData != nil {
                        viewCon.patientData = json.data!.patientData!
                    }
                    if json.data!.testResult != nil {
                        if !(json.data!.testResult!.description.isNilOrEmpty) {
                            viewCon.descriptionmess = json.data!.testResult!.description!
                        }
                        if !(json.data!.testResult!.recommendation.isNilOrEmpty) {
                            viewCon.recommendation = json.data!.testResult!.recommendation!
                        }
                    }
                    if json.data!.quickcheckupSessionResults != nil {
                        if !(json.data!.quickcheckupSessionResults!.testLeftAverage.isNilOrEmpty) {
                            viewCon.testLeftAverage = json.data!.quickcheckupSessionResults!.testLeftAverage!
                        }
                        if !(json.data!.quickcheckupSessionResults!.testLeftImpression.isNilOrEmpty) {
                            viewCon.testLeftImpression = json.data!.quickcheckupSessionResults!.testLeftImpression!
                        }
                        if !(json.data!.quickcheckupSessionResults!.testRightAverage.isNilOrEmpty) {
                            viewCon.testRightAverage = json.data!.quickcheckupSessionResults!.testRightAverage!
                        }
                        if !(json.data!.quickcheckupSessionResults!.testRightImpression.isNilOrEmpty) {
                            viewCon.testRightImpression = json.data!.quickcheckupSessionResults!.testRightImpression!
                        }
                        if !(json.data!.quickcheckupSessionResults!.reportLink.isNilOrEmpty) {
                            viewCon.reportLink = json.data!.quickcheckupSessionResults!.reportLink!
                        }
                    }
                    viewCon.canHideShimmering = true
                    viewCon.toLoadData(canHideShimmering: viewCon.canHideShimmering)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
