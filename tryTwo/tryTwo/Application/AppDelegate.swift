//
//  AppDelegate.swift
//  tryTwo
//
//  Created by fivecoil on 29/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //MARK: - App entry point
        let mainTabBar = CustomTabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainTabBar
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }

}

