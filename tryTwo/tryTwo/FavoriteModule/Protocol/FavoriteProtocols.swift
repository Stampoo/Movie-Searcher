//
//  FavoriteProtocols.swift
//  tryTwo
//
//  Created by fivecoil on 02/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol FavoriteViewInput: class {
    
    func configure(with actualData: [Movie])
    
    func setupInitialState()
    
}

protocol FavoriteViewOutput: class {
    
    func viewLoaded()
    
    func reloadView()
    
    func present(with id: Int)
    
}

protocol FavoriteRouterInput: class {
    
    func showModule(_ moduleOutput: ModuleOutput)
    
}
