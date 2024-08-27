//
//  StoreReviewViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 31/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Cosmos

class StoreReviewViewController: UIViewController, UITextViewDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var storeNameLabel: CalloutFontLabel!
    
    @IBOutlet var storeAddressLabel: FootnoteFontLabel!
    
    @IBOutlet var ratingTitleLabel: FootnoteFontLabel!
    @IBOutlet var ratingView: CosmosView!
    
    @IBOutlet var reviewTitleLabel: FootnoteFontLabel!
    @IBOutlet var reviewTextView: MDFloatingTextView!
    @IBOutlet var reviewwordsLabel: Caption2FontLabel!
    
    @IBOutlet var postButton: FootnoteBackgroundButton!
    
    // MARK: - Lets and Var
    let storeReviewViewModel = StoreReviewViewModel()
    var activeField = UITextView()
    var rating = 0
    var slug = ""
    var storeName = ""
    var storeAddress = ""
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.setNavigationBar()
    }
    override func viewWillLayoutSubviews() {
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    // MARK: -  Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_blue_112F70,style: StatusBarTheme.lightContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: - Set Initial View
    func setInitialView() {
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        
        self.storeNameLabel.text = storeName
        self.storeAddressLabel.text = storeAddress
        
        self.reviewTextView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.reviewTextView.clipsToBounds = true
        self.reviewTextView.backgroundColor = UIColor.colorLiteral.theme_white_F6FAFD
        self.reviewTextView.layer.borderColor = UIColor.colorLiteral.theme_white_F2F2F2.cgColor
        self.reviewTextView.layer.borderWidth = 1
        self.reviewTextView.delegate = self
        self.reviewTextView.textContainerInset = UIEdgeInsets(top: 15, left: 8, bottom: 10, right: 8)
        self.reviewTextView.font = AppFont.regular.size(13.0)
        self.reviewTextView.placeholderFont = AppFont.regular.size(13)
        self.reviewTextView.titleFont = AppFont.regular.size(11)
        self.reviewTextView.titleColor = UIColor.colorLiteral.theme_grey_777777
        self.reviewTextView.placeholderColor = UIColor.colorLiteral.theme_grey_777777
        self.reviewTextView.awakeFromNib()
        self.ratingView.didTouchCosmos = didTouchCosmos(_:)
        self.ratingView.didFinishTouchingCosmos = didFinishTouchingCosmos(_:)
        self.setUserInteractionPostButton()
        self.commonAPICALL(retryAPIID: 1001)
        
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.reviewStore
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.ratingTitleLabel.text = AppLocalizationString.howwasyourexperience
        self.reviewTitleLabel.text = AppLocalizationString.describeyourexperienceoptional
        self.reviewTextView.titleText = AppLocalizationString.sharedetailsofyourownexperienceatthisplace
        self.reviewTextView.placeholderText = AppLocalizationString.sharedetailsofyourownexperienceatthisplace
        self.postButton.setTitle(AppLocalizationString.submit.uppercased(), for: .normal)
        self.reviewwordsLabel.text = AppLocalizationString.reviewWord
    }
    
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.postStoreReview(retryAPIID: retryAPIID, canShowLoader: true)
                } else if retryAPIID == 1001 {
                    self.getStoreReview(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getStoreReview(retryAPIID: Int, canShowLoader: Bool) {
        let suburl = "\(SubAPIUrl.getStoreReview)\(self.slug)/"
        self.storeReviewViewModel.getStoreReview(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: suburl, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postStoreReview(retryAPIID: Int, canShowLoader: Bool) {
        let review = self.reviewTextView.text?.allowSpecialCharacters ?? ""
        var param = ""
        param = String(format: "rating=%d&review=%@&store_slug=%@", self.rating, review, self.slug)
        self.storeReviewViewModel.postStoreReview(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getStoreReview, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func postButtonPressed(_ sender: UIButton) {
        self.commonAPICALL(retryAPIID: 1000)
    }
    
    // MARK: - Custom Methods
    func setUserInteractionPostButton() {
        DispatchQueue.main.async {
            if self.rating > 0 {
                self.setButtonEnable()
            } else {
                self.setButtonDisable()
            }
        }
    }
    func setButtonDisable() {
        self.postButton.isUserInteractionEnabled = false
        self.postButton.backgroundColor = UIColor.colorLiteral.theme_blue_DCF3FF
        self.postButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.postButton.setNeedsDisplay()
        self.postButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func setButtonEnable() {
        self.postButton.isUserInteractionEnabled = true
        self.postButton.backgroundColor = UIColor.colorLiteral.theme_blue_2AACEF
        self.postButton.setTitleColor(UIColor.colorLiteral.theme_white_FFFFFF, for: .normal)
        self.postButton.setNeedsDisplay()
        self.postButton.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func postButtonAlert() {
        self.view.endEditing(true)
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: AppLocalizationString.thanksforyourfeedback, message: "", preferredStyle: .alert)
            let okbtn = UIAlertAction(title: AppLocalizationString.ok.uppercased(), style: .default, handler: { (_) in
                self.navigateBackToStoreDetailViewController()
            })
            alertViewController.addAction(okbtn)
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    // MARK: - Cosmos Delegate
    private func didTouchCosmos(_ rating: Double) {
        self.rating = Int(rating)
        self.setUserInteractionPostButton()
    }
    private func didFinishTouchingCosmos(_ rating: Double) {
        self.rating = Int(rating)
        self.setUserInteractionPostButton()
    }
    
    // MARK: - Textfield Delegate
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location == 0 && (text == " ") {
            return false
        } else if range.location == 0 && (text == "\n") {
            return false
        }
        return textView.text.count + (text.count - range.length) <= 250
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.setUserInteractionPostButton()
    }
    func textViewDidChange(_ textView: UITextView) {
        self.setUserInteractionPostButton()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeField.resignFirstResponder()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        activeField = textView
    }
}
extension StoreReviewViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
extension StoreReviewViewController: ProtocolNetworkRechabilityDelegate {
    // MARK: - InternetError
    func showInternetPopupScreen(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Common, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.NetworkRechabilityViewController) as! NetworkRechabilityViewController
            viewCon.retryAPIID = retryAPIID
            viewCon.protocolNetworkRechabilityDelegate = self
            viewCon.modalPresentationStyle = .fullScreen
            viewCon.modalTransitionStyle = .coverVertical
            self.present(viewCon, animated: true, completion: nil)
        }
    }
    // MARK: - NetworkRechabilityDelegate
    func tryAgainWithID(retryAPIID: Int) {
        self.commonAPICALL(retryAPIID: retryAPIID)
    }
}
