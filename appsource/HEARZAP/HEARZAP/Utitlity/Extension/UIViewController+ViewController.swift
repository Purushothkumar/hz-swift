//
//  UIViewController+ViewController.swift
//  HEARZAP
//
//  Created by Purushoth on 01/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import CallKit
import MediaPlayer
import Photos

extension UIViewController {
    /*
     *******************************************
     Navigate to respective ViewController
     *******************************************
     */
    // MARK: - StoryBoard User Credential
    func navigateToLoginViewController(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserCredential, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.LoginViewController) as! LoginViewController
            viewCon.isFrom = isFrom
            viewCon.isWishList = isWishlist
            viewCon.productUID = productUID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToSignupViewController(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserCredential, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.SignupViewController) as! SignupViewController
            viewCon.isFrom = isFrom
            viewCon.isWishList = isWishlist
            viewCon.productUID = productUID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToOTPVerificationViewController(isFrom: String, mobileNumber: String, isLogin: Bool, name: String, phoneToken: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserCredential, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OTPVerificationViewController) as! OTPVerificationViewController
            viewCon.mobileNumber = mobileNumber
            viewCon.isFrom = isFrom
            viewCon.isLogin = isLogin
            viewCon.name = name
            viewCon.phoneToken = phoneToken
            viewCon.isWishList = isWishlist
            viewCon.productUID = productUID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToOTPSuccessViewController(isFrom: String, isLogin: Bool, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserCredential, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OTPSuccessViewController) as! OTPSuccessViewController
            viewCon.isFrom = isFrom
            viewCon.isLogin = isLogin
            viewCon.isWishList = isWishlist
            viewCon.productUID = productUID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    // MARK: - StoryBoard home
    /* back */
    func navigateBackToHomeStaticViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is HomeStaticViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
//    func navigateBackToHomeStaticViewControllerToQuickCheck(isFrom: String, isWishlist: Bool, productUID: String) {
//        DispatchQueue.main.async {
//            self.view.endEditing(true)
//            let  viewCon: HomeStaticViewController = self.navigationController?.viewControllers.filter({$0 is HomeStaticViewController}).last as! HomeStaticViewController
//            viewCon.verifiedQuickCheckUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
//            self.navigationController?.popToViewController(viewCon, animated: true)
//        }
//    }
    // MARK: - StoryBoard HearingCare
    /* back */
    func navigateBackToHearingCareViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is HearingCareViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToHearingCareViewControllerToCart(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: HearingCareViewController = self.navigationController?.viewControllers.filter({$0 is HearingCareViewController}).last as! HearingCareViewController
            viewCon.verifiedCartUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToHearingCareViewControllerToMyAlert(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: HearingCareViewController = self.navigationController?.viewControllers.filter({$0 is HearingCareViewController}).last as! HearingCareViewController
            viewCon.verifiedMyAlertUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
//    func navigateBackToHearingCareViewControllerToQuickCheck(isFrom: String, isWishlist: Bool, productUID: String) {
//        DispatchQueue.main.async {
//            self.view.endEditing(true)
//            let  viewCon: HearingCareViewController = self.navigationController?.viewControllers.filter({$0 is HearingCareViewController}).last as! HearingCareViewController
//            viewCon.verifiedQuickCheckUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
//            self.navigationController?.popToViewController(viewCon, animated: true)
//        }
//    }
    // MARK: - StoryBoard store
    func navigateToStoreFilterViewController(queryString: String, isState: Bool, isCity: Bool, isZipCode: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Store, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.StoreFilterViewController) as! StoreFilterViewController
            viewCon.queryString = queryString
            viewCon.isState = isState
            viewCon.isCity = isCity
            viewCon.isZipCode = isZipCode
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToStoreDetailViewController(slug: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Store, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.StoreDetailViewController) as! StoreDetailViewController
            viewCon.slug = slug
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToStoreReviewViewController(slug: String, storeName: String, storeAddress: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Store, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.StoreReviewViewController) as! StoreReviewViewController
            viewCon.slug = slug
            viewCon.storeName = storeName
            viewCon.storeAddress = storeAddress
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    /* back */
    func navigateBackToStoreFinderViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is StoreFinderViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToStoreDetailViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: StoreDetailViewController = self.navigationController?.viewControllers.filter({$0 is StoreDetailViewController}).last as! StoreDetailViewController
            self.navigationController?.popToViewController(viewCon, animated: true)
            viewCon.commonAPICALL(retryAPIID: 1000)
        }
    }
    func navigateBackToStoreDetailViewControllerFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: StoreDetailViewController = self.navigationController?.viewControllers.filter({$0 is StoreDetailViewController}).last as! StoreDetailViewController
            viewCon.verifiedUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToStoreFinderViewControllerToCart(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: StoreFinderViewController = self.navigationController?.viewControllers.filter({$0 is StoreFinderViewController}).last as! StoreFinderViewController
            viewCon.verifiedCartUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToStoreFinderViewControllerToMyAlert(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: StoreFinderViewController = self.navigationController?.viewControllers.filter({$0 is StoreFinderViewController}).last as! StoreFinderViewController
            viewCon.verifiedMyAlertUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    // MARK: - StoryBoard shop
    func navigateToAccessoriesSubCategoryColorViewController(accessoriesSubcategoriesSlug: String, accessoriesSubcategoriesArray: [SubCategorySpec], accessoriesSubcategoriesTitle: String, accessoriesSubcategoriesDescription: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Shop, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.AccessoriesSubCategoryColorViewController) as! AccessoriesSubCategoryColorViewController
            viewCon.accessoriesSubcategoriesSlug = accessoriesSubcategoriesSlug
            viewCon.accessoriesSubcategoriesArray = accessoriesSubcategoriesArray
            viewCon.accessoriesSubcategoriesTitle = accessoriesSubcategoriesTitle
            viewCon.accessoriesSubcategoriesDescription = accessoriesSubcategoriesDescription
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToAccessoriesSubCategoryViewController(accessoriesSubcategoriesSlug: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Shop, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.AccessoriesSubCategoryViewController) as! AccessoriesSubCategoryViewController
            viewCon.accessoriesSubcategoriesSlug = accessoriesSubcategoriesSlug
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    func navigateToViewAllProductViewController(isFrom: String, filterSlug: String, viewAllSlug: String, styleID: Int, tabSelectedIndex: Int) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Shop, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ViewAllProductViewController) as! ViewAllProductViewController
            viewCon.delegate = (self as! ProtocolViewAllProductViewController)
            viewCon.filterSlug = filterSlug
            viewCon.viewAllSlug = viewAllSlug
            viewCon.styleID = styleID
            viewCon.tabSelectedIndex = tabSelectedIndex
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToHearingAidFilterViewController(styleArraySelected: [String], brandArraySelected: [String], featureArraySelected: NSMutableArray, specificationArraySelected: NSMutableArray) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Shop, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.HearingAidFilterViewController) as! HearingAidFilterViewController
            viewCon.styleArraySelected = styleArraySelected
            viewCon.brandArraySelected = brandArraySelected
            viewCon.featureArraySelected = featureArraySelected
            viewCon.specificationArraySelected = specificationArraySelected

            viewCon.delegate = (self as! ProtocolHearingAidFilterViewController)
            self.modalPresentationStyle = .fullScreen
            self.modalTransitionStyle = .coverVertical
            self.present(viewCon, animated: true, completion: nil)
        }
    }
    func navigateToAccessoriesFilterViewController(styleArraySelected: [String], brandArraySelected: [String], featureArraySelected: NSMutableArray, specificationArraySelected: NSMutableArray) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Shop, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.AccessoriesFilterViewController) as! AccessoriesFilterViewController
            viewCon.styleArraySelected = styleArraySelected
            viewCon.brandArraySelected = brandArraySelected
            viewCon.featureArraySelected = featureArraySelected
            viewCon.specificationArraySelected = specificationArraySelected
            viewCon.delegate = (self as! ProtocolAccessoriesFilterViewController)
            self.modalPresentationStyle = .fullScreen
            self.modalTransitionStyle = .coverVertical
            self.present(viewCon, animated: true, completion: nil)
        }
    }
    func navigateToHAProductDetailViewController(isFrom: String, productslug: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Shop, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.HAProductDetailViewController) as! HAProductDetailViewController
            viewCon.productslug = productslug
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToProductDetailViewController(isFrom: String, productslug: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Shop, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ProductDetailViewController) as! ProductDetailViewController
            viewCon.productslug = productslug
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    /* back */
    func navigateBackToShopCategoryViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is ShopCategoryViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToShopCategoryViewControllerToCart(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: ShopCategoryViewController = self.navigationController?.viewControllers.filter({$0 is ShopCategoryViewController}).last as! ShopCategoryViewController
            viewCon.verifiedCartUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToShopCategoryViewControllerToMyAlert(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: ShopCategoryViewController = self.navigationController?.viewControllers.filter({$0 is ShopCategoryViewController}).last as! ShopCategoryViewController
            viewCon.verifiedMyAlertUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToHAProductDetailViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is HAProductDetailViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToHAProductDetailViewControllerToWishlist(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: HAProductDetailViewController = self.navigationController?.viewControllers.filter({$0 is HAProductDetailViewController}).last as! HAProductDetailViewController
            viewCon.verifiedWishlistUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToProductDetailViewControllerToWishlist(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: ProductDetailViewController = self.navigationController?.viewControllers.filter({$0 is ProductDetailViewController}).last as! ProductDetailViewController
            viewCon.verifiedWishlistUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToHAProductDetailViewControllerToCart(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: HAProductDetailViewController = self.navigationController?.viewControllers.filter({$0 is HAProductDetailViewController}).last as! HAProductDetailViewController
            viewCon.verifiedCartUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToProductDetailViewControllerToCart(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: ProductDetailViewController = self.navigationController?.viewControllers.filter({$0 is ProductDetailViewController}).last as! ProductDetailViewController
            viewCon.verifiedCartUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToHAProductDetailViewControllerToCartLogo(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: HAProductDetailViewController = self.navigationController?.viewControllers.filter({$0 is HAProductDetailViewController}).last as! HAProductDetailViewController
            viewCon.verifiedCartUserLogo(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToProductDetailViewControllerToCartLogo(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: ProductDetailViewController = self.navigationController?.viewControllers.filter({$0 is ProductDetailViewController}).last as! ProductDetailViewController
            viewCon.verifiedCartUserLogo(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }

    func navigateBackToAccessoriesSubCategoryViewControllerToCart(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: AccessoriesSubCategoryViewController = self.navigationController?.viewControllers.filter({$0 is AccessoriesSubCategoryViewController}).last as! AccessoriesSubCategoryViewController
            viewCon.verifiedCartUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToAccessoriesSubCategoryColorViewControllerToCart(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: AccessoriesSubCategoryColorViewController = self.navigationController?.viewControllers.filter({$0 is AccessoriesSubCategoryColorViewController}).last as! AccessoriesSubCategoryColorViewController
            viewCon.verifiedCartUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToViewAllProductViewControllerToCart(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: ViewAllProductViewController = self.navigationController?.viewControllers.filter({$0 is AccessoriesSubCategoryViewController}).last as! ViewAllProductViewController
            viewCon.verifiedCartUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    // MARK: - StoryBoard menu
    /* back */
    func navigateBackToMenuViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToMenuViewControllerFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerSurveyFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedSurveyUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerReferFriendFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedReferFriendUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerRegisterDeviceFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedRegisterDeviceUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerCouponFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedCouponUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerAddressFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedAddressUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerProfileFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedProfileUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerRewardsFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedRewardsUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerBuyBackFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedBuyBackUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerToCart(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedCartUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerToMyAlert(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedMyAlertUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerToServiceRequest(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedServiceRequestUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerToAudiogramReport(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedAudiogramReportUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }

    func navigateBackToMenuViewControllerToOrderList(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedOrderListUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMenuViewControllerToWishlist(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MenuViewController = self.navigationController?.viewControllers.filter({$0 is MenuViewController}).last as! MenuViewController
            viewCon.verifiedWishlistUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    // MARK: - StoryBoard Quick Test
    //    func navigateToQuickTestDemoViewController(isFrom: String) {
    //        DispatchQueue.main.async {
    //            self.view.endEditing(true)
    //            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
    //            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestDemoViewController) as! QuickTestDemoViewController
    //            viewCon.isFrom = isFrom
    //            self.navigationController?.pushViewController(viewCon, animated: true)
    //        }
    //    }

    func navigateToQuickTestAddUserViewController(isEdit: Bool, isFrom: String, uid: String, name: String, dob: String, genderSlug: String, relationShipSlug: String, relationShip: String,newGuestpatientList:[PatientList]) {
            DispatchQueue.main.async {
                self.view.endEditing(true)
                let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
                let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestAddUserViewController) as! QuickTestAddUserViewController
                viewCon.isFrom = isFrom
                viewCon.newGuestpatientList = newGuestpatientList
                viewCon.isEdit = isEdit
                viewCon.isFrom = isFrom
                viewCon.uid = uid
                viewCon.name = name
                viewCon.dob = dob
                viewCon.genderSlug = genderSlug
                viewCon.relationShipSlug = relationShipSlug
                viewCon.relationShip = relationShip
                self.navigationController?.pushViewController(viewCon, animated: true)
            }
        }

    func navigateToQuickTestProfileViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestProfileViewController) as! QuickTestProfileViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToQuickTestHeadsetConnectivityViewController(isFrom: String, patientData: PatientList, sessionID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestHeadsetConnectivityViewController) as! QuickTestHeadsetConnectivityViewController
            viewCon.isFrom = isFrom
            viewCon.patientData = patientData
            viewCon.sessionID = sessionID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToQuickTestNoiseLevelViewController(isFrom: String, patientData: PatientList, sessionID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestNoiseLevelViewController) as! QuickTestNoiseLevelViewController
            viewCon.isFrom = isFrom
            viewCon.patientData = patientData
            viewCon.sessionID = sessionID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToQuickTestEarCheckViewController(isFrom: String, patientData: PatientList, sessionID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestEarCheckViewController) as! QuickTestEarCheckViewController
            viewCon.isFrom = isFrom
            viewCon.patientData = patientData
            viewCon.sessionID = sessionID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToQuickTestSelectEarViewController(isFrom: String, earTestCount: Int, selectedEar: String, patientData: PatientList, sessionID: String, dictLeft: [String: String], dictRight: [String: String], arrayLeft: [Int], arrayRight: [Int]) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestSelectEarViewController) as! QuickTestSelectEarViewController
            viewCon.selectedEar = selectedEar
            viewCon.earTestCount = earTestCount
            viewCon.isFrom = isFrom
            viewCon.patientData = patientData
            viewCon.sessionID = sessionID
            viewCon.dictLeft = dictLeft
            viewCon.dictRight = dictRight
            viewCon.arrayLeft = arrayLeft
            viewCon.arrayRight = arrayRight
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToQuickTestViewController(isFrom: String, earTestCount: Int, selectedEar: String, patientData: PatientList, sessionID: String, dictLeft: [String: String], dictRight: [String: String], arrayLeft: [Int], arrayRight: [Int]) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestViewController) as! QuickTestViewController
            viewCon.earTestCount = earTestCount
            viewCon.selectedEar = selectedEar
            viewCon.isFrom = isFrom
            viewCon.patientData = patientData
            viewCon.sessionID = sessionID
            viewCon.dictLeft = dictLeft
            viewCon.dictRight = dictRight
            viewCon.arrayLeft = arrayLeft
            viewCon.arrayRight = arrayRight
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToQuickTestSuccessViewController(isFrom: String, earTestCount: Int, selectedEar: String, patientData: PatientList, sessionID: String, dictLeft: [String: String], dictRight: [String: String], arrayLeft: [Int], arrayRight: [Int]) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestSuccessViewController) as! QuickTestSuccessViewController
            viewCon.earTestCount = earTestCount
            viewCon.selectedEar = selectedEar
            viewCon.isFrom = isFrom
            viewCon.patientData = patientData
            viewCon.sessionID = sessionID
            viewCon.dictLeft = dictLeft
            viewCon.dictRight = dictRight
            viewCon.arrayLeft = arrayLeft
            viewCon.arrayRight = arrayRight
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToQuickTestUserInfoViewController(isFrom: String, patientData: PatientList, sessionID: String, dictLeft: [String: String], dictRight: [String: String], arrayLeft: [Int], arrayRight: [Int]) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestUserInfoViewController) as! QuickTestUserInfoViewController
            viewCon.isFrom = isFrom
            viewCon.patientData = patientData
            viewCon.sessionID = sessionID
            viewCon.dictLeft = dictLeft
            viewCon.dictRight = dictRight
            viewCon.arrayLeft = arrayLeft
            viewCon.arrayRight = arrayRight
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToQuickTestUserVerificationViewController(isFrom: String, patientData: PatientList, sessionID: String, dictLeft: [String: String], dictRight: [String: String], arrayLeft: [Int], arrayRight: [Int],phoneToken:String,name:String,mobileNumber:String,email:String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestUserVerificationViewController) as! QuickTestUserVerificationViewController
            viewCon.isFrom = isFrom
            viewCon.patientData = patientData
            viewCon.sessionID = sessionID
            viewCon.dictLeft = dictLeft
            viewCon.dictRight = dictRight
            viewCon.arrayLeft = arrayLeft
            viewCon.arrayRight = arrayRight
            viewCon.phoneToken = phoneToken
            viewCon.name = name
            viewCon.mobileNumber = mobileNumber
            viewCon.email = email

            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToQuickTestResultViewController(isFrom: String, sessionID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.QuickTest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.QuickTestResultViewController) as! QuickTestResultViewController
            viewCon.isFrom = isFrom
            viewCon.sessionID = sessionID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }


    /*back*/
    func navigateBackToQuickTestHeadsetConnectivityViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is QuickTestHeadsetConnectivityViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToGuestQuickTestProfileViewController(newGuestpatientList:[PatientList]) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: QuickTestProfileViewController = self.navigationController?.viewControllers.filter({$0 is QuickTestProfileViewController}).last as! QuickTestProfileViewController
            viewCon.setInitialView()
            viewCon.newGuestpatientList = newGuestpatientList
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToQuickTestProfileViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: QuickTestProfileViewController = self.navigationController?.viewControllers.filter({$0 is QuickTestProfileViewController}).last as! QuickTestProfileViewController
            viewCon.setInitialView()
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToQuickTestResultViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is QuickTestResultViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)

        }
    }
    // MARK: - StoryBoard BookAppointment
    func navigateToBookAppointmentLocationViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BookAppointment, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BookAppointmentLocationViewController) as! BookAppointmentLocationViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToBookAppointmentScheduleViewController(isFrom: String,visitType: String,concernID: String, newUser: Bool, selectedCity: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BookAppointment, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BookAppointmentScheduleViewController) as! BookAppointmentScheduleViewController
            viewCon.isFrom = isFrom
            viewCon.visitType = visitType
            viewCon.concernID = concernID
            viewCon.newUser = newUser
            viewCon.selectedCity = selectedCity
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToBookAppointmentUserInfoViewController(isFrom: String,concernID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BookAppointment, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BookAppointmentUserInfoViewController) as! BookAppointmentUserInfoViewController
            viewCon.isFrom = isFrom
            viewCon.concernID = concernID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToBookAppointmentSuccessViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BookAppointment, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BookAppointmentSuccessViewController) as! BookAppointmentSuccessViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    func navigateToBookAppointmentDemoViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BookAppointment, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BookAppointmentDemoViewController) as! BookAppointmentDemoViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToBookAppointmentViewController(isFrom: String, patientUid: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BookAppointment, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BookAppointmentViewController) as! BookAppointmentViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToBookAppointmentAddressViewController(isFrom: String, selectedServiceArray: [ServiceSelected], patientUid: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BookAppointment, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BookAppointmentAddressViewController) as! BookAppointmentAddressViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            viewCon.selectedServiceArray = selectedServiceArray
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToBookAppointmentSummaryViewControllerController(isFrom: String, patientUid: String, bookingUid: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BookAppointment, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BookAppointmentSummaryViewController) as! BookAppointmentSummaryViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            viewCon.bookingUid = bookingUid
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToBookAppointmentConfirmationViewController(isFrom: String, bookingUid: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.BookAppointment, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BookAppointmentConfirmationViewController) as! BookAppointmentConfirmationViewController
            viewCon.isFrom = isFrom
            viewCon.bookingUid = bookingUid
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    /* back */
    func navigateBackToBookAppointmentViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: BookAppointmentViewController = self.navigationController?.viewControllers.filter({$0 is BookAppointmentViewController}).last as! BookAppointmentViewController
            viewCon.commonAPICALL(retryAPIID: 1001)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToBookAppointmentDemoViewControllerFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: BookAppointmentDemoViewController = self.navigationController?.viewControllers.filter({$0 is BookAppointmentDemoViewController}).last as! BookAppointmentDemoViewController
            viewCon.verifiedUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToBookAppointmentAddressViewControllerFromAddress() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: BookAppointmentAddressViewController = self.navigationController?.viewControllers.filter({$0 is BookAppointmentAddressViewController}).last as! BookAppointmentAddressViewController
            viewCon.storeUID = ""
            viewCon.addressID = ""
            viewCon.selectedTime = ""
            viewCon.selectedDate = ""
            viewCon.setUserInteractionButton()
            viewCon.deliveryType = DeliveryType.home.rawValue
            viewCon.pincodeTextField.text = viewCon.pincode
            viewCon.commonAPICALL(retryAPIID: 1003)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToBookAppointmentSummaryViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: BookAppointmentSummaryViewController = self.navigationController?.viewControllers.filter({$0 is BookAppointmentSummaryViewController}).last as! BookAppointmentSummaryViewController
            viewCon.appliedCoupon()
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    // MARK: - StoryBoard FHA
    func navigateToFindRightDeviceIntroductionViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.FindRightDevice, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.FindRightDeviceIntroductionViewController) as! FindRightDeviceIntroductionViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToFindRightDeviceUploadReportViewController(isFrom: String, patientUid: String,sessionID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.FindRightDevice, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.FindRightDeviceUploadReportViewController) as! FindRightDeviceUploadReportViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            viewCon.sessionID = sessionID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToFindRightDeviceStyleViewController(isFrom: String, patientUid: String,sessionID: String,sessionUID: String, sessionKey: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.FindRightDevice, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.FindRightDeviceStyleViewController) as! FindRightDeviceStyleViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            viewCon.sessionID = sessionID
            viewCon.sessionUID = sessionUID
            viewCon.sessionKey = sessionKey
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToFindRightDeviceFeatureViewController(isFrom: String, patientUid: String, lifestyleID: Int, lifestyleName:String, sessionID: String,sessionUID: String, sessionKey: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.FindRightDevice, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.FindRightDeviceFeatureViewController) as! FindRightDeviceFeatureViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            viewCon.lifestyleID = lifestyleID
            viewCon.lifestyleName = lifestyleName
            viewCon.sessionID = sessionID
            viewCon.sessionUID = sessionUID
            viewCon.sessionKey = sessionKey
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToFindRightDeviceEarPreferenceViewController(isFrom: String, patientUid: String, lifestyleID: Int?, model: [Int], technologyID: Int?,sessionID: String,sessionUID: String, sessionKey: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.FindRightDevice, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.FindRightDeviceEarPreferenceViewController) as! FindRightDeviceEarPreferenceViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            viewCon.lifestyleID = lifestyleID
            viewCon.model = model
            viewCon.technologyID = technologyID
            viewCon.sessionID = sessionID
            viewCon.sessionUID = sessionUID
            viewCon.sessionKey = sessionKey
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToFindRightDeviceRecommendViewController(isFrom: String, patientUid: String, lifestyleID: Int?, model: [Int], technologyID: Int?, earpreferenceID: Int?, UID: String?, sessionUID: String, sessionKey: String, isNewUser: Bool,sessionID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.FindRightDevice, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.FindRightDeviceRecommendViewController) as! FindRightDeviceRecommendViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            viewCon.lifestyleID = lifestyleID
            viewCon.model = model
            viewCon.technologyID = technologyID
            viewCon.earpreferenceID = earpreferenceID
            viewCon.UID = UID
            viewCon.sessionUID = sessionUID
            viewCon.sessionKey = sessionKey
            viewCon.isNewUser = isNewUser
            viewCon.sessionID = sessionID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    /*Back*/
    func navigateBackToFindRightDeviceIntroductionViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is FindRightDeviceIntroductionViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToFindRightDeviceIntroductionViewControllerFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: FindRightDeviceIntroductionViewController = self.navigationController?.viewControllers.filter({$0 is FindRightDeviceIntroductionViewController}).last as! FindRightDeviceIntroductionViewController
            viewCon.verifiedUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToFindRightDeviceUploadReportViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: FindRightDeviceUploadReportViewController = self.navigationController?.viewControllers.filter({$0 is FindRightDeviceUploadReportViewController}).last as! FindRightDeviceUploadReportViewController
            viewCon.commonAPICALL(retryAPIID: 1000)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToFindRightDeviceRecommendViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: FindRightDeviceRecommendViewController = self.navigationController?.viewControllers.filter({$0 is FindRightDeviceRecommendViewController}).last as! FindRightDeviceRecommendViewController
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    /*back*/
    func navigateBackToFindRightDeviceUploadReportViewControllerToQuickCheck(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: FindRightDeviceUploadReportViewController = self.navigationController?.viewControllers.filter({$0 is FindRightDeviceUploadReportViewController}).last as! FindRightDeviceUploadReportViewController
            viewCon.commonAPICALL(retryAPIID: 1000)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }

    // MARK: - StoryBoard OnlineConsultaion
    func navigateToOnlineConsultationLocationViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.OnlineConsultation, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OnlineConsultationLocationViewController) as! OnlineConsultationLocationViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToOnlineConsultationScheduleViewController(isFrom: String,concernID: String,newUser:Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.OnlineConsultation, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OnlineConsultationScheduleViewController) as! OnlineConsultationScheduleViewController
            viewCon.isFrom = isFrom
            viewCon.concernID = concernID
            viewCon.newUser = newUser
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToOnlineConsultationUserInfoViewController(isFrom: String,concernID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.OnlineConsultation, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OnlineConsultationUserInfoViewController) as! OnlineConsultationUserInfoViewController
            viewCon.isFrom = isFrom
            viewCon.concernID = concernID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToOnlineConsultationSuccessViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.OnlineConsultation, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OnlineConsultationSuccessViewController) as! OnlineConsultationSuccessViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    func navigateToOnlineConsultationDemoViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.OnlineConsultation, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OnlineConsultationDemoViewController) as! OnlineConsultationDemoViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToOnlineConsultationConcernViewController(isFrom: String, patientUid: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.OnlineConsultation, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OnlineConsultationConcernViewController) as! OnlineConsultationConcernViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToOnlineConsultationAudiologistViewController(isFrom: String, patientUid: String, concernArraySelected: NSMutableArray) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.OnlineConsultation, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OnlineConsultationAudiologistViewController) as! OnlineConsultationAudiologistViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            viewCon.concernArraySelected = concernArraySelected
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToOnlineConsultationAppointmentViewController(isFrom: String, patientUid: String, concernArraySelected: NSMutableArray, audiologistProfile: AudiologistProfile) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.OnlineConsultation, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OnlineConsultationAppointmentViewController) as! OnlineConsultationAppointmentViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            viewCon.concernArraySelected = concernArraySelected
            viewCon.audiologistProfile = audiologistProfile
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToOnlineConsultationPaymentViewController(isFrom: String, patientUid: String, bookingUid: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.OnlineConsultation, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OnlineConsultationPaymentViewController) as! OnlineConsultationPaymentViewController
            viewCon.isFrom = isFrom
            viewCon.patientUid = patientUid
            viewCon.bookingUid = bookingUid
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    func navigateToOnlineConsultationConfirmationViewController(isFrom: String, bookingUid: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.OnlineConsultation, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OnlineConsultationConfirmationViewController) as! OnlineConsultationConfirmationViewController
            viewCon.isFrom = isFrom
            viewCon.bookingUid = bookingUid

            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    /*
     back
     */
    func navigateBackToOnlineConsultationDemoViewControllerFromOTP(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: OnlineConsultationDemoViewController = self.navigationController?.viewControllers.filter({$0 is OnlineConsultationDemoViewController}).last as! OnlineConsultationDemoViewController
            viewCon.verifiedUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)

        }
    }
    func navigateBackToOnlineConsultationPaymentViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is OnlineConsultationPaymentViewController}).last as! OnlineConsultationPaymentViewController
            viewCon.appliedCoupon()
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    // MARK: - StoryBoard ServiceRequest
    func navigateToServiceRequestListViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.ServiceRequest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ServiceRequestListViewController) as! ServiceRequestListViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToServiceRequestDetailViewController(isFrom: String, bookingUid: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.ServiceRequest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ServiceRequestDetailViewController) as! ServiceRequestDetailViewController
            viewCon.isFrom = isFrom
            viewCon.bookingUid = bookingUid
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToServiceRequestStaffRatingViewController(bookingUid: String, staffExperience: String, staffName: String, staffSpecialization: String, imageurl: String, isStaff: Bool, staffid: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.ServiceRequest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ServiceRequestStaffRatingViewController) as! ServiceRequestStaffRatingViewController
            viewCon.bookingUid = bookingUid
            viewCon.staffName = staffName
            viewCon.staffExperience = staffExperience
            viewCon.staffSpecialization = staffSpecialization
            viewCon.imageurl = imageurl
            viewCon.delegate = (self as! ProtocolServiceRequestStaffRatingViewController)
            viewCon.isStaff = isStaff
            viewCon.staffid = staffid
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCancelServiceRequestViewController(cancelReasonList: [SRDModelCancelReasonList], bookingUid: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.ServiceRequest, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CancelServiceRequestViewController) as! CancelServiceRequestViewController
            viewCon.bookingUid = bookingUid
            viewCon.reasonArray = cancelReasonList
            viewCon.delegate = (self as! ProtocolCancelServiceRequestViewController)
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    // MARK: - StoryBoard Compare Product
    func navigateToCompareProductBrandViewController(isFrom: String, product1: String, product2: String, isEdit: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.CompareProduct, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CompareProductBrandViewController) as! CompareProductBrandViewController
            viewCon.isFrom = isFrom
            viewCon.product1 = product1
            viewCon.product2 = product2
            viewCon.isEdit = isEdit
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCompareProductPriceViewController(isFrom: String, product1: String, product2: String, brandListArray: [HearingAidBrandList], priceRangeListArray: [HearingAidPriceRangeList], modelListArray: [ShopModelList], tagArray: [CompareTagModel], isEdit: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.CompareProduct, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CompareProductPriceViewController) as! CompareProductPriceViewController
            viewCon.isFrom = isFrom
            viewCon.product1 = product1
            viewCon.product2 = product2
            viewCon.priceRangeListArray = priceRangeListArray
            viewCon.brandListArray = brandListArray
            viewCon.modelListArray = modelListArray
            viewCon.tagArray = tagArray
            viewCon.isEdit = isEdit
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCompareProductStyleViewController(isFrom: String, product1: String, product2: String, brandListArray: [HearingAidBrandList], priceRangeListArray: [HearingAidPriceRangeList], modelListArray: [ShopModelList], tagArray: [CompareTagModel], isEdit: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.CompareProduct, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CompareProductStyleViewController) as! CompareProductStyleViewController
            viewCon.isFrom = isFrom
            viewCon.product1 = product1
            viewCon.product2 = product2
            viewCon.priceRangeListArray = priceRangeListArray
            viewCon.brandListArray = brandListArray
            viewCon.modelListArray = modelListArray
            viewCon.tagArray = tagArray
            viewCon.isEdit = isEdit
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCompareProductModelViewController(isFrom: String, product1: String, product2: String, brandListArray: [HearingAidBrandList], priceRangeListArray: [HearingAidPriceRangeList], modelListArray: [ShopModelList], tagArray: [CompareTagModel], isEdit: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.CompareProduct, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CompareProductModelViewController) as! CompareProductModelViewController
            viewCon.isFrom = isFrom
            viewCon.product1 = product1
            viewCon.product2 = product2
            viewCon.priceRangeListArray = priceRangeListArray
            viewCon.brandListArray = brandListArray
            viewCon.modelListArray = modelListArray
            viewCon.tagArray = tagArray
            viewCon.isEdit = isEdit
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCompareProductViewController(isFrom: String, product1: String, product2: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.CompareProduct, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CompareProductViewController) as! CompareProductViewController
            viewCon.isFrom = isFrom
            viewCon.product1 = product1
            viewCon.product2 = product2
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    /*Back*/
    func navigateBackToCompareProductBrandViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is CompareProductBrandViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToCompareProductPriceViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is CompareProductPriceViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToCompareProductStyleViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is CompareProductStyleViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToCompareProductModelViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is CompareProductModelViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToCompareProductViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is CompareProductViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToCompareProductViewControllerForProduct(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is CompareProductViewController}).last as! CompareProductViewController
            if IsNavigateFrom.loginCartCompare2.rawValue == isFrom {
                viewCon.checkCartVerifiedUser(senderTag: 1)
            } else if IsNavigateFrom.loginCartCompare1.rawValue == isFrom {
                viewCon.checkCartVerifiedUser(senderTag: 0)
            }
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }

    // MARK: - StoryBoard Cart
    func navigateToCartDetailViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Cart, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CartDetailViewController) as! CartDetailViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCheckOutViewController(orderID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Cart, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CheckOutViewController) as! CheckOutViewController
            viewCon.orderID = orderID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCheckOutSummaryViewController(orderID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Cart, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CheckOutSummaryViewController) as! CheckOutSummaryViewController
            viewCon.orderID = orderID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCheckOutConfirmationViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Cart, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CheckOutConfirmationViewController) as! CheckOutConfirmationViewController
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    /*back*/
    func navigateBackToCheckOutViewControllerFromAddress() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: CheckOutViewController = self.navigationController?.viewControllers.filter({$0 is CheckOutViewController}).last as! CheckOutViewController
            viewCon.storeID = ""
            viewCon.addressID = ""
            viewCon.setUserInteractionButton()
            viewCon.deliveryType = DeliveryType.home.rawValue
            viewCon.pincodeTextField.text = viewCon.pincode
            viewCon.commonAPICALL(retryAPIID: 1003)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToCheckOutSummaryViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: CheckOutSummaryViewController = self.navigationController?.viewControllers.filter({$0 is CheckOutSummaryViewController}).last as! CheckOutSummaryViewController
            viewCon.commonAPICALL(retryAPIID: 1002)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToCartDetailViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: CartDetailViewController = self.navigationController?.viewControllers.filter({$0 is CartDetailViewController}).last as! CartDetailViewController
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    // MARK: - StoryBoard Order
    func navigateToOrderListViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Order, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OrderListViewController) as! OrderListViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToOrderDetailViewController(isFrom: String, isReturn: Bool, orderID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Order, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.OrderDetailViewController) as! OrderDetailViewController
            viewCon.isFrom = isFrom
            viewCon.isReturn = isReturn
            viewCon.orderID = orderID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCancelOrderViewController(orderID: String, reasonArray: [CancelReasonList]) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Order, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CancelOrderViewController) as! CancelOrderViewController
            viewCon.reasonArray = reasonArray
            viewCon.selectedReason = ""
            viewCon.orderID = orderID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToReturnReasonViewController(orderID: String, reasonArray: [ReturnReasonList], selectArray: [String], productListArray: [OrderItemList]) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Order, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ReturnReasonViewController) as! ReturnReasonViewController
            viewCon.reasonArray = reasonArray
            viewCon.selectArray = selectArray
            viewCon.selectedReason = ""
            viewCon.productListArray = productListArray
            viewCon.orderID = orderID
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    /* back */
    func navigateBackToOrderListViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: OrderListViewController = self.navigationController?.viewControllers.filter({$0 is OrderListViewController}).last as! OrderListViewController
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToOrderDetailViewControllertoOpenPopup() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: OrderDetailViewController = self.navigationController?.viewControllers.filter({$0 is OrderDetailViewController}).last as! OrderDetailViewController
            self.navigationController?.popToViewController(viewCon, animated: true)
            viewCon.showPopup()
        }
    }

    // MARK: - StoryBoard AddUser
    func navigateToSelectUserViewControllerToQuickCheck(isFrom: String, showFourDotView: Bool, showFiveDotView: Bool, showSixDotView: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.AddUser, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.SelectUserViewController) as! SelectUserViewController
            viewCon.isFrom = isFrom
            viewCon.showFourDotView = showFourDotView
            viewCon.showFiveDotView = showFiveDotView
            viewCon.showSixDotView = showSixDotView
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToSelectUserViewControllerToFHA(isFrom: String, showFourDotView: Bool, showFiveDotView: Bool, showSixDotView: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.AddUser, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.SelectUserViewController) as! SelectUserViewController
            viewCon.isFrom = isFrom
            viewCon.showFourDotView = showFourDotView
            viewCon.showFiveDotView = showFiveDotView
            viewCon.showSixDotView = showSixDotView
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToSelectUserViewControllerToOnlineConsultation(isFrom: String, showFourDotView: Bool, showFiveDotView: Bool, showSixDotView: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.AddUser, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.SelectUserViewController) as! SelectUserViewController
            viewCon.isFrom = isFrom
            viewCon.showFourDotView = showFourDotView
            viewCon.showFiveDotView = showFiveDotView
            viewCon.showSixDotView = showSixDotView
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToSelectUserViewControllerToBookAppointment(isFrom: String, showFourDotView: Bool, showFiveDotView: Bool, showSixDotView: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.AddUser, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.SelectUserViewController) as! SelectUserViewController
            viewCon.isFrom = isFrom
            viewCon.showFourDotView = showFourDotView
            viewCon.showFiveDotView = showFiveDotView
            viewCon.showSixDotView = showSixDotView
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToAddUserViewController(isEdit: Bool, isFrom: String, uid: String, name: String, dob: String, genderSlug: String, relationShipSlug: String, relationShip: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.AddUser, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.AddUserViewController) as! AddUserViewController
            viewCon.isEdit = isEdit
            viewCon.isFrom = isFrom
            viewCon.uid = uid
            viewCon.name = name
            viewCon.dob = dob
            viewCon.genderSlug = genderSlug
            viewCon.relationShipSlug = relationShipSlug
            viewCon.relationShip = relationShip
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    /*back*/
    func navigateBackToSelectUserViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: SelectUserViewController = self.navigationController?.viewControllers.filter({$0 is SelectUserViewController}).last as! SelectUserViewController
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }

    // MARK: - StoryBoard RegisterDevice
    func navigateToRegisterDeviceViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.RegisterDevice, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.RegisterDeviceViewController) as! RegisterDeviceViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    func navigateToAddRegisterDeviceViewController(id: String, orderRef: String, deviceUserName: String, deviceUserUID: String, deviceName: String, deviceBrand: String, deviceBrandUID: String, deviceModel: String, deviceSerialNumber: String, deviceEarPreference: String, deviceEarPreferenceValue: String, devicePurchasedOn: String, devicePurchasedFrom: String, devicePurchasedFromValue: String, deviceWarrantyExpiresOn: String, deviceExtendedWarrantyEndOn: String, deviceWarrantyDetails: String, deviceWarrantyDetailsValue: String, deviceNextServiceDate: String, deviceLastServiceDate: String, deviceRemark: String, isEdit: Bool, isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.RegisterDevice, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.AddRegisterDeviceViewController) as! AddRegisterDeviceViewController
            viewCon.id = id
            viewCon.orderRef = orderRef
            viewCon.deviceUserName = deviceUserName
            viewCon.deviceUserUID = deviceUserUID
            viewCon.deviceName = deviceName
            viewCon.deviceBrand = deviceBrand
            viewCon.deviceBrandUID = deviceBrandUID
            viewCon.deviceModel = deviceModel
            viewCon.deviceSerialNumber = deviceSerialNumber
            viewCon.deviceEarPreference = deviceEarPreference
            viewCon.deviceEarPreferenceValue = deviceEarPreferenceValue
            viewCon.devicePurchasedOn = devicePurchasedOn
            viewCon.devicePurchasedFrom = devicePurchasedFrom
            viewCon.devicePurchasedFromValue = devicePurchasedFromValue
            viewCon.deviceWarrantyExpiresOn = deviceWarrantyExpiresOn
            viewCon.deviceExtendedWarrantyEndOn = deviceExtendedWarrantyEndOn
            viewCon.deviceNextServiceDate = deviceNextServiceDate
            viewCon.deviceLastServiceDate = deviceLastServiceDate
            viewCon.deviceWarrantyDetails = deviceWarrantyDetails
            viewCon.deviceWarrantyDetailsValue = deviceWarrantyDetailsValue
            viewCon.deviceRemark = deviceRemark
            viewCon.isEdit = isEdit
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    /* back */
    func navigateBackToRegisterDeviceViewControllerUpdated() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: RegisterDeviceViewController = self.navigationController?.viewControllers.filter({$0 is RegisterDeviceViewController}).last as! RegisterDeviceViewController
            viewCon.commonAPICALL(retryAPIID: 2000)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }

    // MARK: - StoryBoard Profile
    func navigateToAddressListViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Profile, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.AddressListViewController) as! AddressListViewController
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    func navigateToAddressonMapViewController(isFrom: String, isEdit: Bool, id: String, customerName: String, mobile: String, addressType: String, address1: String, address2: String, address3: String, landmark: String, city: String, state: String, zipcode: String, lat: String, lng: String, isprimary: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Profile, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.AddressonMapViewController) as! AddressonMapViewController
            viewCon.isFrom = isFrom
            viewCon.isEdit = isEdit
            viewCon.id = id
            viewCon.customerName = customerName
            viewCon.mobile = mobile
            viewCon.addressType = addressType
            viewCon.address1 = address1 // street
            viewCon.address2 = address2 // area
            viewCon.address3 = address3
            viewCon.landmark = landmark
            viewCon.city = city // city
            viewCon.state = state // state
            viewCon.zipcode = zipcode // pincode
            viewCon.lat = lat
            viewCon.lng = lng
            viewCon.isprimary = isprimary

            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToEnterAddressViewController(isFrom: String, isEdit: Bool, id: String, customerName: String, mobile: String, addressType: String, address1: String, address2: String, address3: String, landmark: String, city: String, state: String, zipcode: String, lat: String, lng: String, isprimary: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Profile, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.EnterAddressViewController) as! EnterAddressViewController
            viewCon.isFrom = isFrom
            viewCon.isEdit = isEdit
            viewCon.id = id
            viewCon.customerName = customerName
            viewCon.mobile = mobile
            viewCon.addressType = addressType
            viewCon.address1 = address1 // street
            viewCon.address2 = address2 // area
            viewCon.address3 = address3
            viewCon.landmark = landmark
            viewCon.city = city // city
            viewCon.state = state // state
            viewCon.zipcode = zipcode // pincode
            viewCon.lat = lat
            viewCon.lng = lng
            viewCon.isprimary = isprimary
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    func navigateToProfileInformationViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Profile, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ProfileInformationViewController) as! ProfileInformationViewController
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToChangeInformationViewController(toChangeNumber: Bool) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Profile, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ChangeInformationViewController) as! ChangeInformationViewController
            viewCon.toChangeNumber = toChangeNumber
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToChangeInformationOTPVerificationViewController(toChangeNumber: Bool, changeData: String, token: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Profile, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ChangeInformationOTPVerificationViewController) as! ChangeInformationOTPVerificationViewController
            viewCon.toChangeNumber = toChangeNumber
            viewCon.changeData = changeData
            viewCon.token = token
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToEditProfileViewController( name: String, dob: String, genderSlug: String, photo: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Profile, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.EditProfileViewController) as! EditProfileViewController
            viewCon.name = (name == "-") ? "" : name
            viewCon.dob = (dob == "-") ? "" : dob
            viewCon.genderSlug = (genderSlug == "-") ? "" : genderSlug
            viewCon.photo = photo
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    /*back*/
    func navigateBackToProfileInformationViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: ProfileInformationViewController = self.navigationController?.viewControllers.filter({$0 is ProfileInformationViewController}).last as! ProfileInformationViewController
            viewCon.commonAPICALL(retryAPIID: 2000)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }

    func navigateBackToAddressListViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon = self.navigationController?.viewControllers.filter({$0 is AddressListViewController}).last
            self.navigationController?.popToViewController(viewCon!, animated: true)
        }
    }
    func navigateBackToAddressListViewControllerUpdated() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: AddressListViewController = self.navigationController?.viewControllers.filter({$0 is AddressListViewController}).last as! AddressListViewController
            viewCon.commonAPICALL(retryAPIID: 2000)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }

    // MARK: - StoryBoard Userdata
    func navigateToWishlistViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.WishlistViewController) as! WishlistViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCouponListViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CouponListViewController) as! CouponListViewController
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    func navigateToRewardPointsViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.RewardPointsViewController) as! RewardPointsViewController
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToRewardPointsDetailViewController(rewardUid: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.RewardPointsDetailViewController) as! RewardPointsDetailViewController
            viewCon.rewardUid = rewardUid
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToRedeemCoinsViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.RedeemCoinsViewController) as! RedeemCoinsViewController
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToReferFriendViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ReferFriendViewController) as! ReferFriendViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToSurveyViewController(isFrom: String, surveyType: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.SurveyViewController) as! SurveyViewController
            viewCon.isFrom = isFrom
            viewCon.surveyType = surveyType
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToShareExperienceViewController(isFrom: String, surveyType: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ShareExperienceViewController) as! ShareExperienceViewController
            viewCon.isFrom = isFrom
            viewCon.surveyType = surveyType
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToSurveySuccessViewController(isFrom: String, message: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.SurveySuccessViewController) as! SurveySuccessViewController
            viewCon.isFrom = isFrom
            viewCon.message = message
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToServiceCouponListViewController(isFrom: String, bookingUid: String, couponOfferedFor: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.ServiceCouponListViewController) as! ServiceCouponListViewController
            viewCon.isFrom = isFrom
            viewCon.bookingUid = bookingUid
            viewCon.couponOfferedFor = couponOfferedFor
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToMyAlertViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.MyAlertViewController) as! MyAlertViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToAudiogramReportViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.UserData, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.AudiogramReportViewController) as! AudiogramReportViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    /*back*/
    func navigateBackToReferFriendViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: ReferFriendViewController = self.navigationController?.viewControllers.filter({$0 is ReferFriendViewController}).last as! ReferFriendViewController
            viewCon.commonAPICALL(retryAPIID: 1000)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToMyAlertViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: MyAlertViewController = self.navigationController?.viewControllers.filter({$0 is MyAlertViewController}).last as! MyAlertViewController
            viewCon.commonAPICALL(retryAPIID: 1000)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToAudiogramReportViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: AudiogramReportViewController = self.navigationController?.viewControllers.filter({$0 is AudiogramReportViewController}).last as! AudiogramReportViewController
            viewCon.commonAPICALL(retryAPIID: 1001)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    func navigateBackToAudiogramReportViewControllerToQuickCheckView(isFrom: String, isWishlist: Bool, productUID: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let  viewCon: AudiogramReportViewController = self.navigationController?.viewControllers.filter({$0 is AudiogramReportViewController}).last as! AudiogramReportViewController
            viewCon.verifiedQuickCheckViewReportUser(isFrom: isFrom, isWishlist: isWishlist, productUID: productUID)
            self.navigationController?.popToViewController(viewCon, animated: true)
        }
    }
    // MARK: - StoryBoard blog
    func navigateToBlogsListViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Blog, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BlogsListViewController) as! BlogsListViewController
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToBlogsSearchViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Blog, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BlogsSearchViewController) as! BlogsSearchViewController
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToBlogsDetailViewController(slug: String,isFrom:String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Blog, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BlogsDetailViewController) as! BlogsDetailViewController
            viewCon.slug = slug
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToTipsListViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Blog, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BlogContainerViewController) as! BlogContainerViewController
            viewCon.selectedIndex = 0
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToTipsDetailViewController(slug: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Blog, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.TipsDetailViewController) as! TipsDetailViewController
            viewCon.slug = slug
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCareMaintenanceListViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Blog, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BlogContainerViewController) as! BlogContainerViewController
            viewCon.selectedIndex = 1
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCareMaintenanceDetailViewController(slug: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Blog, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CareMaintenanceDetailViewController) as! CareMaintenanceDetailViewController
            viewCon.slug = slug
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCustomerTestimonialListViewController() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Blog, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CustomerTestimonialListViewController) as! CustomerTestimonialListViewController
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToCustomerTestimonialDetailViewController(slug: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Blog, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.CustomerTestimonialDetailViewController) as! CustomerTestimonialDetailViewController
            viewCon.slug = slug
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    // MARK: - StoryBoard Information
    func navigateToSupportViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Information, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.SupportViewController) as! SupportViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToFAQViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Information, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.FAQViewController) as! FAQViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToAboutUsViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Information, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.AboutUsViewController) as! AboutUsViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToTermsConditionsViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Information, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.TermsConditionsViewController) as! TermsConditionsViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToLegalViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Information, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.LegalViewController) as! LegalViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToPrivacyPolicyViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Information, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.PrivacyPolicyViewController) as! PrivacyPolicyViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    func navigateToBuyBackViewController(isFrom: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Information, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.BuyBackViewController) as! BuyBackViewController
            viewCon.isFrom = isFrom
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }

    // MARK: - StoryBoard Common
    func VersionControlViewController(canShowPrimaryMsg: Bool, canShowSecondaryMsg: Bool, canShowBtn: Bool, isHavingAction: Bool, btnText: String, androidBtnLink: String, iosBtnLink: String, primaryMsgText: String, secondaryMsgText: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Common, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.VersionControlViewController) as! VersionControlViewController
            viewCon.canShowPrimaryMsg = canShowPrimaryMsg
            viewCon.canShowSecondaryMsg = canShowSecondaryMsg
            viewCon.canShowBtn = canShowBtn
            viewCon.isHavingAction = isHavingAction
            viewCon.iosBtnLink = iosBtnLink
            viewCon.btnText = btnText
            viewCon.primaryMsgText = primaryMsgText
            viewCon.secondaryMsgText = secondaryMsgText
            viewCon.androidBtnLink = androidBtnLink
            self.navigationController?.pushViewController(viewCon, animated: true)

        }
    }
    func navigateToYoutubePlayerViewController(servicePosterVideoLink: String) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryBoard.Common, bundle: nil)
            let viewCon = storyBoard.instantiateViewController(withIdentifier: ViewController.YoutubePlayerViewController) as! YoutubePlayerViewController
            viewCon.servicePosterVideoLink = servicePosterVideoLink
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    // MARK: - StoryBoard Main
    func navigateBackToViewController() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func navigateToCustomTabbar() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            if let window = UIApplication.shared.delegate?.window {
                let storyboard = UIStoryboard(name: StoryBoard.Main, bundle: nil)
                let viewCon: UITabBarController = storyboard.instantiateViewController(withIdentifier: ViewController.CustomTabbarController) as! CustomTabbarController
                let navigationController = UINavigationController(rootViewController: viewCon)
                navigationController.isNavigationBarHidden = true
                if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.activeTab) == AppLocalizationString.tabHome {
                    viewCon.selectedIndex = 0
                } else if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.activeTab) == AppLocalizationString.tabHearingCare {
                    viewCon.selectedIndex = 1
                } else if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.activeTab) == AppLocalizationString.tabStores {
                    viewCon.selectedIndex = 2
                } else if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.activeTab) == AppLocalizationString.tabShop {
                    viewCon.selectedIndex = 3
                } else if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.activeTab) == AppLocalizationString.tabAccount {
                    viewCon.selectedIndex = 4
                } else {
                    UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
                    UserDefaults.standard.synchronize()
                    viewCon.selectedIndex = 0
                }
                window?.rootViewController  = navigationController
                window?.makeKeyAndVisible()
            }
        }
    }
    var sceneDelegate: SceneDelegate? {
        for scene in UIApplication.shared.connectedScenes {
            if scene == currentScene,
               let delegate = scene.delegate as? SceneDelegate {
                return delegate
            }
        }
        return nil
    }
    func signout() {
        let fcm_token = UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.fcmTokenString)
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
        UserDefaults.standard.synchronize()
        UIApplication.shared.applicationIconBadgeNumber = 0
        UserDefaults.standard.set("", forKey: UserDefaultsPreferenceKeys.token)
        UserDefaults.standard.set(fcm_token, forKey: UserDefaultsPreferenceKeys.fcmTokenString)
        UIApplication.shared.applicationIconBadgeNumber = 0
        UserDefaults.standard.synchronize()
        self.sceneDelegate?.navigateToCustomTabbar()
    }

    func round(_ value: Double, toNearest: Double) -> Double {
        return Darwin.round(value / toNearest) * toNearest
    }
    // MARK: - Returns the statusBarHeight
    func statusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }

    // MARK: - Show Toast message
    func showToastAlert(_ msg: String, txtcolor: UIColor, bgColor: UIColor, viewCon: UIViewController) {
        viewCon.view.endEditing(true)
        var tabBarHeight: CGFloat = 0
        if (viewCon.theClassName.contains(ViewController.HomeStaticViewController)) || (viewCon.theClassName.contains(ViewController.StoreFinderViewController)) || (viewCon.theClassName.contains( ViewController.ShopCategoryViewController)) || (viewCon.theClassName.contains(ViewController.HearingCareViewController)) || (viewCon.theClassName.contains(ViewController.MenuViewController)) || (viewCon.theClassName.contains(ViewController.CustomTabbarController)) {
            tabBarHeight = (tabBarController!.tabBar.bounds.size.height)
        }
        let toastLabel: PaddingLabel = PaddingLabel(frame: CGRect(x: 0, y: 0, width: 32, height: 36))
        toastLabel.layer.backgroundColor = bgColor.cgColor
        toastLabel.textColor = txtcolor
        toastLabel.textAlignment = .center
        toastLabel.text = msg
        toastLabel.alpha = AppConstantValue.maxAplha
        toastLabel.numberOfLines = 0
        toastLabel.sizeToFit()
        toastLabel.layer.cornerRadius = AppConstantValue.cornerRadius4
        toastLabel.clipsToBounds = true

        let height = heightForText(text: msg, Font: toastLabel.font, Width: AppConstantValue.screenWidthminus32)

        toastLabel.frame = CGRect(x: 0, y: screenFrameHeight - (tabBarHeight + height + 36), width: screenFrameWidth, height: (height + 36))
        viewCon.view.addSubview(toastLabel)
        toastLabel.bringSubviewToFront(viewCon.view)

        UIView.animate(withDuration: AppConstantValue.toastdelayduration, delay: AppConstantValue.toastdisplayduration, options: .curveEaseOut, animations: {
            toastLabel.alpha = AppConstantValue.minAlpha
        }, completion: {(_) in
            toastLabel.removeFromSuperview()
        })
    }
    // MARK: - Disable Mutliple Touch
    func disableMutlipleTouch() {
        let allSubviews = self.view.subviewsRecursive()
        if allSubviews.count > 0 {
            for v in allSubviews {
                if v is UIButton {
                    let btn = v as? UIButton
                    btn?.isExclusiveTouch = true
                }
            }
        }
    }
    // MARK: - Height and Width For Text
    func heightForText(text: String, Font: UIFont, Width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: Width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = Font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }

    func widthForText(strText: String, font_txt: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: screenFrameWidth, height: .greatestFiniteMagnitude)
        let boundingBox = strText.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font_txt], context: nil)
        return boundingBox.width
    }
    // MARK: - Set Theme
    func setStatusBarThemeForApp(style:Int) {
        if (style == 1){
            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .dark
            }
        }
        else{
            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
            }
        }
    }

    //    func setLightThemeForApp() {
    //        if #available(iOS 13.0, *) {
    //            overrideUserInterfaceStyle = .light
    //        }
    //    }
    func changeStatusBarColor(colorliteral: UIColor,style: Int) {
        self.setStatusBarThemeForApp(style: style)
        self.disableMutlipleTouch()
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            let topPadding = window?.safeAreaInsets.top
            let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: topPadding ?? 0.0))
            statusBar.backgroundColor = colorliteral
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = colorliteral
        }
    }

    // MARK: - To Make Phone Call
    func makeCall(phoneNumber: String) {
        if !(phoneNumber.isEmpty) {
            let phoneNumberString = phoneNumber.removeEnclosedWhiteSpace()
            guard let number = URL(string: "tel://\(phoneNumberString)") else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(number)
            }
        }
    }
    // MARK: - To Open Whatsapp
    func openWhatsapp(phoneNumber: String) {
        if !(phoneNumber.isEmpty) {
            let phoneNumberString = phoneNumber.removeEnclosedWhiteSpace().checkPlusCharacter
            guard let number = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumberString)") else { return }

            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(number)
            }
        }
    }
    // MARK: - To Open Email
    //    func openMail(emailAddress: String) {
    //    // stackoverflow.com/questions/25981422/how-to-open-mail-app-from-swift
    //        if !(emailAddress.isEmpty) {
    //            let email_address = emailAddress.removeEnclosedWhiteSpace()
    //            guard let email = URL(string: "mailto:\(email_address)") else { return }
    //            if #available(iOS 10.0, *) {
    //                UIApplication.shared.open(email)
    //            } else {
    //                UIApplication.shared.openURL(email)
    //            }
    //        }
    //    }


    // MARK: - To PhotoLibrary Permission
    func showAlertForPhotoLibraryLimited() {
            let alert = UIAlertController(title: "Photo Library access is Limited", message: "Please Select more photos or Allow access to all photos in Settings", preferredStyle: .alert)

            let action2 = UIAlertAction(title: "Select more photos", style: .default) { [weak self] _ in
                guard let self = self else { return }
                PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
            }

            let action3 = UIAlertAction(title: "Keep Current Selection", style: .default)

            alert.addAction(self.getOpenSettingsAlertAction())
            alert.addAction(action2)
            alert.addAction(action3)

            self.present(alert, animated: true, completion: nil)
        }

        func showAlertForPhotoLibraryDenied() {
                let alert = UIAlertController(title: "Photo Library access is Denied", message: "Please provide access to PhotoLibrary to use the app", preferredStyle: .alert)
                alert.addAction(self.getOpenSettingsAlertAction())
                self.present(alert, animated: true, completion: nil)
        }
        func showAlertForPhotoLibraryRestricted() {
            let alert = UIAlertController(title: "Photo Library access is Restricted", message: "You are not able to grant such permission", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }

        func getOpenSettingsAlertAction() -> UIAlertAction {
            let action = UIAlertAction(title: "Open Settings", style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.redirectToAppSettings()
            }
            return action
        }

        func redirectToAppSettings() {
            DispatchQueue.main.async {
                guard let url = URL(string: UIApplication.openSettingsURLString),
                      UIApplication.shared.canOpenURL(url) else {
                    print("not possible")
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
}
extension NSObject {
    var theClassName: String {
        return NSStringFromClass(type(of: self))
    }
}
extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView(frame: .zero)
        volumeView.tintColor = .clear
        volumeView.backgroundColor = .clear
        volumeView.clipsToBounds = true
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            slider?.value = volume
        }
    }
}
