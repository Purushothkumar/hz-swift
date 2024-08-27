//
//  StoreFinderViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 18/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct StoreFinderViewModel {
    func getNotificationCount(canShowLoader: Bool, viewCon: StoreFinderViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(NotificationCountModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.hasCart = false
                    viewCon.hasAlert = false
                    if json.data!.cart != nil {
                        viewCon.hasCart = json.data!.cart!
                    }
                    if json.data!.alert != nil {
                        viewCon.hasAlert = json.data!.alert!
                    }
                    viewCon.setNavigationBar()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getStoreFinderList(canShowLoader: Bool, viewCon: StoreFinderViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// title
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// video
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// filter title
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// experience store title
        //        let view4 = viewCon.mainStackView.arrangedSubviews[4]// city list
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// metro list
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// nearby title
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// State list


        let view10 = viewCon.mainStackView.arrangedSubviews[10]// empty view
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// banner commitment view
        let view12 = viewCon.mainStackView.arrangedSubviews[12]//stats view
        let view13 = viewCon.mainStackView.arrangedSubviews[13]//provider view
        let view14 = viewCon.mainStackView.arrangedSubviews[14]//empty

        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view5.isHidden = true
        view6.isHidden = true
        view7.isHidden = true
        view10.isHidden = true
        view11.isHidden = true
        view12.isHidden = true
        view13.isHidden = true
        view14.isHidden = true

        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreFinderModel.self, from: result as Data)
                if json.data != nil {

                    if retryAPIID == 1000 {
                        viewCon.commonAPICALL(retryAPIID: 1001)
                    }
                    view0.isHidden = false
                    if (json.data!.videoLink).isNilOrEmpty {
                        view1.isHidden = true
                    } else {
                        view1.isHidden = false
                        let videoLink = json.data!.videoLink!
                        let strVideoLinkID = videoLink.extractYoutubeIDFromLink()
                        if !(strVideoLinkID.isNilOrEmpty) {
                            viewCon.youTubePlayerView.loadVideoID("\(strVideoLinkID!)")
                            viewCon.youTubePlayerView.play()
                        }
                    }
                    view2.isHidden = false
                    //                    if json.data!.metroCityList != nil {
                    //                        if (json.data!.metroCityList!.count)! > 0 {
                    //                            view4.isHidden = false
                    //                            viewCon.cityNamesArray.removeAll()
                    //                            viewCon.cityNamesArray = (json.data!.metroCityList)!
                    //                            viewCon.reloadCityCollectionView()
                    //                        } else {
                    //                            view4.isHidden = true
                    //                        }
                    //                    } else {
                    //                        view4.isHidden = true
                    //                    }
                    if json.data!.metroStoreList != nil {
                        if json.data!.metroStoreList!.count > 0 {
                            view5.isHidden = false
                            viewCon.metroStoreArray.removeAll()
                            viewCon.metroStoreArray = json.data!.metroStoreList!
                            viewCon.reloadMetroStoreCollectionView()
                        } else {
                            view5.isHidden = true
                        }
                    } else {
                        view5.isHidden = true
                    }
                    
                    if (viewCon.metroStoreArray.count > 0) || (viewCon.cityNamesArray.count > 0) {
                        view3.isHidden = false
                    } else {
                        view3.isHidden = true
                    }
                    
                    if json.data!.stateList != nil {
                        if json.data!.stateList!.count > 0 {
                            view6.isHidden = false
                            view7.isHidden = false
                            viewCon.stateCountArray.removeAll()
                            viewCon.stateCountArray = json.data!.stateList!
                            viewCon.reloadStateCountTableView()
                        } else {
                            view6.isHidden = true
                            view7.isHidden = true
                            viewCon.reloadStateCountTableView()
                        }
                    } else {
                        view6.isHidden = true
                        view7.isHidden = true
                    }
                        view10.isHidden = false
                        view11.isHidden = false
                        view12.isHidden = false
                        view13.isHidden = false
                        view14.isHidden = false
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getStoreFinderHearzapDifferenceList(canShowLoader: Bool, viewCon: StoreFinderViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// hearzap difference title
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// hearzap difference Collection view
        view8.isHidden = true
        view9.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreFinderDifferenceModel.self, from: result as Data)
                if json.data != nil {
                    if retryAPIID == 1001 {
                        viewCon.commonAPICALL(retryAPIID: 1002)
                    }
                    if json.data!.results != nil {
                        if json.data!.results!.count > 0 {
                            view8.isHidden = false
                            view9.isHidden = false
                            viewCon.hearzapDifferenceArray.removeAll()
                            viewCon.hearzapDifferenceArray = json.data!.results!
                            viewCon.reloadHearzapDifferenceCollectionView()
                        } else {
                            view8.isHidden = true
                            view9.isHidden = true
                            viewCon.reloadHearzapDifferenceCollectionView()
                        }
                    } else {
                        view8.isHidden = true
                        view9.isHidden = true
                        viewCon.reloadHearzapDifferenceCollectionView()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getStoreFinderCustomerTestimonial(canShowLoader: Bool, viewCon: StoreFinderViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view15 = viewCon.mainStackView.arrangedSubviews[15]// testimonial Collection view
        view15.isHidden = true
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreFinderCustomerTestimonial.self, from: result as Data)
                if json.data != nil {
                    if viewCon.testimonialPageNumber == 1 {
                        viewCon.reviewRatingArray.removeAll()
                    }
                    if retryAPIID == 1002 {
                        viewCon.commonAPICALL(retryAPIID: 1003)
                    }
                    if json.data!.paginatedData != nil {
                        if json.data!.paginatedData!.pageNumber != nil {
                            viewCon.testimonialPageNumber += 1
                        }
                        if json.data!.paginatedData!.next != nil {
                            viewCon.testimonialnext = json.data!.paginatedData!.next!
                        }
                    }
                    if json.data!.results != nil {
                        let arrayTestimonialList = json.data!.results!
                        if viewCon.reviewRatingArray.count > 0 {
                            for item in arrayTestimonialList {
                                viewCon.reviewRatingArray.append(item)
                            }
                        } else {
                            viewCon.reviewRatingArray = arrayTestimonialList
                        }
                        if viewCon.reviewRatingArray.count > 0 {
                            view15.isHidden = false
                            viewCon.reloadStoreRatingCollectionView()
                        } else {
                            view15.isHidden = true
                            viewCon.reloadStoreRatingCollectionView()
                        }
                        if viewCon.reviewRatingArray.count > 1 {
                            viewCon.pageControl.isHidden = false
                            viewCon.pageControl.numberOfPages = viewCon.reviewRatingArray.count
                        } else {
                            viewCon.pageControl.isHidden = true
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getStoreFAQList(canShowLoader: Bool, viewCon: StoreFinderViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view16 = viewCon.mainStackView.arrangedSubviews[16]// Faq Title
        let view17 = viewCon.mainStackView.arrangedSubviews[17]// Faq table View
        let view18 = viewCon.mainStackView.arrangedSubviews[18]// load more
        view16.isHidden = true
        view17.isHidden = true
        view18.isHidden = true
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreFAQModel.self, from: result as Data)
                if json.data != nil {
                    if viewCon.faqPageNumber == 0 {
                        viewCon.faqArray.removeAll()
                    }
                    if json.data!.paginatedData != nil {
                        if json.data!.paginatedData!.pageNumber != nil {
                            viewCon.faqPageNumber += 1
                        }
                        if json.data!.paginatedData!.next != nil {
                            viewCon.faqnext = json.data!.paginatedData!.next!
                        }
                    }
                    if json.data!.results != nil {
                        let arrayFaqList = json.data!.results!
                        if arrayFaqList.count > 0 {
                            for i in 0..<arrayFaqList.count {
                                let dict_data = arrayFaqList[i]
                                var question = ""
                                var answer = ""
                                if !(dict_data.question.isNilOrEmpty) {
                                    question = dict_data.question!
                                }
                                if !(dict_data.answer.isNilOrEmpty) {
                                    answer = dict_data.answer!
                                }
                                viewCon.faqArray.append(FAQModelExpanded(question: question, answer: answer, expanded: false))
                            }
                        }
                        if viewCon.faqArray.count > 0 {
                            view16.isHidden = false
                            view17.isHidden = false
                            viewCon.reloadFAQTableView()
                        } else {
                            view16.isHidden = true
                            view17.isHidden = true
                            viewCon.reloadFAQTableView()
                        }
                        if viewCon.faqnext == true {
                            view18.isHidden = false
                        } else {
                            view18.isHidden = true
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func getStoreProvidersList(viewCon: StoreFinderViewController) {
        viewCon.providerArray = [StoreProvidersModel(title: "Booking for an appointment at hearing clinics is quick and easy", hearzap: true, others: false),
                                 StoreProvidersModel(title: "Free hearing checkup at anytime and anywhere", hearzap: true, others: false),
                                 StoreProvidersModel(title: "Generating free preliminary hearing report", hearzap: true, others: false),
                                 StoreProvidersModel(title: "Visiting a hearing clinic is mandatory", hearzap: false, others: true),
                                 StoreProvidersModel(title: "Home visits by the hearing experts", hearzap: true, others: true),
                                 StoreProvidersModel(title: "Live interaction with hearing experts at any time", hearzap: true, others: false),
                                 StoreProvidersModel(title: "Many choices for hearing aids", hearzap: true, others: true),
                                 StoreProvidersModel(title: "Clinic visit for the purchase of hearing aid accessories is compulsory", hearzap: true, others: false),
                                 StoreProvidersModel(title: "Reminder for the service and warranty of the hearing aid", hearzap: true, others: false),
                                 StoreProvidersModel(title: "Transparency while selecting the hearing aid by using latest Hii5 technology is available", hearzap: true, others: false),
                                 StoreProvidersModel(title: "Hassle free hearing care experience at your fingertips", hearzap: true, others: false)
        ]
        viewCon.reloadProviderTableView()
    }
}
