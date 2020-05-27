//
//  AlternativeDetailRouter.swift
//  tryTwo
//
//  Created by fivecoil on 17/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class AlternativeDetailRouter {

    //MARK: - Public properties

    var view: ModuleTransitionable?

}


//MARK: - Extensions

extension AlternativeDetailRouter: AlternativeDetailRouterInput {

    func pushModule(with moduleOutput: ModuleOutput) {
        let detailModule = AlternativeDetailModuleConfigurator().configurateModule(with: moduleOutput)
        view?.pushModule(module: detailModule, animation: true)
    }

    func pushActorModule(with moduleOutput: ModuleOutput) {
        let actorDetailModule = ActorDetailModuleConfigurator().configureModule(with: moduleOutput)
        view?.pushModule(module: actorDetailModule, animation: true)
    }

    func pushPhotoModule(with moduleOutput: ModuleOutput) {
        let photoModule = PhotoViewerModuleConfigurator().configurateModule(moduleOutput: moduleOutput)
        view?.pushModule(module: photoModule, animation: true)
    }

}
