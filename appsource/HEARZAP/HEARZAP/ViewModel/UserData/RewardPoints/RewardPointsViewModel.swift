//
//  RewardPointsViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 15/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct RewardPointsViewModel {
    func getRewardsList(canShowLoader: Bool, viewCon: RewardPointsViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// Rewards
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// CollectionView
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// TableView
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(RewardPointsModel.self, from: result as Data)
                let headerview0 = viewCon.rewardPointsHeaderStackView.arrangedSubviews[0]// Empty
                let headerview1 = viewCon.rewardPointsHeaderStackView.arrangedSubviews[1]// Points
                let headerview2 = viewCon.rewardPointsHeaderStackView.arrangedSubviews[2]// Label
                let headerview3 = viewCon.rewardPointsHeaderStackView.arrangedSubviews[3]// Button
                let headerview4 = viewCon.rewardPointsHeaderStackView.arrangedSubviews[4]// Empty
                
                headerview0.isHidden = true
                headerview1.isHidden = true
                headerview2.isHidden = true
                headerview3.isHidden = true
                headerview4.isHidden = true
                
                if json.data != nil {
                    if json.data!.rewards != nil {
                        view1.isHidden = false
                        viewCon.rewardPointsArray = json.data!.rewards!
                    }
                    if json.data!.rewardTransactions != nil {
                        view2.isHidden = false
                        viewCon.rewardPointsTranscationArray = json.data!.rewardTransactions!
                    }
                    if json.data!.customerRewardPoints != nil {
                        view0.isHidden = false
                        headerview0.isHidden = false
                        headerview1.isHidden = false
                        headerview2.isHidden = false
                        headerview4.isHidden = false
                        let customerRewardPoints = json.data!.customerRewardPoints!
                        viewCon.redeemPointsHeaderlabel.text = String(format: "%d", customerRewardPoints)
                        viewCon.customerRewardPoints = customerRewardPoints
                        if customerRewardPoints > 0 {
                            headerview3.isHidden = false
                        }
                    }
                    viewCon.reloadRewardPointsTableView()
                    viewCon.reloadRewardPointsCollectionView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
