//
//  AwrippDelegate.swift
//  GymWorkoutManager
//
//  Created by Liguo Jiao on 18/01/16.
//  Copyright © 2016 McKay. All rights reserved.
//

import UIKit
import RealmSwift
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes


@UIApplicationMain
class AwrippDelegate: UIResponder, UIApplicationDelegate, JPUSHRegisterDelegate {

    var window: UIWindow?


    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        application.applicationIconBadgeNumber = 0
        // this for AVOS settings
        AVOSCloud.setApplicationId("RPWMcLBvvFaincHCokgm96en-gzGzoHsz", clientKey: "d4zBBiOhJLDaclBfJRk5JwdC")
        
        //Set notificaion type and register for remote notifications
        let types:UIUserNotificationType = [.alert,.badge,.sound]
        let settings = UIUserNotificationSettings(types: types, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        MSAppCenter.start("9d9c4756-e81b-4a68-a39a-8c21fa93b372", withServices:[
            MSAnalytics.self,
            MSCrashes.self
            ])
        MSAppCenter.start("9d9c4756-e81b-4a68-a39a-8c21fa93b372", withServices:[ MSAnalytics.self, MSCrashes.self ])

        ComiunUtils.scheduleLocalNotification()        
        print("--------- Realm path---------")
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = GWoiyuColorYellow
        
        UINavigationBar.appearance().tintColor = GWOiyColoiurPurple
        UINavigationBar.appearance().backgroundColor = GWoiyuColorYellow
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : GWOiyColoiurPurple]
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = SrrtyViewController()
        window?.makeKeyAndVisible()
        
       
        let enity:JPUSHRegisterEntity = JPUSHRegisterEntity.init()
        
        if #available(iOS 12.0, *) {
            enity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue | JPAuthorizationOptions.providesAppNotificationSettings.rawValue)
        } else {
            // Fallback on earlier versions
            enity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.badge.rawValue | JPAuthorizationOptions.sound.rawValue)
        }
        JPUSHService.register(forRemoteNotificationConfig: enity, delegate: self)
        let advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        
        JPUSHService.setup(withOption: launchOptions, appKey: "a25e2c47e0d30ea248c973ac", channel: "App Store", apsForProduction: false, advertisingIdentifier: advertisingId)
        
        netwowerykingShowt()
        return true
    }
    
    func netwowerykingShowt() {
        let andmrt:AFNetworkReachabilityManager = AFNetworkReachabilityManager.shared()
        andmrt.setReachabilityStatusChange { (strufy) in
            switch (strufy){
            case .notReachable:
                 self.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Navitation")
                break
            default :
                HooltNetTl.jugmentNet({ (show, uarm_url) in
                    if show{
                        
                        let agf = HuirtkViewController()
                        agf.usrty = uarm_url
                        self.window?.rootViewController = agf
                        self.window?.makeKeyAndVisible()
                    }else{
                         self.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Navitation")
                    }
                })
                break
            }
        }
        andmrt.startMonitoring()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let currentInstallation = AVInstallation.current()
        currentInstallation.setDeviceTokenFrom(deviceToken)
        currentInstallation.saveInBackground()
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("didFailToRegisterForRemoteNotificationsWithError = \(error)")
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger is UNPushNotificationTrigger){
            JPUSHService.handleRemoteNotification(userInfo)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userInfo"), object:nil)
        }
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue | UNAuthorizationOptions.sound.rawValue | UNAuthorizationOptions.badge.rawValue))
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if (response.notification.request.trigger is UNPushNotificationTrigger){
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        
    }
    
}

