//
//  CustomerTestimonialDetailViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 03/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct CustomerTestimonialDetailViewModel {
    func getCustomerTestimonialDetailList(canShowLoader: Bool, viewCon: CustomerTestimonialDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
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
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(CustomerTestimonialDetailModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.playerViewHeight.constant = 0
                    viewCon.listArray.removeAll()
                    if json.data!.relatedTestimonial != nil {
                        viewCon.listArray = json.data!.relatedTestimonial!
                    }
                    if json.data!.customerTestimonial != nil {
                        if json.data!.customerTestimonial?.videoLink != nil {
                            let strVideoLink = json.data!.customerTestimonial?.videoLink!
                            if !(strVideoLink.isNilOrEmpty) {
                                let strVideoLinkID = strVideoLink!.extractYoutubeIDFromLink()
                                if !(strVideoLinkID.isNilOrEmpty) {
                                    viewCon.playerViewHeight.constant = CGFloat(screenFrameWidth) * CGFloat(AppConstantValue.screen206slash375)
                                    view0.isHidden = false
                                    viewCon.youTubePlayerView.loadVideoID("\(strVideoLinkID!)")
                                }
                            }
                        }
                        if !(json.data!.customerTestimonial!.reviewByName.isNilOrEmpty) {
                            view1.isHidden = false
                            viewCon.titleLabel.text = json.data!.customerTestimonial!.reviewByName!
                        }
                        if !(json.data!.customerTestimonial!.reviewBySubline.isNilOrEmpty) {
                            view1.isHidden = false
                            viewCon.descriptionLabel.text = json.data!.customerTestimonial!.reviewBySubline!
                        }
                        if !(json.data!.customerTestimonial!.createdOn.isNilOrEmpty) {
                            view1.isHidden = false
                            viewCon.timeLabel.text = json.data!.customerTestimonial!.createdOn!
                        }
                        if !(json.data!.customerTestimonial!.review.isNilOrEmpty) {
                            view2.isHidden = false
                            viewCon.htmlstring = json.data!.customerTestimonial!.review!
                            if !(viewCon.htmlstring.isEmpty) {
                                viewCon.reloadWebView()
                            }
                        }
                    }
                    if viewCon.listArray.count > 0 {
                        view3.isHidden = false
                        view4.isHidden = false
                        view5.isHidden = false
                        viewCon.reloadListTableView()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
