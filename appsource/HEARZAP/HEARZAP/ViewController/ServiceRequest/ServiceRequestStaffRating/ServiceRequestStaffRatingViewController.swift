//
//  ServiceRequestStaffRatingViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 07/04/23.
//  Copyright © 2023 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import BottomPopup
import Cosmos

protocol ProtocolServiceRequestStaffRatingViewController {
    func postButtonPressedServiceRequestStaffRatingViewController()
}

class ServiceRequestStaffRatingViewController: UIViewController, UITextViewDelegate {

    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var staffNameLabel: CalloutFontLabel!
    @IBOutlet var staffExperienceLabel: FootnoteFontLabel!
    @IBOutlet var staffSpecializationLabel: FootnoteFontLabel!
    @IBOutlet var staffImageView: UIImageView!

    @IBOutlet var ratingTitleLabel: FootnoteFontLabel!
    @IBOutlet var ratingView: CosmosView!

    @IBOutlet var reviewTitleLabel: FootnoteFontLabel!
    @IBOutlet var reviewTextView: MDFloatingTextView!
    @IBOutlet var reviewwordsLabel: Caption2FontLabel!

    @IBOutlet var postButton: FootnoteBackgroundButton!

    // MARK: - Lets and Var
    var serviceRequestStaffRatingViewModel = ServiceRequestStaffRatingViewModel()

    var activeField = UITextView()
    var rating = 0
    var staffName = ""
    var staffExperience = ""
    var staffSpecialization = ""
    var imageurl = ""
    var bookingUid = ""
    var isStaff = false
    var staffid = ""

    var delegate: ProtocolServiceRequestStaffRatingViewController!

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
        UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()

        self.staffNameLabel.text = staffName
        self.staffExperienceLabel.text = staffExperience
        self.staffSpecializationLabel.text = staffSpecialization

        self.staffImageView.setImage(imageUrl: imageurl, placeHolderImage: profileBlue)

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
    }
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
        self.navigationBar.leftImage = Asset.arrowleftwhite
        self.navigationBar.rightImage = ""
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.reviewStaff
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_blue_112F70,titleTextColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.ratingTitleLabel.text = AppLocalizationString.rateourStaff
        self.reviewTitleLabel.text = AppLocalizationString.describeyourexperienceoptional
        self.reviewTextView.titleText = AppLocalizationString.shareyourexperiencedot
        self.reviewTextView.placeholderText = AppLocalizationString.shareyourexperiencedot
        self.postButton.setTitle(AppLocalizationString.submit.uppercased(), for: .normal)
        self.reviewwordsLabel.text = AppLocalizationString.reviewWord
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.postAudiologistRating(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }

    func postAudiologistRating(retryAPIID: Int, canShowLoader: Bool) {
        let url = "\(SubAPIUrl.postAudiologistRating)\(self.bookingUid)/\(self.staffid)/"
        let review = self.reviewTextView.text?.allowSpecialCharacters ?? ""
        var param = ""
        param = String(format: "rating=%d&review=%@", self.rating, review)
        self.serviceRequestStaffRatingViewModel.postAudiologistRating(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: url, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
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
                self.delegate.postButtonPressedServiceRequestStaffRatingViewController()
                self.navigateBackToViewController()
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

extension ServiceRequestStaffRatingViewController: ProtocolNetworkRechabilityDelegate {
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
extension ServiceRequestStaffRatingViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {}
}
