//
//  BlogsDetailViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 04/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct BlogsDetailViewModel{
    func getBlogsDetail(canShowLoader: Bool, viewCon: BlogsDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BlogsDetailModel.self, from: result as Data)
                if json.data != nil {
                    let stackView0 = viewCon.mainStackView.arrangedSubviews[0]// Blog
                    let stackView1 = viewCon.mainStackView.arrangedSubviews[1]// Related Articles title
                    let stackView2 = viewCon.mainStackView.arrangedSubviews[2]// Related Articles
                    let stackView3 = viewCon.mainStackView.arrangedSubviews[3]// queries
                    let stackView4 = viewCon.mainStackView.arrangedSubviews[4]// Recent Articles title
                    let stackView5 = viewCon.mainStackView.arrangedSubviews[5]// Recent Articles
                    let stackView6 = viewCon.mainStackView.arrangedSubviews[6]// subscription

                    stackView0.isHidden = true
                    stackView1.isHidden = true
                    stackView2.isHidden = true
                    stackView3.isHidden = false
                    stackView4.isHidden = true
                    stackView5.isHidden = true
                    stackView6.isHidden = false

                    let blogsstackView0 = viewCon.blogStackView.arrangedSubviews[0]// title
                    let blogsstackView1 = viewCon.blogStackView.arrangedSubviews[1]// description
                    let blogsstackView2 = viewCon.blogStackView.arrangedSubviews[2]// time
                    let blogsstackView3 = viewCon.blogStackView.arrangedSubviews[3]// image
                    let blogsstackView4 = viewCon.blogStackView.arrangedSubviews[4]// content

                    blogsstackView0.isHidden = true
                    blogsstackView1.isHidden = true
                    blogsstackView2.isHidden = true
                    blogsstackView3.isHidden = true
                    blogsstackView4.isHidden = true

                    viewCon.gridArray.removeAll()
                    viewCon.listArray.removeAll()

                    viewCon.htmlstring = ""
                    viewCon.titleLabel.text = ""
                    viewCon.descriptionLabel.text = ""
                    viewCon.contentLabel.text = ""
                    viewCon.timeLabel.text = ""
                    viewCon.queriesNameTextField.text = ""
                    viewCon.queriesMobileTextField.text = ""
                    viewCon.queriesStateTextField.text = ""
                    viewCon.queriesEmailTextField.text = ""
                    viewCon.queriesCommentTextView.text = ""
                    viewCon.subscriptionEmailTextField.text = ""

                    viewCon.canHideShimmering = true
                    viewCon.mainScrollView.isScrollEnabled = true

                    if (json.data!.article != nil){
                        var authorName = ""
                        var displayDate = ""
                        var imgurl = ""

                        let article = json.data!.article!
                        if !(article.content.isNilOrEmpty){
                            stackView0.isHidden = false
                            blogsstackView4.isHidden = false
                            viewCon.htmlstring = json.data!.article!.content!
                            viewCon.reloadWebView()
                        }

                        if (article.category != nil)  {
                            if !(article.category!.name.isNilOrEmpty)  {
                                viewCon.titleLabel.text = article.category!.name!
                                stackView0.isHidden = false
                                blogsstackView0.isHidden = false
                            }
                        }
                        if !(article.title.isNilOrEmpty)  {
                            stackView0.isHidden = false
                            blogsstackView1.isHidden = false
                            viewCon.descriptionLabel.text = article.title
                        }
                        if !(article.authorName.isNilOrEmpty) {
                            authorName = article.authorName!
                        }
                        if !(article.displayDate.isNilOrEmpty) {
                            displayDate = article.displayDate!
                        }
                        if !(authorName.isEmpty) && !(displayDate.isEmpty){
                            stackView0.isHidden = false
                            blogsstackView2.isHidden = false
                            viewCon.timeLabel.text = "By \(authorName) | \(displayDate)"
                        }
                        else if !(authorName.isEmpty) {
                            stackView0.isHidden = false
                            blogsstackView2.isHidden = false
                            viewCon.timeLabel.text = "By \(authorName)"
                        } else if !(displayDate.isEmpty){
                            stackView0.isHidden = false
                            blogsstackView2.isHidden = false
                            viewCon.timeLabel.text = "\(displayDate)"
                        }
                        if !(article.image.isNilOrEmpty) {
                            imgurl = article.image!
                            viewCon.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
                            viewCon.bannerImageViewHeight.constant = CGFloat(screenFrameWidth) * CGFloat(AppConstantValue.screen192dot94slash375)
                            stackView0.isHidden = false
                            blogsstackView3.isHidden = false
                        }
                        else{
                            blogsstackView3.isHidden = true
                            viewCon.bannerImageView.setImage(imageUrl: imgurl, placeHolderImage: hearzapPlaceholder)
                            viewCon.bannerImageViewHeight.constant = 0
                        }
                    }

                    if (json.data!.relatedArticle != nil){
                        viewCon.gridArray = json.data!.relatedArticle!
                        viewCon.reloadGridCollectionView()
                        if (viewCon.gridArray.count > 0){
                            stackView1.isHidden = false
                            stackView2.isHidden = false
                        }
                        else{
                            stackView1.isHidden = true
                            stackView2.isHidden = true
                        }
                    }
                    if (json.data!.recentArticles != nil){
                        viewCon.listArray = json.data!.recentArticles!
                        viewCon.reloadRecentBlogsTableView()
                        if (viewCon.listArray.count > 0){
                            stackView4.isHidden = false
                            stackView5.isHidden = false
                        }
                        else{
                            stackView4.isHidden = true
                            stackView5.isHidden = true
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postBlogsQueries(canShowLoader: Bool, viewCon: BlogsDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BlogsQueriesModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.queriesNameTextField.text = ""
                    viewCon.queriesMobileTextField.text = ""
                    viewCon.queriesStateTextField.text = ""
                    viewCon.queriesEmailTextField.text = ""
                    viewCon.queriesCommentTextView.text = ""
                    viewCon.subscriptionEmailTextField.text = ""
                    viewCon.isQueriesAccepted = false
                    viewCon.queriesAuthorised()

                    if !(json.data!.message.isNilOrEmpty){
                        viewCon.showToastAlert(json.data!.message!, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: viewCon)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postBlogsNewsletter(canShowLoader: Bool, viewCon: BlogsDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BlogsNewletterModel.self, from: result as Data)
                viewCon.queriesNameTextField.text = ""
                viewCon.queriesMobileTextField.text = ""
                viewCon.queriesStateTextField.text = ""
                viewCon.queriesEmailTextField.text = ""
                viewCon.queriesCommentTextView.text = ""
                viewCon.subscriptionEmailTextField.text = ""
                viewCon.isQueriesAccepted = false
                viewCon.queriesAuthorised()
                
                if json.data != nil {
                    viewCon.showToastAlert(json.data!.message!, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_green_27AE60, viewCon: viewCon)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
