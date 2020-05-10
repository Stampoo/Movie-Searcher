//
//  ViewController.swift
//  filmInfo
//
//  Created by fivecoil on 22/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

//this extension not done
extension UIViewController {
    func loading(_ loading:() -> Bool) {
        
    }
    func createShadow() {
    }
}

//MARK: - for crate shadow to UIView and inheritors
extension UIView {
    func createShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = .init(width: 0.5, height: 4.0)
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
}

