//
//  UIColor+Color.swift
//  HEARZAP
//
//  Created by Purushoth on 30/06/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    struct ProductColor {
        
        static let productColorBeige                            = #colorLiteral(red: 0.8196078431, green: 0.6078431373, blue: 0.4862745098, alpha: 1) // "D19B7C" //Beige
        static let productColorTaupe                            = #colorLiteral(red: 0.9176470588, green: 0.7019607843, blue: 0.5764705882, alpha: 1) // "EAB393" //Taupe
        static let productColorDarkGray                         = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1) // "454545" //Dark gray
        static let productColorGray                             = #colorLiteral(red: 0.3529411765, green: 0.3529411765, blue: 0.3529411765, alpha: 1) // "5A5A5A" //Gray
        static let productColorBlack                            = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) // "000000" //Black
        static let productColorBrown                            = #colorLiteral(red: 0.4862745098, green: 0.2431372549, blue: 0, alpha: 1) // "7C3E00" //Brown
        static let productColorBlue                             = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1) // "0075FF" //Blue
        static let productColorRed                              = #colorLiteral(red: 1, green: 0.1254901961, blue: 0.1098039216, alpha: 1) // "FF201C" //Red
        static let productColorSilver                           = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1) // "C0C0C0" //Silver
        static let productColorGold                             = #colorLiteral(red: 0.9254901961, green: 0.7333333333, blue: 0.1098039216, alpha: 1) // "ECBB1C" //Gold
        static let productColorRoseGold                         = #colorLiteral(red: 0.9215686275, green: 0.737254902, blue: 0.6980392157, alpha: 1) // "EBBCB2" //Rose Gold
        static let productColorWhite                            = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // "FFFFFF" //White
        
    }
    struct colorLiteral {
        
        static let theme_black_333333                           = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) // "333333" //dark
        
        static let theme_blue_112F70_30                         = #colorLiteral(red: 0.06666666667, green: 0.1843137255, blue: 0.4392156863, alpha: 0.3) // "112F70" 0.30 //blue
        static let theme_blue_112F70_70                         = #colorLiteral(red: 0.06666666667, green: 0.1843137255, blue: 0.4392156863, alpha: 0.7) // "112F70" 0.70 //blue
        static let theme_blue_112F70                            = #colorLiteral(red: 0.06666666667, green: 0.1843137255, blue: 0.4392156863, alpha: 1) // "112F70"
        static let theme_blue_212B36                            = #colorLiteral(red: 0.1294117647, green: 0.168627451, blue: 0.2117647059, alpha: 1) // "212B36"

        static let theme_blue_2AACEF_60                         = #colorLiteral(red: 0.1647058824, green: 0.6745098039, blue: 0.937254902, alpha: 0.6) // "2AACEF" 0.60 //button/link
        static let theme_blue_2AACEF                            = #colorLiteral(red: 0.1647058824, green: 0.6745098039, blue: 0.937254902, alpha: 1) // "2AACEF" //button/link
        
        static let theme_blue_DCF3FF                            = #colorLiteral(red: 0.862745098, green: 0.9529411765, blue: 1, alpha: 1) // "DCF3FF" //button/link light
        static let theme_blue_E7F4FF                            = #colorLiteral(red: 0.9058823529, green: 0.9568627451, blue: 1, alpha: 1) // "E7F4FF" //secondary
        
        static let theme_blue_CCF0FF                            = #colorLiteral(red: 0.8, green: 0.9411764706, blue: 1, alpha: 1) // "CCF0FF" //
        static let theme_blue_CAE3F1                            = #colorLiteral(red: 0.7921568627, green: 0.8901960784, blue: 0.9450980392, alpha: 1) // "CAE3F1" //
        static let theme_blue_0665C1                            = #colorLiteral(red: 0.02352941176, green: 0.3960784314, blue: 0.7568627451, alpha: 1) // "0665C1" //
        static let theme_blue_0665C1_60                         = #colorLiteral(red: 0.02352941176, green: 0.3960784314, blue: 0.7568627451, alpha: 0.6) // "0665C1" 0.60 //
        static let theme_blue_409CFF                            = #colorLiteral(red: 0.02352941176, green: 0.3960784314, blue: 0.7568627451, alpha: 1) // "0665C1" 0.60 //

        static let theme_green_27AE60                           = #colorLiteral(red: 0.1529411765, green: 0.6823529412, blue: 0.3764705882, alpha: 1) // "27AE60" //Success
        static let theme_green_E5FFF0                           = #colorLiteral(red: 0.8980392157, green: 1, blue: 0.9411764706, alpha: 1) // "E5FFF0" //Success light
        static let theme_green_CAEEF1                           = #colorLiteral(red: 0.7921568627, green: 0.9333333333, blue: 0.9450980392, alpha: 1) // "CAEEF1" //
        
        static let theme_grey_777777                            = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1) // "777777" //light gray
        static let theme_grey_DCDCDD                            = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.8666666667, alpha: 1) // "DCDCDD" //gray
        static let theme_grey_999999                            = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1) // "999999" //light gray
        static let theme_grey_E4E4E4                            = #colorLiteral(red: 0.8941176471, green: 0.8941176471, blue: 0.8941176471, alpha: 1) // "E4E4E4" //gray


        static let theme_grey_3C3C43_18                         = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.18) // "3C3C43" 0.18//grey light
        static let theme_grey_3C3C43_60                         = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.6) // "3C3C43" 0.60//grey light
        static let theme_grey_3C3C43                            = #colorLiteral(red: 1, green: 0.8980392157, blue: 0.8470588235, alpha: 1) // "3C3C43"//grey light


        static let theme_orange_F1DDCA                          = #colorLiteral(red: 0.9450980392, green: 0.8666666667, blue: 0.7921568627, alpha: 1) // "F1DDCA" //
        static let theme_orange_F7732F                          = #colorLiteral(red: 0.968627451, green: 0.4509803922, blue: 0.1843137255, alpha: 1) // "F7732F" //orange
        static let theme_orange_FFE5D8                          = #colorLiteral(red: 1, green: 0.8980392157, blue: 0.8470588235, alpha: 1) // "FFE5D8" //orange light
        static let theme_orange_F8A401                          = #colorLiteral(red: 1, green: 0.8980392157, blue: 0.8470588235, alpha: 1) // "F8A401" //orange light

        static let theme_pink_FF6482                            = #colorLiteral(red: 1, green: 0.3921568627, blue: 0.5098039216, alpha: 1) // "FF6482" //coupon
        
        static let theme_red_FF6961                             = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.3803921569, alpha: 1) // "FF6961" //alert
        static let theme_red_FFE6E4                             = #colorLiteral(red: 1, green: 0.9019607843, blue: 0.8941176471, alpha: 1) // "FFE6E4" //alert light
        
        static let theme_white_F2F2F2                           = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1) // "F2F2F2" // separator
        static let theme_white_F6FAFD                           = #colorLiteral(red: 0.9647058824, green: 0.9803921569, blue: 0.9921568627, alpha: 1) // "F6FAFD" // background
        static let theme_white_FFFFFF                           = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // "FFFFFF" // white
        
        static let theme_yellow_EFEDD6                          = #colorLiteral(red: 0.937254902, green: 0.9294117647, blue: 0.8392156863, alpha: 1) // "EFEDD6" //yellow
        static let theme_yellow_FFD426                          = #colorLiteral(red: 1, green: 0.831372549, blue: 0.1490196078, alpha: 1) // "FFD426" //yellow
        static let theme_yellow_FFFCEC                          = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.9254901961, alpha: 1) // "FFFCEC" //yellow light
        static let theme_yellow_E8D150                          = #colorLiteral(red: 0.9292015433, green: 0.8450875878, blue: 0.3841246963, alpha: 1) // "FFFCEC" //yellow
        
    }
    // MARK: - To Change Hexadecimal to UIColor
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format: "#%06x", rgb)
    }
}

// blue disable C1E2F7 enable 2AACEF
// orange disable F0D3C2 enable F7732F
