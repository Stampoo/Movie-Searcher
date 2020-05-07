//
//  FavoriteProtocols.swift
//  tryTwo
//
//  Created by fivecoil on 02/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol FavoriteViewInput: class {
    
    func configure(_ actualData: [Movie])
    
    func setupInitialState()
    
}

protocol FavoriteViewOutput: class {
    
    func viewLoaded()
    
    func reload()
    
}

protocol FavoriteRouterInput: class {
    
    func showModule()
    
}
