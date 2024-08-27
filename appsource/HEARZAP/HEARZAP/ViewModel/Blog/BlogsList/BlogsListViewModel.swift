//
//  BlogsListViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 04/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct BlogsListViewModel {
    func getBlogsList(canShowLoader: Bool, viewCon: BlogsListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BlogsListModel.self, from: result as Data)
                if json.data != nil {

                    let stackView0 = viewCon.mainStackView.arrangedSubviews[0]// category
                    let stackView1 = viewCon.mainStackView.arrangedSubviews[1]// grid
                    let stackView2 = viewCon.mainStackView.arrangedSubviews[2]// pagination
                    let stackView3 = viewCon.mainStackView.arrangedSubviews[3]// empty
                    let stackView4 = viewCon.mainStackView.arrangedSubviews[4]// queries
                    let stackView5 = viewCon.mainStackView.arrangedSubviews[5]// subscription

                    stackView0.isHidden = false
                    stackView1.isHidden = true
                    stackView2.isHidden = true
                    stackView3.isHidden = true
                    stackView4.isHidden = false
                    stackView5.isHidden = false

                    viewCon.categoryList.removeAll()
                    viewCon.categoryListSlug.removeAll()
                    viewCon.gridArray.removeAll()
                    viewCon.canHideShimmering = true
                    viewCon.mainScrollView.isScrollEnabled = true
                    if (json.data!.category != nil){
                        let category = json.data!.category!
                        if (category.count > 0){
                            for item in category {
                                if !(item.slug.isNilOrEmpty) && !(item.name.isNilOrEmpty) {
                                    viewCon.categoryList.append(item.name!)
                                    viewCon.categoryListSlug.append(item.slug!)
                                }
                            }
                            if (viewCon.categoryLabel.text!.isEmpty){
                                if !(category[0].name.isNilOrEmpty){
                                    viewCon.categoryLabel.text = viewCon.categoryList[0]
                                }
                            }
                        }
                    }
                    if (json.data!.articles != nil){
                        if (json.data!.articles!.count > 0){
                            viewCon.gridArray = json.data!.articles!
                            stackView1.isHidden = false
                            stackView2.isHidden = false
                            stackView3.isHidden = true
                        }
                        else{
                            stackView1.isHidden = true
                            stackView2.isHidden = true
                            stackView3.isHidden = false
                        }
                        viewCon.reloadGridCollectionView()
                    }
                    if json.data!.paginatedData != nil {
                        if json.data!.paginatedData?.next != nil {
                            viewCon.hasnext = json.data!.paginatedData!.next!
                        }
                        if json.data!.paginatedData?.next != nil {
                            viewCon.hasprevious = json.data!.paginatedData!.previous!
                        }
                        if json.data!.paginatedData?.totalPages != nil {
                            viewCon.totalPages = json.data!.paginatedData!.totalPages!
                            if (viewCon.totalPages > 1){
                                stackView2.isHidden = false
                            }
                        }
                        viewCon.pageNumber = viewCon.pageNumber
                        viewCon.previousPageButton.isUserInteractionEnabled = viewCon.hasprevious
                        viewCon.nextPageButton.isUserInteractionEnabled = viewCon.hasnext
                        viewCon.setButtonTitle()
                    }
                      UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                        viewCon.mainScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
                    }, completion: nil)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getBlogsCategoryList(canShowLoader: Bool, viewCon: BlogsListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(BlogsListModel.self, from: result as Data)
                if json.data != nil {
                    let stackView0 = viewCon.mainStackView.arrangedSubviews[0]// category
                    let stackView1 = viewCon.mainStackView.arrangedSubviews[1]// grid
                    let stackView2 = viewCon.mainStackView.arrangedSubviews[2]// pagination
                    let stackView3 = viewCon.mainStackView.arrangedSubviews[3]// empty
                    let stackView4 = viewCon.mainStackView.arrangedSubviews[4]// queries
                    let stackView5 = viewCon.mainStackView.arrangedSubviews[5]// subscription

                    stackView0.isHidden = false
                    stackView1.isHidden = true
                    stackView2.isHidden = true
                    stackView3.isHidden = true
                    stackView4.isHidden = false
                    stackView5.isHidden = false

                    viewCon.categoryList.removeAll()
                    viewCon.categoryListSlug.removeAll()
                    viewCon.gridArray.removeAll()
                    viewCon.canHideShimmering = true
                    viewCon.mainScrollView.isScrollEnabled = true
                    if (json.data!.category != nil){
                        let category = json.data!.category!
                        if (category.count > 0){
                            for item in category {
                                if !(item.slug.isNilOrEmpty) && !(item.name.isNilOrEmpty) {
                                    viewCon.categoryList.append(item.name!)
                                    viewCon.categoryListSlug.append(item.slug!)
                                }
                            }
                        }
                    }
                    if (json.data!.articles != nil){
                        if (json.data!.articles!.count > 0){
                            viewCon.gridArray = json.data!.articles!
                            stackView1.isHidden = false
                            stackView2.isHidden = false
                            stackView3.isHidden = true
                        }
                        else{
                            stackView1.isHidden = true
                            stackView2.isHidden = true
                            stackView3.isHidden = false
                        }
                        viewCon.reloadGridCollectionView()
                    }
                    if json.data!.paginatedData != nil {
                        if json.data!.paginatedData?.next != nil {
                            viewCon.hasnext = json.data!.paginatedData!.next!
                        }
                        if json.data!.paginatedData?.next != nil {
                            viewCon.hasprevious = json.data!.paginatedData!.previous!
                        }
                        if json.data!.paginatedData?.totalPages != nil {
                            viewCon.totalPages = json.data!.paginatedData!.totalPages!
                            if (viewCon.totalPages > 0){
                                stackView1.isHidden = false
                            }
                        }
                        viewCon.pageNumber = viewCon.pageNumber
                        viewCon.previousPageButton.isUserInteractionEnabled = viewCon.hasprevious
                        viewCon.nextPageButton.isUserInteractionEnabled = viewCon.hasnext
                        viewCon.setButtonTitle()
                    }

                    UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                        viewCon.mainScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
                    }, completion: nil)

                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postBlogsQueries(canShowLoader: Bool, viewCon: BlogsListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
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
    func postBlogsNewsletter(canShowLoader: Bool, viewCon: BlogsListViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
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
