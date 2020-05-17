//
//  FavoriteRouter.swift
//  tryTwo
//
//  Created by fivecoil on 02/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class FavoriteRouter {

    //MARK: - Public properties

    weak var view: ModuleTransitionable?

}


//MARK: - Extensions

extension FavoriteRouter: FavoriteRouterInput {

    func showModule(_ moduleOutput: ModuleOutput) {
        let detailVC = DetailModuleConfigurator().configure(with: moduleOutput)
        view?.presentModule(module: detailVC, animation: true, completion: nil)
    }

}
