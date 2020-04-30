//
//  Configurator.swift
//  tryTwo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

//entry point class
final class MainModuleConfigurator {

    // MARK: Internal methods

    func configure() -> MainViewController {
        let view = MainViewController()
        let presenter = MainPresenter()
        let router = MainRouter()

        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter
        
        return view
    }

}

