//
//  BlogsListViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 31/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift


class BlogsListViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var categoryView: UIView!
    @IBOutlet var categoryTitleLabel: Caption2FontLabel!
    @IBOutlet var categoryLabel: FootnoteFontLabel!
    @IBOutlet var categoryButton: FootnoteOutlineButton!
//    @IBOutlet var categoryViewHeight: NSLayoutConstraint!

    @IBOutlet var gridView: UIView!
    @IBOutlet var gridCollectionView: UICollectionView!
    @IBOutlet var gridCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet var paginationView: UIView!
    @IBOutlet var paginationStackView: UIStackView!
    @IBOutlet var previousPageButton: CalloutOutlineButton!
    @IBOutlet var firstButton: CalloutOutlineButton!
    @IBOutlet var secondButton: CalloutOutlineButton!
    @IBOutlet var thirdButton: CalloutOutlineButton!
    @IBOutlet var fourthButton: CalloutOutlineButton!
    @IBOutlet var fifthButton: CalloutOutlineButton!
    @IBOutlet var sixthButton: CalloutOutlineButton!
    @IBOutlet var seventhButton: CalloutOutlineButton!

    @IBOutlet var nextPageButton: CalloutOutlineButton!

    @IBOutlet var errorView: UIView!
    @IBOutlet var errorStackView: UIStackView!
    @IBOutlet var errorImageView: UIImageView!
    @IBOutlet var primaryMessageLabel: CalloutFontLabel!

    @IBOutlet var queriesView: UIView!
    @IBOutlet var queriesStackView: UIStackView!

    @IBOutlet var queriesTitleView: UIView!

    @IBOutlet var queriesTitleLabel: Title2FontLabel!
    @IBOutlet var queriesDescLabel: Caption1FontLabel!

    @IBOutlet var queriesNameView: UIView!
    @IBOutlet var queriesNameTextField: Caption1FontTextfield!

    @IBOutlet var queriesMobileView: UIView!
    @IBOutlet var queriesMobileTextField: Caption1FontTextfield!

    @IBOutlet var queriesEmailView: UIView!
    @IBOutlet var queriesEmailTextField: Caption1FontTextfield!

    @IBOutlet var queriesStateView: UIView!
    @IBOutlet var queriesStateTextField: Caption1FontTextfield!
    @IBOutlet var queriesStateButton: CalloutOutlineButton!

    @IBOutlet var queriesCommentView: UIView!
    @IBOutlet var queriesCommentTextView: MDFloatingTextView!

    @IBOutlet var queriesAuthoriseView: UIView!
    @IBOutlet var queriesAuthoriseLabel: Caption1FontLabel!
    @IBOutlet var queriesAuthoriseButton: FootnoteOutlineButton!

    @IBOutlet var queriesSubmitView: UIView!
    @IBOutlet var queriesSubmitButton: Callout1BackgroundButton!

    @IBOutlet var subscriptionView: UIView!
    @IBOutlet var subscriptionStackView: UIStackView!

    @IBOutlet var subscriptionTitleView: UIView!

    @IBOutlet var subscriptionTitleLabel: Title2FontLabel!
    @IBOutlet var subscriptionDescLabel: Caption1FontLabel!

    @IBOutlet var subscriptionEmailView: UIView!
    @IBOutlet var subscriptionEmailTextField: Caption1FontTextfield!

    @IBOutlet var subscriptionSubmitView: UIView!
    @IBOutlet var subscriptionButton: Callout1BackgroundButton!

    // MARK: - Lets and Var
    var gridArray = [BlogsListModelArticle]()
    let gridCollectionViewMargin = CGFloat(0)
    let gridCollectionViewItemSpacing = CGFloat(16)
    var gridCollectionViewItemHeight = CGFloat(308)
    var gridCollectionViewItemWidth = CGFloat(343)
    let gridCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var catergoryName = ""
    var catergorySlug = ""
    var searchblog = ""
    var htmlstring = ""
    var totalPages = 1
    var pageNumber = 1

    var blogsListViewModel = BlogsListViewModel()
    var hasnext = false
    var hasprevious = false

    var buttontitle = "1"
    var firstButtontitle = "2"
    var secondButtontitle = "3"
    var thirdButtontitle = "4"
    var fourthButtontitle = "5"
    var fifthButtontitle = "6"
    var sixthButtontitle = "7"
    var seventhButtontitle = "8"
    var isQueriesAccepted = false
    var activeField = UITextField()
    var categoryList = [String]()
    var categoryListSlug = [String]()

    var isSearch = false
    var isCategory = false

    var canHideShimmering = false

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
        self.setNavigationBar()
        //        self.setUserInteractionButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
        self.changeStatusBarColor()
        self.changeLanguageFormat()
        self.navigationController?.isNavigationBarHidden = true
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        self.isQueriesAccepted = false
        self.queriesAuthorised()

        self.queriesNameTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.queriesNameTextField.clipsToBounds = true
        self.queriesNameTextField.layer.borderColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        self.queriesNameTextField.layer.borderWidth = 1.0
        self.queriesNameTextField.setLeftPaddingPoints(16.0)
        self.queriesNameTextField.setRightPaddingPoints(16.0)
        self.queriesNameTextField.delegate = self
        self.queriesNameTextField.text = ""
        self.queriesNameTextField.tintColor = UIColor.colorLiteral.theme_black_333333

        self.queriesMobileTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.queriesMobileTextField.clipsToBounds = true
        self.queriesMobileTextField.layer.borderColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        self.queriesMobileTextField.layer.borderWidth = 1.0
        self.queriesMobileTextField.setLeftPaddingPoints(16.0)
        self.queriesMobileTextField.setRightPaddingPoints(16.0)
        self.queriesMobileTextField.delegate = self
        self.queriesMobileTextField.text = ""
        self.queriesMobileTextField.tintColor = UIColor.colorLiteral.theme_black_333333

        self.queriesEmailTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.queriesEmailTextField.clipsToBounds = true
        self.queriesEmailTextField.layer.borderColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        self.queriesEmailTextField.layer.borderWidth = 1.0
        self.queriesEmailTextField.setLeftPaddingPoints(16.0)
        self.queriesEmailTextField.setRightPaddingPoints(16.0)
        self.queriesEmailTextField.delegate = self
        self.queriesEmailTextField.text = ""
        self.queriesEmailTextField.tintColor = UIColor.colorLiteral.theme_black_333333

        self.queriesStateTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.queriesStateTextField.clipsToBounds = true
        self.queriesStateTextField.layer.borderColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        self.queriesStateTextField.layer.borderWidth = 1.0
        self.queriesStateTextField.setLeftPaddingPoints(16.0)
        self.queriesStateTextField.setRightPaddingPoints(60.0)
        self.queriesStateTextField.delegate = self
        self.queriesStateTextField.text = ""
        self.queriesStateTextField.tintColor = UIColor.colorLiteral.theme_black_333333

        self.queriesCommentTextView.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.queriesCommentTextView.clipsToBounds = true
        self.queriesCommentTextView.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.queriesCommentTextView.layer.borderColor = UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        self.queriesCommentTextView.layer.borderWidth = 1
        self.queriesCommentTextView.delegate = self
        self.queriesCommentTextView.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right:16)

        self.queriesCommentTextView.font = AppFont.regular.size(13.0)
        self.queriesCommentTextView.placeholderFont = AppFont.regular.size(13)
        self.queriesCommentTextView.titleFont = AppFont.regular.size(11)
        self.queriesCommentTextView.titleColor = UIColor.colorLiteral.theme_grey_777777
        self.queriesCommentTextView.placeholderColor = UIColor.colorLiteral.theme_grey_777777

        self.queriesCommentTextView.awakeFromNib()

        self.subscriptionEmailTextField.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.subscriptionEmailTextField.clipsToBounds = true
        self.subscriptionEmailTextField.layer.borderColor = UIColor.colorLiteral.theme_grey_999999.cgColor
        self.subscriptionEmailTextField.layer.borderWidth = 1.0
        self.subscriptionEmailTextField.setLeftPaddingPoints(16.0)
        self.subscriptionEmailTextField.setRightPaddingPoints(16.0)
        self.subscriptionEmailTextField.delegate = self
        self.subscriptionEmailTextField.text = ""
        self.subscriptionEmailTextField.tintColor = UIColor.colorLiteral.theme_black_333333

        self.categoryLabel.text = ""

        self.loadShimmerUI()
        self.reloadGridCollectionView()
        self.commonAPICALL(retryAPIID: 1000)
    }

    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = false
        self.navigationBar.leftImage = Asset.arrowleftdarkblue
        self.navigationBar.rightImage = Asset.searchdarkblue
        self.navigationBarHeight.constant = CGFloat(AppConstantValue.navigationBarHeight)
        self.navigationBar.title = AppLocalizationString.blogs.capitalized
        self.navigationBar.delegate = self
        self.navigationBar.setupView(backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF,titleTextColor: UIColor.colorLiteral.theme_blue_112F70)
    }

    // MARK: - Localization String
    func changeLanguageFormat() {
        self.queriesTitleLabel.text = AppLocalizationString.blogsContactus
        self.queriesDescLabel.text = AppLocalizationString.blogsContactusDesc
        self.queriesAuthoriseLabel.text = AppLocalizationString.iauthorizeHEARZAPtocontactme
        self.queriesSubmitButton.setTitle(AppLocalizationString.submit.uppercased(), for: .normal)

        self.primaryMessageLabel.text = AppLocalizationString.noBlogsFound

        var placeHolderName = NSMutableAttributedString()
        // Set the Font
        placeHolderName = NSMutableAttributedString(string:AppLocalizationString.namestar, attributes: [NSAttributedString.Key.font:AppFont.regular.size(13)])
        // Set the color
        placeHolderName.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_red_FF6961, range:NSRange(location:0,length:AppLocalizationString.namestar.count))
        placeHolderName.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_grey_777777, range:NSRange(location:0,length:AppLocalizationString.namestar.count - 1))
        // Add attribute
        self.queriesNameTextField.attributedPlaceholder = placeHolderName

        var placeHolderMobile = NSMutableAttributedString()
        // Set the Font
        placeHolderMobile = NSMutableAttributedString(string:AppLocalizationString.mobileNumberstar, attributes: [NSAttributedString.Key.font:AppFont.regular.size(13)])
        // Set the color
        placeHolderMobile.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_red_FF6961, range:NSRange(location:0,length:AppLocalizationString.mobileNumberstar.count))
        placeHolderMobile.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_grey_777777, range:NSRange(location:0,length:AppLocalizationString.mobileNumberstar.count - 1))
        // Add attribute
        self.queriesMobileTextField.attributedPlaceholder = placeHolderMobile

        var placeHolderemail = NSMutableAttributedString()
        // Set the Font
        placeHolderemail = NSMutableAttributedString(string:AppLocalizationString.emailAddressstar, attributes: [NSAttributedString.Key.font:AppFont.regular.size(13)])
        // Set the color
        placeHolderemail.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_red_FF6961, range:NSRange(location:0,length:AppLocalizationString.mobileNumberstar.count))
        placeHolderemail.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_grey_777777, range:NSRange(location:0,length:AppLocalizationString.mobileNumberstar.count - 1))
        // Add attribute
        self.queriesEmailTextField.attributedPlaceholder = placeHolderemail

        var placeHolderState = NSMutableAttributedString()
        // Set the Font
        placeHolderState = NSMutableAttributedString(string:AppLocalizationString.selectStatestar, attributes: [NSAttributedString.Key.font:AppFont.regular.size(13)])
        // Set the color
        placeHolderState.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_red_FF6961, range:NSRange(location:0,length:AppLocalizationString.selectStatestar.count))
        placeHolderState.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_grey_777777, range:NSRange(location:0,length:AppLocalizationString.selectStatestar.count - 1))
        // Add attribute
        self.queriesStateTextField.attributedPlaceholder = placeHolderState

        self.queriesCommentTextView.placeholderText = AppLocalizationString.comments
        self.subscriptionTitleLabel.text = AppLocalizationString.blogsNewsletterSubscription
        self.subscriptionDescLabel.text = AppLocalizationString.blogsNewsletterSubscriptionDesc
        var subscriptionPlaceholder = NSMutableAttributedString()
        // Set the Font
        subscriptionPlaceholder = NSMutableAttributedString(string:AppLocalizationString.youremailgoeshere, attributes: [NSAttributedString.Key.font:AppFont.regular.size(13)])
        // Set the color
        subscriptionPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_grey_777777, range:NSRange(location:0,length:AppLocalizationString.youremailgoeshere.count))
        // Add attribute
        self.subscriptionEmailTextField.attributedPlaceholder = subscriptionPlaceholder

        self.subscriptionButton.setTitle(AppLocalizationString.subscribe.uppercased(), for: .normal)

    }
    // MARK: - Reload
    func reloadGridCollectionView() {
        var spacingbetween:CGFloat = 0.0
        if self.gridArray.count > 0 {
            if (self.gridArray.count > 2){
                spacingbetween = CGFloat(self.gridArray.count - 1) * self.gridCollectionViewItemSpacing
            }
            else if (self.gridArray.count == 2){
                spacingbetween = 16.0
            }
            self.gridCollectionViewHeight.constant = (((CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(192.94/343.0)) + CGFloat(115)/*16 + 16 + 3 + 45 + 3 + 16 + 16 */) * CGFloat(self.gridArray.count)) + spacingbetween
        }
        else if (self.canHideShimmering == false){
            spacingbetween = CGFloat(5 - 1) * self.gridCollectionViewItemSpacing
            self.gridCollectionViewHeight.constant = (((CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(192.94/343.0)) + CGFloat(115)/*16 + 16 + 3 + 45 + 3 + 16 + 16 */) * CGFloat(5)) + spacingbetween
        }
        else {
            self.gridCollectionViewHeight.constant = 0
        }
        self.gridCollectionViewItemHeight = (CGFloat(AppConstantValue.screenWidthminus32) * CGFloat(192.94/343.0)) + CGFloat(115)/*16 + 16 + 3 + 45 + 3 + 16 + 16 */
        self.gridCollectionViewItemWidth = CGFloat(AppConstantValue.screenWidthminus32)
        self.gridCollectionViewlayout.sectionInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.gridCollectionViewlayout.itemSize = CGSize(width: self.gridCollectionViewItemWidth, height: self.gridCollectionViewItemHeight)
        self.gridCollectionViewlayout.minimumLineSpacing = self.gridCollectionViewItemSpacing
        self.gridCollectionViewlayout.minimumInteritemSpacing = self.gridCollectionViewItemSpacing
        self.gridCollectionViewlayout.scrollDirection = .vertical
        self.gridCollectionView!.collectionViewLayout = self.gridCollectionViewlayout
        self.gridCollectionView.dataSource = self
        self.gridCollectionView.delegate = self
        self.gridCollectionView.reloadData()
    }

    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getBlogsList(retryAPIID: retryAPIID, canShowLoader: false)
                }
                else if retryAPIID == 1001 {
                    self.getBlogsCategoryList(retryAPIID: retryAPIID, canShowLoader: false)
                }
                else if retryAPIID == 1002 {
                    self.postBlogsQueries(retryAPIID: retryAPIID, canShowLoader: true)
                }
                else if retryAPIID == 1003 {
                    self.postBlogsNewsletter(retryAPIID: retryAPIID, canShowLoader: true)
                }

            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }

    func getBlogsList(retryAPIID: Int, canShowLoader: Bool) {
        self.canHideShimmering = false
        self.loadShimmerUI()
            self.blogsListViewModel.getBlogsList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getBlogsList, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(self.pageNumber)", retryAPIID: retryAPIID, strQuery: "&page_size=12")
    }
    func getBlogsCategoryList(retryAPIID: Int, canShowLoader: Bool) {
            var subUrl = ""
            if !(self.catergorySlug.isEmpty){
                self.canHideShimmering = false
                self.loadShimmerUI()
                subUrl = "\(SubAPIUrl.getBlogsCategoryList)\(self.catergorySlug.allowSpecialCharacters)/"
            }
            else{
                self.showToastAlert(AppLocalizationString.linkInvalid, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
                return
            }
            self.blogsListViewModel.getBlogsCategoryList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: subUrl, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(self.pageNumber)", retryAPIID: retryAPIID, strQuery: "&page_size=12")
    }
    func postBlogsQueries(retryAPIID: Int, canShowLoader: Bool) {
        let param =  String(format: "name=%@&phone_number=%@%@&state=%@&email_address=%@&comments=%@", self.queriesNameTextField.text!.allowSpecialCharacters, "+91".allowSpecialCharacters,self.queriesMobileTextField.text!.allowSpecialCharacters,self.queriesStateTextField.text!.allowSpecialCharacters,self.queriesEmailTextField.text!.allowSpecialCharacters,self.queriesCommentTextView.text!.allowSpecialCharacters)
        let subUrl = "\(SubAPIUrl.postBlogsQueries)list/"

        self.blogsListViewModel.postBlogsQueries(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: subUrl, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postBlogsNewsletter(retryAPIID: Int, canShowLoader: Bool) {
        let subUrl = "\(SubAPIUrl.postBlogsNewsletter)list/"
        let param =  String(format: "email_address=%@", self.subscriptionEmailTextField.text!.allowSpecialCharacters)
        self.blogsListViewModel.postBlogsNewsletter(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: subUrl, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    // MARK: - IBAction
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        if (self.buttontitle != "..."){
            if (Int(self.buttontitle)! != 1){
                self.buttontitle = "\(Int(self.buttontitle)! - 1)"
                self.callAPI()
            }
            else{
                self.buttontitle = "1"
                self.callAPI()
            }
        }
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if (self.buttontitle != "..."){
            if (Int(self.buttontitle)! != self.totalPages){
                self.buttontitle = "\(Int(self.buttontitle)! + 1)"
                self.callAPI()        }
            else{
                self.buttontitle = "\(self.totalPages)"
                self.callAPI()
            }
        }
    }
    @IBAction func firstButtonPressed(_ sender: UIButton) {
        if (sender.currentTitle != "..."){
            self.buttontitle = "1"
            self.callAPI()
        }
    }
    @IBAction func secondButtonPressed(_ sender: UIButton) {
        if (sender.currentTitle != "..."){
            self.buttontitle = "\(Int(sender.currentTitle!)!)"
            self.callAPI()
        }
    }
    @IBAction func thirdButtonPressed(_ sender: UIButton) {
        if (sender.currentTitle != "..."){
            self.buttontitle = "\(Int(sender.currentTitle!)!)"
            self.callAPI()
        }
    }
    @IBAction func fourthButtonPressed(_ sender: UIButton) {
        if (sender.currentTitle != "..."){
            self.buttontitle = "\(Int(sender.currentTitle!)!)"
            self.callAPI()
        }
    }
    @IBAction func fifthButtonPressed(_ sender: UIButton) {
        if (sender.currentTitle != "..."){
            self.buttontitle = "\(Int(sender.currentTitle!)!)"
            self.callAPI()
        }
    }
    @IBAction func sixthButtonPressed(_ sender: UIButton) {
        if (sender.currentTitle != "..."){
            self.buttontitle = "\(Int(sender.currentTitle!)!)"
            self.callAPI()
        }
    }
    @IBAction func seventhButtonPressed(_ sender: UIButton) {
        if (sender.currentTitle != "..."){
            self.buttontitle = "\(self.totalPages)"
            self.callAPI()
        }
    }

    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        if self.categoryList.count > 0 {
            self.view.endEditing(true)
            let dropDown = DropDown()
            // The view to which the drop down will appear on
            dropDown.anchorView = self.categoryButton // UIView or UIBarButtonItem

            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = self.categoryList
            dropDown.show()

            // Action triggered on selection
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.catergoryName = self.categoryList[index]
                self.catergorySlug = self.categoryListSlug[index]

                self.categoryLabel.text = self.categoryList[index]
                self.buttontitle = "1"
                self.pageNumber = 1
                self.isSearch = false
                self.isCategory = true
                self.callAPI()
            }
        } else {
            self.showToastAlert(AppLocalizationString.dropDownError, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
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
    @IBAction func queriesAuthoriseButtonPressed(_ sender: UIButton) {
        self.queriesAuthorised()
    }
    @IBAction func queriesSubmitButtonPressed(_ sender: UIButton) {
        if self.queriesNameTextField.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseentername, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        } else if self.queriesMobileTextField.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseentervalidmobilenumber, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        } else if self.queriesMobileTextField.text!.count < 10 {
            self.showToastAlert(AppLocalizationString.pleaseentervalidmobilenumber, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        } else if self.queriesStateTextField.text.isNilOrEmpty {
            self.showToastAlert(AppLocalizationString.pleaseselectstate, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        } else if self.queriesEmailTextField.text.isNilOrEmpty || self.queriesEmailTextField.text!.isEmailValid == false {
            self.showToastAlert(AppLocalizationString.pleaseentervalidemailaddress, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        } else if self.isQueriesAccepted == false{
            self.showToastAlert(AppLocalizationString.pleaseauthorizeustocontactyou, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
        else{
            self.commonAPICALL(retryAPIID: 1002)
        }
    }
    @IBAction func subscriptionButtonPressed(_ sender: UIButton) {
        if self.subscriptionEmailTextField.text.isNilOrEmpty || self.subscriptionEmailTextField.text!.isEmailValid == false {
            self.showToastAlert(AppLocalizationString.pleaseentervalidemailaddress, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
        else{
            self.commonAPICALL(retryAPIID: 1003)
        }
    }

    // MARK: - Custom Methods
    func loadShimmerUI(){
        if self.canHideShimmering == false {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.mainScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }, completion: nil)
            
            let stackView0 = self.mainStackView.arrangedSubviews[0]// category
            let stackView1 = self.mainStackView.arrangedSubviews[1]// grid
            let stackView2 = self.mainStackView.arrangedSubviews[2]// pagination
            let stackView3 = self.mainStackView.arrangedSubviews[3]// empty
            let stackView4 = self.mainStackView.arrangedSubviews[4]// queries
            let stackView5 = self.mainStackView.arrangedSubviews[5]// subscription

            stackView0.isHidden = true
            stackView1.isHidden = false
            stackView2.isHidden = true
            stackView3.isHidden = true
            stackView4.isHidden = true
            stackView5.isHidden = true

            self.reloadGridCollectionView()
        }
        self.mainScrollView.isScrollEnabled = self.canHideShimmering
    }
    func callAPI(){
        self.pageNumber = Int(self.buttontitle)!
        if (self.isCategory == true){
            self.commonAPICALL(retryAPIID: 1001)
        }
        else {
            self.commonAPICALL(retryAPIID: 1000)
        }
    }
    func setButtonTitle(){
        let paginationStackView0 = self.paginationStackView.arrangedSubviews[0]// previous
        let paginationStackView1 = self.paginationStackView.arrangedSubviews[1]// first
        let paginationStackView2 = self.paginationStackView.arrangedSubviews[2]// second
        let paginationStackView3 = self.paginationStackView.arrangedSubviews[3]// third
        let paginationStackView4 = self.paginationStackView.arrangedSubviews[4]// fourth
        let paginationStackView5 = self.paginationStackView.arrangedSubviews[5]// fifth
        let paginationStackView6 = self.paginationStackView.arrangedSubviews[6]// sixth
        let paginationStackView7 = self.paginationStackView.arrangedSubviews[7]// seventh
        let paginationStackView8 = self.paginationStackView.arrangedSubviews[8]// next
        paginationStackView0.isHidden = true
        paginationStackView1.isHidden = true
        paginationStackView2.isHidden = true
        paginationStackView3.isHidden = true
        paginationStackView4.isHidden = true
        paginationStackView5.isHidden = true
        paginationStackView6.isHidden = true
        paginationStackView7.isHidden = true
        paginationStackView8.isHidden = true

            self.previousPageButton.isUserInteractionEnabled = self.hasprevious
            self.nextPageButton.isUserInteractionEnabled = self.hasnext

        if self.totalPages > 7{
            if !(self.buttontitle == "..."){
                self.firstButtontitle = "1"
                self.seventhButtontitle = "\(self.totalPages)"
                self.firstButton.setTitle(firstButtontitle, for: .normal)
                self.seventhButton.setTitle(seventhButtontitle, for: .normal)
                paginationStackView0.isHidden = false
                //                paginationStackView0.isHidden = !self.hasprevious
                paginationStackView1.isHidden = false
                paginationStackView7.isHidden = false
                paginationStackView8.isHidden = false
                //                paginationStackView8.isHidden = !self.hasnext

                if (Int(self.buttontitle)  == 1) || (Int(self.buttontitle) == self.totalPages){
                    self.secondButtontitle = "2"
                    self.thirdButtontitle = "..."
                    self.fourthButtontitle = "..."
                    self.fifthButtontitle = "..."
                    self.sixthButtontitle = "\(self.totalPages - 1)"
                    paginationStackView2.isHidden = false
                    paginationStackView3.isHidden = false
                    paginationStackView4.isHidden = true
                    paginationStackView5.isHidden = true
                    paginationStackView6.isHidden = false
                }
                else if (Int(self.buttontitle)  == 2){
                    self.secondButtontitle = "2"
                    self.thirdButtontitle = "3"
                    self.fourthButtontitle = "..."
                    self.fifthButtontitle = "..."
                    self.sixthButtontitle = "..."
                    paginationStackView2.isHidden = false
                    paginationStackView3.isHidden = false
                    paginationStackView4.isHidden = false
                    paginationStackView5.isHidden = true
                    paginationStackView6.isHidden = true
                }
                else if (Int(self.buttontitle)  == 3){
                    self.secondButtontitle = "2"
                    self.thirdButtontitle = "3"
                    self.fourthButtontitle = "4"
                    self.fifthButtontitle = "..."
                    self.sixthButtontitle = "..."
                    paginationStackView2.isHidden = false
                    paginationStackView3.isHidden = false
                    paginationStackView4.isHidden = false
                    paginationStackView5.isHidden = false
                    paginationStackView6.isHidden = true
                }
                else if (Int(self.buttontitle)  == 4){
                    self.secondButtontitle = "..."
                    self.thirdButtontitle = "3"
                    self.fourthButtontitle = "4"
                    self.fifthButtontitle = "5"
                    self.sixthButtontitle = "..."
                    paginationStackView2.isHidden = false
                    paginationStackView3.isHidden = false
                    paginationStackView4.isHidden = false
                    paginationStackView5.isHidden = false
                    paginationStackView6.isHidden = false
                }
                else if (Int(self.buttontitle) == self.totalPages - 4){
                    self.secondButtontitle = "..."
                    self.thirdButtontitle = "\(self.totalPages - 5)"
                    self.fourthButtontitle = "\(self.totalPages - 4)"
                    self.fifthButtontitle = "\(self.totalPages - 3)"
                    self.sixthButtontitle = "..."
                    paginationStackView2.isHidden = false
                    paginationStackView3.isHidden = false
                    paginationStackView4.isHidden = false
                    paginationStackView5.isHidden = false
                    paginationStackView6.isHidden = false
                }
                else if (Int(self.buttontitle) == self.totalPages - 3){
                    self.secondButtontitle = "..."
                    self.thirdButtontitle = "\(self.totalPages - 4)"
                    self.fourthButtontitle = "\(self.totalPages - 3)"
                    self.fifthButtontitle = "\(self.totalPages - 2)"
                    self.sixthButtontitle = "..."
                    paginationStackView2.isHidden = false
                    paginationStackView3.isHidden = false
                    paginationStackView4.isHidden = false
                    paginationStackView5.isHidden = false
                    paginationStackView6.isHidden = false
                }
                else if (Int(self.buttontitle) == self.totalPages - 2){
                    self.secondButtontitle = "..."
                    self.thirdButtontitle = "..."
                    self.fourthButtontitle = "\(self.totalPages - 3)"
                    self.fifthButtontitle = "\(self.totalPages - 2)"
                    self.sixthButtontitle = "\(self.totalPages - 1)"
                    paginationStackView2.isHidden = true
                    paginationStackView3.isHidden = false
                    paginationStackView4.isHidden = false
                    paginationStackView5.isHidden = false
                    paginationStackView6.isHidden = false
                }
                else if (Int(self.buttontitle) == self.totalPages - 1){
                    self.secondButtontitle = "..."
                    self.thirdButtontitle = "..."
                    self.fourthButtontitle = "..."
                    self.fifthButtontitle = "\(self.totalPages - 2)"
                    self.sixthButtontitle = "\(self.totalPages - 1)"
                    paginationStackView2.isHidden = true
                    paginationStackView3.isHidden = true
                    paginationStackView4.isHidden = false
                    paginationStackView5.isHidden = false
                    paginationStackView6.isHidden = false
                }
                else{
                    self.secondButtontitle = "..."
                    self.thirdButtontitle = "\(Int(self.buttontitle)! + 1)"
                    self.fourthButtontitle = "\(Int(self.buttontitle)! + 2)"
                    self.fifthButtontitle = "\(Int(self.buttontitle)! + 3)"
                    self.sixthButtontitle = "..."
                    paginationStackView2.isHidden = false
                    paginationStackView3.isHidden = false
                    paginationStackView4.isHidden = false
                    paginationStackView5.isHidden = false
                    paginationStackView6.isHidden = false
                }
                self.secondButton.setTitle(secondButtontitle, for: .normal)
                self.thirdButton.setTitle(thirdButtontitle, for: .normal)
                self.fourthButton.setTitle(fourthButtontitle, for: .normal)
                self.fifthButton.setTitle(fifthButtontitle, for: .normal)
                self.sixthButton.setTitle(sixthButtontitle, for: .normal)
            }
        }
        else{
            self.secondButtontitle = "2"
            self.thirdButtontitle = "3"
            self.fourthButtontitle = "4"
            self.fifthButtontitle = "5"
            self.sixthButtontitle = "6"
            self.seventhButtontitle = "7"

            paginationStackView0.isHidden = false
            //            paginationStackView0.isHidden = !self.hasprevious
            paginationStackView1.isHidden = false
            paginationStackView8.isHidden = false
            //            paginationStackView8.isHidden = !self.hasnext

            self.secondButton.setTitle(secondButtontitle, for: .normal)
            self.thirdButton.setTitle(thirdButtontitle, for: .normal)
            self.fourthButton.setTitle(fourthButtontitle, for: .normal)
            self.fifthButton.setTitle(fifthButtontitle, for: .normal)
            self.sixthButton.setTitle(sixthButtontitle, for: .normal)
            if self.totalPages == 7{
                paginationStackView2.isHidden = false
                paginationStackView3.isHidden = false
                paginationStackView4.isHidden = false
                paginationStackView5.isHidden = false
                paginationStackView6.isHidden = false
                paginationStackView7.isHidden = false
            }
            else if self.totalPages == 6 {
                paginationStackView2.isHidden = false
                paginationStackView3.isHidden = false
                paginationStackView4.isHidden = false
                paginationStackView5.isHidden = false
                paginationStackView6.isHidden = false
            }
            else if self.totalPages == 5 {
                paginationStackView2.isHidden = false
                paginationStackView3.isHidden = false
                paginationStackView4.isHidden = false
                paginationStackView5.isHidden = false
            }
            else if self.totalPages == 4 {
                paginationStackView2.isHidden = false
                paginationStackView3.isHidden = false
                paginationStackView4.isHidden = false
            }
            else if self.totalPages == 3 {
                paginationStackView2.isHidden = false
                paginationStackView3.isHidden = false
            }
            else if self.totalPages == 2 {
                paginationStackView2.isHidden = false
            }
        }
        self.setDefaultButtonUI()
    }

    func setDefaultButtonUI(){
        self.setSelectedButton(button: self.firstButton, backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF, titleColor: UIColor.colorLiteral.theme_black_333333, borderColor: UIColor.colorLiteral.theme_grey_999999)
        self.setSelectedButton(button: self.secondButton, backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF, titleColor: UIColor.colorLiteral.theme_black_333333, borderColor: UIColor.colorLiteral.theme_grey_999999)
        self.setSelectedButton(button: self.thirdButton, backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF, titleColor: UIColor.colorLiteral.theme_black_333333, borderColor: UIColor.colorLiteral.theme_grey_999999)
        self.setSelectedButton(button: self.fourthButton, backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF, titleColor: UIColor.colorLiteral.theme_black_333333, borderColor: UIColor.colorLiteral.theme_grey_999999)
        self.setSelectedButton(button: self.fifthButton, backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF, titleColor: UIColor.colorLiteral.theme_black_333333, borderColor: UIColor.colorLiteral.theme_grey_999999)
        self.setSelectedButton(button: self.sixthButton, backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF, titleColor: UIColor.colorLiteral.theme_black_333333, borderColor: UIColor.colorLiteral.theme_grey_999999)
        self.setSelectedButton(button: self.seventhButton, backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF, titleColor: UIColor.colorLiteral.theme_black_333333, borderColor: UIColor.colorLiteral.theme_grey_999999)
        if (self.hasprevious == false){
            self.setSelectedButton(button: self.previousPageButton, backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF, titleColor: UIColor.colorLiteral.theme_grey_3C3C43_18, borderColor: UIColor.colorLiteral.theme_grey_3C3C43_18)
        }
        else{
            self.setSelectedButton(button: self.previousPageButton, backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF, titleColor: UIColor.colorLiteral.theme_grey_777777, borderColor: UIColor.colorLiteral.theme_grey_999999)
        }
        if (self.hasnext == false){
            self.setSelectedButton(button: self.nextPageButton, backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF, titleColor: UIColor.colorLiteral.theme_grey_3C3C43_18, borderColor: UIColor.colorLiteral.theme_grey_3C3C43_18)
        }
        else{
            self.setSelectedButton(button: self.nextPageButton, backgroundColor: UIColor.colorLiteral.theme_white_FFFFFF, titleColor: UIColor.colorLiteral.theme_grey_777777, borderColor: UIColor.colorLiteral.theme_grey_999999)
        }

        if self.buttontitle == self.firstButton.currentTitle {
            self.setSelectedButton(button: self.firstButton, backgroundColor: UIColor.colorLiteral.theme_blue_DCF3FF, titleColor: UIColor.colorLiteral.theme_blue_2AACEF, borderColor: UIColor.colorLiteral.theme_blue_2AACEF)
        }  else if self.buttontitle == self.secondButton.currentTitle{
            self.setSelectedButton(button: self.secondButton, backgroundColor: UIColor.colorLiteral.theme_blue_DCF3FF, titleColor: UIColor.colorLiteral.theme_blue_2AACEF, borderColor: UIColor.colorLiteral.theme_blue_2AACEF)
        } else if self.buttontitle == self.thirdButton.currentTitle{
            self.setSelectedButton(button: self.thirdButton, backgroundColor: UIColor.colorLiteral.theme_blue_DCF3FF, titleColor: UIColor.colorLiteral.theme_blue_2AACEF, borderColor: UIColor.colorLiteral.theme_blue_2AACEF)
        } else if self.buttontitle == self.fourthButton.currentTitle{
            self.setSelectedButton(button: self.fourthButton, backgroundColor: UIColor.colorLiteral.theme_blue_DCF3FF, titleColor: UIColor.colorLiteral.theme_blue_2AACEF, borderColor: UIColor.colorLiteral.theme_blue_2AACEF)
        } else if self.buttontitle == self.fifthButton.currentTitle{
            self.setSelectedButton(button: self.fifthButton, backgroundColor: UIColor.colorLiteral.theme_blue_DCF3FF, titleColor: UIColor.colorLiteral.theme_blue_2AACEF, borderColor: UIColor.colorLiteral.theme_blue_2AACEF)
        } else if self.buttontitle == self.sixthButton.currentTitle{
            self.setSelectedButton(button: self.sixthButton, backgroundColor: UIColor.colorLiteral.theme_blue_DCF3FF, titleColor: UIColor.colorLiteral.theme_blue_2AACEF, borderColor: UIColor.colorLiteral.theme_blue_2AACEF)
        } else if self.buttontitle == self.seventhButton.currentTitle{
            self.setSelectedButton(button: self.seventhButton, backgroundColor: UIColor.colorLiteral.theme_blue_DCF3FF, titleColor: UIColor.colorLiteral.theme_blue_2AACEF, borderColor: UIColor.colorLiteral.theme_blue_2AACEF)
        } else{
            self.setSelectedButton(button: self.firstButton, backgroundColor: UIColor.colorLiteral.theme_blue_DCF3FF, titleColor: UIColor.colorLiteral.theme_blue_2AACEF, borderColor: UIColor.colorLiteral.theme_blue_2AACEF)
        }
    }

    func setSelectedButton(button:UIButton,backgroundColor:UIColor,titleColor:UIColor,borderColor:UIColor){
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = AppConstantValue.cornerRadius4
        button.clipsToBounds = true
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = 1.0
        button.setNeedsDisplay()
        button.layoutIfNeeded()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    func queriesAuthorised(){
        self.isQueriesAccepted == false ? ( self.isQueriesAccepted = true) : ( self.isQueriesAccepted = false)
        self.queriesAuthoriseButton.setImage(self.isQueriesAccepted == false ? UIImage(named: Asset.checksquaregrey) : UIImage(named: Asset.checksquarenavybluefill), for: .normal)
    }

    // MARK: - TextField Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeField.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && (string == " ") {
            return false
        }
        var maxLength = 255
        if textField == self.queriesMobileTextField  {
            maxLength = 10
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.numericRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        } else if textField == self.queriesNameTextField{
            maxLength = 50
            if string == "" {return true}
            let predicate = NSPredicate(format: "SELF MATCHES %@", AppConstantValue.nameRegEx)
            let predicateBool = predicate.evaluate(with: string)
            if predicateBool == false {
                return predicateBool
            }
        }
        else{
            maxLength = 500
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
        //        self.setUserInteractionPostButton()
    }
    func textViewDidChange(_ textView: UITextView) {
        //        self.setUserInteractionPostButton()
    }

    //    func textViewDidBeginEditing(_ textView: UITextView) {
    //        activeField = textView
    //    }
}
extension BlogsListViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        self.navigateBackToViewController()
    }
    func rightButtonPressed() {
        self.navigateToBlogsSearchViewController()
    }
}
extension BlogsListViewController: ProtocolNetworkRechabilityDelegate {
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
extension BlogsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.canHideShimmering == false){
            return 5
        }
        else{
            return self.gridArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (self.canHideShimmering == false){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BlogsShimmerCollectionViewCell, for: indexPath) as! BlogsShimmerCollectionViewCell
            cell.configure(canHideShimmering: self.canHideShimmering)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BlogsListCollectionViewCell, for: indexPath) as! BlogsListCollectionViewCell
            cell.configure(article: self.gridArray[indexPath.item], indexpath: indexPath.item)
            cell.delegate = self
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = 0
        var cellHeight: CGFloat = 0
        if self.gridArray.count > 0  || (self.canHideShimmering == false) {
            cellWidth = self.gridCollectionViewItemWidth
            cellHeight = self.gridCollectionViewItemHeight
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }

}
extension BlogsListViewController: ProtocolBlogsListCollectionViewCell {
    func tapButtonPressedBlogsListCollectionViewCell(senderTag: Int) {
        if (self.gridArray.count > 0) {
            if !(self.gridArray[senderTag].slug.isNilOrEmpty){
                self.navigateToBlogsDetailViewController(slug: self.gridArray[senderTag].slug!.allowSpecialCharacters,isFrom: IsNavigateFrom.blogslist.rawValue)
            }
        }
    }
}
