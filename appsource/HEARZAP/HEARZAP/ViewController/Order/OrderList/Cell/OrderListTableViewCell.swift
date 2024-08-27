//
//  OrderListTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 09/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolOrderListTableViewCell {
    func tapButtonPressedOrderListTableViewCell(senderTag: Int)

}
class OrderListTableViewCell: UITableViewCell {

    @IBOutlet var stackview: UIStackView!
    @IBOutlet var bookingTypeLabel: SubheadFontLabel!
    @IBOutlet var bookingIDLabel: FootnoteFontLabel!
    @IBOutlet var bookingStatusLabel: Caption1FontLabel!
    @IBOutlet var tapButton: FootnoteOutlineButton!

    var delegate: ProtocolOrderListTableViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(order: OrderList, indexpath: Int) {
        self.tapButton.tag = indexpath
        self.bookingTypeLabel.text = ""

        var orderNumber = ""
        var statusCode = ""
        var statusName = ""
        var orderDate = ""
        var statusTextColor: UIColor = UIColor.colorLiteral.theme_blue_2AACEF
        var statusBgColor: UIColor = UIColor.colorLiteral.theme_white_FFFFFF

        //        let orderNumber, orderDate, statusName, statusCode: String
        //        let statusTextColor, statusBgColor: String
        //        "order_number": "HZ-ORDER-0044",
        //        "order_date": "Mar 31, 2023",
        //        "status_name": "Ordered",
        //        "status_code": "ORDER_PLACED",
        //        "status_text_color": "#2AACEF",
        //        "status_bg_color": "#E7F4FF"

        if !(order.orderNumber.isNilOrEmpty) {
            orderNumber = order.orderNumber!
        }
        if !(order.statusName.isNilOrEmpty) {
            statusName = order.statusName!.capitalized
        }
        if !(order.statusCode.isNilOrEmpty) {
            statusCode = order.statusCode!
        }
        if !(order.orderDate.isNilOrEmpty) {
            orderDate = order.orderDate!.capitalized
        }
        if !(order.statusBgColor.isNilOrEmpty) {
            statusBgColor = UIColor(hexString: order.statusBgColor!, alpha: 1.0)
        }
        if !(order.statusTextColor.isNilOrEmpty) {
            statusTextColor = UIColor(hexString: order.statusTextColor!, alpha: 1.0)
        }
        // title processing

        if !(statusName.isEmpty) {
            self.bookingTypeLabel.text  = "Order"
        }
        if !(orderNumber.isEmpty) {
            self.bookingIDLabel.text  = orderNumber
        }

        // dateandtime processing

        if !(orderDate.isEmpty) && !(statusName.isEmpty) {
            let combination = NSMutableAttributedString()

            let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
            let statusFontAttributes = [NSAttributedString.Key.foregroundColor: statusTextColor, NSAttributedString.Key.font: AppFont.regular.size(13)]

            let date = NSMutableAttributedString(string: String(format: "%@ | ", orderDate), attributes: dateFontAttributes as [NSAttributedString.Key: Any])
            let status = NSMutableAttributedString(string: String(format: "%@", statusName), attributes: statusFontAttributes as [NSAttributedString.Key: Any])

            combination.append(date)
            combination.append(status)
            self.bookingStatusLabel.attributedText = combination
        } else if !(orderDate.isEmpty) {
            let combination = NSMutableAttributedString()

            let dateFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorLiteral.theme_grey_777777, NSAttributedString.Key.font: AppFont.regular.size(13)]
            let date = NSMutableAttributedString(string: String(format: "%@", orderDate), attributes: dateFontAttributes as [NSAttributedString.Key: Any])

            combination.append(date)
            self.bookingStatusLabel.attributedText = combination
        }

    }
    @IBAction func tapButtonPressed(_ sender: UIButton) {
        self.delegate?.tapButtonPressedOrderListTableViewCell(senderTag: sender.tag)
    }

}
