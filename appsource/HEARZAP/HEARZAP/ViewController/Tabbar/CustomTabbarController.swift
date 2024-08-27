//
//  CustomTabbarController.swift
//  HEARZAP
//
//  Created by Purushoth on 22/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//
import UIKit

class CustomTabbarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeStatusBarColor()
        self.delegate = self
        self.setTabbar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Setting the UITabBarItem
        self.changeStatusBarColor()
    }
    // MARK: -  Status Bar Color
    func changeStatusBarColor() {
        self.changeStatusBarColor(colorliteral: UIColor.colorLiteral.theme_blue_112F70,style: StatusBarTheme.lightContent.rawValue)
        self.setStatusBarThemeForApp(style: StatusBarTheme.lightContent.rawValue)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func setTabbar() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: AppFont.regular.size(13)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: AppFont.regular.size(13)], for: .selected)
        
        self.tabBar.tintColor = UIColor.colorLiteral.theme_blue_112F70// tab bar icon tint color
        self.tabBar.unselectedItemTintColor = UIColor.colorLiteral.theme_grey_777777 // tab bar icon unselected tint color
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = UIColor.colorLiteral.theme_white_FFFFFF // tab bar background color
        UITabBar.appearance().barTintColor = UIColor.colorLiteral.theme_white_FFFFFF // tab bar background color
        
        let storyboardHomeStatic = UIStoryboard(name: StoryBoard.Home, bundle: nil)
        let tab0 = storyboardHomeStatic.instantiateViewController(identifier: ViewController.HomeStaticViewController) as HomeStaticViewController
        let tab0BarItem = UITabBarItem(title: "", image: UIImage(named: Asset.tabHome), selectedImage: UIImage(named: Asset.tabHomeSelected))
        tab0.tabBarItem = tab0BarItem
        tab0.tabBarItem.tag = 0
        tab0.overrideUserInterfaceStyle = .light
        let navigationController1 = UINavigationController(rootViewController: tab0)
        //        navigationController1.overrideUserInterfaceStyle = .light
        
        let storyboardHearingCare = UIStoryboard(name: StoryBoard.HearingCare, bundle: nil)
        let tab1 = storyboardHearingCare.instantiateViewController(identifier: ViewController.HearingCareViewController) as HearingCareViewController
        let tab1BarItem = UITabBarItem(title: "", image: UIImage(named: Asset.tabHearingCare), selectedImage: UIImage(named: Asset.tabHearingCareSelected))
        tab1.tabBarItem = tab1BarItem
        tab1.tabBarItem.tag = 1
        tab1.overrideUserInterfaceStyle = .light
        let navigationController2 = UINavigationController(rootViewController: tab1)
        //        navigationController2.overrideUserInterfaceStyle = .light
        
        let storyboardStore = UIStoryboard(name: StoryBoard.Store, bundle: nil)
        let tab2 = storyboardStore.instantiateViewController(identifier: ViewController.StoreFinderViewController) as StoreFinderViewController
        let tab2BarItem = UITabBarItem(title: "", image: UIImage(named: Asset.tabStore), selectedImage: UIImage(named: Asset.tabStoreSelected))
        tab2.tabBarItem = tab2BarItem
        tab2.tabBarItem.tag = 2
        tab2.overrideUserInterfaceStyle = .light
        let navigationController3 = UINavigationController(rootViewController: tab2)
        //        navigationController3.overrideUserInterfaceStyle = .light
        
        let storyboardShop = UIStoryboard(name: StoryBoard.Shop, bundle: nil)
        let tab3 = storyboardShop.instantiateViewController(identifier: ViewController.ShopCategoryViewController) as ShopCategoryViewController
        let tab3BarItem = UITabBarItem(title: "", image: UIImage(named: Asset.tabShop), selectedImage: UIImage(named: Asset.tabShopSelected))
        tab3.tabBarItem = tab3BarItem
        tab3.tabBarItem.tag = 3
        tab3.overrideUserInterfaceStyle = .light
        let navigationController4 = UINavigationController(rootViewController: tab3)
        //        navigationController4.overrideUserInterfaceStyle = .light
        
        let storyboardMenu = UIStoryboard(name: StoryBoard.Menu, bundle: nil)
        let tab4 = storyboardMenu.instantiateViewController(identifier: ViewController.MenuViewController) as MenuViewController
        let tab4BarItem = UITabBarItem(title: "", image: UIImage(named: Asset.tabAccount), selectedImage: UIImage(named: Asset.tabAccountSelected))
        tab4.tabBarItem = tab4BarItem
        tab4.tabBarItem.tag = 4
        tab4.overrideUserInterfaceStyle = .light
        let navigationController5 = UINavigationController(rootViewController: tab4)
        //        navigationController5.overrideUserInterfaceStyle = .light
        
        //        self.navigationController.isNavigationBarHidden = true
        
        //        self.viewControllers = [tab0, tab1, tab2, tab3, tab4]
        
        self.viewControllers = [navigationController1, navigationController2, navigationController3, navigationController4, navigationController5]
        
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.activeTab) == AppLocalizationString.tabHome {
            self.selectedIndex = 0
        } else if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.activeTab) == AppLocalizationString.tabHearingCare {
            self.selectedIndex = 1
        } else if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.activeTab) == AppLocalizationString.tabStores {
            self.selectedIndex = 2
        } else if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.activeTab) == AppLocalizationString.tabShop {
            self.selectedIndex = 3
        } else if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.activeTab) == AppLocalizationString.tabAccount {
            self.selectedIndex = 4
        } else {
            UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
            UserDefaults.standard.synchronize()
            self.selectedIndex = 0
        }
    }
    
    //    // Delegate methods
    //    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    ////        return theTabBarController.selectedViewController != viewController
    //        return true
    //    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            //            item.title = AppLocalizationString.tabHome
            //            tabBar.items?[0].title = AppLocalizationString.tabHome
            tabBar.items?[0].title = ""
            item.title = ""
            
        }
        if item.tag == 1 {
            //            item.title = AppLocalizationString.tabHearingCare
            //            tabBar.items?[1].title = AppLocalizationString.tabHearingCare
            tabBar.items?[1].title = ""
            item.title = ""
            
        }
        if item.tag == 2 {
            //            item.title = AppLocalizationString.tabStores
            //            tabBar.items?[2].title = AppLocalizationString.tabStores
            tabBar.items?[2].title = ""
            item.title = ""
        }
        if item.tag == 3 {
            //            item.title = AppLocalizationString.tabShop
            //            tabBar.items?[3].title = AppLocalizationString.tabShop
            tabBar.items?[3].title = ""
            item.title = ""
        }
        if item.tag == 4 {
            //            item.title = AppLocalizationString.tabAccount
            //            tabBar.items?[4].title = AppLocalizationString.tabAccount
            tabBar.items?[4].title = ""
            item.title = ""
        }
    }
}
