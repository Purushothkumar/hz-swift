//
//  UIView+View.swift
//  HEARZAP
//
//  Created by Purushoth on 01/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit

// MARK: - extension UIView
extension UIView {
    func addShadow(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowColor: UIColor) {
        self.layer.cornerRadius = cornerRadius// 4.0
        self.layer.borderWidth = borderWidth// 1.0
        self.layer.borderColor = borderColor.cgColor// UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        self.layer.shadowColor = shadowColor.cgColor// UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = shadowRadius// 2.0
        self.layer.shadowOpacity = shadowOpacity// 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.bounds = self.bounds
        self.layer.position = self.center
        //        self.layer.layer.addSublayer(layer0)
        
    }
    public var safeAreaFrame: CGRect {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.layoutFrame
        }
        return bounds
    }
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.subtype = .fromBottom
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor) {// UIView extension to set gradient for view
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addBorder(toEdges edges: UIRectEdge, color: UIColor, thickness: CGFloat) {
        func addBorder(toEdge edges: UIRectEdge, color: UIColor, thickness: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            switch edges {
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 40, height: thickness)
            case .bottom:
                border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
            case .right:
                border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            default:
                break
            }
            layer.addSublayer(border)
        }
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(toEdge: .top, color: color, thickness: thickness)
        }
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(toEdge: .bottom, color: color, thickness: thickness)
        }
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(toEdge: .left, color: color, thickness: thickness)
        }
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(toEdge: .right, color: color, thickness: thickness)
        }
    }
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    // MARK: - Height and Width For Text
    func heightForText(text: String, Font: UIFont, Width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: Width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = Font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    func widthForText(strText: String, font_txt: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: screenFrameWidth, height: .greatestFiniteMagnitude)
        let boundingBox = strText.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font_txt], context: nil)
        return boundingBox.width
    }
    
    func addVerticalDashedBorder(color: UIColor) {
        // Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 3
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2, 3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: 0, y: self.frame.height)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func addHorizontalDashedBorder(color: UIColor) {
        // Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2, 3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    func addDashedBorder(color: UIColor, shapeRect: CGRect) {
        let color = color
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = shapeRect.size
        let shapeRect = shapeRect
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6, 3]
        shapeLayer.cornerRadius = AppConstantValue.cornerRadius4
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    // MARK: - Shimmer Effect
    func shimmerEffectView(canStop:Bool){
        self.showShimmerEffect()
        if canStop == true {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.hideShimmerEffect()
            }
        }
    }
    
    func showLoadingAnimation(){
        self.alpha = 0
        UIView.animate(withDuration: 4, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
             self.alpha = 1
             }, completion: { (Bool) -> Void in    }
        )
        
    }
}

