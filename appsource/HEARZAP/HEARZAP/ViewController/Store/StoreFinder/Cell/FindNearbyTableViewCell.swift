//
//  FindNearbyTableViewCell.swift
//  HEARZAP
//
//  Created by Purushoth on 27/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit

protocol ProtocolFindNearbyTableViewCell {
    func viewStoreButtonPressedFindNearbyTableViewCell(senderTag: Int)
}
class FindNearbyTableViewCell: UITableViewCell {
    
    @IBOutlet var viewStoreButton: CalloutOutlineButton!
    @IBOutlet var stateLabel: CalloutFontLabel!
    @IBOutlet var stateCountLabel: FootnoteFontLabel!
    
    var delegate: ProtocolFindNearbyTableViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func configure(storeFinderModelStateList: StoreFinderModelStateList, indexpath: Int) {
        self.viewStoreButton.tag = indexpath
        var storecount = ""
        var name = ""
        if storeFinderModelStateList.storeCount != nil {
            if storeFinderModelStateList.storeCount! > 0 {
                if storeFinderModelStateList.storeCount! > 1 {
                    storecount = "\(String(describing: storeFinderModelStateList.storeCount!)) Stores"
                } else {
                    storecount = "\(String(describing: storeFinderModelStateList.storeCount!)) Store"
                }
            } else {
                storecount = "\(String(describing: storeFinderModelStateList.storeCount!)) Store"
            }
        }
        if !(storeFinderModelStateList.name.isNilOrEmpty) {
            name = "\(String(describing: storeFinderModelStateList.name!.capitalized))"
        }
        self.stateLabel.text = name.uppercased()
        self.stateCountLabel.text = storecount
    }
    @IBAction func viewStoreButtonPressed(_ sender: UIButton) {
        self.delegate?.viewStoreButtonPressedFindNearbyTableViewCell(senderTag: sender.tag)
    }
}
