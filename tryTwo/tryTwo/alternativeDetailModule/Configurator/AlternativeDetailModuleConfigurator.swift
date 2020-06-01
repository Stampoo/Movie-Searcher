//
//  AlternativeDetailModuleConfigurator.swift
//  tryTwo
//
//  Created by fivecoil on 17/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class AlternativeDetailModuleConfigurator {

    func configurateModule(with outputModule: ModuleOutput) -> UIViewController {
        let view = AlternativeDetailViewController()
        let presenter = AlternativeDetailModulePresenter()
        let router = AlternativeDetailRouter()

        view.output = presenter
        presenter.view = view
        presenter.router = router
        presenter.outputModule = outputModule
        router.view = view

        return view
    }

}
