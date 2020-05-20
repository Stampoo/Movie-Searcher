//
//  UIViewController.swift
//  tryTwo
//
//  Created by fivecoil on 10/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit


extension UIViewController {

    func showNavigationBar(_ isAnimated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: isAnimated)
    }

    func hideNavigationBar(_ isAnimated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: isAnimated)
    }

    func hideTabBar(_ isAnimated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    func showTabBar(_ isAnimated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

}
