//
//  HomeStaticViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 10/04/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import ShimmerEffect_iOS
import DropDown
import IQKeyboardManagerSwift

class HomeStaticViewController: UIViewController,UITextFieldDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: MainLogoNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var quickCardView: UIView!
    @IBOutlet var quickCardStackView: UIStackView!
    
    @IBOutlet var quickCard1View: UIView!
    @IBOutlet var quickCard1ImageView: UIImageView!
    @IBOutlet var quickCard1Button: FootnoteBackgroundButton!
    
    @IBOutlet var quickCard2View: UIView!
    @IBOutlet var quickCard2ImageView: UIImageView!
    @IBOutlet var quickCard2Button: FootnoteBackgroundButton!
    
    @IBOutlet var quickCard3View: UIView!
    @IBOutlet var quickCard3ImageView: UIImageView!
    @IBOutlet var quickCard3Button: FootnoteBackgroundButton!
    
    @IBOutlet var bannerView: UIView!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var bannerButton: FootnoteBackgroundButton!
    
    @IBOutlet var statusView: UIView!
    @IBOutlet var statusStackView: UIStackView!
    @IBOutlet var statusViewHeight: NSLayoutConstraint!
    
    @IBOutlet var statusCard1View: UIView!
    @IBOutlet var statusCard1StackView: UIStackView!
    
    @IBOutlet var statusCard1SubView: UIView!
    @IBOutlet var statusCard1SubImageView: UIImageView!
    
    @IBOutlet var statusCard2SubView: UIView!
    @IBOutlet var statusCard2SubImageView: UIImageView!
    
    @IBOutlet var statusCard3SubView: UIView!
    @IBOutlet var statusCard3SubImageView: UIImageView!
    
    @IBOutlet var statusCard2View: UIView!
    @IBOutlet var statusCard2StackView: UIStackView!
    
    @IBOutlet var statusCard4SubView: UIView!
    @IBOutlet var statusCard4SubImageView: UIImageView!
    
    @IBOutlet var statusCard5SubView: UIView!
    @IBOutlet var statusCard5SubImageView: UIImageView!
    
    @IBOutlet var statusCard6SubView: UIView!
    @IBOutlet var statusCard6SubImageView: UIImageView!
    
    @IBOutlet var queriesView: UIView!
    @IBOutlet var queriesStackView: UIStackView!
    
    @IBOutlet var queriesTitleView: UIView!
    
    @IBOutlet var queriesTitleLabel: Title2FontLabel!
    @IBOutlet var queriesDescLabel: Caption1FontLabel!
    
    @IBOutlet var queriesNameView: UIView!
    @IBOutlet var queriesNameTextField: Caption1FontTextfield!
    
    @IBOutlet var queriesMobileView: UIView!
    @IBOutlet var queriesMobileTextField: Caption1FontTextfield!
    
    @IBOutlet var queriesStateView: UIView!
    @IBOutlet var queriesStateTextField: Caption1FontTextfield!
    @IBOutlet var queriesStateButton: CalloutOutlineButton!
    
    @IBOutlet var queriesAuthoriseView: UIView!
    @IBOutlet var queriesAuthoriseLabel: Caption1FontLabel!
    @IBOutlet var queriesAuthoriseButton: FootnoteOutlineButton!
    
    @IBOutlet var queriesSubmitView: UIView!
    @IBOutlet var queriesSubmitButton: Callout1BackgroundButton!
    
    @IBOutlet var buisnessView: UIView!
    @IBOutlet var buisnessStackView: UIStackView!
    
    @IBOutlet var frdView: UIView!
    @IBOutlet var frdImageView: UIImageView!
    @IBOutlet var frdButton: FootnoteBackgroundButton!
    
    @IBOutlet var shopView: UIView!
    @IBOutlet var shopImageView: UIImageView!
    @IBOutlet var shopButton: FootnoteBackgroundButton!
    
    @IBOutlet var offersView: UIView!
    @IBOutlet var offersImageView: UIImageView!
    @IBOutlet var offersButton: FootnoteBackgroundButton!
    
    @IBOutlet var storeView: UIView!
    @IBOutlet var storeImageView: UIImageView!
    @IBOutlet var storeButton: FootnoteBackgroundButton!
    
    @IBOutlet var ratingTitleView: UIView!
    @IBOutlet var ratingTitleStackView: UIStackView!
    @IBOutlet var customerFeedbackTitleLabel: Title1FontLabel!
    @IBOutlet var customerFeedbackDescLabel: Caption1FontLabel!
    @IBOutlet var homeReviewCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var homeReviewCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var digitalTitleView: UIView!
    @IBOutlet var digitalTitleLabel: Title1FontLabel!
    @IBOutlet var digitalDescLabel: Caption1FontLabel!
    
    @IBOutlet var digitalTitleImageView: UIImageView!
    @IBOutlet var digitalTitleImageViewHeight: NSLayoutConstraint!
    @IBOutlet var digitalView: UIView!
    @IBOutlet var digitalImageView: UIImageView!
    
    @IBOutlet var digitalLinkView: UIView!
    @IBOutlet var digitalLinkStackView: UIStackView!
    @IBOutlet var digitalLinkPlayStoreView: UIView!
    @IBOutlet var digitalLinkPlayStoreImageView: UIImageView!
    @IBOutlet var digitalLinkPlayStoreButton: FootnoteBackgroundButton!
    
    @IBOutlet var digitalLinkAppStoreView: UIView!
    @IBOutlet var digitalLinkAppStoreImageView: UIImageView!
    @IBOutlet var digitalLinkAppStoreButton: FootnoteBackgroundButton!
    
    @IBOutlet var gtHeaderView: UIView!
    @IBOutlet var gtHeaderStackView: UIStackView!
    @IBOutlet var gtHeaderTitleLabel: HeadlineFontLabel!
    @IBOutlet var gtHeaderLabel: Callout1FontLabel!
    @IBOutlet var gtHeaderDescLabel: BodyFontLabel!
    
    @IBOutlet var gtView: UIView!
    @IBOutlet var gtStackView: UIStackView!
    
    @IBOutlet var gtTitleView: UIView!
    
    @IBOutlet var gtTitleLabel: Title2FontLabel!
    @IBOutlet var gtDescLabel: Caption1FontLabel!
    
    @IBOutlet var gtNameView: UIView!
    @IBOutlet var gtNameTextField: Caption1FontTextfield!
    
    @IBOutlet var gtMobileView: UIView!
    @IBOutlet var gtMobileTextField: Caption1FontTextfield!
    
    @IBOutlet var gtStateView: UIView!
    @IBOutlet var gtStateTextField: Caption1FontTextfield!
    @IBOutlet var gtStateButton: CalloutOutlineButton!
    
    @IBOutlet var gtAuthoriseView: UIView!
    @IBOutlet var gtAuthoriseLabel: Caption1FontLabel!
    @IBOutlet var gtAuthoriseButton: FootnoteOutlineButton!
    
    @IBOutlet var gtSubmitView: UIView!
    @IBOutlet var gtSubmitButton: Callout1BackgroundButton!
    
    @IBOutlet var socialMediaView: UIView!
    @IBOutlet var socialMediaStackView: UIStackView!
    @IBOutlet var socialMediaLabel: FootnoteFontLabel!
    @IBOutlet var supportTitleLabel: FootnoteFontLabel!
    @IBOutlet var copyRightsLabel: Caption1FontLabel!
    
    @IBOutlet var socialMediaButtonStackView: UIStackView!
    @IBOutlet var facebookImageView: UIImageView!
    @IBOutlet var facebookButton: FootnoteOutlineButton!
    @IBOutlet var whatsappImageView: UIImageView!
    @IBOutlet var whatsappButton: FootnoteOutlineButton!
    @IBOutlet var instagramImageView: UIImageView!
    @IBOutlet var instagramButton: FootnoteOutlineButton!
    @IBOutlet var youtubeImageView: UIImageView!
    @IBOutlet var youtubeButton: FootnoteOutlineButton!
    @IBOutlet var twitterImageView: UIImageView!
    @IBOutlet var twitterButton: FootnoteOutlineButton!
    
    @IBOutlet var socialLinkView: UIView!
    @IBOutlet var socialLinkStackView: UIStackView!
    @IBOutlet var socialLinkAppStoreView: UIView!
    @IBOutlet var socialLinkAppStoreImageView: UIImageView!
    @IBOutlet var socialLinkAppStoreButton: FootnoteBackgroundButton!
    @IBOutlet var socialLinkPlayStoreView: UIView!
    @IBOutlet var socialLinkPlayStoreImageView: UIImageView!
    @IBOutlet var socialLinkPlayStoreButton: FootnoteBackgroundButton!
    
    // MARK: - Lets and Var
    var homeStaticViewModel = HomeStaticViewModel()
    
    var reviewRatingArray = [HomeStaticReviewModel]()
    
    let homeReviewCollectionViewMargin = CGFloat(0)
    let homeReviewCollectionViewItemSpacing = CGFloat(0)
    var homeReviewCollectionViewItemHeight = CGFloat(135)
    var homeReviewCollectionViewItemWidth = CGFloat(300)
    let homeReviewCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var timerReview = Timer()
    
    var activeField = UITextField()
    var isGTAccepted = false
    var isQueriesAccepted = false
    var stateListArray = State.allRawValues()

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.set("", forKey: UserDefaultsPreferenceKeys.accessoriestab)
        UserDefaults.standard.synchronize()
        self.setNavigationBar()
        self.commonAPICALL(retryAPIID: 1000)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timerReview.invalidate()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: -  Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_white_FFFFFF,style: StatusBarTheme.darkContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - Set Initial View
    func setInitialView() {
        /* Manual Crash
         FirebaseCrashlyticsCollectionEnabled
         
         let numbers = [0]
         let _ = numbers[1]
         
         */
        
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
        self.setNavigationBar()
        
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        self.mainScrollView.keyboardDismissMode = .onDrag

        self.quickCard1View.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.quickCard1View.clipsToBounds = true
        
        self.quickCard2View.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.quickCard2View.clipsToBounds = true
        
        self.quickCard3View.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.quickCard3View.clipsToBounds = true
        
        var statuscardHeight = 0.0
        statuscardHeight = (screenFrameWidth - (16/*leading and trailing*/ + 16/*space between 3 elements*/)) / 3
        self.statusViewHeight.constant = (statuscardHeight * 2) + 8
        
        self.queriesNameTextField.setLeftPaddingPoints(10)
        self.queriesNameTextField.setRightPaddingPoints(30)
        
        self.queriesMobileTextField.setLeftPaddingPoints(10)
        self.queriesMobileTextField.setRightPaddingPoints(10)
        
        self.queriesStateTextField.setLeftPaddingPoints(10)
        self.queriesStateTextField.setRightPaddingPoints(40)
        
        self.gtNameTextField.setLeftPaddingPoints(10)
        self.gtNameTextField.setRightPaddingPoints(30)
        
        self.gtMobileTextField.setLeftPaddingPoints(10)
        self.gtMobileTextField.setRightPaddingPoints(10)
        
        self.gtStateTextField.setLeftPaddingPoints(10)
        self.gtStateTextField.setRightPaddingPoints(40)
        
        
        self.queriesNameTextField.delegate = self
        self.queriesMobileTextField.delegate = self
        self.queriesStateTextField.delegate = self
        self.gtNameTextField.delegate = self
        self.gtMobileTextField.delegate = self
        self.gtStateTextField.delegate = self
        
        self.queriesNameView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.queriesMobileView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.queriesStateView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.gtNameView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.gtMobileView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.gtStateView.layer.cornerRadius = AppConstantValue.cornerRadius4
        
        
        self.reviewRatingArray.removeAll()
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "Rabul Ansari", reviewBySubline: "Got invisible hearing aids ,and it was a perfect fit from Rexton brand and the audiologist was too good ,a highly appreciated and recommended place,thank you hearzap"))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "Eliyas A", reviewBySubline: "The service was good ..We bought the brand Philips from hearzap ..the Brand and service was too good..Rate is reasonable, for good experience and Hearing do visit hearzap for those who in need"))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "Ravi Kumar Thanikachalam", reviewBySubline: "Visited Vellore centre on 29.12.23 for my mother. Very nice staff. Good Service with lot of patience.thanks a lot"))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "A Swain", reviewBySubline: "The services and the testing were very well done a recommended place for hearing aid and testings..thanks to hearzap"))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "Gurram chandu", reviewBySubline: "I have had very great experience with hearing solutions. Doctor did hearing test and suggested the best hearing aid's for my dad. I liked the way doctor & staff over there trated us and finally i got good discount. Thank you so much for your service."))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "Konuku Suneetha", reviewBySubline: "Actually first I didn't hear anything, voices was not clarity. By seeing in online I have visied the clinic in tanuku. In clinic their was tested & suggested the hearing machine which I have perfectly set. Now iam onwards iam hear fine. Keeep it like this only. Thank you to tanuku staff & doctor"))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "Varalakshmi Juttru", reviewBySubline: "Today purchasing new hearing for father, He is very satisfied after hearing aid fitting\nI am also satisfied for hearing aid using explanation\nThanks to hearzap"))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "Nagaraju Nandigapu", reviewBySubline: "We are using hearing aids last two years good working today purchased second hearing aid good quality\nThanks Hearzap…"))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "T Naga Vijaya Kumar", reviewBySubline: "Best suggestions of hearing problem.\nThey need to hearing aid, best model suggested Hearing aid\nThanks to Hearzap"))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "Subramanya Koodli", reviewBySubline: "Excellent staff. Courteous and Customer centric. Audiologist listens to the issues with patience and try to find the best possible way to address the issue. Overall good experience."))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "Kardirvelb", reviewBySubline: "I came here for Fine tuning. Audiologist has given so much of information and I spent useful time here. Good service and treating level of audiologist and GRE has been excellent. Iam very happy . and fully satisfied."))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "SATHISH BABU", reviewBySubline: "Good... Doctor Patience is Excellent 👍 what ever silly questions we ask he is answerable and Receptionist received in good manner way and told exactly waiting time period. Totally Good."))
        self.reviewRatingArray.append(HomeStaticReviewModel(reviewRating: "5", reviewByName: "Ranjiani P", reviewBySubline: "Very good audiologist, always willing to help, spends lot of time with patients explaining problems & solutions. Good digital equipment & good experience."))
        
        [self.queriesNameTextField, self.queriesMobileTextField, self.queriesStateTextField, self.gtNameTextField, self.gtMobileTextField, self.gtStateTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)})
        
        self.customUI()
        self.loadShimmerUI()
        self.reloadHomeReviewCollectionView()
    }
    
    
    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isLeftSecondaryViewHidden = true
        self.navigationBar.isRightViewHidden = false
        self.navigationBar.isRightSecondaryViewHidden = false
        self.navigationBar.leftImage = Asset.menublue
        self.navigationBar.rightImage = Asset.whatsappgreen
        self.navigationBar.rightSecondaryImage = Asset.telephonedarkblue
        self.navigationBar.isLogoHidden = false
        self.navigationBar.logoImage = Asset.hzlogodark
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF)
    }
    // MARK: - Localization String
    func changeLanguageFormat() {
        self.customerFeedbackTitleLabel.text = AppLocalizationString.ourGoogleReviews
        self.customerFeedbackDescLabel.text = AppLocalizationString.ourGoogleReviewsDesc
        self.queriesTitleLabel.text = AppLocalizationString.haveanyqueries
        self.queriesDescLabel.text = AppLocalizationString.requestacallback
        self.queriesAuthoriseLabel.text = AppLocalizationString.iauthorizeHEARZAPtocontactme
        self.queriesSubmitButton.setTitle(AppLocalizationString.submit.uppercased(), for: .normal)
        
        self.gtTitleLabel.text = AppLocalizationString.talkwithus
        self.gtDescLabel.text = AppLocalizationString.talkwithusdesc
        self.gtHeaderTitleLabel.text = AppLocalizationString.support.uppercased()
        self.gtHeaderLabel.text = AppLocalizationString.havinghearingproblems
        self.gtHeaderDescLabel.text = AppLocalizationString.getInTouch
        self.gtAuthoriseLabel.text = AppLocalizationString.iauthorizeHEARZAPtocontactme
        self.gtSubmitButton.setTitle(AppLocalizationString.submit.uppercased(), for: .normal)
        
        var placeHolderName = NSMutableAttributedString()
        // Set the Font
        placeHolderName = NSMutableAttributedString(string:AppLocalizationString.namestar, attributes: [NSAttributedString.Key.font:AppFont.regular.size(13)])
        // Set the color
        placeHolderName.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_red_FF6961, range:NSRange(location:0,length:AppLocalizationString.namestar.count))
        placeHolderName.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_grey_777777, range:NSRange(location:0,length:AppLocalizationString.namestar.count - 1))
        // Add attribute
        self.queriesNameTextField.attributedPlaceholder = placeHolderName
        self.gtNameTextField.attributedPlaceholder = placeHolderName
        
        var placeHolderMobile = NSMutableAttributedString()
        // Set the Font
        placeHolderMobile = NSMutableAttributedString(string:AppLocalizationString.mobileNumberstar, attributes: [NSAttributedString.Key.font:AppFont.regular.size(13)])
        // Set the color
        placeHolderMobile.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_red_FF6961, range:NSRange(location:0,length:AppLocalizationString.mobileNumberstar.count))
        placeHolderMobile.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_grey_777777, range:NSRange(location:0,length:AppLocalizationString.mobileNumberstar.count - 1))
        // Add attribute
        self.queriesMobileTextField.attributedPlaceholder = placeHolderMobile
        self.gtMobileTextField.attributedPlaceholder = placeHolderMobile
        
        var placeHolderState = NSMutableAttributedString()
        // Set the Font
        placeHolderState = NSMutableAttributedString(string:AppLocalizationString.selectStatestar, attributes: [NSAttributedString.Key.font:AppFont.regular.size(13)])
        // Set the color
        placeHolderState.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_red_FF6961, range:NSRange(location:0,length:AppLocalizationString.selectStatestar.count))
        placeHolderState.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_grey_777777, range:NSRange(location:0,length:AppLocalizationString.selectStatestar.count - 1))
        // Add attribute
        self.queriesStateTextField.attributedPlaceholder = placeHolderState
        self.gtStateTextField.attributedPlaceholder = placeHolderState
        
        self.digitalTitleLabel.text = AppLocalizationString.joinIndiasfirstdigitalplatformforallyourhearin
        self.digitalDescLabel.text = AppLocalizationString.scanthisQRcodeonyourmobilecameraapptothedownload
        
        self.socialMediaLabel.text = AppLocalizationString.experienceHEARZAPonmobile
        self.supportTitleLabel.text = AppLocalizationString.followusinsocialmedia
        let year = Calendar.current.component(.year, from: Date())
        
        self.copyRightsLabel.text = String(format: AppLocalizationString.copyrightHearzapAllrightsreserved, year)
    }
    // MARK: - Reload
    func reloadHomeReviewCollectionView() {
        self.homeReviewCollectionViewItemHeight = CGFloat(300)
        self.homeReviewCollectionViewItemWidth = CGFloat(screenFrameWidth) - CGFloat(52)
        self.homeReviewCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.homeReviewCollectionViewlayout.itemSize = CGSize(width: self.homeReviewCollectionViewItemWidth, height: self.homeReviewCollectionViewItemHeight)
        self.homeReviewCollectionViewlayout.minimumLineSpacing = self.homeReviewCollectionViewItemSpacing
        self.homeReviewCollectionViewlayout.minimumInteritemSpacing = self.homeReviewCollectionViewItemSpacing
        self.homeReviewCollectionViewlayout.scrollDirection = .horizontal
        self.homeReviewCollectionView!.collectionViewLayout = self.homeReviewCollectionViewlayout
        self.homeReviewCollectionView.dataSource = self
        self.homeReviewCollectionView.delegate = self
        self.homeReviewCollectionView.reloadData()
        self.homeReviewCollectionViewHeight.constant = self.homeReviewCollectionViewItemHeight
        self.pageControl.numberOfPages = self.reviewRatingArray.count
        self.pageControl.currentPage = 0
        let ratingTitleStackView3 = self.ratingTitleStackView.arrangedSubviews[3] // left
        
        if self.reviewRatingArray.count > 1 {
            self.timerReview.invalidate()
            self.startAutoScrollCollectionReview()
            ratingTitleStackView3.isHidden = false
        } else {
            ratingTitleStackView3.isHidden = true
        }
    }
    
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getHomeVersionControl(retryAPIID: retryAPIID, canShowLoader: false)
                }
                else if retryAPIID == 1001 {
                    self.postHomequeries(retryAPIID: retryAPIID, canShowLoader: true)
                }
                else if retryAPIID == 1002 {
                    self.postHomeGetInTouch(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getHomeVersionControl(retryAPIID: Int, canShowLoader: Bool) {
        self.homeStaticViewModel.getHomeVersionControl(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getHomeVersionControl, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postHomequeries(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.queriesNameTextField.text.isNilOrEmpty) && !(self.queriesMobileTextField.text.isNilOrEmpty) && !(self.queriesStateTextField.text.isNilOrEmpty){
            let param =  String(format: "name=%@&phone_number=%@%@&state=%@", self.queriesNameTextField.text!, "+91".allowSpecialCharacters, self.queriesMobileTextField.text!,self.queriesStateTextField.text!)
            self.homeStaticViewModel.postHomequeries(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postHomequeries, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    func postHomeGetInTouch(retryAPIID: Int, canShowLoader: Bool) {
        if !(self.gtNameTextField.text.isNilOrEmpty) && !(self.gtMobileTextField.text.isNilOrEmpty) && !(self.gtStateTextField.text.isNilOrEmpty){
            let param =  String(format: "name=%@&phone_number=%@%@&state=%@", self.gtNameTextField.text!, "+91".allowSpecialCharacters, self.gtMobileTextField.text!,self.gtStateTextField.text!)
            self.homeStaticViewModel.postHomeGetInTouch(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.postHomeGetInTouch, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
        }
    }
    
    // MARK: - IBAction
    @IBAction func bannerButtonPressed(_ sender: UIButton){
        let view0 = self.mainStackView.arrangedSubviews[0]// quick card
        let view1 = self.mainStackView.arrangedSubviews[1]// banner
        let view2 = self.mainStackView.arrangedSubviews[2]// status card
        let view3 = self.mainStackView.arrangedSubviews[3]// queries
        let view4 = self.mainStackView.arrangedSubviews[4]// empty
        let view5 = self.mainStackView.arrangedSubviews[5]// buisness
        let view6 = self.mainStackView.arrangedSubviews[6]// empty
        let view7 = self.mainStackView.arrangedSubviews[7]// ratimg
        let view8 = self.mainStackView.arrangedSubviews[8]// hearzap diffference
        let view9 = self.mainStackView.arrangedSubviews[9]// digital image title
        let view10 = self.mainStackView.arrangedSubviews[10]// digital image
        let view11 = self.mainStackView.arrangedSubviews[11]// gt header
        //        let view = self.mainStackView.arrangedSubviews[]//
        
        let dateSlotViewY: CGFloat = view0.frame.height + view1.frame.height + view2.frame.height + view3.frame.height + view4.frame.height + view5.frame.height + view6.frame.height + view7.frame.height + view8.frame.height + view9.frame.height + view10.frame.height + view11.frame.height
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.mainScrollView.setContentOffset(CGPoint(x: 0, y: dateSlotViewY), animated: false)
        }, completion: nil)
    }
    @IBAction func queriesStateButtonPressed(_ sender: UIButton) {
        if self.stateListArray.count > 0 {
            self.view.endEditing(true)
            let dropDown = DropDown()
            // The view to which the drop down will appear on
            dropDown.anchorView = self.queriesStateButton // UIView or UIBarButtonItem
            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = self.stateListArray
            dropDown.show()
            // Action triggered on selection
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.queriesStateTextField.text = item
            }
        } else {
            self.showToastAlert(AppLocalizationString.dropDownError, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func queriesSubmitButtonPressed(_ sender: UIButton) {
        if self.queriesNameTextField.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseentername, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        } else if self.queriesMobileTextField.text.isNilOrEmpty{
            self.showToastAlert(AppLocalizationString.pleaseentervalidmobilenumber, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }else if self.queriesStateTextField.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseselectstate, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        } else if self.isQueriesAccepted == false{
            self.showToastAlert(AppLocalizationString.pleaseauthorizeustocontactyou, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
        else{
            self.commonAPICALL(retryAPIID: 1001)
        }
    }
    @IBAction func frdTryNowButtonPressed(_ sender: UIButton) {
        self.navigateToFindRightDeviceIntroductionViewController(isFrom: IsNavigateFrom.fhaHomeStatic.rawValue)
    }
    @IBAction func shopTryNowButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    @IBAction func offersButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabShop, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    @IBAction func storeTryNowButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(AppLocalizationString.tabStores, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    @IBAction func playstoreButtonPressed(_ sender: UIButton) {
        if !(AppLocalizationString.linkPlayStore.isEmpty) {
            guard let appURL = URL(string: AppLocalizationString.linkPlayStore.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func appstoreButtonPressed(_ sender: UIButton) {
        if !(AppLocalizationString.linkAppStore.isEmpty) {
            guard let appURL = URL(string: AppLocalizationString.linkAppStore.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func gtStateButtonPressed(_ sender: UIButton) {
        if self.stateListArray.count > 0 {
            self.view.endEditing(true)
            let dropDown = DropDown()
            // The view to which the drop down will appear on
            dropDown.anchorView = self.gtStateButton // UIView or UIBarButtonItem
            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = self.stateListArray
            dropDown.show()
            // Action triggered on selection
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.gtStateTextField.text = item
                
            }
        } else {
            self.showToastAlert(AppLocalizationString.dropDownError, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    @IBAction func gtAuthoriseButtonPressed(_ sender: UIButton) {
        self.gtAuthorised()
    }
    @IBAction func queriesAuthoriseButtonPressed(_ sender: UIButton) {
        self.queriesAuthorised()
    }
    @IBAction func gtSubmitButtonPressed(_ sender: UIButton) {
        if self.gtNameTextField.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseentername, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        } else if self.gtMobileTextField.text.isNilOrEmpty{
            self.showToastAlert(AppLocalizationString.pleaseentervalidmobilenumber, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }else if self.gtStateTextField.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseselectstate, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        } else if self.isGTAccepted == false{
            self.showToastAlert(AppLocalizationString.pleaseauthorizeustocontactyou, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
        else{
            self.commonAPICALL(retryAPIID: 1002)
        }
    }
    @IBAction func quickTestButtonPressed(_ sender: UIButton) {
        self.navigateToQuickTestProfileViewController(isFrom:  IsNavigateFrom.qcHomeStatic.rawValue)
    }
    @IBAction func bookAppointmentPressed(_ sender: UIButton) {
        self.navigateToBookAppointmentLocationViewController(isFrom: IsNavigateFrom.baHomeStatic.rawValue)
    }
    @IBAction func onlineConsultAudiologistButtonPressed(_ sender: UIButton) {
        self.navigateToOnlineConsultationLocationViewController(isFrom: IsNavigateFrom.ocHomeStatic.rawValue)
    }
    @IBAction func socialMediaButtonPressed(_ sender: UIButton) {
        guard let baseUrl: String = Bundle.main.infoDictionary?["BASE_URL"] as? String else { return }
        var socialMediaURL = ""
        if sender.tag == 0 {
            socialMediaURL = "\(baseUrl)\(SubAPIUrl.fbRedirectUrl)"
        } else if sender.tag == 1 {
            socialMediaURL = "\(baseUrl)\(SubAPIUrl.whatsappRedirectUrl)"
        } else if sender.tag == 2 {
            socialMediaURL = "\(baseUrl)\(SubAPIUrl.instaRedirectUrl)"
        } else if sender.tag == 3 {
            socialMediaURL = "\(baseUrl)\(SubAPIUrl.youtubeRedirectUrl)"
        } else if sender.tag == 4 {
            socialMediaURL = "\(baseUrl)\(SubAPIUrl.twitterRedirectUrl)"
        }
        if !(socialMediaURL.isEmpty) {
            guard let appURL = URL(string: socialMediaURL.checkhttpCharacter) else {
                // url error msg
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // error msg
                self.showToastAlert(AppLocalizationString.failedToOpen, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)            }
        } else {
            // empty msg
            self.showToastAlert(AppLocalizationString.noLinkFound, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    // MARK: - Custom Methods
    func loadShimmerUI(){
        self.quickCard1ImageView.shimmerEffectView(canStop: true)
        self.quickCard2ImageView.shimmerEffectView(canStop: true)
        self.quickCard3ImageView.shimmerEffectView(canStop: true)
        
        self.bannerImageView.shimmerEffectView(canStop: true)
        
        self.statusCard1SubImageView.shimmerEffectView(canStop: true)
        self.statusCard2SubImageView.shimmerEffectView(canStop: true)
        self.statusCard3SubImageView.shimmerEffectView(canStop: true)
        self.statusCard4SubImageView.shimmerEffectView(canStop: true)
        self.statusCard5SubImageView.shimmerEffectView(canStop: true)
        self.statusCard6SubImageView.shimmerEffectView(canStop: true)
        
        self.queriesTitleLabel.shimmerEffectView(canStop: true)
        self.queriesDescLabel.shimmerEffectView(canStop: true)
        self.queriesNameView.shimmerEffectView(canStop: true)
        self.queriesMobileView.shimmerEffectView(canStop: true)
        self.queriesStateView.shimmerEffectView(canStop: true)
        self.queriesAuthoriseView.shimmerEffectView(canStop: true)
        self.queriesSubmitView.shimmerEffectView(canStop: true)
        
        self.frdImageView.shimmerEffectView(canStop: true)
        self.shopImageView.shimmerEffectView(canStop: true)
        self.offersImageView.shimmerEffectView(canStop: true)
        self.storeImageView.shimmerEffectView(canStop: true)
        
        self.customerFeedbackTitleLabel.shimmerEffectView(canStop: true)
        self.customerFeedbackDescLabel.shimmerEffectView(canStop: true)
        self.homeReviewCollectionView.shimmerEffectView(canStop: true)
        
        self.digitalTitleLabel.shimmerEffectView(canStop: true)
        self.digitalDescLabel.shimmerEffectView(canStop: true)
        self.digitalTitleImageView.shimmerEffectView(canStop: true)
        self.digitalImageView.shimmerEffectView(canStop: true)
        self.digitalLinkPlayStoreImageView.shimmerEffectView(canStop: true)
        self.digitalLinkAppStoreImageView.shimmerEffectView(canStop: true)
        
        self.gtHeaderTitleLabel.shimmerEffectView(canStop: true)
        self.gtHeaderLabel.shimmerEffectView(canStop: true)
        self.gtHeaderDescLabel.shimmerEffectView(canStop: true)
        self.gtTitleLabel.shimmerEffectView(canStop: true)
        self.gtDescLabel.shimmerEffectView(canStop: true)
        self.gtNameView.shimmerEffectView(canStop: true)
        self.gtMobileView.shimmerEffectView(canStop: true)
        self.gtStateView.shimmerEffectView(canStop: true)
        self.gtAuthoriseView.shimmerEffectView(canStop: true)
        self.gtSubmitView.shimmerEffectView(canStop: true)
        
        self.socialMediaLabel.shimmerEffectView(canStop: true)
        self.supportTitleLabel.shimmerEffectView(canStop: true)
        self.copyRightsLabel.shimmerEffectView(canStop: true)
        
        self.facebookImageView.shimmerEffectView(canStop: true)
        self.whatsappImageView.shimmerEffectView(canStop: true)
        self.instagramImageView.shimmerEffectView(canStop: true)
        self.youtubeImageView.shimmerEffectView(canStop: true)
        self.twitterImageView.shimmerEffectView(canStop: true)
        
        self.socialLinkAppStoreImageView.shimmerEffectView(canStop: true)
        self.socialLinkPlayStoreImageView.shimmerEffectView(canStop: true)
    }
    func customUI(){
        self.queriesNameTextField.text = ""
        self.queriesMobileTextField.text = ""
        self.queriesStateTextField.text = ""
        self.isQueriesAccepted = false
        self.queriesAuthorised()
        
        self.gtNameTextField.text = ""
        self.gtMobileTextField.text = ""
        self.gtStateTextField.text = ""
        self.isGTAccepted = false
        self.gtAuthorised()
    }
    func gtAuthorised(){
        self.isGTAccepted == false ? ( self.isGTAccepted = true) : ( self.isGTAccepted = false)
        self.gtAuthoriseButton.setImage(self.isGTAccepted == false ? UIImage(named: Asset.checksquaregrey) : UIImage(named: Asset.checksquarenavybluefill), for: .normal)
    }
    func queriesAuthorised(){
        self.isQueriesAccepted == false ? ( self.isQueriesAccepted = true) : ( self.isQueriesAccepted = false)
        self.queriesAuthoriseButton.setImage(self.isQueriesAccepted == false ? UIImage(named: Asset.checksquaregrey) : UIImage(named: Asset.checksquarenavybluefill), for: .normal)
    }
    func startAutoScrollCollectionReview() {
        DispatchQueue.main.async {
            self.timerReview.invalidate()
            self.timerReview =  Timer.scheduledTimer(timeInterval: Double(AppConstantValue.reviewTimerInterval), target: self, selector: #selector(self.autoScrollCollectionReview), userInfo: nil, repeats: true)
        }
    }
    @objc func autoScrollCollectionReview(_ timer1: Timer) {
        if let coll  = self.homeReviewCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if (indexPath?.item)! < self.reviewRatingArray.count - 1 {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(item: (indexPath?.item)! + 1, section: 0)
                    pageControl.currentPage = (indexPath1?.item)!
                    let rect = coll.layoutAttributesForItem(at: indexPath1!)?.frame
                    coll.scrollRectToVisible(rect!, animated: true)
                } else {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(item: 0, section: 0)
                    pageControl.currentPage = 0
                    let rect = coll.layoutAttributesForItem(at: indexPath1!)?.frame
                    coll.scrollRectToVisible(rect!, animated: true)
                }
            }
        }
    }
    // MARK: - TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && (string == " ") {
            return false
        }
        var maxLength = 255
        if textField == self.queriesMobileTextField || textField == self.gtMobileTextField {
            maxLength = 10
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.numericRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        } else if textField == self.queriesNameTextField ||  textField == self.gtNameTextField{
            maxLength = 50
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.nameRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    @objc func editingChanged(_ textField: UITextField) {
        //        self.setQueriesUserInteractionButton()
        //        self.setGTUserInteractionButton()
    }
}
extension HomeStaticViewController: ProtocolMainLogoNavigationBar {
    // MARK: - Navigation Bar Delegates
    /*
     "contact_number" = "+91 96594 55455";
     "email_address" = "support@hearzap.com";
     "h1_title" = "<null>";
     "whatsapp_number" = 919659455455;
     */
    func leftSecondaryButtonPressed() {}
    func rightSecondaryButtonPressed() {
        let phonenumber = "+91 96594 55455".replacingOccurrences(of: " ", with: "")
        
        self.makeCall(phoneNumber: phonenumber)
    }
    func leftButtonPressed() {
        UserDefaults.standard.set(AppLocalizationString.tabAccount, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }
    func rightButtonPressed() {
        self.openWhatsapp(phoneNumber: "919659455455")
    }
}
extension HomeStaticViewController: ProtocolNetworkRechabilityDelegate {
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

extension HomeStaticViewController: UICollectionViewDelegate, UICollectionViewShimmerDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reviewRatingArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.HomeStaticReviewCollectionViewCell, for: indexPath) as! HomeStaticReviewCollectionViewCell
        cell.configure(homeStaticReviewModel: self.reviewRatingArray[indexPath.item], indexpath: indexPath.item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if collectionView == self.homeReviewCollectionView {
            cellWidth = self.homeReviewCollectionViewItemWidth
            cellHeight = self.homeReviewCollectionViewItemHeight
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
    // MARK: - Scrollview Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.homeReviewCollectionView {
            if self.reviewRatingArray.count > 1 {
                for cell in self.homeReviewCollectionView.visibleCells {
                    let indexPath = self.homeReviewCollectionView.indexPath(for: cell)
                    self.pageControl.currentPage = indexPath!.item
                }
            }
        }
    }
}
