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
        let mainTabBar = UITabBarController()
        let mainVc = MainModuleConfigurator().configure()
        let favoriteVc = FavoriteConfigurator().configure()
        let nc = UINavigationController(rootViewController: mainVc)
        mainTabBar.setViewControllers([nc, favoriteVc], animated: true)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainTabBar
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        //title size
        nc.navigationBar.prefersLargeTitles = true
        
        //tabbar item
        mainVc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        favoriteVc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        if let data = UserDefaults.standard.array(forKey: "favoriteStorage") as? [Data] {
            print(data)
            
        } else {
            UserDefaults.standard.set([Data](), forKey: "favoriteStorage")
            print("yea")
        }
        
        return true
    }

}

