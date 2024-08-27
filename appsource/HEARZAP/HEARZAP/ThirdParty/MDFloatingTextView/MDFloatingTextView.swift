//
//  MDFloatingTextView.swift
//  MDFloatingTextView
//
//  Created by dhaval on 16/08/20.
//

import Foundation
import UIKit

public class MDFloatingTextView: UITextView {
    /*
     //MARK:- Placeholder Inspectable Property
     @IBInspectable var placeholderText  : String    = "Description"
     @IBInspectable var placeholderFont  : UIFont    = AppFont.regular.size(16)
     @IBInspectable var placeholderColor : UIColor   = .gray
     
     //MARK:- Title Inspectable Property
     @IBInspectable var titleText        : String?   = nil
     @IBInspectable var titleFont        : UIFont    = AppFont.regular.size(13)
     @IBInspectable var titleColor       : UIColor   = .blue
     @IBInspectable var titleBgColor     : UIColor   = .white
     @IBInspectable var titleLeadingSpace: CGFloat   = 12
     */

    // MARK: - Placeholder Property
    var placeholderText: String    = "Description"
    var placeholderFont: UIFont    = AppFont.regular.size(16)
    var placeholderColor: UIColor   = .gray

    // MARK: - Title Property
    var titleText: String?
    var titleFont: UIFont    = AppFont.regular.size(13)
    var titleColor: UIColor   = .blue
    var titleBgColor: UIColor   = .white
    var titleLeadingSpace: CGFloat   = 12

    // MARK: - Private variables
    private var lblPlaceholder = UILabel()
    private var btnFlotingTitle = UIButton(type: .custom)
    private var _titleText: String {
        return self.titleText ?? placeholderText
    }

    // MARK: - Public variable
    /// Define floating type of textview title
    public var flotingType: FlotingType = .onBorder

    /// Inside EdgeInsets of title label
    public var titleInnerEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero) {
        didSet { btnFlotingTitle.contentEdgeInsets = titleInnerEdgeInsets}
    }

    // MARK: - Class Enum
    public enum FlotingType: Int {
        case insideBorder, onBorder, outsideBorder
    }

    // MARK: - Life Cycle Method
    override public func awakeFromNib() {
        super.awakeFromNib()

        //        //Setup textview
        //        layer.borderColor = UIColor.red.cgColor
        //        layer.cornerRadius = 10
        //        layer.borderWidth = 1
        //        textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        //        font = UIFont.systemFont(ofSize: 16)

        // Setup placehodler
        lblPlaceholder.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lblPlaceholder.lineBreakMode = .byWordWrapping
        lblPlaceholder.numberOfLines = 0
        lblPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        lblPlaceholder.textColor = placeholderColor
        lblPlaceholder.text = placeholderText
        lblPlaceholder.font = placeholderFont
        lblPlaceholder.backgroundColor = .clear
        lblPlaceholder.frame = placeholderExpectedFrame
        addSubview(lblPlaceholder)

        // Setup title label
        btnFlotingTitle.setTitle(_titleText, for: .normal)
        btnFlotingTitle.titleLabel?.font = titleFont
        //        btnFlotingTitle.setTitleColor(titleColor, for: .normal)
        btnFlotingTitle.setTitleColor(.clear, for: .normal)
        //        btnFlotingTitle.backgroundColor = titleBgColor
        btnFlotingTitle.backgroundColor = .clear
        btnFlotingTitle.frame = titleLabelFrame
        superview!.addSubview(btnFlotingTitle)
        textDidChange()

        // add observer
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }

    deinit {
        lblPlaceholder.removeFromSuperview()
        btnFlotingTitle.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        updateFrames()
    }

    // MARK: - Override Property
    override public var text: String? {
        didSet {    self.textDidChange()    }
    }

    override public var alpha: CGFloat {
        didSet { btnFlotingTitle.alpha = self.alpha  }
    }

    override public var isHidden: Bool {
        didSet { btnFlotingTitle.isHidden = self.isHidden    }
    }

    // MARK: - Action Methods
    @objc private func textDidChange() {
        updateFrames()
        self.lblPlaceholder.alpha = self.text!.isEmpty ? 1 : 0
        self.btnFlotingTitle.alpha = self.text!.isEmpty ? 0 : 1
    }

    private func updateFrames() {
        lblPlaceholder.frame = placeholderExpectedFrame
        btnFlotingTitle.frame = titleLabelFrame
    }

    // ------------------------------------------------------
    // MARK: Setup placeholder
    private var placeholderInsets: UIEdgeInsets {
        return UIEdgeInsets(top: self.textContainerInset.top, left: self.textContainerInset.left + self.textContainer.lineFragmentPadding, bottom: self.textContainerInset.bottom, right: self.textContainerInset.right + self.textContainer.lineFragmentPadding)
    }

    private var placeholderExpectedFrame: CGRect {
        let placeholderInsets = self.placeholderInsets
        let maxWidth = self.frame.width-placeholderInsets.left-placeholderInsets.right
        let expectedSize = lblPlaceholder.sizeThatFits(CGSize(width: maxWidth, height: self.frame.height-placeholderInsets.top-placeholderInsets.bottom))

        return CGRect(x: placeholderInsets.left, y: placeholderInsets.top, width: maxWidth, height: expectedSize.height)
    }

    // ------------------------------------------------------
    // MARK: Setup title label

    private var titleLabelFrame: CGRect {
        let labelSize = btnFlotingTitle.titleLabel!.text!.sizeOfString(font: titleFont)
        let width = labelSize.width+titleInnerEdgeInsets.left+titleInnerEdgeInsets.right

        var y: CGFloat = .zero
        switch self.flotingType {
        case .insideBorder: y = frame.minY+1
        case .onBorder: y = frame.minY-(labelSize.height/2)-titleInnerEdgeInsets.top
        case .outsideBorder: y = frame.minY-labelSize.height-titleInnerEdgeInsets.top-titleInnerEdgeInsets.bottom
        }

        return CGRect(x: (self.userInterfaceLayoutDirection == .leftToRight) ? (frame.minX+titleLeadingSpace) : (frame.maxX-titleLeadingSpace-width),
                      y: y,
                      width: labelSize.width+titleInnerEdgeInsets.left+titleInnerEdgeInsets.right,
                      height: labelSize.height+titleInnerEdgeInsets.top+titleInnerEdgeInsets.bottom)
    }
}

// MARK: - Helper Extension
fileprivate extension String {
    func sizeOfString(font: UIFont) -> CGSize {
        return self.boundingRect(with: CGSize(width: Double.greatestFiniteMagnitude,
                                              height: Double.greatestFiniteMagnitude),
                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                 attributes: [NSAttributedString.Key.font: font],
                                 context: nil).size
    }
}

fileprivate extension UIView {
    /// Returns text and UI direction based on current view settings
    var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        if #available(iOS 9.0, *) {
            return UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute)
        } else {
            return UIApplication.shared.userInterfaceLayoutDirection
        }
    }
}
