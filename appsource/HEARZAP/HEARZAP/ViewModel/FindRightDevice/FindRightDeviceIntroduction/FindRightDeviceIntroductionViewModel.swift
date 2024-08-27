//
//  FindRightDeviceIntroductionViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 08/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct FindRightDeviceIntroductionViewModel {
    func getFindRightDeviceDemoList(canShowLoader: Bool, viewCon: FindRightDeviceIntroductionViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// bannerView
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// demoview
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// emptyview
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        
        let viewlist0 = viewCon.listStackView.arrangedSubviews[0]// title
        let viewlist1 = viewCon.listStackView.arrangedSubviews[1]// stepstack
        let viewlist2 = viewCon.listStackView.arrangedSubviews[2]// recommendation
        
        viewlist0.isHidden = true
        viewlist1.isHidden = true
        viewlist2.isHidden = true
        
        let viewstep0 = viewCon.stepStackView.arrangedSubviews[0]// list
        let viewstep1 = viewCon.stepStackView.arrangedSubviews[1]// play
        
        viewstep0.isHidden = true
        viewstep1.isHidden = true
        viewCon.tryNowView.isHidden = true
        
        let resultlist0 = viewCon.resultStackView.arrangedSubviews[0]// title
        let resultlist1 = viewCon.resultStackView.arrangedSubviews[1]// recommendation
        
        resultlist0.isHidden = true
        resultlist1.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(FindRightDeviceIntroductionModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.tryNowView.isHidden = false
                    var imgurl = ""
                    viewCon.stepArray.removeAll()
                    viewCon.previousResultArray.removeAll()
                    viewCon.reloadTableview()
                    viewCon.reloadPreviousTableview()
                    viewCon.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
                    view0.isHidden = false
                    view2.isHidden = false
                    viewCon.setNavigationBar()
                    if !(json.data!.servicePosterImage.isNilOrEmpty) {
                        view0.isHidden = false
                        view2.isHidden = false
                        imgurl = (json.data!.servicePosterImage)!
                        viewCon.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
                    }
                    //                    if !(json.data!.servicePosterVideoLink.isNilOrEmpty) {
                    //                        viewCon.servicePosterVideoLink = (json.data!.servicePosterVideoLink)!
                    //                        view1.isHidden = false
                    //                        view2.isHidden = false
                    //                        viewlist0.isHidden = false
                    //                        viewlist1.isHidden = false
                    //                        viewstep1.isHidden = false
                    //                    }
                    
                    if json.data!.steps != nil {
                        viewCon.stepArray = json.data!.steps!
                        if viewCon.stepArray.count > 0 {
                            view1.isHidden = false
                            view2.isHidden = false
                            viewlist0.isHidden = false
                            viewlist1.isHidden = false
                            viewstep0.isHidden = false
                            viewCon.reloadTableview()
                        }
                    }
                    if json.data!.previousResults != nil {
                        viewCon.previousResultArray = json.data!.previousResults!
                        if viewCon.previousResultArray.count > 0 {
                            view1.isHidden = false
                            view2.isHidden = false
                            viewlist0.isHidden = false
                            viewlist2.isHidden = false
                            resultlist0.isHidden = false
                            resultlist1.isHidden = false
                            viewCon.reloadPreviousTableview()
                        }
                    }
                    viewCon.backgroundView.roundCorners([.topLeft, .topRight], radius: 20.0)
                    if canShowLoader == false {
                        viewCon.navigateToSelectUserViewControllerToFHA(isFrom: viewCon.isFrom, showFourDotView: false, showFiveDotView: false, showSixDotView: true)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
