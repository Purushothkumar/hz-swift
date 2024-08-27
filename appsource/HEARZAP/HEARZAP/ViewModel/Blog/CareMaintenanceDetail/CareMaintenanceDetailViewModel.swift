//
//  CareMaintenanceDetailViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct CareMaintenanceDetailViewModel {
    func getCareMaintenanceDetailList(canShowLoader: Bool, viewCon: CareMaintenanceDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CareMaintenanceDetailModel.self, from: result as Data)
                if json.data != nil {
                    let view0 = viewCon.mainStackView.arrangedSubviews[0]// playerview
                    let view1 = viewCon.mainStackView.arrangedSubviews[1]// contentView
                    let view2 = viewCon.mainStackView.arrangedSubviews[2]// descriptionView
                    let view3 = viewCon.mainStackView.arrangedSubviews[3]// empty
                    let view4 = viewCon.mainStackView.arrangedSubviews[4]// list
                    let view5 = viewCon.mainStackView.arrangedSubviews[5]// empty
                    view0.isHidden = true
                    view1.isHidden = true
                    view2.isHidden = true
                    view3.isHidden = true
                    view4.isHidden = true
                    view5.isHidden = true
                    
                    viewCon.playerViewHeight.constant = 0
                    viewCon.listArray.removeAll()
                    if json.data!.relatedCareAndMaintenance != nil {
                        viewCon.listArray = json.data!.relatedCareAndMaintenance!
                    }
                    if json.data!.careAndMaintenance != nil {
                        if json.data!.careAndMaintenance?.videoLink != nil {
                            let strVideoLink = json.data!.careAndMaintenance?.videoLink!
                            if !(strVideoLink.isNilOrEmpty) {
                                let strVideoLinkID = strVideoLink!.extractYoutubeIDFromLink()
                                if !(strVideoLinkID.isNilOrEmpty) {
                                    viewCon.playerViewHeight.constant = CGFloat(screenFrameWidth) * CGFloat(AppConstantValue.screen206slash375)
                                    view0.isHidden = false
                                    viewCon.youTubePlayerView.loadVideoID("\(strVideoLinkID!)")
                                }
                            }
                        }
                        if !(json.data!.careAndMaintenance!.categoryName.isNilOrEmpty) {
                            view1.isHidden = false
                            viewCon.titleLabel.text = json.data!.careAndMaintenance!.categoryName!
                        }
                        
                        if !(json.data!.careAndMaintenance!.title.isNilOrEmpty) {
                            view1.isHidden = false
                            viewCon.descriptionLabel.text = json.data!.careAndMaintenance!.title!
                        }
                        if !(json.data!.careAndMaintenance!.createdOnDate.isNilOrEmpty) {
                            view1.isHidden = false
                            viewCon.timeLabel.text = json.data!.careAndMaintenance!.createdOnDate!
                        }
                        if !(json.data!.careAndMaintenance!.content.isNilOrEmpty) {
                            view2.isHidden = false
                            viewCon.htmlstring = json.data!.careAndMaintenance!.content!
                            if !(viewCon.htmlstring.isEmpty) {
                                viewCon.reloadWebView()
                            }
                        }
                    }
                    if viewCon.listArray.count > 0 {
                        view3.isHidden = false
                        view4.isHidden = false
                        view5.isHidden = false
                    }
                    viewCon.reloadListTableView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
