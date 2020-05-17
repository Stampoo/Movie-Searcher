//
//  CustomTabBarController.swift
//  tryTwo
//
//  Created by fivecoil on 07/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class CustomTabBarController: UITabBarController {

    //MARK: - Constants

    private enum Constants {
        static let keyForMovieListInStorage = "favoriteStorage"
    }

    
    //MARK: - Private properties

    private let mainVc = MainModuleConfigurator().configureModule()
    private let favoriteVc = FavoriteConfigurator().configure()
    private var nc = UINavigationController()


    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarIcon()
        checkToFirstStart()
        
        nc = UINavigationController(rootViewController: mainVc)
        nc.navigationBar.prefersLargeTitles = true
        self.setViewControllers([nc, favoriteVc], animated: true)
        self.delegate = self
    }


    //MARK: - Private methods

    private func setTabBarIcon() {
        mainVc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        favoriteVc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
    }
    
    private func checkToFirstStart() {
        if let _ = UserDefaults.standard.array(forKey: Constants.keyForMovieListInStorage) as? [Data] {
        } else {
            UserDefaults.standard.set([Data](), forKey: Constants.keyForMovieListInStorage)
        }
    }
    
}


//MARK: - Extensions

extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController == favoriteVc {
            favoriteVc.checkMoviesInStorage()
        }
    }
    
}
