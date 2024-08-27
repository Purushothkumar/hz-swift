//
//  BlogsSearchViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 05/06/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

//
//  BlogsSearchViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 31/05/24.
//  Copyright © 2024 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift

class BlogsSearchViewController: UIViewController,UISearchBarDelegate {
    // MARK: - IBOutlets
    @IBOutlet var navigationBar: UIView!
    @IBOutlet var backButton: FootnoteOutlineButton!
    @IBOutlet var searchButton: FootnoteOutlineButton!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var mainBackgroundView: UIView!

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

    // MARK: - Lets and Var
    var gridArray = [BlogsListModelArticle]()
    let gridCollectionViewMargin = CGFloat(0)
    let gridCollectionViewItemSpacing = CGFloat(16)
    var gridCollectionViewItemHeight = CGFloat(308)
    var gridCollectionViewItemWidth = CGFloat(343)
    let gridCollectionViewlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()


    var totalPages = 1
    var pageNumber = 1

    var blogsSearchViewModel = BlogsSearchViewModel()
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

    var isSearch = false
    var searchblog = ""
    var canHideShimmering = false

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeStatusBarColor()
        self.changeLanguageFormat()
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
        
        self.searchBar.layer.cornerRadius = AppConstantValue.cornerRadius4
        self.searchBar.clipsToBounds = true
        self.searchBar.layer.borderColor =  UIColor.colorLiteral.theme_white_FFFFFF.cgColor
        self.searchBar.layer.borderWidth = 1.0
//        self.searchBar.searchTextField.setLeftPaddingPoints(10.0)
//        self.searchBar.searchTextField.setRightPaddingPoints(10.0)
        self.searchBar.delegate = self
        self.searchBar.text = ""
        self.searchBar.tintColor = UIColor.colorLiteral.theme_black_333333
        self.searchBar.searchTextField.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF
        self.searchBar.searchTextField.tintColor = UIColor.colorLiteral.theme_black_333333
        self.searchBar.searchTextField.textColor = UIColor.colorLiteral.theme_black_333333
        self.searchBar.setSearchImage(color: UIColor.colorLiteral.theme_black_333333)
        self.searchBar.setClearButton(color: UIColor.colorLiteral.theme_black_333333)
        
//        self.searchBar.set(textColor: UIColor.colorLiteral.theme_black_333333)
//        self.searchBar.setTextField(color: UIColor.colorLiteral.theme_black_333333)

        self.isSearch = false

        let stackView0 = self.mainStackView.arrangedSubviews[0]// grid
        let stackView1 = self.mainStackView.arrangedSubviews[1]// pagination

        stackView0.isHidden = true
        stackView1.isHidden = true
        
        self.errorView.isHidden = true
        self.reloadGridCollectionView()
        self.searchBar.becomeFirstResponder()
    }


    // MARK: - Localization String
    func changeLanguageFormat() {
        self.primaryMessageLabel.text = AppLocalizationString.noBlogsFound

        var searchBlogPlaceholder = NSMutableAttributedString()
        // Set the Font
        searchBlogPlaceholder = NSMutableAttributedString(string:AppLocalizationString.searchBlogs, attributes: [NSAttributedString.Key.font:AppFont.regular.size(13)])
        // Set the color
        searchBlogPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.colorLiteral.theme_grey_777777, range:NSRange(location:0,length:AppLocalizationString.searchBlogs.count))
        // Add attribute
        self.searchBar.searchTextField.attributedPlaceholder = searchBlogPlaceholder
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
                    self.getBlogsSearchList(retryAPIID: retryAPIID, canShowLoader: false)
                }
            } else {
                self.showInternetPopupScreen(retryAPIID: retryAPIID)
            }
        }
    }

    func getBlogsSearchList(retryAPIID: Int, canShowLoader: Bool) {
        self.canHideShimmering = false
        self.loadShimmerUI()
            var strQuery = ""
        if !(self.searchblog.isEmpty){
                strQuery = String(format: "&search=%@&page_size=12", self.searchblog.allowSpecialCharacters)
            }
            self.blogsSearchViewModel.getBlogsSearchList(canShowLoader: canShowLoader, viewCon: self, subAPIUrl: SubAPIUrl.getBlogsSearchList, methodName: HTTPMethods.get, parameter: "", pageNumber: "\(self.pageNumber)", retryAPIID: retryAPIID, strQuery: strQuery)
    }

    // MARK: - IBAction
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigateBackToViewController()
    }
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

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        self.searchblog = self.searchBar.text ?? ""
        self.searchBlogs()
    }

    // MARK: - Custom Methods
    func loadShimmerUI(){
        if self.canHideShimmering == false {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.mainScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }, completion: nil)
            
            let stackView0 = self.mainStackView.arrangedSubviews[0]// grid
            let stackView1 = self.mainStackView.arrangedSubviews[1]// pagination

            stackView0.isHidden = false
            stackView1.isHidden = true
            self.errorView.isHidden = true

            self.reloadGridCollectionView()
        }
        self.mainScrollView.isScrollEnabled = self.canHideShimmering
    }
    func callAPI(){
        if !(self.searchblog.isEmpty){
            self.isSearch = true
        }
        else{
            self.isSearch = false
        }
        self.pageNumber = Int(self.buttontitle)!
        if (self.isSearch == true){
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
                paginationStackView1.isHidden = false
                paginationStackView7.isHidden = false
                paginationStackView8.isHidden = false
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
            paginationStackView1.isHidden = false
            paginationStackView8.isHidden = false

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
    func searchBlogs(){
        if !(self.searchblog.isEmpty){
            self.isSearch = true
            self.pageNumber = 1
            self.buttontitle = "1"
            self.callAPI()
        }
        else{
            self.showToastAlert(AppLocalizationString.searchBlogEmpty, txtcolor: UIColor.colorLiteral.theme_white_FFFFFF, bgColor: UIColor.colorLiteral.theme_red_FF6961, viewCon: self)
        }
    }
    // MARK: - TextField Delegates
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearch = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearch = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearch = false;
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.searchBar.showsCancelButton = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.isSearch = false
        self.searchblog = self.searchBar.text ?? ""
        self.searchBlogs()
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isSearch = true;
        self.searchBar.showsCancelButton = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.resignFirstResponder()
        self.searchBar.endEditing(true)
        self.view.endEditing(true)
        self.searchBar.searchTextField.endEditing(true)
        self.searchBar.showsCancelButton = false
        self.searchBar.text = ""

    }
}
extension BlogsSearchViewController: ProtocolNetworkRechabilityDelegate {
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
extension BlogsSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.canHideShimmering == false){
            return 5
        } else {
            return self.gridArray.count
        }

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (self.canHideShimmering == false){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BlogsShimmerCollectionViewCell, for: indexPath) as! BlogsShimmerCollectionViewCell
            cell.configure(canHideShimmering: self.canHideShimmering)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.BlogsSearchCollectionViewCell, for: indexPath) as! BlogsSearchCollectionViewCell
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
extension BlogsSearchViewController: ProtocolBlogsSearchCollectionViewCell {
    func tapButtonPressedBlogsSearchCollectionViewCell(senderTag: Int) {
        if (self.gridArray.count > 0) {
            if !(self.gridArray[senderTag].slug.isNilOrEmpty){
                self.navigateToBlogsDetailViewController(slug: self.gridArray[senderTag].slug!.allowSpecialCharacters,isFrom: IsNavigateFrom.blogssearch.rawValue)
            }
        }
    }
}
