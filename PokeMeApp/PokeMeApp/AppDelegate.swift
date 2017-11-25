//
//  AppDelegate.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 09. 23..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    //TODO: Remove it after service implemented
    var mockHabit = MockHabitGenerator().createMockHabits(1).first!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().tintColor = Constants.Colors.Green
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:Constants.Colors.Green]
        registerForPushNotifications(application)
        return true
    }
    
    private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        return true
    }
    
    func registerForPushNotifications(_ application: UIApplication) {
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("APNs device token: \(deviceTokenString)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let dropdownNotification = DropdownMessageManager.shared.createDropdownNotification(from: userInfo)
        showDropDownNotifications(dropdownNotification)
    }
    
    func showDropDownNotifications(_ dropdownNotification: DropdownNotification?){
        guard let dropdownNotification: DropdownNotification = dropdownNotification else {
            return
        }
        DropdownMessageManager.shared.manageDropdown(dropdownNotification: dropdownNotification)
        
    }
    
    func handleNotification(_ dropdownNotification: DropdownNotification? = nil) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                if presentedViewController is UINavigationController {
                    topController = presentedViewController
                }
            }
            let userDashboardViewController = storyBoard.instantiateViewController(withIdentifier: "UserDashboardViewController") as! UserDashboardViewController
            let newUserHabitViewController: NewUserHabitViewController = storyBoard.instantiateViewController(withIdentifier: "NewUserHabitViewController") as! NewUserHabitViewController
            
            let tabBarController = topController
            guard tabBarController is UITabBarController else {
                return
            }
            
            if let _: DropdownNotification = dropdownNotification{
                        let firstController = (tabBarController as! UITabBarController).selectedViewController
                        guard let navigationController: UINavigationController =  firstController as? UINavigationController else {
                            return
                        }
                newUserHabitViewController.habit = self.mockHabit
                        navigationController.popToRootViewController(animated: false)
                        navigationController.viewControllers = [userDashboardViewController, /*newUserHabitViewController*/]
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

