//
//  DetailRouter.swift
//  tryTwo
//
//  Created by fivecoil on 01/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class DetailRouter {
    
    //MARK: - Public properties

    var view: ModuleTransitionable?
    
}


//MARK: - Extensions

extension DetailRouter: DetailRouterInput {
    
    func showModule(_ moduleOutput: ModuleOutput) {
        let detailVc = DetailModuleConfigurator().configure(with: moduleOutput)
        view?.pushModule(module: detailVc, animation: true)
    }

    func popModule(animation: Bool) {
        view?.popModule(animation: true)
    }

}
