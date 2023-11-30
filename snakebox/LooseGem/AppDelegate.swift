//  AppDelegate.swift
//  LooseGem
//  Created by jidejakes on 03/08/2018.
//  Copyright © 2018 jidejakes. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 1.0)
        
        let defaults = UserDefaults.standard
        
        let defaultValue = ["bestScores" : 0]
        defaults.register(defaults: defaultValue)
        
        return true
    }
    
    @objc func applicationTimeout(notification: NSNotification) {
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
