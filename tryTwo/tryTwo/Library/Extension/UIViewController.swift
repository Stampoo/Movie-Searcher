//
//  UIViewController.swift
//  tryTwo
//
//  Created by fivecoil on 10/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit


extension UIViewController {

    func showNavigationBar(_ animation: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animation)
    }

    func hideNavigationBar(_ animation: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animation)
    }

}
