//
//  ActorDetailModuleConfigurator.swift
//  tryTwo
//
//  Created by fivecoil on 22/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class ActorDetailModuleConfigurator {

    func configureModule(with moduleOutput: ModuleOutput) -> UIViewController {
        let view = ActorDetailViewController()
        let presenter = ActorDetailPresenter()
        let router = ActorDetailRouter()

        view.output = presenter
        presenter.view = view
        presenter.router = router
        presenter.moduleOutput = moduleOutput
        router.view = view

        return view
    }

}
