//
//  Configurator.swift
//  tryTwo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class MainModuleConfigurator {

    func configureModule() -> MainModuleViewController {
        let view = MainModuleViewController()
        let presenter = MainModulePresenter()
        let router = MainModuleRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter
        
        return view
    }

}

