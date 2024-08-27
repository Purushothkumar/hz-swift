//
//  StoreCityListCollectionViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 07/03/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolStoreCityListCollectionViewCell {
    func cityButtonPressedStoreCityListCollectionViewCell(senderTag: Int)
}
class StoreCityListCollectionViewCell: UICollectionViewCell {
    @IBOutlet var cityNameLabel: FootnoteFontLabel!
    @IBOutlet var cityButton: CalloutOutlineButton!
    
    var delegate: ProtocolStoreCityListCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    public func configure(cityNames: String, indexpath: Int) {
        self.cityNameLabel.text = ""
        self.cityNameLabel.text = cityNames
        self.cityButton.tag = indexpath
    }
    @IBAction func cityButtonPressed(_ sender: UIButton) {
        self.delegate?.cityButtonPressedStoreCityListCollectionViewCell(senderTag: sender.tag)
    }
}
