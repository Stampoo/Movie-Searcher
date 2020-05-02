//
//  FavoriteViewController.swift
//  tryTwo
//
//  Created by fivecoil on 02/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class FavoriteViewController: UIViewController, ModuleTransitionable {
    
    //MARK: - Properties
    var presenter: FavoriteViewOutput?
    
    
}

extension FavoriteViewController: FavoriteViewInput {
    
    func configure() {
        print("configure")
    }
    
    func setupInitialState() {
        print("setupInitialState")
    }
    
}
