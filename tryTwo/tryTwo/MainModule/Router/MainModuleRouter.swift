//
//  MainRouter.swift
//  tryTwo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class MainModuleRouter {
    
    //MARK: - Public properties

   weak var view: ModuleTransitionable?

}


//MARK: - Extensions

extension MainModuleRouter: MainRouterInput {
    
    func showModule(_ moduleOutput: ModuleOutput) {
        let detailVc = AlternativeDetailModuleConfigurator().configurateModule(with: moduleOutput)
        view?.pushModule(module: detailVc, animation: true)
    }

    func popModule(animation: Bool) {
        view?.popModule(animation: true)
    }

}
