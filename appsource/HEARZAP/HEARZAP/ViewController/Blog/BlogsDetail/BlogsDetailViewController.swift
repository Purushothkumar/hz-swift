//
//  BlogsDetailViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 31/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import DropDown
import WebKit
import IQKeyboardManagerSwift

class BlogsDetailViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,WKNavigationDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: TitleNavigationBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

    @IBOutlet var blogView: UIView!
    @IBOutlet var blogStackView: UIStackView!
    @IBOutlet var titleLabel: Caption2FontLabel!
    @IBOutlet var descriptionLabel: Footnote1FontLabel!
    @IBOutlet var timeLabel: Caption2FontLabel!
    @IBOutlet var contentLabel: BodyFontLabel!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var bannerImageViewHeight: NSLayoutConstraint!

    @IBOutlet var blogwebView: UIView!
    @IBOutlet var webview: WKWebView!
    @IBOutlet var webviewheight: NSLayoutConstraint!

    @IBOutlet var relatedBlogsTitleView: UIView!
    @IBOutlet var relatedBlogsTitleLabel: Title2FontLabel!

    @IBOutlet var gridView: UIView!
    @IBOutlet var gridCollectionView: UICollectionView!
    @IBOutlet var gridCollectionViewHeight: NSLayoutConstraint!

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

    @IBOutlet var recentBlogsTitleView: UIView!
    @IBOutlet var recentBlogsTitleLabel: Title2FontLabel!

    @IBOutlet var recentBlogsListView: UIView!
    @IBOutlet var recentBlogsTableView: UITableView!
    @IBOutlet var recentBlogsTableViewHeight: NSLayoutConstraint!

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
    var categoryList = ["All","Hearing Care","Hearing loss"]
    var gridArray = [BlogsDetailModelArticle]()
    let gridCollectionViewMargin = CGFloat(0)
    let gridCollectionViewItemSpacing = CGFloat(16)
    var gridCollectionViewItemHeight = CGFloat(308)
    var gridCollectionViewItemWidth = CGFloat(343)
    let gridCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    var catergoryName = ""
    var catergorySlug = ""
    var slug = ""
    var isFrom = ""
    var htmlstring = ""

    var isQueriesAccepted = true
    var activeField = UITextField()
    var listArray = [BlogsDetailModelArticle]()
    var blogsDetailViewModel = BlogsDetailViewModel()
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
        self.webviewheight.constant = self.webview.scrollView.contentSize.height
        if self.listArray.count > 0 {
            self.recentBlogsTableViewHeight.constant = self.recentBlogsTableView.contentSize.height
        } else {
            self.recentBlogsTableViewHeight.constant = 0
        }
        if !(self.htmlstring.isEmpty){
            self.webviewheight.constant = self.webview.scrollView.contentSize.height
        } else {
            self.webviewheight.constant = 0
        }
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

        self.recentBlogsTableView.tableFooterView = UIView()
        self.recentBlogsTableView.separatorColor = UIColor.clear
        self.recentBlogsTableView.backgroundColor = UIColor.clear
        self.recentBlogsTableView.rowHeight = UITableView.automaticDimension
        self.recentBlogsTableView.estimatedRowHeight = UITableView.automaticDimension

        self.commonAPICALL(retryAPIID: 1000)
    }

    // MARK: - Set Navigation Bar
    func setNavigationBar() {
        self.navigationBar.isLeftViewHidden = false
        self.navigationBar.isRightViewHidden = true
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
        //        subscriptionPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_red_FF6961, range:NSRange(location:0,length:AppLocalizationString.youremailgoeshere.count))
        subscriptionPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_grey_777777, range:NSRange(location:0,length:AppLocalizationString.youremailgoeshere.count))
        // Add attribute
        self.subscriptionEmailTextField.attributedPlaceholder = subscriptionPlaceholder

        self.subscriptionButton.setTitle(AppLocalizationString.subscribe.uppercased(), for: .normal)

        self.recentBlogsTitleLabel.text = AppLocalizationString.recentBlogs
        self.relatedBlogsTitleLabel.text = AppLocalizationString.relatedBlogs

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
    // MARK: - Reload
    func reloadRecentBlogsTableView() {
        self.recentBlogsTableView.delegate = self
        self.recentBlogsTableView.dataSource = self
        self.recentBlogsTableView.reloadData()
    }
    func reloadWebView() {
        if !(self.htmlstring.isEmpty) {
            self.webview.loadHTMLString("<!DOCTYPE html><head><meta charset='utf-8'><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' /><link href='https://fonts.googleapis.com/css?family=Poppins' rel='stylesheet'><style>:root,* {font-family: 'Poppins';text-align: left;-webkit-user-select: none;user-select: none;}</style></head><body style='color:black;'>\(self.htmlstring)</body>", baseURL: nil)
            self.webview.navigationDelegate = self
            self.webview.reload()
        }
    }
    // MARK: - APICALL
    func commonAPICALL(retryAPIID: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if Reachability.isConnectedToNetwork() {
                if retryAPIID == 1000 {
                    self.getBlogsDetail(retryAPIID: retryAPIID, canShowLoader: false)
                }
                else if retryAPIID == 1001 {
                    self.postBlogsQueries(retryAPIID: retryAPIID, canShowLoader: true)
                }
                else if retryAPIID == 1002 {
                    self.postBlogsNewsletter(retryAPIID: retryAPIID, canShowLoader: true)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }
    func getBlogsDetail(retryAPIID: Int, canShowLoader: Bool) {
        self.canHideShimmering = false
        self.loadShimmerUI()
            let subUrl = "\(SubAPIUrl.getBlogsDetail)\(self.slug)/"
            self.blogsDetailViewModel.getBlogsDetail(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: subUrl, methodName: HTTPMethods.get, parameter: "", pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postBlogsQueries(retryAPIID: Int, canShowLoader: Bool) {
        let param =  String(format: "name=%@&phone_number=%@%@&state=%@&email_address=%@&comments=%@", self.queriesNameTextField.text!.allowSpecialCharacters, "+91".allowSpecialCharacters,self.queriesMobileTextField.text!.allowSpecialCharacters,self.queriesStateTextField.text!.allowSpecialCharacters,self.queriesEmailTextField.text!.allowSpecialCharacters,self.queriesCommentTextView.text!.allowSpecialCharacters)
        let subUrl = "\(SubAPIUrl.postBlogsQueries)view/"

        self.blogsDetailViewModel.postBlogsQueries(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: subUrl, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }
    func postBlogsNewsletter(retryAPIID: Int, canShowLoader: Bool) {
        let subUrl = "\(SubAPIUrl.postBlogsNewsletter)view/"

        let param =  String(format: "email_address=%@", self.subscriptionEmailTextField.text!.allowSpecialCharacters)
        self.blogsDetailViewModel.postBlogsNewsletter(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: subUrl, methodName: HTTPMethods.post, parameter: param, pageNumber: "", retryAPIID: retryAPIID, strQuery: "")
    }

    // MARK: - IBAction
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
        } else if self.queriesMobileTextField.text.isNilOrEmpty{
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
            self.commonAPICALL(retryAPIID: 1001)
        }
    }
    @IBAction func subscriptionButtonPressed(_ sender: UIButton) {
        if self.subscriptionEmailTextField.text.isNilOrEmpty || self.subscriptionEmailTextField.text!.isEmailValid == false {
            self.showToastAlert(AppLocalizationString.pleaseentervalidemailaddress, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
        else{
            self.commonAPICALL(retryAPIID: 1002)
        }
    }

    // MARK: - Custom Methods
    func loadShimmerUI(){
        if self.canHideShimmering == false {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.mainScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }, completion: nil)

            let stackView0 = self.mainStackView.arrangedSubviews[0]// Blog
            let stackView1 = self.mainStackView.arrangedSubviews[1]// Related Articles title
            let stackView2 = self.mainStackView.arrangedSubviews[2]// Related Articles
            let stackView3 = self.mainStackView.arrangedSubviews[3]// queries
            let stackView4 = self.mainStackView.arrangedSubviews[4]// Recent Articles title
            let stackView5 = self.mainStackView.arrangedSubviews[5]// Recent Articles
            let stackView6 = self.mainStackView.arrangedSubviews[6]// subscription

            stackView0.isHidden = true
            stackView1.isHidden = true
            stackView2.isHidden = false
            stackView3.isHidden = true
            stackView4.isHidden = true
            stackView5.isHidden = true
            stackView6.isHidden = true
            self.reloadGridCollectionView()
        }
        self.mainScrollView.isScrollEnabled = self.canHideShimmering
    }
    func queriesAuthorised(){
        self.isQueriesAccepted == false ? ( self.isQueriesAccepted = true) : ( self.isQueriesAccepted = false)
        self.queriesAuthoriseButton.setImage(self.isQueriesAccepted == false ? UIImage(named: Asset.checksquaregrey) : UIImage(named: Asset.checksquarenavybluefill), for: .normal)
    }
    // MARK: - WKWebview Delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.webview.frame.size.height = 1
            self.webview.frame.size = webView.scrollView.contentSize
            self.webviewheight.constant = webView.scrollView.contentSize.height
            self.view.layoutIfNeeded()
            self.viewWillLayoutSubviews()
        }
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard case .linkActivated = navigationAction.navigationType,
              let url = navigationAction.request.url
        else {
            decisionHandler(.allow)
            return
        }
        decisionHandler(.cancel)
        var websiteLink = ""
        websiteLink = navigationAction.request.url?.absoluteString ?? ""
        if !(websiteLink.isEmpty) {
            guard let appURL = URL(string: websiteLink.checkhttpCharacter) else {
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
extension BlogsDetailViewController: ProtocolTitleNavigationBar {
    // MARK: - Navigation Bar Delegates
    func leftButtonPressed() {
        if (isFrom == IsNavigateFrom.blogslist.rawValue){
            self.navigateBackToViewController()
        } else if (isFrom == IsNavigateFrom.blogssearch.rawValue){
            self.navigateBackToViewController()
        } else if (isFrom == IsNavigateFrom.blogsdetailrecent.rawValue){
            self.navigateBackToViewController()
        } else if (isFrom == IsNavigateFrom.blogsdetailrelated.rawValue){
            self.navigateBackToViewController()
        } else {
            self.navigateBackToViewController()
        }
    }
    func rightButtonPressed() {
    }
}
extension BlogsDetailViewController: ProtocolNetworkRechabilityDelegate {
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
extension BlogsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.canHideShimmering == false){
            return 5
        }else{
            return self.gridArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (self.canHideShimmering == false){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BlogsShimmerCollectionViewCell, for: indexPath) as! BlogsShimmerCollectionViewCell
            cell.configure(canHideShimmering: self.canHideShimmering)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BlogsDetailCollectionViewCell, for: indexPath) as! BlogsDetailCollectionViewCell
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
extension BlogsDetailViewController: ProtocolBlogsDetailCollectionViewCell {
    func tapButtonPressedBlogsDetailCollectionViewCell(senderTag: Int) {
        if (self.gridArray.count > 0) {
            if !(self.gridArray[senderTag].slug.isNilOrEmpty){
                self.navigateToBlogsDetailViewController(slug: self.gridArray[senderTag].slug!.allowSpecialCharacters, isFrom: IsNavigateFrom.blogsdetailrelated.rawValue)
            }
        }
    }
}
extension BlogsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.BlogsDetailTableViewCell, for: indexPath) as! BlogsDetailTableViewCell
        cell.configure(article: self.listArray[indexPath.row], indexpath: indexPath.row)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.recentBlogsTableViewHeight.constant = tableView.contentSize.height
        self.view.layer.layoutIfNeeded()
        self.viewWillLayoutSubviews()
    }
}

extension BlogsDetailViewController: ProtocolBlogsDetailTableViewCell {
    func tapButtonPressedBlogsDetailTableViewCell(senderTag: Int) {
        if self.listArray.count > 0 {
            if !(self.listArray[senderTag].slug.isNilOrEmpty){
                self.navigateToBlogsDetailViewController(slug: self.listArray[senderTag].slug!.allowSpecialCharacters,isFrom: IsNavigateFrom.blogsdetailrecent.rawValue)
            }
        }
    }
}
