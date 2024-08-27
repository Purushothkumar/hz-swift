//
//  FindRightDeviceReportTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 19/07/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolFindRightDeviceReportTableViewCell {
    func tapButtonPressedFindRightDeviceReportTableViewCell(senderTag: Int)
    func viewReportButtonPressedFindRightDeviceReportTableViewCell(senderTag: Int)
    
}

class FindRightDeviceReportTableViewCell: UITableViewCell {
    @IBOutlet var mainStackview: UIStackView!
    @IBOutlet var reportStackview: UIStackView!
    @IBOutlet var titleLabel: FootnoteFontLabel!
    @IBOutlet var userLabel: SubheadFontLabel!
    @IBOutlet var descLabel: Caption1FontLabel!
    @IBOutlet var reportDateLabel: Caption1FontLabel!
    @IBOutlet var selectButton: FootnoteOutlineButton!
    @IBOutlet var tapButton: FootnoteOutlineButton!
    @IBOutlet var viewReportButton: FootnoteOutlineButton!
    
    var delegate: ProtocolFindRightDeviceReportTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(audiogramTestReport: FindRightDeviceReportModelAudiogramTestReport, indexPath: Int, viewCon: FindRightDeviceUploadReportViewController) {
        self.titleLabel.text = AppLocalizationString.selectHearingTestReport
        self.viewReportButton.setTitle(AppLocalizationString.viewReport, for: .normal)
        
        var patientName = ""
        var reportName = ""
        var reportDate = ""
        
        self.selectButton.tag = indexPath
        self.viewReportButton.tag = indexPath
        self.tapButton.tag = indexPath
        self.selectButton.setImage(UIImage(named: Asset.circlegrey), for: .normal)
        var indexpathReportID = ""
        let view0 = self.mainStackview.arrangedSubviews[0]// title
        let view1 = self.mainStackview.arrangedSubviews[1]// report
        view0.isHidden = true
        view1.isHidden = false
        
        self.reportStackview.clipsToBounds = true
        self.reportStackview.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.reportStackview.layer.borderColor = UIColor.colorLiteral.theme_grey_DCDCDD.cgColor
        self.reportStackview.layer.borderWidth = 1.0
        self.reportStackview.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        
        if indexPath == 0 {
            view0.isHidden = false
        }
        //        if !(audiogramTestReport.sessionUid.isNilOrEmpty){
        //            indexpathSessionID = audiogramTestReport.sessionUid!
        //        }
        if !(audiogramTestReport.sessionUid.isNilOrEmpty) {
            indexpathReportID = audiogramTestReport.sessionUid!
        }
        if !(audiogramTestReport.patientName.isNilOrEmpty) {
            patientName = audiogramTestReport.patientName!
        }
        if !(audiogramTestReport.reportName.isNilOrEmpty) {
            reportName = audiogramTestReport.reportName!
        }
        if !(audiogramTestReport.reportDate.isNilOrEmpty) {
            reportDate = audiogramTestReport.reportDate!
        }
        self.descLabel.text = reportName
        self.userLabel.text = patientName
        self.reportDateLabel.text = reportDate
        if viewCon.sessionUID == indexpathReportID {
            self.reportStackview.layer.borderColor = UIColor.colorLiteral.theme_blue_2AACEF.cgColor
            self.selectButton.setImage(UIImage(named: Asset.circlelightbluethick), for: .normal)
            self.reportStackview.backgroundColor = UIColor.colorLiteral.theme_blue_E7F4FF
        }
    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedFindRightDeviceReportTableViewCell(senderTag: sender.tag)
    }
    @IBAction func viewReportButtonPressed(_ sender: UIButton) {
        self.delegate?.viewReportButtonPressedFindRightDeviceReportTableViewCell(senderTag: sender.tag)
    }
}
