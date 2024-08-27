//
//  BottomSheetProductDetailViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 07/11/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup

class BottomSheetProductDetailViewController: BottomPopupViewController {

    @IBOutlet var productInformationTableView: UITableView!
    @IBOutlet var addToCartButton: BackgroundButton!

    // var productInformationArray = []()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: - Reload
    func reloadProductAccessoriesTableView() {
        self.productInformationTableView.tableFooterView = UIView()
        //        self.productAccessoriesTableView.separatorColor = UIColor.clear
        self.productInformationTableView.backgroundColor = UIColor.clear
        self.productInformationTableView.rowHeight = UITableView.automaticDimension
        self.productInformationTableView.estimatedRowHeight = UITableView.automaticDimension
        //        self.productInformationTableView.delegate = self
        //        self.productInformationTableView.dataSource = self
        //        self.productInformationTableView.reloadData()
    }

    // MARK: - IBAction
    @IBAction func productAddtoBagButtonPressed(_ sender: UIButton) {}

}

/*
 extension BottomSheetProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
 // MARK: - TableView Delegate
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return self.productInformationArray.count
 }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
 if tableView == self.productFeatureTableView {
 let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductDetailFeatureTableViewCell, for: indexPath) as! ProductDetailFeatureTableViewCell
 cell.configure(productFeature: self.productFeatureArray[indexPath.row], indexpath: indexPath.row)
 return cell
 }  else {
 let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.ProductDetailBoxTableViewCell, for: indexPath) as! ProductDetailBoxTableViewCell
 cell.configure(productBox: self.productBoxArray[indexPath.row], indexpath: indexPath.row)
 return cell
 }
 }
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 return UITableView.automaticDimension
 }
 func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
 return UITableView.automaticDimension
 }
 
 }
 */
