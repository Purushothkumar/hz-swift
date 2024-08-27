//
//  BottomSheetCommonDeleteViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 09/02/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup
import FLAnimatedImage

protocol ProtocolBottomSheetCommonDeleteViewControllerDelegate: AnyObject {
    func deleteButtonPressedBottomSheetCommonDeleteViewController()
}
class BottomSheetCommonDeleteViewController: BottomPopupViewController {

    @IBOutlet var primaryMessageLabel: CalloutFontLabel!
    @IBOutlet var secondaryMessageLabel: Caption1FontLabel!
    @IBOutlet var deleteButton: FootnoteBackgroundButton!
    @IBOutlet var cancelButton: FootnoteOutlineButton!
    @IBOutlet var imgView: FLAnimatedImageView!

    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?

    var isDelete = false

    var primaryMsgText = ""
    var secondaryMsgText = ""
    var deleteText = ""
    var cancelText = ""

    var protocolBottomSheetCommonDeleteViewControllerDelegate: ProtocolBottomSheetCommonDeleteViewControllerDelegate!

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_blue_112F70,style: StatusBarTheme.lightContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Set Initial View
    func setInitialView() {

        self.changeStatusBarColor()
        self.changeLanguageFormat()

        self.cancelButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.cancelButton.layer.borderWidth = 1.0
        self.cancelButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.cancelButton.clipsToBounds = true
        self.cancelButton.layer.cornerRadius = AppConstantValue.cornerRadius4

        self.deleteButton.layer.borderColor = UIColor.colorLiteral.theme_red_FF6961.cgColor
        self.deleteButton.layer.borderWidth = 1.0
        self.deleteButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.deleteButton.clipsToBounds = true
        self.deleteButton.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.deleteButton.backgroundColor = UIColor.colorLiteral.theme_red_FF6961

    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.deleteButton.setTitle(String(format: "  \(deleteText.uppercased())  "), for: .normal)
        self.cancelButton.setTitle(String(format: "  \(cancelText.uppercased())  "), for: .normal)
        self.primaryMessageLabel.text = primaryMsgText
        self.secondaryMessageLabel.text = secondaryMsgText
    }
    // MARK: - IBAction
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.protocolBottomSheetCommonDeleteViewControllerDelegate.deleteButtonPressedBottomSheetCommonDeleteViewController()
        }
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
        }
    }
    // MARK: - BottomPopUp Delegate
    override var popupHeight: CGFloat {
        get {
            return height ?? CGFloat(300)
        }
    }
    override var popupTopCornerRadius: CGFloat {
        get {
            return topCornerRadius ?? CGFloat(10)
        }
    }
    func getPopupHeight() -> CGFloat {
        return height ?? CGFloat(300)
    }
    func getPopupTopCornerRadius() -> CGFloat {
        return topCornerRadius ?? CGFloat(10)
    }
    func getPopupPresentDuration() -> Double {
        return presentDuration ?? 1.0
    }
    func getPopupDismissDuration() -> Double {
        return dismissDuration ?? 1.0
    }
    func shouldPopupDismissInteractivelty() -> Bool {
        return shouldDismissInteractivelty ?? true
    }
}
