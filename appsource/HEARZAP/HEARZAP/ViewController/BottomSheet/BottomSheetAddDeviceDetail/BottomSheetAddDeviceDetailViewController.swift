//
//  BottomSheetAddDeviceDetailViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 24/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup
import FLAnimatedImage

class BottomSheetAddDeviceDetailViewController: BottomPopupViewController {

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var titleLabel: CalloutFontLabel!
    @IBOutlet var descriptionLabel: Caption1FontLabel!

    @IBOutlet var bannerImageView: UIImageView!

    @IBOutlet var tableview: UITableView!
    @IBOutlet var tableviewHeight: NSLayoutConstraint!

    var imageViewName = ""
    var titlemessage = ""
    var descriptionmessage = ""
    var arrlist = [String]()

    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    var tableviewheightConstant: CGFloat = 0
    //    weak var boardingPopupListViewControllerDelegate: BoardingPopupListViewControllerDelegate!

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.color_theme_black)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableviewHeight.constant = tableviewheightConstant

        //        self.mainScrollView.sizeToFit()
        //        self.mainScrollView.contentSize = CGSize(width: self.mainStackView.frame.size.width, height: self.tableview.frame.height + self.tableview.frame.origin.y)
    }
    // MARK: - Set Initial View
    func setInitialView() {
        //        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.color_theme_black)
        overrideUserInterfaceStyle = .light
        self.tableview.tableFooterView = UIView()
        self.tableview.estimatedRowHeight = UITableView.automaticDimension
        self.tableview.rowHeight = UITableView.automaticDimension
        self.tableview.separatorColor = UIColor.colorLiteral.theme_white_F2F2F2
        self.tableviewHeight.constant = tableviewheightConstant
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
        self.tableview.isScrollEnabled = false

        self.titleLabel.text = self.titlemessage
        self.descriptionLabel.text = self.descriptionmessage

        self.bannerImageView.setImage(imageUrl: imageViewName, placeHolderImage: hearzapPlaceholder)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        //        self.lbl_header.text = "select_your_cruise_ship".appTextlocalizationString
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
    // MARK: - IBAction
    @IBAction func closeButtonPressed(_ sender: UIButton) {self.dismiss(animated: true) {}}
    // MARK: - Custom Methods
}

extension BottomSheetAddDeviceDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.arrlist.count > 0 {
            return 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrlist.count > 0 {
            if section == 0 {
                return 1
            } else {
                return self.arrlist.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.arrlist.count > 0 {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BottomSheetAddDeviceDetailTitleTableViewCell, for: indexPath) as! BottomSheetAddDeviceDetailTitleTableViewCell
                cell.titleLabel.text = AppLocalizationString.howitworks
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BottomSheetAddDeviceDetailTableViewCell, for: indexPath) as! BottomSheetAddDeviceDetailTableViewCell
                cell.configure(title: self.arrlist[indexPath.row], indexpath: indexPath.row)
                cell.showSeparator()
                if indexPath.row == (self.arrlist.count - 1) {
                    cell.hideSeparator()
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BottomSheetAddDeviceDetailTableViewCell, for: indexPath) as! BottomSheetAddDeviceDetailTableViewCell
            cell.configure(title: self.arrlist[indexPath.row], indexpath: indexPath.row)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableviewHeight.constant = tableviewheightConstant
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
