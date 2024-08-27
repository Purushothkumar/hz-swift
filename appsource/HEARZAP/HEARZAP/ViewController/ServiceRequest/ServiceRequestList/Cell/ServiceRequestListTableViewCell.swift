//
//  ServiceRequestListTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 30/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
protocol ProtocolServiceRequestListTableViewCell {
    func tapButtonPressedServiceRequestListTableViewCell(senderTag: Int)

}
class ServiceRequestListTableViewCell: UITableViewCell {

    @IBOutlet var stackview: UIStackView!
    @IBOutlet var bookingTypeLabel: SubheadFontLabel!
    @IBOutlet var bookingIDLabel: FootnoteFontLabel!
    @IBOutlet var bookingStatusLabel: Caption1FontLabel!
    @IBOutlet var tapButton: FootnoteOutlineButton!

    var delegate: ProtocolServiceRequestListTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(bookingList: BookingListElement, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.bookingTypeLabel.text = ""

        var bookingUid = ""
        var bookingTypeName = ""
        var bookingTypeCode = ""
        var serviceDate = ""
        var serviceStartTime = ""
        var serviceEndTime = ""
        var bookingStatusCode = ""
        var bookingStatusName = ""
        var bookingStatusColorCode: UIColor = UIColor.colorLiteral.theme_blue_2AACEF

        if !(bookingList.bookingUid.isNilOrEmpty) {
            bookingUid = bookingList.bookingUid!
        }
        if !(bookingList.bookingTypeName.isNilOrEmpty) {
            bookingTypeName = bookingList.bookingTypeName!.capitalized
        }
        if !(bookingList.bookingTypeCode.isNilOrEmpty) {
            bookingTypeCode = bookingList.bookingTypeCode!
        }
        if !(bookingList.serviceDate.isNilOrEmpty) {
            serviceDate = bookingList.serviceDate!.capitalized
        }
        if !(bookingList.serviceStartTime.isNilOrEmpty) {
            serviceStartTime = bookingList.serviceStartTime!.lowercased()
        }
        if !(bookingList.serviceEndTime.isNilOrEmpty) {
            serviceEndTime = bookingList.serviceEndTime!.lowercased()
        }
        if !(bookingList.bookingStatusCode.isNilOrEmpty) {
            bookingStatusCode = bookingList.bookingStatusCode!
        }
        if !(bookingList.bookingStatusName.isNilOrEmpty) {
            bookingStatusName = bookingList.bookingStatusName!.capitalized
        }
        if !(bookingList.bookingStatusColorCode.isNilOrEmpty) {
            bookingStatusColorCode = UIColor(hexString: bookingList.bookingStatusColorCode!, alpha: 1.0)
        }

        // title processing
        //        if !(bookingTypeName.isEmpty) && !(bookingUid.isEmpty){
        //            self.bookingIDLabel.text = "\(bookingTypeName) - (\(bookingUid))"
        //        }
        //        else if !(bookingTypeName.isEmpty) || !(bookingUid.isEmpty){
        //            if !(bookingTypeName.isEmpty) {
        //                self.bookingIDLabel.text  = bookingTypeName
        //            }
        //            else if !(bookingUid.isEmpty){
        //                self.bookingIDLabel.text  = bookingUid
        //            }
        //        }

        if !(bookingTypeName.isEmpty) {
            self.bookingTypeLabel.text  = bookingTypeName
        }
        if !(bookingUid.isEmpty) {
            self.bookingIDLabel.text  = bookingUid
        }

        // dateandtime processing
        var dateandtime = serviceDate

        if !(serviceDate.isEmpty) && !(serviceStartTime.isEmpty) {
            dateandtime = "\(serviceDate), \(serviceStartTime)"
        } else {
            dateandtime = serviceStartTime
        }

        if !(dateandtime.isEmpty) && !(bookingStatusName.isEmpty) {
            let combination = NSMutableAttributedString()

            let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
            let statusFontAttributes = [NSAttributedString.Key.foregroundColor: bookingStatusColorCode, NSAttributedString.Key.font: AppFont.regular.size(13)]

            let date = NSMutableAttributedString(string: String(format: "%@ | ", dateandtime), attributes: dateFontAttributes as [NSAttributedString.Key: Any])
            let status = NSMutableAttributedString(string: String(format: "%@", bookingStatusName), attributes: statusFontAttributes as [NSAttributedString.Key: Any])

            combination.append(date)
            combination.append(status)
            self.bookingStatusLabel.attributedText = combination
        } else if !(dateandtime.isEmpty) {
            let combination = NSMutableAttributedString()

            let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
            let date = NSMutableAttributedString(string: String(format: "%@", dateandtime), attributes: dateFontAttributes as [NSAttributedString.Key: Any])

            combination.append(date)
            self.bookingStatusLabel.attributedText = combination
        }

    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedServiceRequestListTableViewCell(senderTag: sender.tag)
    }

}
