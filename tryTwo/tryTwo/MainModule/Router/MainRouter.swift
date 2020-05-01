//
//  MainRouter.swift
//  tryTwo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class MainRouter: RouterInput {
    
    //MARK: - Properties
   weak var view: ModuleTransitionable? // Транзит
    
    //MARK: - Private Properties
    func showModule(_ moduleOutput: ModuleOutput) {
        let detailVc = DetailModuleConfigurator().configure(moduleOutput)
        view?.presentModule(module: detailVc, animation: true, completion: nil)
    }
    
}
