//
//  OnlineConsultationScheduleViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 29/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct OnlineConsultationScheduleViewModel {
    func getOnlineConsultationSelectDate(canShowLoader: Bool, viewCon: OnlineConsultationScheduleViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OnlineConsultationScheduleSlotModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.store != nil {
                        viewCon.storeList.removeAll()
                        viewCon.storeListID.removeAll()
                        let storeData = json.data!.store!
                        for item in storeData {
                            if (item.id != nil) && !(item.name.isNilOrEmpty) {
                                viewCon.storeList.append(item.name!)
                                viewCon.storeListID.append(item.id!)
                            }
                        }
                    }
                    if json.data!.dateList != nil {
                        viewCon.dateListArray = json.data!.dateList!
                    }
                    if json.data!.otherDateSlots != nil {
                        viewCon.otherDateSlots = json.data!.otherDateSlots!
                    }
                    if json.data!.currentDateSlots != nil {
                        viewCon.currentDateSlots = json.data!.currentDateSlots!
                    }
                    if (viewCon.selectedDate.isEmpty){
                        viewCon.timeListArray.removeAll()
                        viewCon.timeListArray = viewCon.currentDateSlots
                        if (viewCon.dateListArray.count > 0){
                            if (viewCon.dateListArray[0] != nil){
                                if !(viewCon.dateListArray[0].date.isNilOrEmpty){
                                    viewCon.selectedDate = viewCon.dateListArray[0].date!
                                }
                            }
                        }
                    }
                    viewCon.reloadSelectDateCollectionView()
                    viewCon.reloadSelectTimeCollectionView()

                    let borderStackView0 = viewCon.borderStackView.arrangedSubviews[0]// date slot
                    let borderStackView1 = viewCon.borderStackView.arrangedSubviews[1]// time slot
                    let borderStackView2 = viewCon.borderStackView.arrangedSubviews[2]// button

                    borderStackView0.isHidden =  false
                    borderStackView1.isHidden =  false
                    borderStackView2.isHidden =  false
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func postOnlineConsultationSelectDate(canShowLoader: Bool, viewCon: OnlineConsultationScheduleViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(OnlineConsultationScheduleUpdateSlotModel.self, from: result as Data)
                if json.data != nil {
                    if (viewCon.newUser == false){
                        viewCon.navigateToOnlineConsultationSuccessViewController(isFrom: viewCon.isFrom)
                    }
                    else{
                        viewCon.navigateToOnlineConsultationUserInfoViewController(isFrom: viewCon.isFrom,concernID: viewCon.concernID)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
