//
//  FindRightDeviceFeatureViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 14/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct FindRightDeviceFeatureViewModel {
    func getFindRightDeviceModelList(canShowLoader: Bool, viewCon: FindRightDeviceFeatureViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        let view0 = viewCon.mainStackView.arrangedSubviews[0]// empty
        let view1 = viewCon.mainStackView.arrangedSubviews[1]// model
        let view2 = viewCon.mainStackView.arrangedSubviews[2]// empty
        let view3 = viewCon.mainStackView.arrangedSubviews[3]// technology
        let view4 = viewCon.mainStackView.arrangedSubviews[4]// empty
        let view5 = viewCon.mainStackView.arrangedSubviews[5]// feature
        
        view0.isHidden = true
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true
        view5.isHidden = true
        
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(FindRightDeviceFeatureModel.self, from: result as Data)
                if json.data != nil {
                    if json.data!.model != nil {
                        viewCon.modelArray = json.data!.model!
                        if viewCon.modelArray.count > 0 {
                            viewCon.reloadCollectionView()
                            view0.isHidden = false
                            view1.isHidden = false
                        }
                    }
                    if json.data!.technology != nil {
                        viewCon.technologyArray = json.data!.technology!
                        if viewCon.technologyArray.count > 0 {
                            viewCon.reloadTableView()
                            view2.isHidden = false
                            view3.isHidden = false
                        }
                    }
                    if json.data!.features != nil {
                        viewCon.jsonfeatureArray = json.data!.features!
                    }
                    
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
