//
//  UILabel+Label.swift
//  HEARZAP
//
//  Created by Purushoth on 28/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit
import ShimmerEffect_iOS

extension UILabel {
    func setHTMLFromString(htmlText: String, fontFamily: String, fontSize: CGFloat, fontColor: String) {
        let modifiedFont = NSString(format: "<span style=\"font-family: \(fontFamily); font-size: \(fontSize); color: \(fontColor)\">%@</span>" as NSString, htmlText) as String
        // <span style="font-family:Poppins-Regular; font-size: 50; color:red">
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        self.attributedText = attrStr
    }
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    func setStarAttributtedText(textmessage: String, color: UIColor) {
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: textmessage)
        attributedText.setColorForText(textForAttribute: "*", withColor: color)
        self.attributedText = attributedText
    }
}
@IBDesignable open class PaddingLabel: UILabel {
    
    @IBInspectable open var topInset: CGFloat = 18.0
    @IBInspectable open var bottomInset: CGFloat = 18.0
    @IBInspectable open var leftInset: CGFloat = 18.5
    @IBInspectable open var rightInset: CGFloat = 18.0
    
    open override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    open override var bounds: CGRect {
        didSet {
            // Supported Multiple Lines in Stack views
            //            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
