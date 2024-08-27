//
//  AppFont+Font.swift
//  HEARZAP
//
//  Created by Purushoth on 01/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

private let familyName = "Poppins"

enum AppFont: String {
    case black = "Black"
    case blackitalics = "BlackItalic"
    case bold = "Bold"
    case bolditalics = "BoldItalic"
    case extrabold = "ExtraBold"
    case extrabolditalics = "ExtraBoldItalic"
    case extralight = "ExtraLight"
    case extralightitalics = "ExtraLightItalic"
    case italics = "Italic"
    case light = "Light"
    case lightitalics = "LightItalic"
    case medium = "Medium"
    case mediumitalics = "MediumItalic"
    case regular = "Regular"
    case semibold = "SemiBold"
    case semibolditalics = "SemiBoldItalic"
    case thin = "Thin"
    case thinitalics = "ThinItalic"
    
    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size + 1.0) {
            return font
        }
        //        if let font = UIFont(name: fullFontName, size: (size + 1.0).dp) {
        //            return font
        //        }
        fatalError("Font '\(fullFontName)' does not exist.")
    }
    fileprivate var fullFontName: String {
        return rawValue.isEmpty ? familyName : familyName + "-" + rawValue
        
    }
}

// extension UIFont {
//    class func appFont(
//        ofSize size : CGFloat = UIFont.systemFontSize,
//        weight : Weight = .regular,
//        autoScale : Bool = true
//    ) -> UIFont {
//        return UIFont.systemFont(ofSize: autoScale ? size.dp : size, weight: weight)
//    }
// }

//
//
// let customFonts: [UIFont.TextStyle: UIFont] = [
//    .largeTitle: UIFont(name: "Poppins-Regular", size: 34)!,
//    .title1: UIFont(name: "Poppins-Regular", size: 28)!,
//    .title2: UIFont(name: "Poppins-Regular", size: 22)!,
//    .title3: UIFont(name: "Poppins-Regular", size: 20)!,
//    .headline: UIFont(name: "Poppins-Bold", size: 17)!,
//    .body: UIFont(name: "Poppins-Regular", size: 17)!,
//    .callout: UIFont(name: "Poppins-Regular", size: 16)!,
//    .subheadline: UIFont(name: "Poppins-Regular", size: 15)!,
//    .Footnote: UIFont(name: "Poppins-Regular", size: 13)!,
//    .caption1: UIFont(name: "Poppins-Regular", size: 12)!,
//    .caption2: UIFont(name: "Poppins-Regular", size: 11)!
// ]
//
// extension UIFont {
//    class func customFont(forTextStyle style: UIFont.TextStyle) -> UIFont {
//        let customFont = customFonts[style]!
//        let metrics = UIFontMetrics(forTextStyle: style)
//        let scaledFont = metrics.scaledFont(for: customFont)
//
//        return scaledFont
//    }
// }
