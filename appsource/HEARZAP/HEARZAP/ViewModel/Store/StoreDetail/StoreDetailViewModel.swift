//
//  StoreDetailViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 27/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct StoreDetailViewModel {
    func getStoreDetailList(canShowLoader: Bool, viewCon: StoreDetailViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// collection view
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// page control
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// information card
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// service
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// feature
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// loaction
        let view6 = viewCon.mainStackView.arrangedSubviews[6]// working hours
        let view7 = viewCon.mainStackView.arrangedSubviews[7]// empty
        let view8 = viewCon.mainStackView.arrangedSubviews[8]// bookappointment
        let view9 = viewCon.mainStackView.arrangedSubviews[9]// empty
        let view10 = viewCon.mainStackView.arrangedSubviews[10]// banner
        let view11 = viewCon.mainStackView.arrangedSubviews[11]// review
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        view6.isHidden = true
        view7.isHidden = true
        view8.isHidden = true
        view9.isHidden = true
        view10.isHidden = true
        view11.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(StoreDetailModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.storePhotoArray.removeAll()
                    viewCon.storeServiceArray.removeAll()
                    viewCon.storeFeatureArray.removeAll()
                    viewCon.storeRatingArray.removeAll()
                    viewCon.storeAddress = ""
                    viewCon.storename = ""
                    viewCon.email = ""
                    viewCon.phoneNumber = ""
                    viewCon.hasPhoneNumber = false
                    viewCon.hasEmail = false
                    var addressLine1 = ""
                    var addressLine2 = ""
                    var storeCityArea = ""
                    var storeCity = ""
                    var storeState = ""
                    var zipcode = ""
                    var status = ""
                    var statusDescription = ""
                    var isExperienceStore = false
                    
                    let storeInformationView1 = viewCon.storeInformationStackView.arrangedSubviews[1]// experinceStore
                    let storeInformationView4 = viewCon.storeInformationStackView.arrangedSubviews[4]// rating
                    let storeInformationView7 = viewCon.storeInformationStackView.arrangedSubviews[7]// call
                    let storeInformationView8 = viewCon.storeInformationStackView.arrangedSubviews[8]// email
                    
                    storeInformationView1.isHidden = true
                    storeInformationView4.isHidden = true
                    storeInformationView7.isHidden = true
                    storeInformationView8.isHidden = true
                    
                    if json.data!.storePhoto != nil {
                        if json.data!.storePhoto!.count > 0 {
                            view0.isHidden = false
                            viewCon.storePhotoArray = json.data!.storePhoto!
                            viewCon.reloadStoreImageCollectionView()
                            if viewCon.storePhotoArray.count > 1 {
                                view1.isHidden = false
                                viewCon.storePageControl.numberOfPages = viewCon.storePhotoArray.count
                                viewCon.storePageControlHeight.constant = 25
                            }
                        }
                    } else {
                        view0.isHidden = true
                        view1.isHidden = true
                        viewCon.storePageControl.numberOfPages = viewCon.storePhotoArray.count
                        viewCon.storePageControlHeight.constant = 0
                    }
                    if !(json.data!.sharedLink.isNilOrEmpty) {
                        viewCon.sharedLink = "\(String(describing: json.data!.sharedLink!))"
                    }
                    if json.data!.storeObj != nil {
                        view2.isHidden = false
                        
                        if !(json.data!.storeObj!.name.isNilOrEmpty) {
                            viewCon.storename = String(format: "%@", json.data!.storeObj!.name!)
                        }
                        if !(json.data!.storeObj!.addressLine1.isNilOrEmpty) {
                            addressLine1 = String(format: "%@", json.data!.storeObj!.addressLine1!)
                        }
                        if !(json.data!.storeObj!.addressLine2.isNilOrEmpty) {
                            addressLine2 = String(format: "%@", json.data!.storeObj!.addressLine2!)
                        }
                        if !(json.data!.storeObj!.storeCityArea.isNilOrEmpty) {
                            storeCityArea = String(format: "%@", json.data!.storeObj!.storeCityArea!)
                        }
                        if !(json.data!.storeObj!.storeCity.isNilOrEmpty) {
                            storeCity = String(format: "%@", json.data!.storeObj!.storeCity!)
                        }
                        if !(json.data!.storeObj!.storeState.isNilOrEmpty) {
                            storeState = String(format: "%@", json.data!.storeObj!.storeState!)
                        }
                        if !(json.data!.storeObj!.zipcode.isNilOrEmpty) {
                            zipcode = String(format: "%@", json.data!.storeObj!.zipcode!)
                        }
                        if json.data!.storeObj!.isExperienceStore != nil {
                            isExperienceStore = json.data!.storeObj!.isExperienceStore!
                        }
                        
                        if json.data!.storeObj!.storeWorkingHourStatus != nil {
                            if !(json.data!.storeObj!.storeWorkingHourStatus!.status.isNilOrEmpty) {
                                status = String(format: "%@", json.data!.storeObj!.storeWorkingHourStatus!.status!)
                            }
                            if !(json.data!.storeObj!.storeWorkingHourStatus!.statusDescription.isNilOrEmpty) {
                                statusDescription = String(format: "%@", json.data!.storeObj!.storeWorkingHourStatus!.statusDescription!)
                            }
                        }
                        if !(addressLine1.isEmpty) {
                            viewCon.storeAddress = addressLine1
                        }
                        if !(addressLine2.isEmpty) && !(viewCon.storeAddress.isEmpty) {
                            viewCon.storeAddress = "\(viewCon.storeAddress) \(addressLine2)"
                        } else if !(addressLine2.isEmpty) {
                            viewCon.storeAddress = addressLine2
                        }
                        if !(storeCityArea.isEmpty) && !(viewCon.storeAddress.isEmpty) {
                            viewCon.storeAddress = "\(viewCon.storeAddress) \(storeCityArea)"
                        } else if !(storeCityArea.isEmpty) {
                            viewCon.storeAddress = storeCityArea
                        }
                        if !(storeCity.isEmpty) && !(viewCon.storeAddress.isEmpty) {
                            viewCon.storeAddress = "\(viewCon.storeAddress) \(storeCity)"
                        } else if !(storeCity.isEmpty) {
                            viewCon.storeAddress = storeCity
                        }
                        if !(storeState.isEmpty) && !(viewCon.storeAddress.isEmpty) {
                            viewCon.storeAddress = "\(viewCon.storeAddress) \(storeState)"
                        } else  if !(storeState.isEmpty) {
                            viewCon.storeAddress = storeState
                        }
                        if !(zipcode.isEmpty) && !(viewCon.storeAddress.isEmpty) {
                            viewCon.storeAddress = "\(viewCon.storeAddress) - \(zipcode)"
                        } else if !(zipcode.isEmpty) {
                            viewCon.storeAddress = zipcode
                        }
                        if !(json.data!.storeObj!.phoneNumber.isNilOrEmpty) {
                            viewCon.phoneNumber = "\(String(describing: json.data!.storeObj!.phoneNumber!))"
                            if !(viewCon.phoneNumber.isEmpty) {
                                viewCon.hasPhoneNumber = true
                            }
                        }
                        if !(json.data!.storeObj!.email.isNilOrEmpty) {
                            viewCon.email = "\(String(describing: json.data!.storeObj!.email!))"
                            if !(viewCon.email.isEmpty) {
                                viewCon.hasEmail = true
                            }
                        }
                        if json.data!.storeObj!.lat != nil {
                            viewCon.latitude = json.data!.storeObj!.lat!
                        }
                        if json.data!.storeObj!.lng != nil {
                            viewCon.longitude = json.data!.storeObj!.lng!
                        }
                        if isExperienceStore == true {
                            storeInformationView1.isHidden = false
                            viewCon.experienceLabel.text = AppLocalizationString.experienceStore.capitalized
                            viewCon.experienceView.backgroundColor =  UIColor.colorLiteral.theme_orange_F7732F
                            viewCon.experienceLabel.textColor = UIColor.colorLiteral.theme_white_FFFFFF
                        }
                        else{
                            storeInformationView1.isHidden = false
                            viewCon.experienceLabel.text = AppLocalizationString.store.capitalized
                            viewCon.experienceView.backgroundColor =  UIColor.colorLiteral.theme_blue_2AACEF
                            viewCon.experienceLabel.textColor = UIColor.colorLiteral.theme_white_FFFFFF
                        }
                        
                        viewCon.storeNameLabel.text = viewCon.storename
                        if !(storeCity.isEmpty) && !(storeCityArea.isEmpty) {
                            viewCon.storecityLabel.text = "\(storeCityArea) - \(storeCity)"
                        } else {
                            if !(storeCity.isEmpty) {
                                viewCon.storecityLabel.text = storeCity
                            } else if !(storeCityArea.isEmpty) {
                                viewCon.storecityLabel.text = storeCityArea
                            }
                        }
                        var reviewRating = Double(0)
                        if json.data!.averageRating != nil {
                            if json.data!.averageRating! > 0 {
                                storeInformationView4.isHidden = false
                                reviewRating = Double(json.data!.averageRating!)
                                viewCon.storeOverallRating.rating = reviewRating
                            }
                        }
                        
                        viewCon.storeAddressLabel.text = viewCon.storeAddress
                        
                        if !(viewCon.phoneNumber.isEmpty) {
                            storeInformationView7.isHidden = false
                            
                            let phonecombination = NSMutableAttributedString()
                            let contentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(13)]
                            
                            let content = NSMutableAttributedString(string: String(format: "%@", viewCon.phoneNumber.toPhoneNumberFormate()), attributes: contentFontAttributes as [NSAttributedString.Key: Any])
                            
                            phonecombination.append(content)
                            viewCon.callDescriptionLabel.attributedText = phonecombination
                        }
                        
                        if !(viewCon.email.isEmpty) {
                            storeInformationView8.isHidden = false
                            let emailcombination = NSMutableAttributedString()
                            
                            let contentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(13)]
                            
                            let content = NSMutableAttributedString(string: String(format: "%@", viewCon.email), attributes: contentFontAttributes as [NSAttributedString.Key: Any])
                            emailcombination.append(content)
                            viewCon.emailDescriptionLabel.attributedText = emailcombination
                        }
                        viewCon.storeStatusLabel.text = status.capitalized
                        viewCon.storeTimingLabel.text = statusDescription
                        
                        if status.lowercased() == StoreOpenCloseStatus.open.rawValue.lowercased() {
                            //            self.storeStatusView.backgroundColor = UIColor.colorLiteral.theme_green_E5FFF0
                            viewCon.storeStatusLabel.textColor = UIColor.colorLiteral.theme_green_27AE60
                        } else {
                            //            self.storeStatusView.backgroundColor = UIColor.colorLiteral.theme_red_FFE6E4
                            viewCon.storeStatusLabel.textColor = UIColor.colorLiteral.theme_red_FF6961
                        }
                        
                        view5.isHidden = false
                        let locationview0 = viewCon.storeLocationStackView.arrangedSubviews[0]// title
                        let locationview1 = viewCon.storeLocationStackView.arrangedSubviews[1]// address
                        let locationview2 = viewCon.storeLocationStackView.arrangedSubviews[2]// button
                        let locationview3 = viewCon.storeLocationStackView.arrangedSubviews[3]// call
                        locationview0.isHidden = true
                        locationview1.isHidden = true
                        locationview2.isHidden = true
                        locationview3.isHidden = true
                        
                        locationview0.isHidden = false
                        locationview1.isHidden = false
                        viewCon.storeLocationAddressLabel.text = viewCon.storeAddress
                        
                        if (viewCon.latitude != AppConstantValue.defaultlatlong) && (viewCon.longitude != AppConstantValue.defaultlatlong) {
                            locationview2.isHidden = false
                        }
                        let contactview0 = viewCon.storeLocationContactStackView.arrangedSubviews[0]// title
                        let contactview1 = viewCon.storeLocationContactStackView.arrangedSubviews[1]// call
                        let contactview2 = viewCon.storeLocationContactStackView.arrangedSubviews[2]// email
                        
                        contactview0.isHidden = true
                        contactview1.isHidden = true
                        contactview2.isHidden = true
                        
                        if !(viewCon.phoneNumber.isEmpty) {
                            locationview3.isHidden = false
                            contactview0.isHidden = false
                            contactview1.isHidden = false
                            
                            let phonecombination = NSMutableAttributedString()
                            
                            let contentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(13)]
                            
                            let content = NSMutableAttributedString(string: String(format: "%@", viewCon.phoneNumber.toPhoneNumberFormate()), attributes: contentFontAttributes as [NSAttributedString.Key: Any])
                            
                            phonecombination.append(content)
                            viewCon.storeLocationCallDescriptionLabel.attributedText = phonecombination
                        }
                        
                        if !(viewCon.email.isEmpty) {
                            locationview3.isHidden = false
                            contactview0.isHidden = false
                            contactview2.isHidden = false
                            let emailcombination = NSMutableAttributedString()
                            
                            let contentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_2AACEF, NSAttributedString.Key.font: AppFont.regular.size(13)]
                            
                            let content = NSMutableAttributedString(string: String(format: "%@", viewCon.email), attributes: contentFontAttributes as [NSAttributedString.Key: Any])
                            emailcombination.append(content)
                            viewCon.storeLocationEmailDescriptionLabel.attributedText = emailcombination
                        }
                    }
                    if json.data!.storeService != nil {
                        if json.data!.storeService!.count > 0 {
                            view3.isHidden = false
                            viewCon.storeServiceArray = json.data!.storeService!
                            viewCon.reloadTableView()
                        }
                    }
                    if json.data!.storeFeature != nil {
                        if json.data!.storeFeature!.count > 0 {
                            view4.isHidden = false
                            viewCon.storeFeatureArray = json.data!.storeFeature!
                            viewCon.reloadStoreOtherFeatureTableView()
                        }
                    }
                    if json.data!.storeWorkHours != nil {
                        if json.data!.storeWorkHours!.count > 0 {
                            view6.isHidden = false
                            viewCon.storeWorkHourArray = json.data!.storeWorkHours!
                            viewCon.reloadStoreWorkingHoursTableView()
                        }
                    }
                    view7.isHidden = false
                    view8.isHidden = true
                    view9.isHidden = false
                    view10.isHidden = false
                    
                    let bookappointmentview0 = viewCon.bookNowStackView.arrangedSubviews[0]// title
                    let bookappointmentview1 = viewCon.bookNowStackView.arrangedSubviews[1]// name
                    let bookappointmentview2 = viewCon.bookNowStackView.arrangedSubviews[2]// address
                    let bookappointmentview3 = viewCon.bookNowStackView.arrangedSubviews[3]// call
                    let bookappointmentview4 = viewCon.bookNowStackView.arrangedSubviews[4]// email
                    let bookappointmentview5 = viewCon.bookNowStackView.arrangedSubviews[5]// button
                    
                    bookappointmentview0.isHidden = true
                    bookappointmentview1.isHidden = true
                    bookappointmentview2.isHidden = true
                    bookappointmentview3.isHidden = true
                    bookappointmentview4.isHidden = true
                    bookappointmentview5.isHidden = true
                    
                    if !(viewCon.storename.isEmpty) {
                        view8.isHidden = false
                        bookappointmentview0.isHidden = false
                        bookappointmentview1.isHidden = false
                        bookappointmentview5.isHidden = false
                        viewCon.bookNowStoreNameLabel.text = viewCon.storename.uppercased()
                    }
                    if !(viewCon.storeAddress.isEmpty) {
                        view8.isHidden = false
                        bookappointmentview0.isHidden = false
                        bookappointmentview2.isHidden = false
                        bookappointmentview5.isHidden = false
                        viewCon.bookNowAddressLabel.text = viewCon.storeAddress
                    }
                    if !(viewCon.phoneNumber.isEmpty) {
                        view8.isHidden = false
                        bookappointmentview0.isHidden = false
                        bookappointmentview3.isHidden = false
                        bookappointmentview5.isHidden = false
                        let phonecombination = NSMutableAttributedString()
                        let contentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
                        
                        let content = NSMutableAttributedString(string: String(format: "%@", viewCon.phoneNumber.toPhoneNumberFormate()), attributes: contentFontAttributes as [NSAttributedString.Key: Any])
                        
                        phonecombination.append(content)
                        viewCon.bookNowCallDescriptionLabel.attributedText = phonecombination
                    }
                    if !(viewCon.email.isEmpty) {
                        view8.isHidden = false
                        bookappointmentview0.isHidden = false
                        bookappointmentview4.isHidden = false
                        bookappointmentview5.isHidden = false
                        let emailcombination = NSMutableAttributedString()
                        
                        let contentFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
                        
                        let content = NSMutableAttributedString(string: String(format: "%@", viewCon.email), attributes: contentFontAttributes as [NSAttributedString.Key: Any])
                        emailcombination.append(content)
                        viewCon.bookNowEmailDescriptionLabel.attributedText = emailcombination
                    }
                    
                    if json.data!.storeReviewCount != nil {
                        if json.data!.storeReviewCount! > 1 {
                            viewCon.happyDescriptionLabel.text = "\(json.data!.storeReviewCount!) \(AppLocalizationString.customerReviews)"
                        } else {
                            viewCon.happyDescriptionLabel.text = "\(json.data!.storeReviewCount!) \(AppLocalizationString.customerReview)"
                        }
                    }
                    if json.data!.storeReview != nil {
                        let arrayTestimonialList = json.data!.storeReview!
                        if viewCon.storeRatingArray.count > 0 {
                            for item in arrayTestimonialList {
                                viewCon.storeRatingArray.append(item)
                            }
                        } else {
                            viewCon.storeRatingArray = arrayTestimonialList
                        }
                        if viewCon.storeRatingArray.count > 0 {
                            view11.isHidden = false
                            viewCon.reloadStoreRatingCollectionView()
                        } else {
                            view11.isHidden = true
                            viewCon.reloadStoreRatingCollectionView()
                        }
                        if viewCon.storeRatingArray.count > 1 {
                            viewCon.pageControl.isHidden = false
                            viewCon.pageControl.numberOfPages = viewCon.storeRatingArray.count
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
}
