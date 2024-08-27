//
//  HearingCareCardTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 22/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolHearingCareCardTableViewCell {
    func cardButtonPressedHearingCareCardTableViewCell(senderTag: Int)
}

class HearingCareCardTableViewCell: UITableViewCell {
    
    @IBOutlet var bannerImage: UIImageView!
    @IBOutlet var cardTitleLabel: CalloutFontLabel!
    @IBOutlet var cardDescriptionlabel: Caption1FontLabel!
    @IBOutlet var cardButton: FootnoteBackgroundButton!
    @IBOutlet var cardfullButton: FootnoteBackgroundButton!
    
    var delegate: ProtocolHearingCareCardTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    public func configure(card: HearingcareModelService, indexpath: Int) {
        var serviceName = ""
        var serviceDesc = ""
        var servicePosterPhoto = ""
        var buttonData = ""
        self.cardButton.tag = indexpath
        self.cardfullButton.tag = indexpath
        
        if !(card.buttonData.isNilOrEmpty) {
            buttonData = card.buttonData!
        }
        if card.data != nil {
            if !(card.data!.serviceName.isNilOrEmpty) {
                serviceName = card.data!.serviceName!
            }
            if !(card.data!.serviceDesc.isNilOrEmpty) {
                serviceDesc = card.data!.serviceDesc!
            }
            if !(card.data!.serviceDesc.isNilOrEmpty) {
                servicePosterPhoto = card.data!.servicePosterPhoto!
            }
        }
        
        self.cardTitleLabel.text = serviceName.capitalized
        self.cardDescriptionlabel.text = serviceDesc.capitalized
        self.bannerImage.setImage(imageUrl: servicePosterPhoto, placeHolderImage: hearzapPlaceholder)
        self.cardButton.setTitle(buttonData.uppercased(), for: .normal)
        
    }
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        self.delegate?.cardButtonPressedHearingCareCardTableViewCell(senderTag: sender.tag)
    }
}
