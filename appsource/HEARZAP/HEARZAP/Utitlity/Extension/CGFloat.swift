//
//  CGFloat.swift
//  HEARZAP
//
//  Created by Purushoth on 09/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

// https://www.ios-resolution.com/
extension CGFloat {
    var dp: CGFloat {
        let width = UIScreen.main.bounds.width
        let device = UIScreen.main.traitCollection.userInterfaceIdiom
        
        if device == .phone {
            if width <= 320 {// iPod(Gen7),iPhone(4, 4s, 5, 5s, 5c, SEGen1)
                return self * 0.8533
            } else if width <= 375 {// iPhone(SEGen2, SEGen3 6, 6s, 7, 8, X, Xs, 11pro, 12mini, 13mini)
                return self
            } else if width <= 390 {// iPhone(12, 13, 13pro, 14)
                return self * 1.04
            } else if width <= 393 {// iPhone(14pro)
                return self * 1.048
            } else if width <= 414 {// iPhone(6+, 6s+, 7+, 8+, Xr, XsMax, 11, 11promax)
                return self * 1.104
            } else if width <= 428 {// iPhone(13promax, 14+)
                return self * 1.1413
            } else if width <= 430 {// iPhone(14promax)
                //                return self * 1.146
                return self * 1.1413
            } else if width <= 744 {// iPhone(NewModel)
                //                return self * 1.2
                return self * 1.1413
            }
        }
        //        else if (device == .pad) {
        //            if (width <= 744) {
        //                // ipad(miniGen6, )
        //                return self * 1.4
        //            } else if (width <= 768) {
        //                // ipad(Gen5, Gen6, Air, Air2, Pro9.7)
        //                return self * 1.45
        //            } else if (width <= 810) {
        //                // ipad(Gen9)
        //                return self * 1.5
        //            } else if (width <= 834) {
        //                // ipad(AirGen3, AirGen5, Pro10.5, Pro11Gen1, Pro11Gen3)
        //                return self * 1.55
        //            } else if (width <= 1024) {
        //                // ipad(Pro12.9Gen1, Pro12.9Gen2, Pro12.9Gen3, Pro12.9Gen5)
        //                return self * 1.85
        //            }
        //        }
        
        return self
    }
}
