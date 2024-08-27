//
//  AccessoriesFilterViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 01/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct AccessoriesFilterViewModel {
    func getAccessoriesFilterList(canShowLoader: Bool, viewCon: AccessoriesFilterViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(AccessoriesFilterModel.self, from: result as Data)
                if json.data != nil {
                    viewCon.doneButton.isHidden = false
                    viewCon.clearAllButton.isHidden = false
                    viewCon.isFilterClear = false
                    viewCon.isStyle = false
                    viewCon.isBrand = false
                    viewCon.isFeature = false
                    viewCon.isSpecification = false
                    
                    viewCon.styleTableHeight = 0
                    viewCon.brandTableHeight = 0
                    viewCon.featureTableHeight = 0
                    viewCon.specificationTableHeight = 0
                    
                    let view0 = viewCon.mainStackView.arrangedSubviews[0]// style title View
                    let view1 = viewCon.mainStackView.arrangedSubviews[1]// style list View
                    let view2 = viewCon.mainStackView.arrangedSubviews[2]// empty
                    let view3 = viewCon.mainStackView.arrangedSubviews[3]// brand title View
                    let view4 = viewCon.mainStackView.arrangedSubviews[4]// brandlist View
                    let view5 = viewCon.mainStackView.arrangedSubviews[5]// empty
                    let view6 = viewCon.mainStackView.arrangedSubviews[6]// feature title View
                    let view7 = viewCon.mainStackView.arrangedSubviews[7]// feature list View
                    let view8 = viewCon.mainStackView.arrangedSubviews[8]// empty
                    let view9 = viewCon.mainStackView.arrangedSubviews[9]// specification title View
                    let view10 = viewCon.mainStackView.arrangedSubviews[10]// specification list View
                    let view11 = viewCon.mainStackView.arrangedSubviews[11]// empty
                    
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
                    
                    if json.data!.style !=  nil {
                        viewCon.styleArray = json.data!.style!
                    }
                    if json.data!.brand !=  nil {
                        viewCon.brandArray = json.data!.brand!
                    }
                    if json.data!.feature !=  nil {
                        viewCon.featureArray = json.data!.feature!
                    }
                    if json.data!.specification !=  nil {
                        viewCon.specificationArray = json.data!.specification!
                    }
                    if viewCon.styleArray.count > 0 {
                        view0.isHidden = false
                        view2.isHidden = false
                        viewCon.styleTableHeight = viewCon.styleArray.count * 50
                    }
                    if viewCon.brandArray.count > 0 {
                        view3.isHidden = false
                        view5.isHidden = false
                        viewCon.brandTableHeight = viewCon.brandArray.count * 50
                    }
                    if viewCon.featureArray.count > 0 {
                        if viewCon.featureArraySelected.count == 0 {
                            for item in viewCon.featureArray {
                                var keyCode = ""
                                if !(item.id.isNilOrEmpty) {
                                    keyCode = item.id!
                                }
                                if !(keyCode.isEmpty) {
                                    let dictTemp = NSMutableDictionary()
                                    dictTemp.setValue([], forKey: keyCode)
                                    viewCon.featureArraySelected.add(dictTemp)
                                }
                            }
                        }
                        view6.isHidden = false
                        view8.isHidden = false
                        for item in viewCon.featureArray {
                            //                            var keyCode = ""
                            if !(item.id.isNilOrEmpty) {
                                viewCon.featureTableHeight = viewCon.featureTableHeight + 50 + 20
                            }
                            if item.value != nil {
                                if item.value!.count > 0 {
                                    viewCon.featureTableHeight = viewCon.featureTableHeight + (item.value!.count * 50)
                                }
                            }
                        }
                    }
                    if viewCon.specificationArray.count > 0 {
                        if viewCon.specificationArraySelected.count == 0 {
                            for item in viewCon.specificationArray {
                                var keyCode = ""
                                if !(item.id.isNilOrEmpty) {
                                    keyCode = item.id!
                                }
                                if !(keyCode.isEmpty) {
                                    let dictTemp = NSMutableDictionary()
                                    dictTemp.setValue([], forKey: keyCode)
                                    viewCon.specificationArraySelected.add(dictTemp)
                                }
                            }
                        }
                        
                        for item in viewCon.specificationArray {
                            if !(item.id.isNilOrEmpty) {
                                viewCon.specificationTableHeight = viewCon.specificationTableHeight + 50 + 20
                            }
                            if item.value != nil {
                                if item.value!.count > 0 {
                                    viewCon.specificationTableHeight = viewCon.specificationTableHeight + (item.value!.count * 50)
                                }
                            }
                        }
                        view9.isHidden = false
                        view11.isHidden = false
                    }
                    
                    viewCon.setStyleUI()
                    viewCon.setBrandUI()
                    viewCon.setFeatureUI()
                    viewCon.setSpecificationUI()
                    
                    viewCon.reloadStyleTableView()
                    viewCon.reloadBrandTableView()
                    viewCon.reloadFeatureTableView()
                    viewCon.reloadSpecificationTableView()
                    viewCon.setUserInteractionButton()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
