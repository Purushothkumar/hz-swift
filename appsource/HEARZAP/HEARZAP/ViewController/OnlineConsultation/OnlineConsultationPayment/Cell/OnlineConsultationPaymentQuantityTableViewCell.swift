//
//  OnlineConsultationPaymentQuantityTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 28/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

class OnlineConsultationPaymentQuantityTableViewCell: UITableViewCell {

    @IBOutlet var serviceDetailsQtyTitleLabel: Caption1FontLabel!
    @IBOutlet var serviceDetailsQtyDescLabel: Caption1FontLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configure(serviceRequestsList: ServiceRequestsList, indexpath: Int) {
        var name = ""
        var qty = ""

        if !(serviceRequestsList.name.isNilOrEmpty) {
            name = serviceRequestsList.name!.capitalized
        }
        if serviceRequestsList.qty != nil {
            qty = String(format: "%@ %d", AppLocalizationString.qty, serviceRequestsList.qty!)
        }

        self.serviceDetailsQtyTitleLabel.text = name
        self.serviceDetailsQtyDescLabel.text = qty
    }
}
