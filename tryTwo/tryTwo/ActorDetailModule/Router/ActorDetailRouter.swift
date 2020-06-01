//
//  ActorDetailRouter.swift
//  tryTwo
//
//  Created by fivecoil on 22/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class ActorDetailRouter {

    //MARK: - Public properties

    weak var view: ModuleTransitionable?

}


//MARK: - Extensions

extension ActorDetailRouter: ActorDetailRouterInput {

    func pushModule(with outputModule: ModuleOutput) {
        let actorDetailModule = ActorDetailModuleConfigurator().configureModule(with: outputModule)
        view?.pushModule(module: actorDetailModule, animation: true)
    }

}
