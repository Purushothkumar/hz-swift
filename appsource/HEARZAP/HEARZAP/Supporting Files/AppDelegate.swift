//
//  AppDelegate.swift
//  HEARZAP
//
//  Created by Purushoth on 28/06/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import UserNotifications
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseCrashlytics
import FirebaseMessaging
import SDWebImage
import FirebaseAnalytics


public let screenFrameWidth = UIScreen.main.bounds.width
public let screenFrameHeight = UIScreen.main.bounds.height
public let tagHeight = CGFloat(38)

public let hearzapPlaceholder: UIImage = UIImage(named: Asset.hearzapplaceholder)!
public let profileBlue: UIImage = UIImage(named: Asset.profileblue)!
public let profileGrey: UIImage = UIImage(named: Asset.profilegrey)!

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var supportedOrientation: UIInterfaceOrientationMask = .portrait
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(2) // To View Launch Screen Image
        window?.overrideUserInterfaceStyle = .light
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        GMSServices.provideAPIKey(BaseKey.googleAPIKey)
        GMSPlacesClient.provideAPIKey(BaseKey.googleAPIKey)
        
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        UserDefaults.standard.set(AppLocalizationString.tabHome, forKey: UserDefaultsPreferenceKeys.activeTab)
        UserDefaults.standard.synchronize()
        
        //        SDImageCache.shared.clearMemory()
        //        SDImageCache.shared.clearDisk()
        
        let userActivityDictionary = launchOptions?[UIApplication.LaunchOptionsKey.userActivityDictionary] as? [AnyHashable: Any]
        if userActivityDictionary != nil {
            (userActivityDictionary as NSDictionary?)?.enumerateKeysAndObjects({ _, obj, _ in
                if obj is NSUserActivity {
                    print("found NSUserActivity object!")
                }
            })
        }
        
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        //        application.registerForRemoteNotifications()
        Analytics.setAnalyticsCollectionEnabled(true)
        Analytics.logEvent("HEARZAP - iOS", parameters: nil)
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                if !(token.isEmpty) {
                    UserDefaults.standard.set(token, forKey: UserDefaultsPreferenceKeys.fcmTokenString)
                }
            }
        }
        if UserDefaults.standard.string(forKey: UserDefaultsPreferenceKeys.token).isNilOrEmpty {
            UserDefaults.standard.set("", forKey: UserDefaultsPreferenceKeys.token)
        }
        UserDefaults.standard.synchronize()
        self.saveDefaultValues()
        self.checkInitialViewController()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "HEARZAP")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    // MARK: - Firebase
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.supportedOrientation
    }
    // MARK: - Custom Method
    
    func saveDefaultValues() {
        //        UserDefaults.standard.set("", forKey: UserDefaultsPreferenceKeys.movetofha)
        //        UserDefaults.standard.set(false, forKey: UserDefaultsPreferenceKeys.movetofhabool)
        UserDefaults.standard.set("", forKey: UserDefaultsPreferenceKeys.accessoriestab)
        UserDefaults.standard.synchronize()
    }
    func checkInitialViewController() {
        let storyboard = UIStoryboard(name: StoryBoard.Main, bundle: nil)
        let viewCon: CustomTabbarController = storyboard.instantiateViewController(withIdentifier: ViewController.CustomTabbarController) as! CustomTabbarController
        viewCon.setTabbar()
        let navigationController = UINavigationController(rootViewController: viewCon)
        navigationController.isNavigationBarHidden = true
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController  = navigationController
        window?.makeKeyAndVisible()
    }
}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // [START_EXCLUDE]
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // [END_EXCLUDE]
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([[.alert, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        // [START_EXCLUDE]
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // [END_EXCLUDE]
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}

// [END ios_10_message_handling]
extension AppDelegate: MessagingDelegate {
    // https://github.com/firebase/quickstart-ios/blob/master/messaging/MessagingExampleSwift/AppDelegate.swift
    
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token FCM: \(String(describing: fcmToken))")
        let fcmTokenString = fcmToken ?? ""
        
        let dataDict: [String: String] = ["token": fcmTokenString]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        UserDefaults.standard.set(fcmTokenString, forKey: UserDefaultsPreferenceKeys.fcmTokenString)
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    // [END refresh_token]
}
