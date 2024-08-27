//
//  BottomSheetAddDeviceViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 24/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

protocol ProtocolBottomSheetAddDeviceViewController {
    func updateDeviceListBottomSheetAddDeviceViewController(id: String, deviceList: [String])
    func addNewDeviceListBottomSheetAddDeviceViewController(id: String)
}

class BottomSheetAddDeviceViewController: BottomPopupViewController {
    // MARK: - IBOutlets

    @IBOutlet var titleLabel: FootnoteFontLabel!
    @IBOutlet var productTableView: UITableView!

    @IBOutlet var cancelButton: FootnoteOutlineButton!
    @IBOutlet var addButton: FootnoteBackgroundButton!
    @IBOutlet var addDeviceButton: FootnoteOutlineButton!

    // MARK: - Lets and Var
    var selectArray = [String]()
    var deviceListArray = [RegisterDeviceModelDeviceData]()

    var delegate: ProtocolBottomSheetAddDeviceViewController!

    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?

    var deviceList = [String]()
    var id = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        //        self.changeLanguageFormat()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: -  Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_blue_112F70,style: StatusBarTheme.lightContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: - Set Initial View
    func setInitialView() {
        self.changeStatusBarColor()
        //        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true

        self.addDeviceButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.addDeviceButton.layer.borderWidth = 1.0
        self.addDeviceButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.addDeviceButton.clipsToBounds = true
        self.addDeviceButton.layer.cornerRadius = AppConstantValue.cornerRadius4

        self.cancelButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.cancelButton.layer.borderWidth = 1.0
        self.cancelButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.cancelButton.clipsToBounds = true
        self.cancelButton.layer.cornerRadius = AppConstantValue.cornerRadius4

        self.cancelButton.setTitle(AppLocalizationString.cancel.uppercased(), for: .normal)
        self.addButton.setTitle(AppLocalizationString.add.uppercased(), for: .normal)
        self.addDeviceButton.setTitle(AppLocalizationString.plusAddaDevice.uppercased(), for: .normal)
        self.titleLabel.text = AppLocalizationString.selectthedeviceyouwanttoservice

        self.productTableView.tableFooterView = UIView()
        self.productTableView.separatorColor = UIColor.clear
        self.productTableView.backgroundColor = UIColor.clear
        self.productTableView.rowHeight = UITableView.automaticDimension
        self.productTableView.estimatedRowHeight = UITableView.automaticDimension
        self.setUserInteractionButton()
        self.reloadProductTableView()
    }

    // MARK: - Localization String
    //    func changeLanguageFormat() {
    //        self.cancelButton.setTitle(AppLocalizationString.cancel.uppercased(), for: .normal)
    //        self.addButton.setTitle(AppLocalizationString.add.uppercased(), for: .normal)
    //        self.addDeviceButton.setTitle(AppLocalizationString.plusAddaDevice.uppercased(), for: .normal)
    //        self.titleLabel.text = AppLocalizationString.selectthedeviceyouwanttoservice
    //    }
    // MARK: - Reload
    func reloadProductTableView() {
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        self.productTableView.reloadData()
    }

    // MARK: - IBAction
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {}
    }
    @IBAction func addButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate.updateDeviceListBottomSheetAddDeviceViewController(id: self.id, deviceList: self.selectArray)
        }
    }
    @IBAction func addDeviceButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate.addNewDeviceListBottomSheetAddDeviceViewController(id: self.id)
        }
    }
    // MARK: - Custom Methods
    func setUserInteractionButton() {
        DispatchQueue.main.async {
            if self.selectArray.count > 0 {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
        }
    }
    func setButtonDisable() {
        self.addButton.isUserInteractionEnabled = false
        self.addButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.addButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.addButton.setNeedsDisplay()
        self.addButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

    func setButtonEnable() {
        self.addButton.isUserInteractionEnabled = true
        self.addButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.addButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.addButton.setNeedsDisplay()
        self.addButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    // MARK: - BottomPopUp Delegate
    override var popupHeight: CGFloat {
        get {
            return height ?? CGFloat(300)
        }
    }
    override var popupTopCornerRadius: CGFloat {
        get {
            return topCornerRadius ?? 0
        }
    }
    func getPopupHeight() -> CGFloat {return height ?? CGFloat(300)}
    func getPopupTopCornerRadius() -> CGFloat {return topCornerRadius ?? 0}
    func getPopupPresentDuration() -> Double {return presentDuration ?? 1.0}
    func getPopupDismissDuration() -> Double {return dismissDuration ?? 1.0}
    func shouldPopupDismissInteractivelty() -> Bool {return shouldDismissInteractivelty ?? true}
}

extension BottomSheetAddDeviceViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deviceListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BottomSheetAddDeviceTableViewCell, for: indexPath) as! BottomSheetAddDeviceTableViewCell
        cell.configure(device: self.deviceListArray[indexPath.row], indexpath: indexPath.row, viewCon: self)
        cell.delegate = self
        self.viewWillLayoutSubviews()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension BottomSheetAddDeviceViewController: ProtocolBottomSheetAddDeviceTableViewCell {
    func selectButtonPressedBottomSheetAddDeviceTableViewCell(senderTag: Int) {
        var id = ""
        if self.deviceListArray.count > 0 {
            if self.deviceListArray[senderTag].id != nil {
                id = String(format: "%d", self.deviceListArray[senderTag].id!)
            }
            if self.selectArray.count > 0 {
                if self.selectArray.contains(id) {
                    self.selectArray = self.selectArray.filter {$0 != id}
                } else {
                    self.selectArray.append(id)
                }
            } else {
                self.selectArray.append(id)
            }
        }
        self.setUserInteractionButton()
        self.reloadProductTableView()
    }
}
