//
//  FAQViewModel.swift
//  HEARZAP
//
//  Created by Purushoth on 18/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

struct FAQViewModel {
    func getFAQList(canShowLoader: Bool, viewCon: FAQViewController, subAPIUrl: String, methodName: String, parameter: String?, pageNumber: String?, retryAPIID: Int, strQuery: String?) {
        APIManager.shared.request(canShowLoader: canShowLoader, viewCon: viewCon, subAPIUrl: subAPIUrl, methodName: methodName, parameter: parameter, pageNumber: pageNumber, retryAPIID: retryAPIID, strQuery: strQuery) { result in
            do {
                let json = try JSONDecoder().decode(FAQCategoryModel.self, from: result as Data)
                viewCon.faqArray.removeAll()
                viewCon.reloadFAQTableView()
                if json.data != nil {
                    if json.data!.faq != nil {
                        viewCon.faqArray = json.data!.faq!
                        viewCon.reloadFAQTableView()
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
