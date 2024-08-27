//
//  BottomSheetFeatureViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 21/09/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup
import FLAnimatedImage

class BottomSheetFeatureViewController: BottomPopupViewController {

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var styleTitleLabel: CalloutFontLabel!
    @IBOutlet var styleDescriptionLabel: Caption1FontLabel!

    @IBOutlet var statusView: UIView!
    @IBOutlet var statusLabel: FootnoteFontLabel!
    @IBOutlet var contentLabel: Caption1FontLabel!

    @IBOutlet var prosTitleLabel: FootnoteFontLabel!
    @IBOutlet var prosDescriptionLabel: Caption2FontLabel!

    @IBOutlet var consTitleLabel: FootnoteFontLabel!
    @IBOutlet var consDescriptionLabel: Caption2FontLabel!

    @IBOutlet var devicebutton: FootnoteOutlineButton!
    @IBOutlet var humanButton: FootnoteOutlineButton!

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!

    var titlemessage = ""
    var descriptionmessage = ""
    var proArrayList = [String]()
    var consArrayList = [String]()
    var deviceArrayList = [String]()
    var humanArrayList = [String]()

    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?

    var ishuman = false

    let collectionViewMargin = CGFloat(0)
    let collectionViewItemSpacing = CGFloat(0)
    var collectionViewItemHeight = CGFloat(226)
    var collectionViewItemWidth = CGFloat(339)
    let collectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var timer = Timer()

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
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }
    // MARK: - Set Initial View
    func setInitialView() {
        overrideUserInterfaceStyle = .light
        self.changeLanguageFormat()
        self.setDefaultButtonColor()
        let view0 = self.mainStackView.arrangedSubviews[0]// title
        let view1 = self.mainStackView.arrangedSubviews[1]// status
        let view2 = self.mainStackView.arrangedSubviews[2]// pros&cons
        let view3 = self.mainStackView.arrangedSubviews[3]// button
        let view4 = self.mainStackView.arrangedSubviews[4]// collection
        view0.isHidden = false
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view4.isHidden = true

        self.prosDescriptionLabel.setHTMLFromString(htmlText: "", fontFamily: AppConstantValue.poppinsregular, fontSize: 11.0, fontColor: AppConstantValue.fontGrey777777)
        self.consDescriptionLabel.setHTMLFromString(htmlText: "", fontFamily: AppConstantValue.poppinsregular, fontSize: 11.0, fontColor: AppConstantValue.fontGrey777777)

        if (proArrayList.count > 0) || (consArrayList.count > 0) {
            var pro = ["<ul>"]
            var con = ["<ul>"]
            if self.proArrayList.count > 0 {
                var i = 0
                for item in proArrayList {
                    if !(item.isEmpty) {
                        pro.append("<li>\(item)</li>")
                    }
                    i += 1
                    if i >= proArrayList.count {
                        pro.append("</ul>")
                        let prostr = pro.joined(separator: "")
                        self.prosDescriptionLabel.setHTMLFromString(htmlText: prostr, fontFamily: AppConstantValue.poppinsregular, fontSize: 11.0, fontColor: AppConstantValue.fontGrey777777)
                        view2.isHidden = false
                    }
                }
            }
            if self.consArrayList.count > 0 {
                var i = 0
                for item in consArrayList {
                    if !(item.isEmpty) {
                        con.append("<li>\(item)</li>")
                    }
                    i += 1
                    if i >= consArrayList.count {
                        con.append("</ul>")
                        let constr = con.joined(separator: "")
                        self.consDescriptionLabel.setHTMLFromString(htmlText: constr, fontFamily: AppConstantValue.poppinsregular, fontSize: 11.0, fontColor: AppConstantValue.fontGrey777777)
                        view2.isHidden = false
                    }
                }
            }
        }
        if (self.deviceArrayList.count > 0) && (self.humanArrayList.count > 0) {
            view3.isHidden = false
        }
        if (self.deviceArrayList.count > 0) || (self.humanArrayList.count > 0) {
            view4.isHidden = true
            if self.deviceArrayList.count > 0 {
                self.ishuman = false
            } else if self.humanArrayList.count > 0 {
                self.ishuman = true
            }
            view4.isHidden = false
            self.setDefaultButtonColor()
        }
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.prosTitleLabel.text = AppLocalizationString.advantages.uppercased()
        self.consTitleLabel.text =  AppLocalizationString.limitations.uppercased()
        self.styleTitleLabel.text = titlemessage
        self.styleDescriptionLabel.text = descriptionmessage.capitalized
        self.statusLabel.text = ""
        self.contentLabel.text = ""
        self.prosDescriptionLabel.text = ""
        self.consDescriptionLabel.text = ""
        self.devicebutton.setTitle("   \(AppLocalizationString.hearingAid.capitalized)   ", for: .normal)
        self.humanButton.setTitle("   \(AppLocalizationString.howitwilllook.capitalized)   ", for: .normal)
    }
    // MARK: - Reload
    func reloadCollectionView() {
        //        self.collectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(AppConstantValue.screen345slash375)
        self.collectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32)
        self.collectionViewItemHeight = CGFloat(AppConstantValue.screenWidthminus32)
        //        self.collectionViewItemHeight = CGFloat(266 * (screenFrameWidth / AppConstantValue.defaultDesignScreenWidth))
        self.collectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionViewlayout.itemSize = CGSize(width: self.collectionViewItemWidth, height: self.collectionViewItemHeight)
        self.collectionViewlayout.minimumLineSpacing = self.collectionViewItemSpacing
        self.collectionViewlayout.minimumInteritemSpacing = self.collectionViewItemSpacing
        self.collectionViewlayout.scrollDirection = .horizontal
        self.collectionView!.collectionViewLayout = self.collectionViewlayout
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
        if self.ishuman == true {
            if self.humanArrayList.count > 0 {
                //                self.collectionViewHeight.constant = CGFloat(266 * (screenFrameHeight / AppConstantValue.defaultDesignScreenHeight))
                self.collectionViewHeight.constant = CGFloat(AppConstantValue.screenWidthminus32)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
                    if self.humanArrayList.count > 1 {
                        self.timer.invalidate()
                        self.startAutoScrollCollectionBanner()
                    }
                }
            } else {
                self.collectionViewHeight.constant = 0
            }
        } else {
            if self.deviceArrayList.count > 0 {
                //                self.collectionViewHeight.constant = CGFloat(266 * (screenFrameHeight / AppConstantValue.defaultDesignScreenHeight))
                self.collectionViewHeight.constant = CGFloat(AppConstantValue.screenWidthminus32)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
                    if self.deviceArrayList.count > 1 {
                        self.timer.invalidate()
                        self.startAutoScrollCollectionBanner()
                    }
                }
            } else {
                self.collectionViewHeight.constant = 0
            }
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
    @IBAction func deviceButtonPressed(_ sender: UIButton) {
        self.ishuman = false
        self.setDefaultButtonColor()
    }
    @IBAction func humanButtonPressed(_ sender: UIButton) {
        self.ishuman = true
        self.setDefaultButtonColor()
    }

    // MARK: - Custom Methods
    func setDefaultButtonColor() {
        self.devicebutton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.devicebutton.layer.borderWidth = 1.0
        self.devicebutton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.devicebutton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF

        self.humanButton.layer.borderColor = UIColor.colorLiteral.theme_grey_777777.cgColor
        self.humanButton.layer.borderWidth = 1.0
        self.humanButton.setTitleColor(UIColor.colorLiteral.theme_grey_777777, for: .normal)
        self.humanButton.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF

        if self.ishuman == true {
            self.setHumanButtonColor()
        } else {
            self.setDeviceButtonColor()
        }
    }
    func setDeviceButtonColor() {
        self.devicebutton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.devicebutton.layer.borderWidth = 1.0
        self.devicebutton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.devicebutton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.reloadCollectionView()
    }
    func setHumanButtonColor() {
        self.humanButton.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
        self.humanButton.layer.borderWidth = 1.0
        self.humanButton.setTitleColor(UIColor.colorLiteral.theme_blue_2AACEF, for: .normal)
        self.humanButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF

        self.reloadCollectionView()
    }
    func startAutoScrollCollectionBanner() {
        DispatchQueue.main.async {
            self.timer.invalidate()
            self.timer =  Timer.scheduledTimer(timeInterval: Double(AppConstantValue.timerInterval), target: self, selector: #selector(self.autoScrollCollectionBanner), userInfo: nil, repeats: true)
        }
    }
    @objc func autoScrollCollectionBanner(_ timer1: Timer) {
        if let coll  = self.collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if self.ishuman == true {
                    if (indexPath?.item)! < self.humanArrayList.count - 1 {
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(item: (indexPath?.item)! + 1, section: 0)
                        //                    pageControl.currentPage = (indexPath1?.item)!
                        //                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                        let rect = coll.layoutAttributesForItem(at: indexPath1!)?.frame
                        coll.scrollRectToVisible(rect!, animated: true)
                    } else {
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(item: 0, section: 0)
                        //                    pageControl.currentPage = 0
                        //                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                        let rect = coll.layoutAttributesForItem(at: indexPath1!)?.frame
                        coll.scrollRectToVisible(rect!, animated: true)
                    }
                } else {
                    if (indexPath?.item)! < self.deviceArrayList.count - 1 {
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(item: (indexPath?.item)! + 1, section: 0)
                        //                    pageControl.currentPage = (indexPath1?.item)!
                        //                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                        let rect = coll.layoutAttributesForItem(at: indexPath1!)?.frame
                        coll.scrollRectToVisible(rect!, animated: true)
                    } else {
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(item: 0, section: 0)
                        //                    pageControl.currentPage = 0
                        //                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                        let rect = coll.layoutAttributesForItem(at: indexPath1!)?.frame
                        coll.scrollRectToVisible(rect!, animated: true)
                    }
                }
            }
        }
    }

    // MARK: - GestureRecognizer Delegate
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            self.timer.invalidate()
            if self.ishuman == true {
                if self.humanArrayList.count > 1 {
                    self.startAutoScrollCollectionBanner()
                }
            } else {
                if self.deviceArrayList.count > 1 {
                    self.startAutoScrollCollectionBanner()
                }
            }
            return
        } else if gestureRecognizer.state == .began {
            self.timer.invalidate()
            let pointOfContact = gestureRecognizer.location(in: self.collectionView)
            let indexPath = self.collectionView.indexPathForItem(at: pointOfContact)
            if let index = indexPath {
                var cell = self.collectionView.cellForItem(at: index)
                // do stuff with your cell, for example print the indexPath
                //                self.pageControl.currentPage = index.item
            } else {}
        }
    }
}

extension BottomSheetFeatureViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.ishuman == true {
            return self.humanArrayList.count
        } else {
            return self.deviceArrayList.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.ishuman == true {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BottomSheetFeatureHumanCollectionViewCell, for: indexPath) as! BottomSheetFeatureHumanCollectionViewCell
            cell.configure(bannerimageurl: self.humanArrayList[indexPath.item], indexpath: indexPath.item)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BottomSheetFeatureDeviceCollectionViewCell, for: indexPath) as! BottomSheetFeatureDeviceCollectionViewCell
            cell.configure(bannerimageurl: self.deviceArrayList[indexPath.item], indexpath: indexPath.item)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.ishuman == true {
            if self.humanArrayList.count > 0 {
                cellWidth = self.collectionViewItemWidth
                cellHeight = self.collectionViewItemHeight
            }
        } else {
            if self.deviceArrayList.count > 0 {
                cellWidth = self.collectionViewItemWidth
                cellHeight = self.collectionViewItemHeight
            }
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
