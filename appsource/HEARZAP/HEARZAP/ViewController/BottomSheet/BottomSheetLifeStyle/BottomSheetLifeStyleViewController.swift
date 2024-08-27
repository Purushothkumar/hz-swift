//
//  BottomSheetLifeStyleViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 10/08/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup
import FLAnimatedImage

class BottomSheetLifeStyleViewController: BottomPopupViewController {

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var styleTitleLabel: CalloutFontLabel!
    @IBOutlet var styleDescriptionLabel: Caption1FontLabel!

    @IBOutlet var styleImageView: UIImageView!
    @IBOutlet var styleImageViewHeight: NSLayoutConstraint!

    @IBOutlet var styleTableView: UITableView!
    @IBOutlet var styleTableViewHeight: NSLayoutConstraint!

    var imageViewName = ""
    var titlemessage = ""
    var descriptionmessage = ""
    var arrlist = [String]()
    var tableviewheight: CGFloat = 0

    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    var tableviewheightConstant = CGFloat(0)

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
        self.styleTableViewHeight.constant = tableviewheightConstant

        //        self.mainScrollView.sizeToFit()
        //        self.mainScrollView.contentSize = CGSize(width: self.mainStackView.frame.size.width, height: self.styleTableView.frame.height + self.styleTableView.frame.origin.y)
    }
    // MARK: - Set Initial View
    func setInitialView() {
        //        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.color_theme_black)
        overrideUserInterfaceStyle = .light

        self.styleTableView.tableFooterView = UIView()
        self.styleTableView.estimatedRowHeight = UITableView.automaticDimension
        self.styleTableView.rowHeight = UITableView.automaticDimension
        self.styleTableView.separatorColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.styleTableViewHeight.constant = CGFloat(self.tableviewheightConstant)
        self.styleTableView.isScrollEnabled = false
        self.styleTableView.delegate = self
        self.styleTableView.dataSource = self
        self.styleTableView.reloadData()

        self.styleTitleLabel.text = self.titlemessage
        self.styleDescriptionLabel.text = self.descriptionmessage
        self.styleImageView.setImage(imageUrl: imageViewName, placeHolderImage: hearzapPlaceholder)
        self.styleImageViewHeight.constant = CGFloat(278 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth))

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

extension BottomSheetLifeStyleViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrlist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BottomSheetLifeStyleTableViewCell, for: indexPath) as! BottomSheetLifeStyleTableViewCell
        cell.configure(data: self.arrlist[indexPath.row], indexpath: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.styleTableViewHeight.constant = tableviewheightConstant
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}
