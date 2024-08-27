//
//  TipsDetailViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 31/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct TipsDetailViewModel {
    func getTipsDetails(canShowLoader: Bool, viewCon: TipsDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[1]// banner
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// header List
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// heartview
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// list view
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// empty
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        
        viewCon.nextTipsView.isHidden = true
        viewCon.shareButton.isHidden = true
        viewCon.shareLabel.text = ""
        viewCon.nextTipsImageView.isHidden = true
        viewCon.nextLabel.isHidden = true
        viewCon.nextButton.isHidden = true
        viewCon.nextArrowButton.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(TipsDetailModel.self, from: result as Data)
                if json.data != nil {
                    view0.isHidden = false
                    viewCon.tipsBannerImageView.setImage(imageUrl: "", placeHolderImage: hearzapPlaceholder)
                    viewCon.tipsBannerImageViewHeight.constant = CGFloat(332 * (332/343.0)) // pk verification needed
                    if json.data!.tips != nil {
                        if !(json.data!.tips!.image.isNilOrEmpty) {
                            viewCon.tipsBannerImageView.setImage(imageUrl: json.data!.tips!.image!, placeHolderImage: hearzapPlaceholder)
                            view0.isHidden = false
                        }
                        if json.data!.tips!.tipDetailList != nil {
                            viewCon.headerListArray.removeAll()
                            viewCon.reloadHeaderTableView()
                            if json.data!.tips!.tipDetailList!.count > 0 {
                                view1.isHidden = false
                                viewCon.headerListArray = json.data!.tips!.tipDetailList!
                                viewCon.reloadHeaderTableView()
                            }
                        }
                        if !(json.data!.tips!.sharedLink.isNilOrEmpty) {
                            viewCon.nextTipLink = json.data!.tips!.sharedLink!
                        }
                    }
                    
                    if json.data!.relatedTip != nil {
                        viewCon.listArray.removeAll()
                        viewCon.reloadListTableView()
                        if json.data!.relatedTip!.count > 0 {
                            view3.isHidden = false
                            viewCon.listArray = json.data!.relatedTip!
                            viewCon.reloadListTableView()
                        }
                    }
                    if !(viewCon.nextTipLink.isEmpty) {
                        view4.isHidden = false
                        viewCon.nextTipsView.isHidden = false
                        viewCon.shareButton.isHidden = false
                        viewCon.shareLabel.text = AppLocalizationString.share
                    }
                    if json.data!.nextTip != nil {
                        if !(json.data!.nextTip!.slug.isNilOrEmpty) {
                            viewCon.nextTipSlug = json.data!.nextTip!.slug!
                        }
                        if  !(viewCon.nextTipSlug.isEmpty) {
                            view4.isHidden = false
                            viewCon.nextTipsView.isHidden = false
                            viewCon.nextTipsImageView.isHidden = false
                            viewCon.nextLabel.isHidden = false
                            viewCon.nextButton.isHidden = false
                            viewCon.nextArrowButton.isHidden = false
                            viewCon.nextTipsImageView.setImage(imageUrl: "", placeHolderImage: hearzapPlaceholder)
                            if json.data!.nextTip!.imageURL != nil {
                                if !(json.data!.nextTip!.imageURL.isNilOrEmpty) {
                                    viewCon.nextTipsImageView.setImage(imageUrl: json.data!.nextTip!.imageURL!, placeHolderImage: hearzapPlaceholder)
                                }
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
