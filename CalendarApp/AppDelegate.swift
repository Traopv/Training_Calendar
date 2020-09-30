//
//  AppDelegate.swift
//  CalendarApp
//
//  Created by Apple on 9/28/20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white

        let welcome = HomeViewController.init()
        let nav = UINavigationController(rootViewController: welcome)
        window?.rootViewController = nav

        window?.makeKeyAndVisible()
        
        return true
    }
}
