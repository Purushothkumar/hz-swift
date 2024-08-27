//
//  RegisterDeviceTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 22/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import YouTubePlayer

protocol ProtocolRegisterDeviceTableViewCell {
    func tapButtonPressedRegisterDeviceTableViewCell(senderTag: Int)
    func requestServiceButtonPressedRegisterDeviceTableViewCell(senderTag: Int)
    func takeSurveyButtonPressedRegisterDeviceTableViewCell(senderTag: Int)
    func removeButtonPressedRegisterDeviceTableViewCell(senderTag: Int)
    func editButtonPressedRegisterDeviceTableViewCell(senderTag: Int)
    func buybackButtonPressedRegisterDeviceTableViewCell(senderTag: Int)
}
class RegisterDeviceTableViewCell: UITableViewCell {

    @IBOutlet var stackview: UIStackView!
    @IBOutlet var productInfoView: UIView!
    @IBOutlet var bannerImageview: UIImageView!
    @IBOutlet var productLabel: Caption1FontLabel!
    @IBOutlet var detailLabel: Caption2FontLabel!
    @IBOutlet var tapButton: CalloutOutlineButton!
    @IBOutlet var arrowImageView: UIImageView!

    @IBOutlet var deviceInfoView: UIView!
    @IBOutlet var deviceInfoStackView: UIStackView!

    @IBOutlet var userNameTitleLabel: Caption1FontLabel!
    @IBOutlet var userNameLabel: Caption1FontLabel!

    @IBOutlet var brandTitleLabel: Caption1FontLabel!
    @IBOutlet var brandLabel: Caption1FontLabel!

    @IBOutlet var modelTitleLabel: Caption1FontLabel!
    @IBOutlet var modelLabel: Caption1FontLabel!

    @IBOutlet var serialNumberTitleLabel: Caption1FontLabel!
    @IBOutlet var serialNumberLabel: Caption1FontLabel!

    @IBOutlet var receiverSideTitleLabel: Caption1FontLabel!
    @IBOutlet var receiverSideLabel: Caption1FontLabel!

    @IBOutlet var tableview: UITableView!
    @IBOutlet var tableviewHeight: NSLayoutConstraint!

    @IBOutlet var purchasedFromTitleLabel: Caption1FontLabel!
    @IBOutlet var purchasedFromLabel: Caption1FontLabel!

    @IBOutlet var purchasedOnTitleLabel: Caption1FontLabel!
    @IBOutlet var purchasedOnLabel: Caption1FontLabel!

    @IBOutlet var warrantyDetailTitleLabel: Caption1FontLabel!
    @IBOutlet var warrantyDetailLabel: Caption1FontLabel!

    @IBOutlet var lastServiceDateTitleLabel: Caption1FontLabel!
    @IBOutlet var lastServiceDateLabel: Caption1FontLabel!

    @IBOutlet var nextServiceDateTitleLabel: Caption1FontLabel!
    @IBOutlet var nextServiceDateLabel: Caption1FontLabel!

    @IBOutlet var warrantyEndsTitleLabel: Caption1FontLabel!
    @IBOutlet var warrantyEndsLabel: Caption1FontLabel!

    @IBOutlet var exWarrantyEndsTitleLabel: Caption1FontLabel!
    @IBOutlet var exWarrantyEndsLabel: Caption1FontLabel!
    
    @IBOutlet var playerView: UIView!
    @IBOutlet var cmvideoTitleLabel: FootnoteFontLabel!
    @IBOutlet var youTubePlayerView: YouTubePlayerView!
    @IBOutlet var playerViewHeight: NSLayoutConstraint!

    @IBOutlet var remarkTitleLabel: Caption1FontLabel!
    @IBOutlet var remarkLabel: Caption1FontLabel!
    @IBOutlet var remarkViewHeight: NSLayoutConstraint!

    @IBOutlet var requestServiceButton: FootnoteOutlineButton!
    @IBOutlet var requestServiceButtonWidth: NSLayoutConstraint!

    @IBOutlet var takeSurveyButton: FootnoteOutlineButton!
    @IBOutlet var takeSurveyButtonWidth: NSLayoutConstraint!

    @IBOutlet var surveyImageHeight: NSLayoutConstraint!
    @IBOutlet var surveyImageButton: FootnoteOutlineButton!
    
    @IBOutlet var buttonStackview: UIStackView!
    @IBOutlet var removeButton: FootnoteOutlineButton!
    @IBOutlet var editButton: FootnoteOutlineButton!
    @IBOutlet var buybackButton: FootnoteOutlineButton!

    var delegate: ProtocolRegisterDeviceTableViewCell?

    var productSpecArray = [RegisterDeviceModelProductSpecification]()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(device: RegisterDeviceModelDeviceData, indexPath: Int, selectedIndex: String, viewCon: RegisterDeviceViewController) {
        self.userNameTitleLabel.text = AppLocalizationString.name
        self.userNameLabel.text = "-"
        self.brandTitleLabel.text = AppLocalizationString.brand
        self.brandLabel.text = "-"
        self.modelTitleLabel.text = AppLocalizationString.model
        self.modelLabel.text = "-"
        self.serialNumberTitleLabel.text = AppLocalizationString.serialNumber
        self.serialNumberLabel.text = "-"
        self.receiverSideTitleLabel.text = AppLocalizationString.receiverSide
        self.receiverSideLabel.text = "-"
        self.purchasedFromTitleLabel.text = AppLocalizationString.purchasedFrom
        self.purchasedFromLabel.text = "-"
        self.purchasedOnTitleLabel.text = AppLocalizationString.purchasedOn
        self.purchasedOnLabel.text = "-"
        self.warrantyDetailTitleLabel.text = AppLocalizationString.warrantyDetails
        self.warrantyDetailLabel.text = "-"
        self.lastServiceDateTitleLabel.text = AppLocalizationString.lastServiceDate
        self.lastServiceDateLabel.text = "-"
        self.nextServiceDateTitleLabel.text = AppLocalizationString.nextServiceDate
        self.nextServiceDateLabel.text = "-"
        self.warrantyEndsTitleLabel.text = AppLocalizationString.warrantyExpireson
        self.warrantyEndsLabel.text = "-"
        self.exWarrantyEndsTitleLabel.text = AppLocalizationString.exWarrantyExpireson
        self.exWarrantyEndsLabel.text = "-"
        self.remarkTitleLabel.text = AppLocalizationString.remarks
        self.remarkLabel.text = "-"
        self.cmvideoTitleLabel.text = AppLocalizationString.careambermaintenancevideo

        self.takeSurveyButton.setTitle(AppLocalizationString.takeaSurvey.uppercased(), for: .normal)
        self.requestServiceButton.setTitle(AppLocalizationString.requestService.uppercased(), for: .normal)
        self.removeButton.setTitle(AppLocalizationString.remove, for: .normal)
        self.editButton.setTitle(AppLocalizationString.edit, for: .normal)
        self.buybackButton.setTitle(AppLocalizationString.buyBack, for: .normal)

        self.takeSurveyButton.clipsToBounds = true
        self.takeSurveyButton.cornerRadius = AppConstantValue.cornerRadius4
        self.takeSurveyButton.borderColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.takeSurveyButton.borderWidth = 1.0

        self.requestServiceButton.clipsToBounds = true
        self.requestServiceButton.cornerRadius = AppConstantValue.cornerRadius4
        self.requestServiceButton.borderColor = UIColor.colorLiteral.theme_grey_777777
        self.requestServiceButton.borderWidth = 1.0

        self.takeSurveyButton.tag = indexPath
        self.requestServiceButton.tag = indexPath
        self.removeButton.tag = indexPath
        self.editButton.tag = indexPath
        self.buybackButton.tag = indexPath
        self.tapButton.tag = indexPath
        self.surveyImageButton.tag = indexPath

        let view0 = self.stackview.arrangedSubviews[0] // Product Info
        let view1 = self.stackview.arrangedSubviews[1] // Device Details

        view0.isHidden = false
        view1.isHidden = true

        let remarksview13 = self.deviceInfoStackView.arrangedSubviews[13] // Product Info
        remarksview13.isHidden = true
        
        let cmvideoview14 = self.deviceInfoStackView.arrangedSubviews[14] // Product Info
        cmvideoview14.isHidden = true
        
        let buttonview0 = self.buttonStackview.arrangedSubviews[0] //remove
        let buttonview1 = self.buttonStackview.arrangedSubviews[1] //line
        let buttonview2 = self.buttonStackview.arrangedSubviews[2] //Edit
        let buttonview3 = self.buttonStackview.arrangedSubviews[3] //line
        let buttonview4 = self.buttonStackview.arrangedSubviews[4] //buyback
        
        buttonview0.isHidden = true
        buttonview1.isHidden = true
        buttonview2.isHidden = true
        buttonview3.isHidden = true
        buttonview4.isHidden = true
        
        self.arrowImageView.image = UIImage(named: Asset.chevronrightgreydark)

        var id = ""
        var orderRef = ""
        var userName = ""
        var deviceName = ""
        var deviceBrand = ""
        var deviceModel = ""
        var deviceSerialNumber = ""

        var deviceEarPreferenceValue = ""
        var devicePurchasedOn = ""
        var devicePurchasedFromValue = ""
        var deviceWarrantyExpiresOn = ""

        var deviceExtendedWarrantyEndOn = ""
        var deviceWarrantyDetailsValue = ""
        var deviceNextServiceDate = ""
        var deviceLastServiceDate = ""
        var remarks = ""

        var deviceImage = ""
        var deviceCMVideo = ""
        var warrantyEndsOnDays = ""
        var canTakeSurvey = false
        var extendedWarrantyEndsOnDays = ""
        var warrantyEndsOnDaysColor = UIColor.colorLiteral.theme_black_333333
        var extendedWarrantyEndsOnDaysColor = UIColor.colorLiteral.theme_black_333333
        self.youTubePlayerView.stop()
        self.productSpecArray.removeAll()
        let placeHolderImage: UIImage = UIImage(named: Asset.registereddeviceblue)!

        if device.id != nil {
            id = String(format: "%d", device.id!)
        }
        if device.canTakeSurvey != nil {
            canTakeSurvey = device.canTakeSurvey!
        }
        if device.productSpecification != nil {
            self.productSpecArray = device.productSpecification!
        }
        if !(device.orderRef.isNilOrEmpty) {
            orderRef = device.orderRef!
        }
        if !(device.deviceUserName.isNilOrEmpty) {
            userName = device.deviceUserName!.capitalized
        }
        if !(device.deviceName.isNilOrEmpty) {
            deviceName = device.deviceName!.capitalized
        }
        if !(device.deviceBrand.isNilOrEmpty) {
            deviceBrand = device.deviceBrand!.capitalized
        }
        if !(device.deviceModel.isNilOrEmpty) {
            deviceModel = device.deviceModel!.capitalized
        }
        if !(device.deviceSerialNumber.isNilOrEmpty) {
            deviceSerialNumber = device.deviceSerialNumber!
        }
        if !(device.deviceEarPreferenceValue.isNilOrEmpty) {
            deviceEarPreferenceValue = device.deviceEarPreferenceValue!.capitalized
        }
        if !(device.devicePurchasedOn.isNilOrEmpty) {
            devicePurchasedOn = device.devicePurchasedOn!.capitalized
        }
        if !(device.devicePurchasedFromValue.isNilOrEmpty) {
            devicePurchasedFromValue = device.devicePurchasedFromValue!.capitalized
        }
        if !(device.deviceWarrantyExpiresOn.isNilOrEmpty) {
            deviceWarrantyExpiresOn = device.deviceWarrantyExpiresOn!.capitalized
        }
        if !(device.deviceExtendedWarrantyEndOn.isNilOrEmpty) {
            deviceExtendedWarrantyEndOn = device.deviceExtendedWarrantyEndOn!.capitalized
        }
        if !(device.deviceWarrantyDetailsValue.isNilOrEmpty) {
            deviceWarrantyDetailsValue = device.deviceWarrantyDetailsValue!
        }
        if !(device.deviceNextServiceDate.isNilOrEmpty) {
            deviceNextServiceDate = device.deviceNextServiceDate!.capitalized
        }
        if !(device.deviceLastServiceDate.isNilOrEmpty) {
            deviceLastServiceDate = device.deviceLastServiceDate!.capitalized
        }
        if device.deviceCMVideo != nil {
            let strVideoLink = device.deviceCMVideo!
            if !(strVideoLink.isEmpty) {
                deviceCMVideo = strVideoLink.extractYoutubeIDFromLink() ?? ""
            }
        }
        if !(device.deviceImage.isNilOrEmpty) {
            deviceImage = device.deviceImage!
        }
        if !(device.warrantyEndsOnDays.isNilOrEmpty) {
            warrantyEndsOnDays = device.warrantyEndsOnDays!.capitalized
        }
        if !(device.extendedWarrantyEndsOnDays.isNilOrEmpty) {
            extendedWarrantyEndsOnDays = device.extendedWarrantyEndsOnDays!.capitalized
        }
        if !(device.remarks.isNilOrEmpty) {
            remarks = device.remarks!
        }
        if !(device.warrantyEndsOnDaysColor.isNilOrEmpty) {
            warrantyEndsOnDaysColor = UIColor(hexString: device.warrantyEndsOnDaysColor!, alpha: 1.0)
        }
        if !(device.extendedWarrantyEndsOnDaysColor.isNilOrEmpty) {
            extendedWarrantyEndsOnDaysColor = UIColor(hexString: device.extendedWarrantyEndsOnDaysColor!, alpha: 1.0)
        }
        self.bannerImageview.setImage(imageUrl: deviceImage, placeHolderImage: placeHolderImage)

        self.productLabel.text = deviceName
        self.detailLabel.text = ""
        
        if (orderRef.isEmpty){
            buttonview0.isHidden = false
            buttonview1.isHidden = false
            buttonview2.isHidden = true
            buttonview3.isHidden = true
            buttonview4.isHidden = false
        }
        else{
            buttonview0.isHidden = true
            buttonview1.isHidden = true
            buttonview2.isHidden = true
            buttonview3.isHidden = true
            buttonview4.isHidden = false
        }
        if !(deviceBrand.isEmpty) && !(deviceModel.isEmpty) {
            self.detailLabel.text = "\(deviceBrand)\n\(deviceModel)"
        } else {
            if !(deviceBrand.isEmpty) {
                self.detailLabel.text = deviceBrand
            } else if !(deviceModel.isEmpty) {
                self.detailLabel.text = deviceModel
            }
        }
        if !(userName.isEmpty) {
            self.userNameLabel.text = userName
        } else {
            self.userNameLabel.text = "-"
        }
        if !(deviceBrand.isEmpty) {
            self.brandLabel.text = deviceBrand
        } else {
            self.brandLabel.text = "-"
        }
        if !(deviceModel.isEmpty) {
            self.modelLabel.text = deviceModel
        } else {
            self.modelLabel.text = "-"
        }
        if !(deviceSerialNumber.isEmpty) {
            self.serialNumberLabel.text = deviceSerialNumber
        } else {
            self.serialNumberLabel.text = "-"
        }
        if !(deviceEarPreferenceValue.isEmpty) {
            self.receiverSideLabel.text = deviceEarPreferenceValue
        } else {
            self.receiverSideLabel.text = "-"
        }
        if !(devicePurchasedFromValue.isEmpty) {
            self.purchasedFromLabel.text = devicePurchasedFromValue
        } else {
            self.purchasedFromLabel.text = "-"
        }
        if !(devicePurchasedOn.isEmpty) {
            self.purchasedOnLabel.text = devicePurchasedOn
        } else {
            self.purchasedOnLabel.text = "-"
        }
        if !(deviceWarrantyDetailsValue.isEmpty) {
            self.warrantyDetailLabel.text = deviceWarrantyDetailsValue
        } else {
            self.warrantyDetailLabel.text = "-"
        }
        if !(deviceLastServiceDate.isEmpty) {
            self.lastServiceDateLabel.text = deviceLastServiceDate
        } else {
            self.lastServiceDateLabel.text = "-"
        }
        if !(deviceNextServiceDate.isEmpty) {
            self.nextServiceDateLabel.text = deviceNextServiceDate
        } else {
            self.nextServiceDateLabel.text = "-"
        }
        if !(remarks.isEmpty) {
            self.remarkLabel.text = remarks
        } else {
            self.remarkLabel.text = "-"
        }
        let regularFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_blue_112F70, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let warrentyregularColorFontAttributes = [NSAttributedString.Key.foregroundColor: warrantyEndsOnDaysColor, NSAttributedString.Key.font: AppFont.regular.size(13)]
        let exwarrentyregularColorFontAttributes = [NSAttributedString.Key.foregroundColor: extendedWarrantyEndsOnDaysColor, NSAttributedString.Key.font: AppFont.regular.size(13)]

        if !(warrantyEndsOnDays.isEmpty) || !(deviceWarrantyExpiresOn.isEmpty) {
            if !(deviceWarrantyExpiresOn.isEmpty) && !(warrantyEndsOnDays.isEmpty) {
                let part1 = NSMutableAttributedString(string: String(format: "%@ ", deviceWarrantyExpiresOn), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
                let part2 = NSMutableAttributedString(string: String(format: "(%@)", warrantyEndsOnDays), attributes: warrentyregularColorFontAttributes as [NSAttributedString.Key: Any])
                let combination = NSMutableAttributedString()
                combination.append(part1)
                combination.append(part2)
                self.warrantyEndsLabel.attributedText = combination

            } else {
                if !(deviceWarrantyExpiresOn.isEmpty) {
                    let part1 = NSMutableAttributedString(string: String(format: "%@", deviceWarrantyExpiresOn), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
                    let combination = NSMutableAttributedString()
                    combination.append(part1)
                    self.warrantyEndsLabel.attributedText = combination
                } else if !(warrantyEndsOnDays.isEmpty) {
                    let part1 = NSMutableAttributedString(string: String(format: "%@", warrantyEndsOnDays), attributes: warrentyregularColorFontAttributes as [NSAttributedString.Key: Any])
                    let combination = NSMutableAttributedString()
                    combination.append(part1)
                    self.warrantyEndsLabel.attributedText = combination
                } else {
                    self.warrantyEndsLabel.text = "-"
                }
            }
        } else {
            self.warrantyEndsLabel.text = "-"
        }

        if !(deviceExtendedWarrantyEndOn.isEmpty) || !(extendedWarrantyEndsOnDays.isEmpty) {
            if !(deviceExtendedWarrantyEndOn.isEmpty) && !(extendedWarrantyEndsOnDays.isEmpty) {
                let part1 = NSMutableAttributedString(string: String(format: "%@ ", deviceExtendedWarrantyEndOn), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
                let part2 = NSMutableAttributedString(string: String(format: "(%@)", extendedWarrantyEndsOnDays), attributes: exwarrentyregularColorFontAttributes as [NSAttributedString.Key: Any])
                let combination = NSMutableAttributedString()
                combination.append(part1)
                combination.append(part2)
                self.exWarrantyEndsLabel.attributedText = combination
            } else {
                if !(deviceExtendedWarrantyEndOn.isEmpty) {
                    let part1 = NSMutableAttributedString(string: String(format: "%@", deviceExtendedWarrantyEndOn), attributes: regularFontAttributes as [NSAttributedString.Key: Any])
                    let combination = NSMutableAttributedString()
                    combination.append(part1)
                    self.exWarrantyEndsLabel.attributedText = combination
                } else if !(extendedWarrantyEndsOnDays.isEmpty) {
                    let part1 = NSMutableAttributedString(string: String(format: "%@", extendedWarrantyEndsOnDays), attributes: exwarrentyregularColorFontAttributes as [NSAttributedString.Key: Any])
                    let combination = NSMutableAttributedString()
                    combination.append(part1)
                    self.exWarrantyEndsLabel.attributedText = combination
                } else {
                    self.exWarrantyEndsLabel.text = "-"
                }
            }
        } else {
            self.exWarrantyEndsLabel.text = "-"
        }

        var bannerHeight: CGFloat = 0

        if canTakeSurvey == true {
            bannerHeight = screenFrameWidth * CGFloat(111/375.0)
            let buttonWidth = (AppConstantValue.screenWidthminus32 - (16 * 3)) / 2
            self.takeSurveyButtonWidth.constant = buttonWidth
            self.requestServiceButtonWidth.constant = buttonWidth
            self.surveyImageHeight.constant = bannerHeight
        } else {
            let buttonWidth = AppConstantValue.screenWidthminus32
            self.takeSurveyButtonWidth.constant = 0
            self.requestServiceButtonWidth.constant = buttonWidth
            self.surveyImageHeight.constant = bannerHeight
        }

        if selectedIndex == id {
            view1.isHidden = false
            self.arrowImageView.image = UIImage(named: Asset.chevrondowngreydark)
            var remarksHeight: CGFloat = 0
            if remarks.isEmpty {
                remarksHeight = 8 /*top padding*/ + self.heightForText(text: AppLocalizationString.remarks, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - 32) + 2 /*space*/ + 19 + 8 /*bottom padding*/
                remarksview13.isHidden = true

            } else {
                remarksHeight = 8 /*top padding*/ + self.heightForText(text: AppLocalizationString.remarks, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - 32) + 2 /*space*/ + self.heightForText(text: remarks, Font: AppFont.regular.size(13), Width: AppConstantValue.screenWidthminus32 - 32) + 8 /*bottom padding*/
                remarksview13.isHidden = false

            }
            self.remarkViewHeight.constant = remarksHeight
            
            var cmvideoHeight: CGFloat = 0
            
            if deviceCMVideo.isEmpty {
                cmvideoHeight = 0
                cmvideoview14.isHidden = true
            } else {
                cmvideoHeight = 8 /*top padding*/ + self.heightForText(text: AppLocalizationString.careambermaintenancevideo, Font: AppFont.medium.size(13), Width: AppConstantValue.screenWidthminus32 - 32) + 8 /*space*/ + CGFloat(AppConstantValue.screenWidthminus32 - 32) * CGFloat(AppConstantValue.screen206slash375) + 8 /*bottom padding*/
                cmvideoview14.isHidden = false
                self.youTubePlayerView.loadVideoID("\(deviceCMVideo)")
            }
            self.playerViewHeight.constant = cmvideoHeight

            if self.productSpecArray.count > 0 {
                self.tableviewHeight.constant = 25 * CGFloat(self.productSpecArray.count)
                self.tableview.tableFooterView = UIView()
                self.tableview.separatorColor = UIColor.clear
                self.tableview.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
                self.tableview.rowHeight = UITableView.automaticDimension
                self.tableview.estimatedRowHeight = UITableView.automaticDimension
                self.tableview.delegate = self
                self.tableview.dataSource = self
                self.tableview.reloadData()
                self.tableviewHeight.constant = (33 * CGFloat(self.productSpecArray.count))
                
                if cmvideoHeight > 0 {
                    viewCon.selectedIndexHeight = (33 * CGFloat(self.productSpecArray.count)) + CGFloat(33 * 12)/*device info*/ + 16/*top and bottom padding*/ + bannerHeight/* request query */ + 54/* stackbutton 1*/ + 54/* stack button 2*/ + 16 + remarksHeight/*remarksHeight*/ + 16/*top and bottom padding*/ + cmvideoHeight/*cmvideoHeight*/ + 10/*Adjustment*/
                }
                else{
                    viewCon.selectedIndexHeight = (33 * CGFloat(self.productSpecArray.count)) + CGFloat(33 * 12)/*device info*/ + 16/*top and bottom padding*/ + bannerHeight/* request query */ + 54/* stackbutton 1*/ + 54/* stack button 2*/ + 16 + remarksHeight/*remarksHeight*/ + 10/*Adjustment*/
                }
                viewCon.view.layer.layoutIfNeeded()
                viewCon.view.layoutSubviews()
                viewCon.viewWillLayoutSubviews()
            } else {
                if cmvideoHeight > 0 {
                    viewCon.selectedIndexHeight = CGFloat(33 * 12)/*device info*/ + 16/*top and bottom padding*/ + bannerHeight/* request query */ + 54/* stackbutton 1*/ + 54/* stack button 2*/ + 16 + remarksHeight/*remarksHeight*/+ 16/*top and bottom padding*/ + cmvideoHeight/*cmvideoHeight*/
                }
                else{
                    viewCon.selectedIndexHeight = CGFloat(33 * 12)/*device info*/ + 16/*top and bottom padding*/ + bannerHeight/* request query */ + 54/* stackbutton 1*/ + 54/* stack button 2*/ + 16 + remarksHeight/*remarksHeight*/
                }
                viewCon.view.layer.layoutIfNeeded()
                viewCon.view.layoutSubviews()
                viewCon.viewWillLayoutSubviews()
            }
        } else {
            view1.isHidden = true
            self.tableviewHeight.constant = 0
        }
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedRegisterDeviceTableViewCell(senderTag: sender.tag)
    }
    @IBAction func requestServiceButtonPressed(_ sender: UIButton) {
        self.delegate?.requestServiceButtonPressedRegisterDeviceTableViewCell(senderTag: sender.tag)
    }
    @IBAction func takeSurveyButtonPressed(_ sender: UIButton) {
        self.delegate?.takeSurveyButtonPressedRegisterDeviceTableViewCell(senderTag: sender.tag)
    }
    @IBAction func removeButtonPressed(_ sender: UIButton) {
        self.delegate?.removeButtonPressedRegisterDeviceTableViewCell(senderTag: sender.tag)
    }
    @IBAction func editButtonPressed(_ sender: UIButton) {
        self.delegate?.editButtonPressedRegisterDeviceTableViewCell(senderTag: sender.tag)
    }
    @IBAction func buybackButtonPressed(_ sender: UIButton) {
        self.delegate?.buybackButtonPressedRegisterDeviceTableViewCell(senderTag: sender.tag)
    }
}
extension RegisterDeviceTableViewCell: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productSpecArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.RegisterDeviceSpecificationsTableViewCell, for: indexPath) as! RegisterDeviceSpecificationsTableViewCell
        cell.configure(spec: self.productSpecArray[indexPath.row], indexPath: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.productSpecArray.count > 0 {
            self.tableviewHeight.constant = (33 * CGFloat(self.productSpecArray.count))
        }
    }
}
